import { Link, useNavigate } from "react-router-dom";
import { useAuth } from "../context/AuthContext";

export default function Header() {
  const { user, loading, logout } = useAuth();
  const navigate = useNavigate();

  function handleLogout() {
    logout();
    navigate("/");
  }

  return (
    <header className="app-header">
      <Link to="/" className="app-logo">
        <span className="app-logo-mark">🗣️</span>
        <span>Verva</span>
      </Link>

      <nav className="app-nav">
        {loading ? null : user ? (
          <>
            <span className="app-nav-name">Hi, {user.displayName}</span>
            <button className="btn btn-secondary btn-sm" onClick={handleLogout}>
              Log Out
            </button>
          </>
        ) : (
          <>
            <Link className="btn btn-secondary btn-sm" to="/login">
              Log In
            </Link>
            <Link className="btn btn-primary btn-sm" to="/register">
              Sign Up
            </Link>
          </>
        )}
      </nav>
    </header>
  );
}
