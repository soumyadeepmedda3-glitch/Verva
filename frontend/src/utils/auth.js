const API_URL =
  import.meta.env.VITE_API_URL || "http://localhost:5000";

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

async function request(path, options = {}, timeoutMs = 20000) {
  const token = getToken();

  const headers = {
    "Content-Type": "application/json",
    ...(options.headers || {}),
  };

  if (token) {
    headers.Authorization = `Bearer ${token}`;
  }

  const controller = new AbortController();

  const timeoutId = setTimeout(() => {
    controller.abort();
  }, timeoutMs);

  try {
    const response = await fetch(`${API_URL}${path}`, {
      ...options,
      headers,
      signal: controller.signal,
    });

    let data;

    try {
      data = await response.json();
    } catch {
      throw new Error(
        "Unexpected response from the server."
      );
    }

    if (!response.ok) {
      throw new Error(
        data.message ||
          "Something went wrong. Please try again."
      );
    }

    return data;
  } catch (error) {
    if (error.name === "AbortError") {
      throw new Error(
        "The request took too long. Please check your connection and try again."
      );
    }

    if (
      error instanceof TypeError ||
      error.message === "Failed to fetch"
    ) {
      throw new Error(
        "Could not connect to the server. Please try again."
      );
    }

    throw error;
  } finally {
    clearTimeout(timeoutId);
  }
}

// -------------------------
// REGISTER
// -------------------------

export async function registerUser({
  displayName,
  email,
  password,
}) {
  const data = await request(
    "/api/auth/register",
    {
      method: "POST",
      body: JSON.stringify({
        displayName,
        email,
        password,
      }),
    }
  );

  if (data.token) {
    setToken(data.token);
  }

  return data;
}

// -------------------------
// LOGIN
// -------------------------

export async function loginUser({
  email,
  password,
}) {
  const data = await request(
    "/api/auth/login",
    {
      method: "POST",
      body: JSON.stringify({
        email,
        password,
      }),
    }
  );

  if (data.token) {
    setToken(data.token);
  }

  return data;
}

// -------------------------
// CURRENT USER
// -------------------------

export async function fetchCurrentUser() {
  return request("/api/auth/me");
}

// -------------------------
// UPDATE VOICE
// -------------------------

export async function updatePreferredVoice(
  voiceName
) {
  return request(
    "/api/auth/me",
    {
      method: "PATCH",
      body: JSON.stringify({
        preferredVoice: voiceName,
      }),
    }
  );
}

// -------------------------
// FORGOT PASSWORD
// -------------------------

export async function requestPasswordReset(email) {
  return request(
    "/api/auth/forgot-password",
    {
      method: "POST",
      body: JSON.stringify({
        email: email.trim().toLowerCase(),
      }),
    },
    25000
  );
}

// -------------------------
// RESET PASSWORD
// -------------------------

export async function resetPassword({
  email,
  code,
  newPassword,
}) {
  return request(
    "/api/auth/reset-password",
    {
      method: "POST",
      body: JSON.stringify({
        email: email.trim().toLowerCase(),
        code: String(code).trim(),
        newPassword,
      }),
    }
  );
}

// -------------------------
// LOGOUT
// -------------------------

export function logoutUser() {
  clearToken();
}