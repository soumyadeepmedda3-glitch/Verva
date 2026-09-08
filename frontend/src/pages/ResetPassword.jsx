import { useState } from "react";
import { Link, useNavigate, useLocation } from "react-router-dom";
import Header from "../components/Header";
import { resetPassword } from "../utils/auth";

export default function ResetPassword() {
    const navigate = useNavigate();
    const location = useLocation();

    const [email, setEmail] = useState(location.state?.email || "");
    const [code, setCode] = useState("");
    const [newPassword, setNewPassword] = useState("");
    const [error, setError] = useState("");
    const [submitting, setSubmitting] = useState(false);
    const [done, setDone] = useState(false);

    async function handleSubmit(e) {
        e.preventDefault();
        setError("");

        if (!email || !code || !newPassword) {
            setError("Please fill in all fields.");
            return;
        }
        if (newPassword.length < 8) {
            setError("Password must be at least 8 characters long.");
            return;
        }

        setSubmitting(true);
        try {
            await resetPassword({ email, code, newPassword });
            setDone(true);
        } catch (err) {
            setError(err.message || "Could not reset your password. Please try again.");
        } finally {
            setSubmitting(false);
        }
    }

    if (done) {
        return (
            <div className="page">
                <Header />
                <div className="auth-screen">
                    <div className="auth-card card">
                        <h1>Password reset</h1>
                        <p className="auth-subtitle">Your password has been updated. You can log in now.</p>
                        <button className="btn btn-primary btn-lg" onClick={() => navigate("/login")}>
                            Go to Log In
                        </button>
                    </div>
                </div>
            </div>
        );
    }

    return (
        <div className="page">
            <Header />
            <div className="auth-screen">
                <div className="auth-card card">
                    <h1>Reset your password</h1>
                    <p className="auth-subtitle">Enter the code we emailed you and choose a new password.</p>

                    {error && <div className="banner banner-error">{error}</div>}

                    <form className="auth-form" onSubmit={handleSubmit}>
                        <label className="setup-label" htmlFor="reset-email">
                            Email
                        </label>
                        <input
                            id="reset-email"
                            type="email"
                            className="text-input"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                            autoComplete="email"
                            required
                        />

                        <label className="setup-label" htmlFor="reset-code">
                            Reset Code
                        </label>
                        <input
                            id="reset-code"
                            type="text"
                            inputMode="numeric"
                            maxLength={6}
                            className="text-input"
                            value={code}
                            onChange={(e) => setCode(e.target.value.replace(/\D/g, ""))}
                            placeholder="6-digit code"
                            required
                        />

                        <label className="setup-label" htmlFor="reset-new-password">
                            New Password
                        </label>
                        <input
                            id="reset-new-password"
                            type="password"
                            className="text-input"
                            value={newPassword}
                            onChange={(e) => setNewPassword(e.target.value)}
                            autoComplete="new-password"
                            required
                        />
                        <p className="auth-hint">At least 8 characters.</p>

                        <button className="btn btn-primary btn-lg" type="submit" disabled={submitting}>
                            {submitting ? "Resetting..." : "Reset Password"}
                        </button>
                    </form>

                    <p className="auth-switch">
                        Didn&apos;t get a code? <Link to="/forgot-password">Request again</Link>
                    </p>
                </div>
            </div>
        </div>
    );
}
