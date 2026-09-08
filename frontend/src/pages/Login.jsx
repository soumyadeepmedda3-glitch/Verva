import { useState } from "react";
import { Link, useNavigate, useLocation } from "react-router-dom";
import Header from "../components/Header";
import { useAuth } from "../context/AuthContext";

export default function Login() {
  const { login } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [submitting, setSubmitting] = useState(false);

  const redirectTo = location.state?.from || "/setup";

  async function handleSubmit(e) {
    e.preventDefault();
    setError("");

    if (!email || !password) {
      setError("Please enter your email and password.");
      return;
    }

    setSubmitting(true);
    try {
      await login({ email, password });
      navigate(redirectTo, { replace: true });
    } catch (err) {
      setError(err.message || "Could not log in. Please try again.");
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <div className="page">
      <Header />
      <div className="auth-screen">
        <div className="auth-card card">
          <h1>Log in</h1>
          <p className="auth-subtitle">Welcome back to Verva.</p>

          {error && <div className="banner banner-error">{error}</div>}

          <form className="auth-form" onSubmit={handleSubmit}>
            <label className="setup-label" htmlFor="login-email">
              Email
            </label>
            <input
              id="login-email"
              type="email"
              className="text-input"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              autoComplete="email"
              required
            />

            <label className="setup-label" htmlFor="login-password">
              Password
            </label>
            <input
              id="login-password"
              type="password"
              className="text-input"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              autoComplete="current-password"
              required
            />
            <Link to="/forgot-password" className="auth-forgot-link">
              Forgot password?
            </Link>

            <button className="btn btn-primary btn-lg" type="submit" disabled={submitting}>
              {submitting ? "Logging in..." : "Log In"}
            </button>
          </form>

          <p className="auth-switch">
            Don&apos;t have an account? <Link to="/register">Create one</Link>
          </p>
        </div>
      </div>
    </div>
  );
}
