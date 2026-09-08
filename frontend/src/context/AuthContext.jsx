import { createContext, useContext, useEffect, useState } from "react";
import {
  fetchCurrentUser,
  loginUser,
  registerUser,
  logoutUser,
} from "../utils/auth";

const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  // True only while we're checking for an existing session on first load.
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      const current = await fetchCurrentUser();
      if (!cancelled) {
        setUser(current);
        setLoading(false);
      }
    })();
    return () => {
      cancelled = true;
    };
  }, []);

  async function login(credentials) {
    const loggedInUser = await loginUser(credentials);
    setUser(loggedInUser);
    return loggedInUser;
  }

  async function register(details) {
    const newUser = await registerUser(details);
    setUser(newUser);
    return newUser;
  }

  function logout() {
    logoutUser();
    setUser(null);
  }

  function updateUser(patch) {
    setUser((prev) => (prev ? { ...prev, ...patch } : prev));
  }

  const value = { user, loading, login, register, logout, updateUser };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuth() {
  const ctx = useContext(AuthContext);
  if (!ctx) {
    throw new Error("useAuth must be used within an AuthProvider");
  }
  return ctx;
}
