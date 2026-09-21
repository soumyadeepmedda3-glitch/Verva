import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import Header from "../components/Header";
import { fetchTopics } from "../utils/api";
import { isRecordingSupported } from "../utils/recorder";

const LEVELS = [
  { value: "beginner", label: "Beginner", icon: "🌱", text: "Everyday basics" },
  { value: "intermediate", label: "Intermediate", icon: "⚡", text: "Natural conversation" },
  { value: "advanced", label: "Advanced", icon: "✦", text: "More nuanced English" },
];

const DURATIONS = [
  { value: 5, label: "5", sub: "min" },
  { value: 10, label: "10", sub: "min" },
  { value: 15, label: "15", sub: "min" },
  { value: 25, label: "25", sub: "min" },
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
      if (fetchedTopics.length > 0) setTopic(fetchedTopics[0].topic_key || fetchedTopics[0].key);
      setLoadingTopics(false);
    })();
    return () => { cancelled = true; };
  }, []);

  useEffect(() => {
    const supported = isRecordingSupported();
    setRecordingSupported(supported);
    if (!supported) setRecordingEnabled(false);
  }, []);

  function handleStart() {
    if (!topic) return;
    onStartPractice({ topic, level, duration, recordingEnabled, voiceGender });
    navigate("/practice");
  }

  return (
    <div className="page setup-page-modern">
      <Header />
      <main className="setup-modern-shell">
        <div className="setup-modern-heading">
          <div className="section-kicker">Create your session</div>
          <h1>Set up your<br /><em>practice.</em></h1>
          <p>Choose the conversation you want. Everything else is up to you.</p>
        </div>

        {dataSource === "fallback" && !loadingTopics && (
          <div className="banner banner-info">Using built-in conversation data because the backend is not reachable.</div>
        )}

        <div className="setup-modern-card">
          <section className="setup-modern-group">
            <div className="setup-group-heading"><span>01</span><div><h2>Choose a topic</h2><p>What situation would you like to practice?</p></div></div>
            {loadingTopics ? <div className="setup-loading">Loading topics...</div> : (
              <div className="topic-grid-modern">
                {topics.map((t) => {
                  const key = t.topic_key || t.key;
                  return <button key={key} type="button" className={`topic-modern ${topic === key ? "active" : ""}`} onClick={() => setTopic(key)}>{t.name}<span>↗</span></button>;
                })}
              </div>
            )}
          </section>

          <section className="setup-modern-group">
            <div className="setup-group-heading"><span>02</span><div><h2>Choose your level</h2><p>Match the conversation to your current comfort level.</p></div></div>
            <div className="level-modern-grid">
              {LEVELS.map((item) => <button key={item.value} type="button" className={`level-modern ${level === item.value ? "active" : ""}`} onClick={() => setLevel(item.value)}><b>{item.icon}</b><strong>{item.label}</strong><small>{item.text}</small></button>)}
            </div>
          </section>

          <section className="setup-modern-group">
            <div className="setup-group-heading"><span>03</span><div><h2>Choose your time</h2><p>Pick how long you want to keep the conversation going.</p></div></div>
            <div className="duration-modern-grid">
              {DURATIONS.map((item) => <button key={item.value} type="button" className={`duration-modern ${duration === item.value ? "active" : ""}`} onClick={() => setDuration(item.value)}><strong>{item.label}</strong><small>{item.sub}</small></button>)}
            </div>
          </section>

          <section className="setup-modern-group">
            <div className="setup-group-heading"><span>04</span><div><h2>Choose your AI voice</h2><p>Pick the voice you prefer to follow.</p></div></div>
            <div className="voice-modern-grid">
              <button type="button" className={`voice-modern ${voiceGender === "female" ? "active" : ""}`} onClick={() => setVoiceGender("female")}><b>♀</b><span><strong>Female Voice</strong><small>Clear conversational voice</small></span><i>✓</i></button>
              <button type="button" className={`voice-modern ${voiceGender === "male" ? "active" : ""}`} onClick={() => setVoiceGender("male")}><b>♂</b><span><strong>Male Voice</strong><small>Clear conversational voice</small></span><i>✓</i></button>
            </div>
          </section>

          <section className="setup-modern-group last">
            <div className="setup-group-heading"><span>05</span><div><h2>Microphone recording</h2><p>Choose whether you want to replay your spoken session later.</p></div></div>
            {!recordingSupported && <div className="banner banner-info">This browser does not currently support microphone recording. You can still practice without recording.</div>}
            <div className="recording-modern-grid">
              <button type="button" disabled={!recordingSupported} className={`recording-modern ${recordingEnabled ? "active" : ""}`} onClick={() => recordingSupported && setRecordingEnabled(true)}><b>🎙</b><span><strong>With Recording</strong><small>Record your session for replay</small></span><i>✓</i></button>
              <button type="button" className={`recording-modern ${!recordingEnabled ? "active" : ""}`} onClick={() => setRecordingEnabled(false)}><b>○</b><span><strong>Without Recording</strong><small>Practice without using your microphone</small></span><i>✓</i></button>
            </div>
            <p className="recording-note">Your recording is temporary browser data. If you want to keep it, download it before leaving the completion page.</p>
          </section>

          <div className="setup-launch">
            <div><small>YOUR SESSION</small><strong>{topics.find((t) => (t.topic_key || t.key) === topic)?.name || "Choose a topic"} · {duration} minutes</strong></div>
            <button className="btn btn-primary btn-lg" onClick={handleStart} disabled={!topic || loadingTopics}>Start Practice <span>→</span></button>
          </div>
        </div>
      </main>
    </div>
  );
}
