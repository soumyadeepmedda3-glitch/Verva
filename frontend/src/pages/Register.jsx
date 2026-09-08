import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import Header from "../components/Header";
import { useAuth } from "../context/AuthContext";

export default function Register() {
  const { register } = useAuth();
  const navigate = useNavigate();

  const [displayName, setDisplayName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [submitting, setSubmitting] = useState(false);

  async function handleSubmit(e) {
    e.preventDefault();
    setError("");

    if (!displayName || !email || !password) {
      setError("Please fill in all fields.");
      return;
    }
    if (password.length < 8) {
      setError("Password must be at least 8 characters long.");
      return;
    }

    setSubmitting(true);
    try {
      await register({ displayName, email, password });
      navigate("/setup", { replace: true });
    } catch (err) {
      setError(err.message || "Could not create your account. Please try again.");
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <div className="page">
      <Header />
      <div className="auth-screen">
        <div className="auth-card card">
          <h1>Create your account</h1>
          <p className="auth-subtitle">Sign up to save preferences across sessions.</p>

          {error && <div className="banner banner-error">{error}</div>}

          <form className="auth-form" onSubmit={handleSubmit}>
            <label className="setup-label" htmlFor="register-name">
              Name
            </label>
            <input
              id="register-name"
              type="text"
              className="text-input"
              value={displayName}
              onChange={(e) => setDisplayName(e.target.value)}
              autoComplete="name"
              required
            />

            <label className="setup-label" htmlFor="register-email">
              Email
            </label>
            <input
              id="register-email"
              type="email"
              className="text-input"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              autoComplete="email"
              required
            />

            <label className="setup-label" htmlFor="register-password">
              Password
            </label>
            <input
              id="register-password"
              type="password"
              className="text-input"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              autoComplete="new-password"
              required
            />
            <p className="auth-hint">At least 8 characters.</p>

            <button className="btn btn-primary btn-lg" type="submit" disabled={submitting}>
              {submitting ? "Creating account..." : "Create Account"}
            </button>
          </form>

          <p className="auth-switch">
            Already have an account? <Link to="/login">Log in</Link>
          </p>
        </div>
      </div>
    </div>
  );
}
