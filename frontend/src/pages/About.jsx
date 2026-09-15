import { Link } from "react-router-dom";
import Header from "../components/Header";

export default function About() {
  return (
    <div className="page">
      <Header />

      <section className="about-hero">
        <span className="hero-eyebrow">About</span>
        <h1 className="about-title">About Verva</h1>
        <p className="about-subtitle">
          Verva was built to make spoken English practice simple — no grading, no judgment, just
          a guided conversation partner and a way to hear your own progress.
        </p>
      </section>

      <section className="about-content">
        <div className="about-card card">
          <h2>📺 Watch on YouTube</h2>
          <p>
            Follow along for tutorials, updates, and more on the channel behind Verva.
          </p>
          <a
            className="btn btn-primary"
            href="https://youtube.com/@digitaldefence365?si=agrCsTskDAq1_L0D"
            target="_blank"
            rel="noopener noreferrer"
          >
            Visit the Channel
          </a>
        </div>

        <div className="about-card card">
          <h2>✉️ Get in Touch</h2>
          <p>Questions, feedback, or ideas for Verva? Reach out directly.</p>
          <a className="btn btn-secondary" href="mailto:mrrrr8024@gmail.com">
            mrrrr8024@gmail.com
          </a>
        </div>
      </section>

      <section className="cta">
        <div className="cta-card card">
          <h2>Ready to practice?</h2>
          <p>Pick a topic, choose your level, and start speaking in less than a minute.</p>
          <Link className="btn btn-primary btn-lg" to="/setup">
            Get Started
          </Link>
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