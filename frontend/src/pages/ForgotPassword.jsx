import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import Header from "../components/Header";
import { requestPasswordReset } from "../utils/auth";

export default function ForgotPassword() {
    const navigate = useNavigate();

    const [email, setEmail] = useState("");
    const [error, setError] = useState("");
    const [submitting, setSubmitting] = useState(false);
    const [sent, setSent] = useState(false);

    async function handleSubmit(e) {
        e.preventDefault();
        setError("");

        if (!email) {
            setError("Please enter your email address.");
            return;
        }

        setSubmitting(true);
        try {
            await requestPasswordReset(email);
            setSent(true);
        } catch (err) {
            setError(err.message || "Could not send the reset code. Please try again.");
        } finally {
            setSubmitting(false);
        }
    }

    return (
        <div className="page">
            <Header />
            <div className="auth-screen">
                <div className="auth-card card">
                    <h1>Forgot your password?</h1>
                    <p className="auth-subtitle">Enter your email and we&apos;ll send you a reset code.</p>

                    {error && <div className="banner banner-error">{error}</div>}

                    {sent ? (
                        <>
                            <div className="banner banner-info">
                                If an account exists for that email, a reset code is on its way. Check your inbox.
                            </div>
                            <button
                                className="btn btn-primary btn-lg"
                                onClick={() => navigate("/reset-password", { state: { email } })}
                            >
                                I have my code
                            </button>
                        </>
                    ) : (
                        <form className="auth-form" onSubmit={handleSubmit}>
                            <label className="setup-label" htmlFor="forgot-email">
                                Email
                            </label>
                            <input
                                id="forgot-email"
                                type="email"
                                className="text-input"
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
                                autoComplete="email"
                                required
                            />
                            <button className="btn btn-primary btn-lg" type="submit" disabled={submitting}>
                                {submitting ? "Sending..." : "Send Reset Code"}
                            </button>
                        </form>
                    )}

                    <p className="auth-switch">
                        Remembered your password? <Link to="/login">Log in</Link>
                    </p>
                </div>
            </div>
        </div>
    );
}
