import { createContext, useContext, useEffect, useState } from "react";

import {
  fetchCurrentUser,
  loginUser,
  registerUser,
  logoutUser,
  getToken,
  clearToken,
} from "../utils/auth";

const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null);

  // Only true while checking the existing login session.
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;

    async function checkExistingSession() {
      /*
       * If there is no token, there is no logged-in session
       * to check.
       *
       * This is important because otherwise the app would
       * call /api/auth/me unnecessarily and loading could
       * remain stuck.
       */
      const token = getToken();

      if (!token) {
        if (!cancelled) {
          setUser(null);
          setLoading(false);
        }

        return;
      }

      try {
        const current = await fetchCurrentUser();

        if (!cancelled) {
          /*
           * Backend returns:
           *
           * {
           *   success: true,
           *   user: {...}
           * }
           *
           * So store current.user.
           */
          setUser(current?.user || null);
        }
      } catch (error) {
        /*
         * Token may be expired/invalid or the server may
         * currently be unavailable.
         *
         * If the existing token cannot authenticate,
         * clear it so the app returns to logged-out state.
         */
        console.error(
          "Could not restore login session:",
          error.message
        );

        clearToken();

        if (!cancelled) {
          setUser(null);
        }
      } finally {
        if (!cancelled) {
          setLoading(false);
        }
      }
    }

    checkExistingSession();

    return () => {
      cancelled = true;
    };
  }, []);

  // -------------------------
  // LOGIN
  // -------------------------

  async function login(credentials) {
    const response = await loginUser(credentials);

    /*
     * Backend returns:
     * {
     *   success: true,
     *   token: "...",
     *   user: {...}
     * }
     */
    const loggedInUser = response?.user || null;

    setUser(loggedInUser);

    return loggedInUser;
  }

  // -------------------------
  // REGISTER
  // -------------------------

  async function register(details) {
    const response = await registerUser(details);

    /*
     * Backend returns the newly-created user
     * inside response.user.
     */
    const newUser = response?.user || null;

    setUser(newUser);

    return newUser;
  }

  // -------------------------
  // LOGOUT
  // -------------------------

  function logout() {
    logoutUser();

    setUser(null);
  }

  // -------------------------
  // UPDATE USER
  // -------------------------

  function updateUser(patch) {
    setUser((previousUser) =>
      previousUser
        ? {
            ...previousUser,
            ...patch,
          }
        : previousUser
    );
  }

  const value = {
    user,
    loading,
    login,
    register,
    logout,
    updateUser,
  };

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);

  if (!context) {
    throw new Error(
      "useAuth must be used within an AuthProvider"
    );
  }

  return context;
}