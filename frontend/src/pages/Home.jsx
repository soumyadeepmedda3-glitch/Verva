import { useState } from "react";
import { useNavigate, Link } from "react-router-dom";
import Header from "../components/Header";
import CurtainTransition from "../components/CurtainTransition";

const FEATURES = [
  {
    icon: "🗣️",
    title: "Guided AI Sentences",
    description: "An AI avatar speaks each line aloud, so you always know exactly what to listen for.",
  },
  {
    icon: "🎙️",
    title: "Speak It Yourself",
    description: "A suggested sentence is shown for you to say out loud — real speaking practice, no typing.",
  },
  {
    icon: "⏱️",
    title: "Flexible Sessions",
    description: "Choose 5, 10, 15, or 25 minute sessions that fit your schedule.",
  },
  {
    icon: "🎧",
    title: "Listen Back",
    description: "Your entire session is recorded so you can play back everything you said afterward.",
  },
];

export default function Home() {
  const navigate = useNavigate();
  const [isEntering, setIsEntering] = useState(false);

  function handleGetStarted() {
    setIsEntering(true);
  }

  return (
    <div className="page">
      <Header />

      {isEntering && <CurtainTransition onFinish={() => navigate("/setup")} />}

      <section className="hero">
        <div className="hero-content">
          <span className="hero-eyebrow">AI-Powered Speaking Practice</span>
          <h1 className="hero-title">
            Ver<span className="hero-title-accent">va</span>
          </h1>
          <p className="hero-tagline">Practice English. Speak with confidence.</p>
          <p className="hero-description">
            Follow a friendly AI avatar through natural, guided conversations. Listen to each
            line, say the suggested response out loud, and record your entire practice session
            to hear your own progress.
          </p>
          <div className="hero-actions">
            <button className="btn btn-primary btn-lg" onClick={handleGetStarted}>
              Get Started
            </button>
            <Link className="btn btn-secondary btn-lg" to="/how-to-use">
              How It Works
            </Link>
          </div>
        </div>
        <div className="hero-visual" aria-hidden="true">
          <div className="hero-bubble hero-bubble-1">Hello! How are you today?</div>
          <div className="hero-bubble hero-bubble-2">I'm good, thank you!</div>
        </div>
      </section>

      <section className="features">
        <h2 className="section-title">How it works</h2>
        <div className="feature-grid">
          {FEATURES.map((f) => (
            <div className="feature-card card" key={f.title}>
              <div className="feature-icon">{f.icon}</div>
              <h3 className="feature-title">{f.title}</h3>
              <p className="feature-description">{f.description}</p>
            </div>
          ))}
        </div>
      </section>

      <section className="cta">
        <div className="cta-card card">
          <h2>Ready to practice?</h2>
          <p>Pick a topic, choose your level, and start speaking in less than a minute.</p>
          <button className="btn btn-primary btn-lg" onClick={handleGetStarted}>
            Get Started
          </button>
        </div>
      </section>

      <footer className="app-footer">
        <div className="app-footer-links">
          <Link to="/how-to-use">How to Use</Link>
          <span className="app-footer-dot">•</span>
          <Link to="/about">About</Link>
        </div>
        <p>Verva — a simple way to practice spoken English.</p>
      </footer>
    </div>
  );
}