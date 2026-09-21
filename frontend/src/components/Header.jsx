import {
  Link,
  useNavigate,
  useLocation,
} from "react-router-dom";

import { useAuth } from "../context/AuthContext";

export default function Header() {
  const { user, loading, logout } = useAuth();

  const navigate = useNavigate();
  const location = useLocation();

  function handleLogout() {
    logout();

    /*
     * After logout, always return to Home.
     */
    navigate("/", { replace: true });
  }

  function homeAnchor(id) {
    if (location.pathname === "/") {
      return `#${id}`;
    }

    return `/#${id}`;
  }

  return (
    <header className="app-header modern-header">
      {/* =========================
          LEFT SIDE
      ========================== */}

      <div className="app-header-left">
        {location.pathname !== "/" && (
          <button
            className="back-btn"
            onClick={() => navigate(-1)}
            aria-label="Go back"
          >
            ←
          </button>
        )}

        <Link
          to="/"
          className="app-logo"
          aria-label="Verva Home"
        >
          <span className="logo-wordmark">
            verva<span>.</span>
          </span>
        </Link>
      </div>

      {/* =========================
          NAVIGATION
      ========================== */}

      <nav className="app-nav modern-nav">

        {/* HOME BUTTON */}

        <Link
          className="app-nav-link"
          to="/"
        >
          Home
        </Link>

        {/* HOW TO USE */}

        <a
          className="app-nav-link"
          href={homeAnchor("how-it-works")}
        >
          How to Use
        </a>

        {/* ABOUT */}

        <a
          className="app-nav-link"
          href={homeAnchor("about")}
        >
          About
        </a>

        {/* =========================
            AUTHENTICATION
        ========================== */}

        {loading ? null : user ? (
          <>
            <span className="app-nav-name">
              Hi, {user.displayName}
            </span>

            <button
              className="btn btn-secondary btn-sm"
              onClick={handleLogout}
              type="button"
            >
              Log Out
            </button>
          </>
        ) : (
          <>
            <Link
              className="nav-login"
              to="/login"
            >
              Log In
            </Link>

            <Link
              className="nav-signup"
              to="/register"
            >
              Sign Up <span>→</span>
            </Link>
          </>
        )}
      </nav>
    </header>
  );
}