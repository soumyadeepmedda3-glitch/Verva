import {
  useEffect,
  useRef,
  useState,
  useCallback,
} from "react";
import { useNavigate } from "react-router-dom";
import Header from "../components/Header";
import Avatar from "../components/Avatar";
import ConversationCard from "../components/ConversationCard";
import Timer from "../components/Timer";
import AdBanner from "../components/AdBanner";
import NativeAd from "../components/NativeAd";
import { fetchConversations } from "../utils/api";
import {
  speakText,
  cancelSpeech,
  isSpeechSupported,
} from "../utils/speech";
import {
  SessionRecorder,
  isRecordingSupported,
} from "../utils/recorder";

// Builds a shuffled "play order" over the conversation lines.
function buildPlayOrder(length, avoidFirstIndex = null) {
  const indices = Array.from({ length }, (_, i) => i);

  for (let i = indices.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));

    [indices[i], indices[j]] = [
      indices[j],
      indices[i],
    ];
  }

  if (
    avoidFirstIndex !== null &&
    indices.length > 1 &&
    indices[0] === avoidFirstIndex
  ) {
    [indices[0], indices[1]] = [
      indices[1],
      indices[0],
    ];
  }

  return indices;
}

export default function Practice({
  config,
  onFinishPractice,
}) {
  const navigate = useNavigate();

  const recordingRequested =
    config?.recordingEnabled !== false;

  const [phase, setPhase] = useState("setup");
  const [errorMessage, setErrorMessage] = useState("");

  const [conversationData, setConversationData] =
    useState([]);

  const [playOrder, setPlayOrder] = useState([]);
  const [orderPos, setOrderPos] = useState(0);

  const [
    currentConversationIndex,
    setCurrentConversationIndex,
  ] = useState(0);

  const [isSpeaking, setIsSpeaking] =
    useState(false);

  const [isRecording, setIsRecording] =
    useState(false);

  const [elapsedTime, setElapsedTime] =
    useState(0);

  const recorderRef = useRef(null);
  const intervalRef = useRef(null);
  const finishedRef = useRef(false);

  const sessionStartRef = useRef(null);
  const turnStartRef = useRef(0);
  const segmentsRef = useRef([]);
  const currentLineRef = useRef(null);
  const elapsedTimeRef = useRef(0);

  const totalSeconds =
    (config?.duration || 5) * 60;

  // ---------------------------------------------------------
  // Redirect to setup if opened without configuration
  // ---------------------------------------------------------

  useEffect(() => {
    if (!config || !config.topic) {
      navigate("/setup");
    }
  }, [config, navigate]);

  // ---------------------------------------------------------
  // End session
  // ---------------------------------------------------------

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

      if (
        sessionStartRef.current !== null &&
        currentLineRef.current
      ) {
        const nowMs =
          performance.now() -
          sessionStartRef.current;

        segmentsRef.current.push({
          ai: currentLineRef.current.ai,
          answer:
            currentLineRef.current.answer,
          start:
            turnStartRef.current / 1000,
          end: nowMs / 1000,
        });
      }

      let blob = null;

      if (recorderRef.current) {
        blob =
          await recorderRef.current.stop();

        setIsRecording(false);
      }

      if (navigateAway) {
        const url = blob
          ? URL.createObjectURL(blob)
          : null;

        onFinishPractice({
          blob,
          url,
          durationMinutes:
            config?.duration || 0,
          elapsedSeconds:
            elapsedTimeRef.current,
          topic: config?.topic,
          level: config?.level,
          segments: segmentsRef.current,
          recordingEnabled:
            recorderRef.current !== null ||
            !!blob,
          voiceGender:
            config?.voiceGender || "female",
        });

        navigate("/complete");
      }
    },
    [
      config,
      navigate,
      onFinishPractice,
    ]
  );

  // ---------------------------------------------------------
  // Load conversation
  // ---------------------------------------------------------

  const loadConversationContent =
    useCallback(async () => {
      const { conversations } =
        await fetchConversations(
          config.topic,
          config.level
        );

      if (
        !conversations ||
        conversations.length === 0
      ) {
        setErrorMessage(
          "No practice content is available for this topic and level yet."
        );

        setPhase("no-content");

        return false;
      }

      const order =
        buildPlayOrder(
          conversations.length
        );

      setConversationData(
        conversations
      );

      setPlayOrder(order);
      setOrderPos(0);

      setCurrentConversationIndex(
        order[0]
      );

      setPhase("ready");

      return true;
    }, [config]);

  // ---------------------------------------------------------
  // Start microphone recording
  // ---------------------------------------------------------

  async function startMicRecording() {
    if (!isRecordingSupported()) {
      setPhase("unsupported");
      return false;
    }

    setPhase("requesting-mic");

    const recorder =
      new SessionRecorder();

    try {
      await recorder.start();
    } catch (err) {
      if (
        err.message ===
        "PERMISSION_DENIED"
      ) {
        setPhase("denied");
      } else if (
        err.message ===
        "NO_MICROPHONE"
      ) {
        setErrorMessage(
          "No microphone was found on this device."
        );

        setPhase("error");
      } else {
        setErrorMessage(
          "We couldn't access your microphone. Please check your device and try again."
        );

        setPhase("error");
      }

      return false;
    }

    recorderRef.current =
      recorder;

    setIsRecording(true);

    sessionStartRef.current =
      performance.now();

    turnStartRef.current = 0;
    segmentsRef.current = [];

    return true;
  }

  // ---------------------------------------------------------
  // Initial setup
  // ---------------------------------------------------------

  useEffect(() => {
    if (!config || !config.topic) return;

    let cancelled = false;

    (async () => {
      if (recordingRequested) {
        const micOk =
          await startMicRecording();

        if (cancelled) {
          if (recorderRef.current) {
            recorderRef.current.stop();
          }

          return;
        }

        if (!micOk) return;
      } else {
        setPhase("loading");
      }

      const loaded =
        await loadConversationContent();

      if (cancelled || !loaded) return;
    })();

    return () => {
      cancelled = true;
    };

    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [config]);

  // ---------------------------------------------------------
  // Speak current AI line
  // ---------------------------------------------------------

  useEffect(() => {
    if (
      phase !== "ready" ||
      conversationData.length === 0
    ) {
      return;
    }

    const line =
      conversationData[
        currentConversationIndex
      ];

    if (!line) return;

    if (!isSpeechSupported()) {
      return;
    }

    speakText(line.ai, {
      gender:
        config?.voiceGender ||
        "female",

      onStart: () =>
        setIsSpeaking(true),

      onEnd: () =>
        setIsSpeaking(false),

      onError: () =>
        setIsSpeaking(false),
    });

    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [
    currentConversationIndex,
    phase,
    conversationData,
  ]);

  // ---------------------------------------------------------
  // Current line ref
  // ---------------------------------------------------------

  useEffect(() => {
    if (conversationData.length > 0) {
      currentLineRef.current =
        conversationData[
          currentConversationIndex
        ] || null;
    }
  }, [
    currentConversationIndex,
    conversationData,
  ]);

  // ---------------------------------------------------------
  // Timer
  // ---------------------------------------------------------

  useEffect(() => {
    if (phase !== "ready") return;

    intervalRef.current =
      setInterval(() => {
        setElapsedTime((prev) => {
          const next = prev + 1;

          elapsedTimeRef.current =
            next;

          if (
            next >= totalSeconds
          ) {
            endSession(true);
          }

          return next;
        });
      }, 1000);

    return () => {
      if (intervalRef.current) {
        clearInterval(
          intervalRef.current
        );

        intervalRef.current = null;
      }
    };

    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [
    phase,
    totalSeconds,
  ]);

  // ---------------------------------------------------------
  // Cleanup
  // ---------------------------------------------------------

  useEffect(() => {
    return () => {
      cancelSpeech();

      if (intervalRef.current) {
        clearInterval(
          intervalRef.current
        );
      }

      if (
        recorderRef.current &&
        recorderRef.current.isRecording
      ) {
        recorderRef.current.stop();
      }
    };
  }, []);

  // ---------------------------------------------------------
  // Next
  // ---------------------------------------------------------

  function handleNext() {
    if (phase !== "ready") return;

    cancelSpeech();

    if (
      sessionStartRef.current !==
      null
    ) {
      const nowMs =
        performance.now() -
        sessionStartRef.current;

      const line =
        conversationData[
          currentConversationIndex
        ];

      if (line) {
        segmentsRef.current.push({
          ai: line.ai,
          answer: line.answer,
          start:
            turnStartRef.current /
            1000,
          end: nowMs / 1000,
        });
      }

      turnStartRef.current =
        nowMs;
    }

    let nextPos =
      orderPos + 1;

    let order = playOrder;

    if (
      nextPos >= order.length
    ) {
      const lastShown =
        order[
          order.length - 1
        ];

      order =
        buildPlayOrder(
          conversationData.length,
          lastShown
        );

      nextPos = 0;

      setPlayOrder(order);
    }

    setOrderPos(nextPos);

    setCurrentConversationIndex(
      order[nextPos]
    );
  }

  // ---------------------------------------------------------
  // Retry microphone
  // ---------------------------------------------------------

  async function handleRetryMic() {
    finishedRef.current = false;

    setErrorMessage("");

    const micOk =
      await startMicRecording();

    if (!micOk) return;

    await loadConversationContent();
  }

  // ---------------------------------------------------------
  // Continue without recording
  // ---------------------------------------------------------

  async function continueWithoutRecording() {
    finishedRef.current = false;

    setErrorMessage("");

    setPhase("loading");

    await loadConversationContent();
  }

  // =========================================================
  // STATUS: UNSUPPORTED
  // =========================================================

  if (phase === "unsupported") {
    return (
      <div className="page">
        <Header />

        <div className="status-screen">
          <div className="status-card card">
            <h2>
              Recording isn't supported on
              this device
            </h2>

            <p>
              This browser doesn't support
              microphone recording. You can
              still do the full practice —
              you just won't have a recording
              to listen back to afterward.
            </p>

            <div className="status-actions">
              <button
                className="btn btn-primary"
                onClick={
                  continueWithoutRecording
                }
              >
                Continue Without Recording
              </button>

              <button
                className="btn btn-secondary"
                onClick={() =>
                  navigate("/setup")
                }
              >
                Back to Setup
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  // =========================================================
  // STATUS: DENIED
  // =========================================================

  if (phase === "denied") {
    return (
      <div className="page">
        <Header />

        <div className="status-screen">
          <div className="status-card card">
            <h2>
              Microphone access needed
            </h2>

            <p>
              Microphone access is required
              to record your practice. Please
              allow microphone access and try
              again, or continue without
              recording.
            </p>

            <div className="status-actions">
              <button
                className="btn btn-primary"
                onClick={
                  handleRetryMic
                }
              >
                Try Again
              </button>

              <button
                className="btn btn-secondary"
                onClick={
                  continueWithoutRecording
                }
              >
                Continue Without Recording
              </button>

              <button
                className="btn btn-secondary"
                onClick={() =>
                  navigate("/setup")
                }
              >
                Back to Setup
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  // =========================================================
  // STATUS: ERROR / NO CONTENT
  // =========================================================

  if (
    phase === "error" ||
    phase === "no-content"
  ) {
    return (
      <div className="page">
        <Header />

        <div className="status-screen">
          <div className="status-card card">
            <h2>
              Something went wrong
            </h2>

            <p>
              {errorMessage ||
                "Please try again."}
            </p>

            <div className="status-actions">
              {phase === "error" && (
                <button
                  className="btn btn-primary"
                  onClick={
                    continueWithoutRecording
                  }
                >
                  Continue Without Recording
                </button>
              )}

              <button
                className="btn btn-secondary"
                onClick={() =>
                  navigate("/setup")
                }
              >
                Back to Setup
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  // =========================================================
  // STATUS: LOADING
  // =========================================================

  if (
    phase === "setup" ||
    phase === "requesting-mic" ||
    phase === "loading" ||
    conversationData.length === 0
  ) {
    return (
      <div className="page">
        <Header />

        <div className="status-screen">
          <div className="status-card card">
            <h2>
              Getting ready...
            </h2>

            <p>
              {phase ===
              "requesting-mic"
                ? "Requesting microphone access and loading your conversation."
                : "Loading your conversation."}
            </p>
          </div>
        </div>
      </div>
    );
  }

  // =========================================================
  // CURRENT PRACTICE LINE
  // =========================================================

  const currentLine =
    conversationData[
      currentConversationIndex
    ];

  return (
    <div className="page practice-page">

      <Header />

      {/* =====================================================
          PRACTICE AD STYLES
          ===================================================== */}

      <style>{`
        .practice-ad-layout {
          position: relative;
          width: 100%;
        }

        .practice-side-ad {
          position: absolute;
          top: 80px;
          right: 20px;
          width: 160px;
          min-height: 300px;
          z-index: 10;
        }

        .practice-native-ad {
          width: 100%;
          max-width: 800px;
          margin: 25px auto 10px;
          padding: 10px 20px;
          display: flex;
          justify-content: center;
          align-items: center;
        }

        @media (max-width: 1100px) {
          .practice-side-ad {
            display: none;
          }
        }

        @media (max-width: 600px) {
          .practice-native-ad {
            margin: 20px auto 5px;
            padding: 8px;
          }
        }
      `}</style>

      <div className="practice-ad-layout">

        {/* =================================================
            AD #1 — DESKTOP SIDE BANNER
            ================================================= */}

        <aside
          className="practice-side-ad"
          aria-label="Advertisement"
        >
          <AdBanner />
        </aside>

        {/* =================================================
            PRACTICE CONTENT
            ================================================= */}

        <div className="practice-screen">

          <p className="practice-eyebrow">
            PRACTICE
          </p>

          <Avatar
            isSpeaking={isSpeaking}
          />

          <ConversationCard
            aiText={currentLine.ai}
            answerText={
              currentLine.answer
            }
          />

          {/* ===============================================
              AD #2 — NATIVE BANNER
              =============================================== */}

          <section
            className="practice-native-ad"
            aria-label="Advertisement"
          >
            <NativeAd />
          </section>

          {/* ===============================================
              RECORDING STATUS
              =============================================== */}

          <div className="recording-status">
            {isRecording ? (
              <>
                <span className="rec-dot rec-dot-active" />

                <span>
                  Recording
                </span>
              </>
            ) : (
              <>
                <span className="rec-dot" />

                <span>
                  {recordingRequested
                    ? "Recording stopped"
                    : "Practicing without recording"}
                </span>
              </>
            )}
          </div>

          {/* ===============================================
              TIMER
              =============================================== */}

          <Timer
            elapsedSeconds={
              elapsedTime
            }
            totalSeconds={
              totalSeconds
            }
          />

          {/* ===============================================
              ACTIONS
              =============================================== */}

          <div className="practice-actions">

            <button
              className="btn btn-primary btn-lg next-btn"
              onClick={handleNext}
            >
              NEXT →
            </button>

            <button
              className="btn btn-link"
              onClick={() =>
                endSession(true)
              }
            >
              End session early
            </button>

          </div>

        </div>
      </div>
    </div>
  );
}