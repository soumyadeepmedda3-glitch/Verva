import { useEffect, useRef, useState } from "react";
import { useNavigate } from "react-router-dom";
import Header from "../components/Header";
import AudioPlayer from "../components/AudioPlayer";
import { speakText, cancelSpeech } from "../utils/speech";

function formatDuration(minutes) {
  return `${minutes} minute${minutes === 1 ? "" : "s"}`;
}

// Speaks one AI line and resolves once speech finishes (or errors).
function speakAndWait(text, gender) {
  return new Promise((resolve) => {
    speakText(text, { gender, onEnd: resolve, onError: resolve });
  });
}

export default function Complete({ result, onPracticeAgain }) {
  const navigate = useNavigate();

  const audioRef = useRef(null);
  const cancelledRef = useRef(false);
  const sliceTimerRef = useRef(null);

  const [isPlayingAll, setIsPlayingAll] = useState(false);
  const [activeSegmentIndex, setActiveSegmentIndex] = useState(-1);
  const [activeStage, setActiveStage] = useState(null); // "ai" | "you" | null

  useEffect(() => {
    if (!result) {
      navigate("/setup");
    }
  }, [result, navigate]);

  // Note: the recording's object URL is intentionally NOT revoked here.
  // Revoking it on this component's unmount is unsafe under React
  // StrictMode (which mounts, tears down, and remounts every component
  // once in development) — it would destroy the blob right after
  // creating it, causing "Download failed" and silent playback failures.
  // The URL is released instead in App.jsx's handlePracticeAgain(),
  // which is a real, deliberate end-of-session point.

  // Stop any in-progress reconstructed playback if the user navigates away.
  useEffect(() => {
    return () => {
      cancelledRef.current = true;
      cancelSpeech();
      if (sliceTimerRef.current) clearTimeout(sliceTimerRef.current);
      if (audioRef.current) audioRef.current.pause();
    };
  }, []);

  if (!result) return null;

  const segments = result.segments || [];
  const hasFullConversation = segments.length > 0 && !!result.url;

  // Plays back the recorded slice of audio between `start` and `end`
  // (seconds), resolving once that portion has finished playing.
  function playRecordedSlice(start, end) {
    return new Promise((resolve) => {
      const audio = audioRef.current;
      const durationMs = Math.max(0, (end - start) * 1000);

      if (!audio || durationMs <= 0) {
        resolve();
        return;
      }

      const onSeeked = () => {
        audio.removeEventListener("seeked", onSeeked);
        audio.play().catch(() => {});
        sliceTimerRef.current = setTimeout(() => {
          audio.pause();
          resolve();
        }, durationMs);
      };

      audio.addEventListener("seeked", onSeeked);
      try {
        audio.currentTime = start;
      } catch (err) {
        // Some browsers throw if the audio isn't ready yet — just resolve.
        audio.removeEventListener("seeked", onSeeked);
        resolve();
      }
    });
  }

  async function playFullConversation() {
    if (!hasFullConversation || isPlayingAll) return;

    cancelledRef.current = false;
    setIsPlayingAll(true);

    for (let i = 0; i < segments.length; i++) {
      if (cancelledRef.current) break;
      const seg = segments[i];

      setActiveSegmentIndex(i);
      setActiveStage("ai");
      await speakAndWait(seg.ai, result.voiceGender || "female");
      if (cancelledRef.current) break;

      setActiveStage("you");
      await playRecordedSlice(seg.start, seg.end);
    }

    setIsPlayingAll(false);
    setActiveSegmentIndex(-1);
    setActiveStage(null);
  }

  function stopFullConversation() {
    cancelledRef.current = true;
    cancelSpeech();
    if (sliceTimerRef.current) clearTimeout(sliceTimerRef.current);
    if (audioRef.current) audioRef.current.pause();
    setIsPlayingAll(false);
    setActiveSegmentIndex(-1);
    setActiveStage(null);
  }

  const activeSegment = activeSegmentIndex >= 0 ? segments[activeSegmentIndex] : null;

  return (
    <div className="page">
      <Header />
      <div className="complete-screen">
        <div className="complete-card card">
          <div className="complete-emoji">🎉</div>
          <h1>Practice Complete</h1>
          <p className="complete-subtitle">You completed your English practice session.</p>

          <div className="complete-meta">
            <div className="complete-meta-item">
              <span className="complete-meta-label">Duration</span>
              <span className="complete-meta-value">{formatDuration(result.durationMinutes)}</span>
            </div>
          </div>

          {result.recordingEnabled === false ? (
            <div className="complete-listen complete-no-recording">
              <h2>🚫 No Recording This Time</h2>
              <p>
                You practiced without microphone recording, so there's nothing to play back.
                Choose &quot;With Recording&quot; next time to hear yourself afterward.
              </p>
            </div>
          ) : (
            <>
              {hasFullConversation && (
                <div className="complete-listen">
                  <h2>🎬 Play Full Conversation</h2>
                  <p className="full-convo-hint">
                    Hear the AI's lines and your recorded responses together, turn by turn.
                  </p>

                  {!isPlayingAll ? (
                    <button className="btn btn-primary" onClick={playFullConversation}>
                      ▶ Play Full Conversation
                    </button>
                  ) : (
                    <button className="btn btn-secondary" onClick={stopFullConversation}>
                      ■ Stop
                    </button>
                  )}

                  {isPlayingAll && activeSegment && (
                    <div className="full-convo-now-playing">
                      <span className={`full-convo-badge ${activeStage === "ai" ? "full-convo-badge-ai" : "full-convo-badge-you"}`}>
                        {activeStage === "ai" ? "AI" : "You"}
                      </span>
                      <p className="full-convo-text">
                        {activeStage === "ai" ? activeSegment.ai : activeSegment.answer}
                      </p>
                    </div>
                  )}

                  {/* Hidden player used only to play recorded slices during
                      full-conversation playback — separate from the visible
                      player below so both can be used independently. */}
                  <audio ref={audioRef} src={result.url} style={{ display: "none" }} />
                </div>
              )}

              <div className="complete-listen">
                <h2>🎧 Listen to My Recording</h2>
                <AudioPlayer src={result.url} />
              </div>
            </>
          )}

          <div className="complete-actions">
            <button
              className="btn btn-primary btn-lg"
              onClick={() => {
                onPracticeAgain();
                navigate("/setup");
              }}
            >
              Practice Again
            </button>
            <button
              className="btn btn-secondary btn-lg"
              onClick={() => {
                onPracticeAgain();
                navigate("/");
              }}
            >
              Back to Home
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}