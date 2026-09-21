import { Link } from "react-router-dom";
import Header from "../components/Header";

export default function About() {
  return (
    <div className="page">
      <Header />

      <section className="about-hero">
        <span className="hero-eyebrow">
          About
        </span>

        <h1 className="about-title">
          About Verva
        </h1>

        <p className="about-subtitle">
          Verva was built to make spoken English practice simple — no grading,
          no judgment, just a guided conversation partner and a way to hear
          your own progress.
        </p>
      </section>

      <section className="about-content">

        {/* YouTube */}

        <a
          className="about-card card about-card-link"
          href="https://www.youtube.com/@Digitaldefence365"
          target="_blank"
          rel="noopener noreferrer"
        >
          <div className="about-card-icon youtube-card-icon">
            ▶
          </div>

          <div className="about-card-number">
            01
          </div>

          <h2>
            Watch on YouTube
          </h2>

          <p>
            Follow along for tutorials, updates, English practice content,
            and more on the channel behind Verva.
          </p>

          <div className="about-card-action">
            <span>
              Digital Defence 365
            </span>

            <strong>
              ↗
            </strong>
          </div>
        </a>

        {/* Contact */}

        <a
          className="about-card card about-card-link"
          href="mailto:sayvixaofficial@gmail.com"
        >
          <div className="about-card-icon mail-card-icon">
            ✉
          </div>

          <div className="about-card-number">
            02
          </div>

          <h2>
            Get in Touch
          </h2>

          <p>
            Questions, feedback, suggestions, or ideas for Verva?
            Reach out directly.
          </p>

          <div className="about-card-action">
            <span>
              sayvixaofficial@gmail.com
            </span>

            <strong>
              →
            </strong>
          </div>
        </a>

      </section>

      <section className="cta">
        <div className="cta-card card">
          <h2>
            Ready to practice?
          </h2>

          <p>
            Pick a topic, choose your level, and start speaking in less than
            a minute.
          </p>

          <Link
            className="btn btn-primary btn-lg"
            to="/setup"
          >
            Get Started
          </Link>
        </div>
      </section>

      <footer className="app-footer">

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
                YouTube Channel
              </span>

              <strong>
                Digital Defence 365
              </strong>

              <small>
                Tutorials, updates & more
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
                Contact
              </span>

              <strong>
                sayvixaofficial@gmail.com
              </strong>

              <small>
                Questions, feedback & ideas
              </small>
            </div>

            <span className="footer-contact-arrow">
              →
            </span>
          </a>

        </div>

        <div className="app-footer-links">

          <Link to="/">
            Verva
          </Link>

          <span className="app-footer-dot">
            •
          </span>

          <Link to="/how-to-use">
            How to Use
          </Link>

          <span className="app-footer-dot">
            •
          </span>

          <Link to="/about">
            About
          </Link>

        </div>

        <p>
          Verva — a simple way to practice spoken English.
        </p>

      </footer>
    </div>
  );
}