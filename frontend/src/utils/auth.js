const API_URL = import.meta.env.VITE_API_URL || "http://localhost:5000";
const TOKEN_KEY = "verva_token";

export function getToken() {
  return localStorage.getItem(TOKEN_KEY);
}

function setToken(token) {
  localStorage.setItem(TOKEN_KEY, token);
}

export function clearToken() {
  localStorage.removeItem(TOKEN_KEY);
}

async function request(path, options = {}) {
  const token = getToken();
  const headers = { "Content-Type": "application/json", ...(options.headers || {}) };
  if (token) headers.Authorization = `Bearer ${token}`;

  const res = await fetch(`${API_URL}${path}`, { ...options, headers });

  let data;
  try {
    data = await res.json();
  } catch (err) {
    throw new Error("Unexpected response from the server. Please try again.");
  }

  if (!res.ok) {
    throw new Error(data.message || "Something went wrong. Please try again.");
  }

  return data;
}

export async function registerUser({ displayName, email, password }) {
  const data = await request("/api/auth/register", {
    method: "POST",
    body: JSON.stringify({ displayName, email, password }),
  });
  setToken(data.token);
  return data.user;
}

export async function loginUser({ email, password }) {
  const data = await request("/api/auth/login", {
    method: "POST",
    body: JSON.stringify({ email, password }),
  });
  setToken(data.token);
  return data.user;
}

// Returns null (not throw) if there's no token or it's invalid/expired —
// callers treat that as "not logged in" rather than an error.
export async function fetchCurrentUser() {
  if (!getToken()) return null;
  try {
    const data = await request("/api/auth/me", { method: "GET" });
    return data.user;
  } catch (err) {
    clearToken();
    return null;
  }
}

export async function updatePreferredVoice(voiceName) {
  const data = await request("/api/auth/me", {
    method: "PATCH",
    body: JSON.stringify({ preferredVoice: voiceName }),
  });
  return data.user;
}

export async function requestPasswordReset(email) {
  return request("/api/auth/forgot-password", {
    method: "POST",
    body: JSON.stringify({ email }),
  });
}

export async function resetPassword({ email, code, newPassword }) {
  return request("/api/auth/reset-password", {
    method: "POST",
    body: JSON.stringify({ email, code, newPassword }),
  });
}

export function logoutUser() {
  clearToken();
}
