import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import Header from "../components/Header";
import { fetchTopics } from "../utils/api";
import { isRecordingSupported } from "../utils/recorder";

const LEVELS = [
  { value: "beginner", label: "Beginner" },
  { value: "intermediate", label: "Intermediate" },
  { value: "advanced", label: "Advanced" },
];

const DURATIONS = [
  { value: 5, label: "5 Minutes" },
  { value: 10, label: "10 Minutes" },
  { value: 15, label: "15 Minutes" },
  { value: 25, label: "25 Minutes" },
];

export default function Setup({ onStartPractice }) {
  const navigate = useNavigate();

  const [topics, setTopics] = useState([]);
  const [loadingTopics, setLoadingTopics] = useState(true);
  const [dataSource, setDataSource] = useState("api");

  const [topic, setTopic] = useState("");
  const [level, setLevel] = useState("beginner");
  const [duration, setDuration] = useState(5);

  const [recordingSupported, setRecordingSupported] = useState(true);
  const [recordingEnabled, setRecordingEnabled] = useState(true);
  const [voiceGender, setVoiceGender] = useState("female");

  useEffect(() => {
    let cancelled = false;
    (async () => {
      const { topics: fetchedTopics, source } = await fetchTopics();
      if (cancelled) return;
      setTopics(fetchedTopics);
      setDataSource(source);
      if (fetchedTopics.length > 0) {
        setTopic(fetchedTopics[0].topic_key || fetchedTopics[0].key);
      }
      setLoadingTopics(false);
    })();
    return () => {
      cancelled = true;
    };
  }, []);

  // Check once, on load, whether this device/browser can record audio at
  // all (many older mobile browsers can't). If not, recording is disabled
  // and locked — practice-only mode is used instead.
  useEffect(() => {
    const supported = isRecordingSupported();
    setRecordingSupported(supported);
    if (!supported) {
      setRecordingEnabled(false);
    }
  }, []);

  function handleStart() {
    if (!topic) return;
    onStartPractice({ topic, level, duration, recordingEnabled, voiceGender });
    navigate("/practice");
  }

  return (
    <div className="page">
      <Header />

      <section className="setup-section">
        <h1 className="setup-title">Set up your practice</h1>
        <p className="setup-subtitle">Choose a topic, your level, and how long you want to practice.</p>

        {dataSource === "fallback" && !loadingTopics && (
          <div className="banner banner-info">
            Using built-in offline conversation data (backend not reachable).
          </div>
        )}

        <div className="setup-card card">
          <div className="setup-group">
            <label className="setup-label" htmlFor="topic-select">
              Topic
            </label>
            {loadingTopics ? (
              <div className="setup-loading">Loading topics...</div>
            ) : (
              <div className="topic-grid">
                {topics.map((t) => {
                  const key = t.topic_key || t.key;
                  return (
                    <button
                      key={key}
                      type="button"
                      className={`topic-chip ${topic === key ? "topic-chip-active" : ""}`}
                      onClick={() => setTopic(key)}
                    >
                      {t.name}
                    </button>
                  );
                })}
              </div>
            )}
          </div>

          <div className="setup-group">
            <label className="setup-label">Level</label>
            <div className="option-row">
              {LEVELS.map((l) => (
                <button
                  key={l.value}
                  type="button"
                  className={`option-pill ${level === l.value ? "option-pill-active" : ""}`}
                  onClick={() => setLevel(l.value)}
                >
                  {l.label}
                </button>
              ))}
            </div>
          </div>

          <div className="setup-group">
            <label className="setup-label">Duration</label>
            <div className="option-row">
              {DURATIONS.map((d) => (
                <button
                  key={d.value}
                  type="button"
                  className={`option-pill ${duration === d.value ? "option-pill-active" : ""}`}
                  onClick={() => setDuration(d.value)}
                >
                  {d.label}
                </button>
              ))}
            </div>
          </div>

          <div className="setup-group">
            <label className="setup-label">AI Voice</label>
            <div className="option-row">
              <button
                type="button"
                className={`option-pill ${voiceGender === "female" ? "option-pill-active" : ""}`}
                onClick={() => setVoiceGender("female")}
              >
                ♀ Female Voice
              </button>
              <button
                type="button"
                className={`option-pill ${voiceGender === "male" ? "option-pill-active" : ""}`}
                onClick={() => setVoiceGender("male")}
              >
                ♂ Male Voice
              </button>
            </div>
          </div>

          <div className="setup-group">
            <label className="setup-label">Microphone Recording</label>

            {!recordingSupported && (
              <div className="banner banner-info">
                This device/browser doesn&apos;t support audio recording. You can still do the
                full practice — just without a recording to listen back to afterward.
              </div>
            )}

            <div className="option-row">
              <button
                type="button"
                className={`option-pill ${recordingEnabled ? "option-pill-active" : ""} ${
                  !recordingSupported ? "option-pill-disabled" : ""
                }`}
                onClick={() => recordingSupported && setRecordingEnabled(true)}
                disabled={!recordingSupported}
              >
                🎙️ With Recording
              </button>
              <button
                type="button"
                className={`option-pill ${!recordingEnabled ? "option-pill-active" : ""}`}
                onClick={() => setRecordingEnabled(false)}
              >
                🚫 Without Recording
              </button>
            </div>
            <p className="setup-hint">
              {recordingEnabled
                ? "Your microphone will record the session so you can play it back at the end."
                : "Practice without using your microphone at all — nothing is recorded."}
            </p>
          </div>

          <button
            className="btn btn-primary btn-lg setup-start-btn"
            onClick={handleStart}
            disabled={!topic || loadingTopics}
          >
            Start Practice
          </button>
        </div>
      </section>
    </div>
  );
}
