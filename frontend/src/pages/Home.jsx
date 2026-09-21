import { useState } from "react";
import { useNavigate } from "react-router-dom";
import Header from "../components/Header";
import CurtainTransition from "../components/CurtainTransition";

const FEATURES = [
  {
    icon: "🎧",
    number: "01",
    title: "Listen",
    description:
      "Hear a guided English sentence from your AI conversation partner.",
  },
  {
    icon: "🗣️",
    number: "02",
    title: "Speak",
    description:
      "Say the suggested response aloud instead of typing it.",
  },
  {
    icon: "🎙️",
    number: "03",
    title: "Record",
    description:
      "Keep a temporary recording of your whole practice session when recording is enabled.",
  },
  {
    icon: "↻",
    number: "04",
    title: "Replay",
    description:
      "Review your session after practice and hear the conversation turn by turn.",
  },
];

const STEPS = [
  ["01", "Get Started", 'Press "Start Practicing" and open the setup screen.'],
  [
    "02",
    "Choose a Topic",
    "Pick from everyday situations such as College, Travel, Restaurant, Hotel, Job Interview and more.",
  ],
  [
    "03",
    "Choose Your Level",
    "Select Beginner, Intermediate or Advanced to match the conversation difficulty you want.",
  ],
  [
    "04",
    "Choose Duration",
    "Practice for 5, 10, 15 or 25 minutes. The session continues until your selected time ends.",
  ],
  [
    "05",
    "Choose an AI Voice",
    "Select the available female or male voice for the AI conversation partner.",
  ],
  [
    "06",
    "Choose Recording",
    "Turn microphone recording on if you want to replay your spoken session later, or continue without recording.",
  ],
  [
    "07",
    "Listen to Verva",
    "The AI speaks a line and the same line appears on screen so you can follow the conversation.",
  ],
  [
    "08",
    "Say the Suggested Answer",
    "A suggested response is shown below the AI line. Say it aloud as your part of the conversation.",
  ],
  [
    "09",
    "Press Next",
    "Move to the next turn when you are ready. Your recording continues throughout the session when enabled.",
  ],
  [
    "10",
    "Finish & Replay",
    "When time is up, review your session and replay your recorded responses together with the AI conversation.",
  ],
];

const TOPICS = [
  "Daily Conversation",
  "College",
  "School",
  "Shopping",
  "Restaurant",
  "Travel",
  "Hotel",
  "Airport",
  "Job Interview",
  "Office",
  "Friends",
  "Directions",
];

