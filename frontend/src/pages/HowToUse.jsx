import { Link } from "react-router-dom";
import Header from "../components/Header";

const STEPS = [
  {
    number: "01",
    title: "Get Started",
    description:
      "From the home page, press \"Get Started\". You'll land on the setup screen where every session begins.",
  },
  {
    number: "02",
    title: "Choose Your Topic",
    description:
      "Pick from 19 real-life topics — Restaurant, Job Interview, Travel, Meeting Someone, and more. Each one has natural, everyday conversations.",
  },
  {
    number: "03",
    title: "Pick Your Level",
    description:
      "Choose Beginner, Intermediate, or Advanced. Sentences get more natural and nuanced as the level goes up.",
  },
  {
    number: "04",
    title: "Set Your Duration",
    description:
      "Practice for 5, 10, 15, or 25 minutes — whatever fits your schedule. The conversation keeps going until time's up.",
  },
  {
    number: "05",
    title: "Choose Your AI Voice",
    description:
      "Pick a female or male AI voice for the conversation partner — whichever you find easier to follow.",
  },
  {
    number: "06",
    title: "Recording On or Off",
    description:
      "Turn microphone recording on to hear yourself back afterward, or turn it off to practice without using your mic at all.",
  },
  {
    number: "07",
    title: "Follow the Conversation",
    description:
      "The AI avatar speaks a line out loud and shows it on screen. Right below it, you'll see a suggested sentence — say it out loud yourself.",
  },
  {
    number: "08",
    title: "Press NEXT",
    description:
      "When you're ready, press NEXT. The AI speaks the next line automatically, and your microphone keeps recording the whole time (if enabled).",
  },
  {
    number: "09",
    title: "Keep Going Until Time's Up",
    description:
      "The timer counts down your chosen duration. If you finish all the lines for a topic, they'll cycle again without repeating back to back.",
  },
  {
    number: "10",
    title: "Review Your Session",
    description:
      "At the end, listen to your full recording, or press \"Play Full Conversation\" to hear the AI's lines and your responses together, turn by turn.",
  },
];

export default function HowToUse() {
  return (
    <div className="page">
      <Header />

      <section className="howto-hero">
        <span className="hero-eyebrow">Guide</span>
        <h1 className="howto-title">How to Use Verva</h1>
        <p className="howto-subtitle">
          A simple, guided way to practice spoken English — here's exactly how it works, start to
          finish.
        </p>
      </section>

      <section className="howto-steps">
        {STEPS.map((step) => (
          <div className="howto-step card" key={step.number}>
            <div className="howto-step-number">{step.number}</div>
            <div className="howto-step-body">
              <h3>{step.title}</h3>
              <p>{step.description}</p>
            </div>
          </div>
        ))}
      </section>

      <section className="cta">
        <div className="cta-card card">
          <h2>Ready to try it yourself?</h2>
          <p>It takes less than a minute to set up your first session.</p>
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