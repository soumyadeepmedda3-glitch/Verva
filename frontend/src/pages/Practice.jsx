import { useEffect, useRef, useState, useCallback } from "react";
import { useNavigate } from "react-router-dom";
import Header from "../components/Header";
import Avatar from "../components/Avatar";
import ConversationCard from "../components/ConversationCard";
import Timer from "../components/Timer";
import { fetchConversations } from "../utils/api";
import { speakText, cancelSpeech, isSpeechSupported } from "../utils/speech";
import { SessionRecorder, isRecordingSupported } from "../utils/recorder";

// Builds a shuffled "play order" over the conversation lines so that once
// we reach the end we keep going (looping the topic/level content) without
// ever repeating the exact same line twice in a row.
function buildPlayOrder(length, avoidFirstIndex = null) {
  const indices = Array.from({ length }, (_, i) => i);
  for (let i = indices.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [indices[i], indices[j]] = [indices[j], indices[i]];
  }
  if (avoidFirstIndex !== null && indices.length > 1 && indices[0] === avoidFirstIndex) {
    [indices[0], indices[1]] = [indices[1], indices[0]];
  }
  return indices;
}

export default function Practice({ config, onFinishPractice }) {
  const navigate = useNavigate();

  // Whether this session should use the microphone at all. Defaults to
  // true only if the caller didn't specify (backward compatible) — Setup
  // always specifies it explicitly now.
  const recordingRequested = config?.recordingEnabled !== false;

  // "setup" | "requesting-mic" | "loading" | "denied" | "unsupported" | "error" | "ready" | "no-content"
  const [phase, setPhase] = useState("setup");
  const [errorMessage, setErrorMessage] = useState("");

  const [conversationData, setConversationData] = useState([]);
  const [playOrder, setPlayOrder] = useState([]);
  const [orderPos, setOrderPos] = useState(0);
  const [currentConversationIndex, setCurrentConversationIndex] = useState(0);

  const [isSpeaking, setIsSpeaking] = useState(false);
  const [isRecording, setIsRecording] = useState(false);
  const [elapsedTime, setElapsedTime] = useState(0);

  const recorderRef = useRef(null);
  const intervalRef = useRef(null);
  const finishedRef = useRef(false);

  // Session-audio segmentation, used to reconstruct "AI + you" playback
  // on the Complete screen (see Complete.jsx). Only populated when
  // recording is actually active.
  const sessionStartRef = useRef(null);
  const turnStartRef = useRef(0);
  const segmentsRef = useRef([]);
  const currentLineRef = useRef(null);
  const elapsedTimeRef = useRef(0);

  const totalSeconds = (config?.duration || 5) * 60;

  // ---- Redirect to setup if this page was opened directly without config ----
  useEffect(() => {
    if (!config || !config.topic) {
      navigate("/setup");
    }
  }, [config, navigate]);

  const endSession = useCallback(
    async (navigateAway = true) => {
      if (finishedRef.current) return;
      finishedRef.current = true;

      cancelSpeech();
      setIsSpeaking(false);

      if (intervalRef.current) {
        clearInterval(intervalRef.current);
        intervalRef.current = null;
      }

      // Close out whichever turn was still in progress so it's included
      // in the reconstructed "AI + you" playback (only relevant if we
      // were recording).
      if (sessionStartRef.current !== null && currentLineRef.current) {
        const nowMs = performance.now() - sessionStartRef.current;
        segmentsRef.current.push({
          ai: currentLineRef.current.ai,
          answer: currentLineRef.current.answer,
          start: turnStartRef.current / 1000,
          end: nowMs / 1000,
        });
      }

      let blob = null;
      if (recorderRef.current) {
        blob = await recorderRef.current.stop();
        setIsRecording(false);
      }

      if (navigateAway) {
        const url = blob ? URL.createObjectURL(blob) : null;
        onFinishPractice({
          blob,
          url,
          durationMinutes: config?.duration || 0,
          elapsedSeconds: elapsedTimeRef.current,
          topic: config?.topic,
          level: config?.level,
          segments: segmentsRef.current,
          recordingEnabled: recorderRef.current !== null || !!blob,
          voiceGender: config?.voiceGender || "female",
        });
        navigate("/complete");
      }
    },
    [config, navigate, onFinishPractice]
  );

  // Loads the conversation content for the chosen topic/level and moves
  // to the "ready" phase. Shared by every entry path (with mic, without
  // mic, and retry-after-error).
  const loadConversationContent = useCallback(async () => {
    const { conversations } = await fetchConversations(config.topic, config.level);

    if (!conversations || conversations.length === 0) {
      setErrorMessage("No practice content is available for this topic and level yet.");
      setPhase("no-content");
      return false;
    }

    const order = buildPlayOrder(conversations.length);
    setConversationData(conversations);
    setPlayOrder(order);
    setOrderPos(0);
    setCurrentConversationIndex(order[0]);
    setPhase("ready");
    return true;
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [config]);

  // Requests the microphone and starts recording. Returns true on
  // success; on failure it sets the appropriate error phase and returns
  // false so the caller can stop.
  async function startMicRecording() {
    if (!isRecordingSupported()) {
      setPhase("unsupported");
      return false;
    }

    setPhase("requesting-mic");
    const recorder = new SessionRecorder();
    try {
      await recorder.start();
    } catch (err) {
      if (err.message === "PERMISSION_DENIED") {
        setPhase("denied");
      } else if (err.message === "NO_MICROPHONE") {
        setErrorMessage("No microphone was found on this device.");
        setPhase("error");
      } else {
        setErrorMessage("We couldn't access your microphone. Please check your device and try again.");
        setPhase("error");
      }
      return false;
    }

    recorderRef.current = recorder;
    setIsRecording(true);
    sessionStartRef.current = performance.now();
    turnStartRef.current = 0;
    segmentsRef.current = [];
    return true;
  }

  // ---- Initial setup: mic permission (if requested) + load content ----
  useEffect(() => {
    if (!config || !config.topic) return;

    let cancelled = false;

    (async () => {
      if (recordingRequested) {
        const micOk = await startMicRecording();
        if (cancelled) {
          if (recorderRef.current) recorderRef.current.stop();
          return;
        }
        if (!micOk) return; // phase already set to unsupported/denied/error
      } else {
        setPhase("loading");
      }

      const loaded = await loadConversationContent();
      if (cancelled || !loaded) return;
    })();

    return () => {
      cancelled = true;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [config]);

  // ---- Speak the current AI line whenever it changes (while ready) ----
  useEffect(() => {
    if (phase !== "ready" || conversationData.length === 0) return;

    const line = conversationData[currentConversationIndex];
    if (!line) return;

    if (!isSpeechSupported()) {
      // Speech synthesis unsupported — degrade gracefully, text is still shown.
      return;
    }

    speakText(line.ai, {
      gender: config?.voiceGender || "female",
      onStart: () => setIsSpeaking(true),
      onEnd: () => setIsSpeaking(false),
      onError: () => setIsSpeaking(false),
    });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [currentConversationIndex, phase, conversationData]);

  // ---- Keep a ref to the currently-displayed line so endSession (which
  // is memoized and doesn't re-close over state) can always read the
  // latest line when closing out the final turn's segment. ----
  useEffect(() => {
    if (conversationData.length > 0) {
      currentLineRef.current = conversationData[currentConversationIndex] || null;
    }
  }, [currentConversationIndex, conversationData]);

  // ---- Timer ----
  useEffect(() => {
    if (phase !== "ready") return;

    intervalRef.current = setInterval(() => {
      setElapsedTime((prev) => {
        const next = prev + 1;
        elapsedTimeRef.current = next;
        if (next >= totalSeconds) {
          endSession(true);
        }
        return next;
      });
    }, 1000);

    return () => {
      if (intervalRef.current) {
        clearInterval(intervalRef.current);
        intervalRef.current = null;
      }
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [phase, totalSeconds]);

  // ---- Cleanup on unmount (e.g. user navigates away mid-session) ----
  useEffect(() => {
    return () => {
      cancelSpeech();
      if (intervalRef.current) clearInterval(intervalRef.current);
      if (recorderRef.current && recorderRef.current.isRecording) {
        recorderRef.current.stop();
      }
    };
  }, []);

  function handleNext() {
    if (phase !== "ready") return;
    cancelSpeech();

    // Close out the turn that's ending, so it can be replayed later as
    // "AI line, then your recorded response" on the Complete screen.
    if (sessionStartRef.current !== null) {
      const nowMs = performance.now() - sessionStartRef.current;
      const line = conversationData[currentConversationIndex];
      if (line) {
        segmentsRef.current.push({
          ai: line.ai,
          answer: line.answer,
          start: turnStartRef.current / 1000,
          end: nowMs / 1000,
        });
      }
      turnStartRef.current = nowMs;
    }

    let nextPos = orderPos + 1;
    let order = playOrder;

    if (nextPos >= order.length) {
      // Reshuffle for another pass through the topic's content.
      const lastShown = order[order.length - 1];
      order = buildPlayOrder(conversationData.length, lastShown);
      nextPos = 0;
      setPlayOrder(order);
    }

    setOrderPos(nextPos);
    setCurrentConversationIndex(order[nextPos]);
  }

  async function handleRetryMic() {
    finishedRef.current = false;
    setErrorMessage("");
    const micOk = await startMicRecording();
    if (!micOk) return;
    await loadConversationContent();
  }

  // Lets a user whose device/browser can't record (or who denied mic
  // access) continue the practice anyway, without recording.
  async function continueWithoutRecording() {
    finishedRef.current = false;
    setErrorMessage("");
    setPhase("loading");
    await loadConversationContent();
  }

  // ---------------- Render states ----------------

  if (phase === "unsupported") {
    return (
      <div className="page">
        <Header />
        <div className="status-screen">
          <div className="status-card card">
            <h2>Recording isn't supported on this device</h2>
            <p>
              This browser doesn't support microphone recording. You can still do the full
              practice — you just won't have a recording to listen back to afterward.
            </p>
            <div className="status-actions">
              <button className="btn btn-primary" onClick={continueWithoutRecording}>
                Continue Without Recording
              </button>
              <button className="btn btn-secondary" onClick={() => navigate("/setup")}>
                Back to Setup
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  if (phase === "denied") {
    return (
      <div className="page">
        <Header />
        <div className="status-screen">
          <div className="status-card card">
            <h2>Microphone access needed</h2>
            <p>
              Microphone access is required to record your practice. Please allow microphone
              access and try again, or continue without recording.
            </p>
            <div className="status-actions">
              <button className="btn btn-primary" onClick={handleRetryMic}>
                Try Again
              </button>
              <button className="btn btn-secondary" onClick={continueWithoutRecording}>
                Continue Without Recording
              </button>
              <button className="btn btn-secondary" onClick={() => navigate("/setup")}>
                Back to Setup
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  if (phase === "error" || phase === "no-content") {
    return (
      <div className="page">
        <Header />
        <div className="status-screen">
          <div className="status-card card">
            <h2>Something went wrong</h2>
            <p>{errorMessage || "Please try again."}</p>
            <div className="status-actions">
              {phase === "error" && (
                <button className="btn btn-primary" onClick={continueWithoutRecording}>
                  Continue Without Recording
                </button>
              )}
              <button className="btn btn-secondary" onClick={() => navigate("/setup")}>
                Back to Setup
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  if (phase === "setup" || phase === "requesting-mic" || phase === "loading" || conversationData.length === 0) {
    return (
      <div className="page">
        <Header />
        <div className="status-screen">
          <div className="status-card card">
            <h2>Getting ready...</h2>
            <p>
              {phase === "requesting-mic"
                ? "Requesting microphone access and loading your conversation."
                : "Loading your conversation."}
            </p>
          </div>
        </div>
      </div>
    );
  }

  const currentLine = conversationData[currentConversationIndex];

  return (
    <div className="page">
      <Header />
      <div className="practice-screen">
        <p className="practice-eyebrow">PRACTICE</p>

        <Avatar isSpeaking={isSpeaking} />

        <ConversationCard aiText={currentLine.ai} answerText={currentLine.answer} />

        <div className="recording-status">
          {isRecording ? (
            <>
              <span className="rec-dot rec-dot-active" />
              <span>Recording</span>
            </>
          ) : (
            <>
              <span className="rec-dot" />
              <span>{recordingRequested ? "Recording stopped" : "Practicing without recording"}</span>
            </>
          )}
        </div>

        <Timer elapsedSeconds={elapsedTime} totalSeconds={totalSeconds} />

        <div className="practice-actions">
          <button className="btn btn-primary btn-lg next-btn" onClick={handleNext}>
            NEXT →
          </button>
          <button className="btn btn-link" onClick={() => endSession(true)}>
            End session early
          </button>
        </div>
      </div>
    </div>
  );
}