export default function Home() {
  const navigate = useNavigate();
  const [isEntering, setIsEntering] = useState(false);

  function start() {
    setIsEntering(true);
  }

  return (
    <div className="page landing-page">
      <Header />

      {isEntering && (
        <CurtainTransition onFinish={() => navigate("/setup")} />
      )}

      <main>
        {/* ================= HERO ================= */}

        <section className="landing-hero" id="top">
          <div className="hero-glow hero-glow-one" />
          <div className="hero-glow hero-glow-two" />

          <div className="landing-hero-copy reveal">
            <div className="hero-status">
              <span />
              Guided English speaking practice
            </div>

            <h1>
              Speak English.
              <br />
              <span>Build confidence.</span>
            </h1>

            <p className="landing-lead">
              Verva gives you a simple conversation to follow: listen to a
              sentence, say the suggested response, and keep the conversation
              moving.
            </p>

            <div className="hero-actions">
              <button
                className="btn btn-primary btn-lg hero-main-btn"
                onClick={start}
              >
                Start Practicing <span>→</span>
              </button>

              <a className="hero-text-link" href="#how-it-works">
                See how it works ↓
              </a>
            </div>

            <div className="hero-trust-row">
              <span>19+ everyday topics</span>
              <i />
              <span>3 levels</span>
              <i />
              <span>4 session lengths</span>
            </div>
          </div>

          <div className="conversation-preview reveal reveal-delay-2">
            <div className="preview-orbit orbit-a" />
            <div className="preview-orbit orbit-b" />

            <div className="preview-card">
              <div className="preview-top">
                <div className="preview-avatar">V</div>

                <div>
                  <strong>Verva</strong>
                  <small>Conversation partner</small>
                </div>

                <span className="live-dot">●</span>
              </div>

              <div className="preview-bubble ai-bubble">
                Good morning! How are you today?
              </div>

              <div className="preview-wave">
                <span />
                <span />
                <span />
                <span />
                <span />
                <span />
                <span />
                <span />
                <span />
              </div>

              <div className="preview-answer">
                <small>Your turn</small>
                <p>“I'm good, thank you. How are you?”</p>
              </div>

              <div className="preview-next">
                NEXT <span>→</span>
              </div>
            </div>

            <div className="floating-chip chip-record">
              ● Recording ready
            </div>

            <div className="floating-chip chip-topic">
              Travel conversation
            </div>
          </div>
        </section>

        {/* ================= MARQUEE ================= */}

        <section className="marquee-strip" aria-label="Verva features">
          <div>
            <span>LISTEN</span>
            <b>•</b>
            <span>SPEAK</span>
            <b>•</b>
            <span>REPEAT</span>
            <b>•</b>
            <span>REPLAY</span>
            <b>•</b>
            <span>BUILD CONFIDENCE</span>
            <b>•</b>
            <span>LISTEN</span>
            <b>•</b>
            <span>SPEAK</span>
          </div>
        </section>

        {/* ================= FEATURES ================= */}

        <section
          className="landing-section intro-section"
          id="features"
        >
          <div className="section-kicker">
            A simpler way to practice
          </div>

          <div className="split-heading">
            <h2>
              Practice speaking,
              <br />
              <em>not just reading.</em>
            </h2>

            <p>
              Verva keeps the experience focused. You do not have to figure
              out what to say next. The conversation gives you a clear line,
              a clear response, and a clear next step.
            </p>
          </div>

          <div className="feature-grid-modern">
            {FEATURES.map((item) => (
              <article
                className="feature-modern"
                key={item.number}
              >
                <div className="feature-modern-top">
                  <span>{item.number}</span>
                  <b>{item.icon}</b>
                </div>

                <h3>{item.title}</h3>
                <p>{item.description}</p>
              </article>
            ))}
          </div>
        </section>

        {/* ================= HOW IT WORKS ================= */}

        <section
          className="landing-section how-section"
          id="how-it-works"
        >
          <div className="section-kicker">
            How to use Verva
          </div>

          <div className="split-heading">
            <h2>
              From setup to
              <br />
              <em>your last sentence.</em>
            </h2>

            <p>
              Everything you need for a complete practice session is built
              into one guided flow.
            </p>
          </div>

          <div className="steps-modern">
            {STEPS.map(([number, title, description]) => (
              <article
                className="step-modern"
                key={number}
              >
                <div className="step-number">{number}</div>

                <div className="step-line" />

                <div className="step-copy">
                  <h3>{title}</h3>
                  <p>{description}</p>
                </div>
              </article>
            ))}
          </div>
        </section>

        {/* ================= SETUP ================= */}

        <section
          className="landing-section setup-preview-section"
          id="practice"
        >
          <div className="setup-preview-copy">
            <div className="section-kicker">
              Your practice, your choice
            </div>

            <h2>
              Build a session
              <br />
              <em>that fits you.</em>
            </h2>

            <p>
              Choose the situation, difficulty, session length, voice and
              recording mode before you begin. All existing Verva practice
              options remain available.
            </p>

            <button
              className="btn btn-primary btn-lg"
              onClick={start}
            >
              Open Practice Setup →
            </button>
          </div>

          <div className="setup-mockup">
            <div className="mockup-header">
              <span>Practice setup</span>
              <small>Verva</small>
            </div>

            <div className="mock-label">TOPIC</div>

            <div className="mock-topics">
              {TOPICS.map((t, i) => (
                <span
                  className={i === 4 ? "selected" : ""}
                  key={t}
                >
                  {t}
                </span>
              ))}
            </div>

            <div className="mock-row">
              <div>
                <div className="mock-label">LEVEL</div>

                <div className="mock-options">
                  <span className="selected">Beginner</span>
                  <span>Intermediate</span>
                  <span>Advanced</span>
                </div>
              </div>

              <div>
                <div className="mock-label">DURATION</div>

                <div className="mock-options">
                  <span>5 min</span>
                  <span className="selected">10 min</span>
                  <span>15 min</span>
                  <span>25 min</span>
                </div>
              </div>
            </div>

            <div className="mock-row">
              <div>
                <div className="mock-label">AI VOICE</div>

                <div className="mock-options">
                  <span className="selected">♀ Female</span>
                  <span>♂ Male</span>
                </div>
              </div>

              <div>
                <div className="mock-label">RECORDING</div>

                <div className="mock-options">
                  <span className="selected">🎙 On</span>
                  <span>Off</span>
                </div>
              </div>
            </div>

            <button
              className="mock-start"
              onClick={start}
            >
              Start Practice <span>→</span>
            </button>
          </div>
        </section>

        {/* ================= ABOUT ================= */}

        <section
          className="landing-section about-section"
          id="about"
        >
          <div className="about-panel">
            <div className="section-kicker">
              About Verva
            </div>

            <h2>
              English practice should feel like a{" "}
              <em>conversation.</em>
            </h2>

            <p>
              Verva is designed around a simple idea: give learners a
              structured conversation they can follow without the pressure of
              a traditional classroom.
            </p>

            <p>
              The AI partner speaks first. The sentence appears on screen.
              Your suggested response is shown next. You say it aloud, press
              Next, and continue.
            </p>

            <p>
              When recording is enabled, your microphone captures your spoken
              session temporarily in the browser so you can review it after
              practice. The recording is not automatically stored in the Verva
              database.
            </p>

            <div className="about-values">
              <div>
                <strong>01</strong>
                <span>Simple</span>
                <small>No complicated lesson flow.</small>
              </div>

              <div>
                <strong>02</strong>
                <span>Focused</span>
                <small>One conversation turn at a time.</small>
              </div>

              <div>
                <strong>03</strong>
                <span>Flexible</span>
                <small>Choose your topic and session length.</small>
              </div>

              <div>
                <strong>04</strong>
                <span>Private by design</span>
                <small>
                  Session audio stays temporary unless you keep it.
                </small>
              </div>
            </div>
          </div>
        </section>

        {/* ================= CTA ================= */}

        <section className="final-cta">
          <div className="final-cta-glow" />

          <div className="section-kicker">
            Ready?
          </div>

          <h2>
            Your next sentence
            <br />
            <span>starts here.</span>
          </h2>

          <p>
            Choose a topic and start a guided speaking session.
          </p>

          <button
            className="btn btn-light btn-lg"
            onClick={start}
          >
            Start Practicing →
          </button>
        </section>
      </main>

      {/* ================= FOOTER ================= */}

      <footer className="app-footer landing-footer">
        <div className="footer-contact-box">

          <a
            className="footer-contact-card"
            href="https://www.youtube.com/@Digitaldefence365"
            target="_blank"
            rel="noopener noreferrer"
          >
            <div className="footer-contact-icon youtube-icon">
              ▶
            </div>

            <div className="footer-contact-content">
              <span className="footer-contact-label">
                YouTube Channel-
              </span>

              <strong>
                 Digital Defence 365 
              </strong>

              <small>
               || Tutorials, updates & more
              </small>
            </div>

            <span className="footer-contact-arrow">
              ↗
            </span>
          </a>

          <a
            className="footer-contact-card"
            href="mailto:sayvixaofficial@gmail.com"
          >
            <div className="footer-contact-icon mail-icon">
              ✉
            </div>

            <div className="footer-contact-content">
              <span className="footer-contact-label">
                Contact-
              </span>

              <strong>
                 sayvixaofficial@gmail.com 
              </strong>

              <small>
                || Questions, feedback & ideas
              </small>
            </div>

            <span className="footer-contact-arrow">
              →
            </span>
          </a>

        </div>

        <div className="app-footer-links">
          <a href="#top">Verva</a>

          <span>•</span>

          <a href="#how-it-works">
            How to Use
          </a>

          <span>•</span>

          <a href="#about">
            About
          </a>
        </div>

        <p>
          Verva — a simple way to practice spoken English.
        </p>
      </footer>
    </div>
  );
}