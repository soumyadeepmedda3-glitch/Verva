const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const { pool } = require("../config/db");
const { sendPasswordResetEmail } = require("../config/mailer");

const TOKEN_EXPIRY = "7d";
const SALT_ROUNDS = 10;
const RESET_CODE_EXPIRY_MINUTES = 15;

function isValidEmail(email) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function generateResetCode() {
  return String(Math.floor(100000 + Math.random() * 900000)); // 6 digits
}

function signToken(user) {
  return jwt.sign(
    { sub: user.id, email: user.email, displayName: user.display_name },
    process.env.JWT_SECRET,
    { expiresIn: TOKEN_EXPIRY }
  );
}

function toPublicUser(row) {
  return {
    id: row.id,
    email: row.email,
    displayName: row.display_name,
    preferredVoice: row.preferred_voice || null,
  };
}

// POST /api/auth/register
async function register(req, res) {
  const { displayName, email, password } = req.body || {};

  if (!displayName || !email || !password) {
    return res.status(400).json({
      success: false,
      message: "Name, email, and password are all required.",
    });
  }
  if (!isValidEmail(email)) {
    return res.status(400).json({ success: false, message: "Please enter a valid email address." });
  }
  if (password.length < 8) {
    return res.status(400).json({
      success: false,
      message: "Password must be at least 8 characters long.",
    });
  }

  const normalizedEmail = email.trim().toLowerCase();

  try {
    const [existing] = await pool.query("SELECT id FROM users WHERE email = ?", [normalizedEmail]);
    if (existing.length > 0) {
      return res.status(409).json({
        success: false,
        message: "An account with this email already exists. Try logging in instead.",
      });
    }

    const passwordHash = await bcrypt.hash(password, SALT_ROUNDS);

    const [result] = await pool.query(
      "INSERT INTO users (display_name, email, password_hash) VALUES (?, ?, ?)",
      [displayName.trim(), normalizedEmail, passwordHash]
    );

    const userRow = {
      id: result.insertId,
      display_name: displayName.trim(),
      email: normalizedEmail,
      preferred_voice: null,
    };

    const token = signToken(userRow);
    res.status(201).json({ success: true, token, user: toPublicUser(userRow) });
  } catch (err) {
    console.error("register error:", err.message);
    res.status(500).json({
      success: false,
      message: "Could not create your account right now. Please try again later.",
    });
  }
}

// POST /api/auth/login
async function login(req, res) {
  const { email, password } = req.body || {};

  if (!email || !password) {
    return res.status(400).json({ success: false, message: "Email and password are required." });
  }

  const normalizedEmail = email.trim().toLowerCase();

  try {
    const [rows] = await pool.query(
      "SELECT id, display_name, email, password_hash, preferred_voice FROM users WHERE email = ?",
      [normalizedEmail]
    );

    // Same generic message whether the email or the password was wrong,
    // so we don't reveal which emails have accounts.
    if (rows.length === 0) {
      return res.status(401).json({ success: false, message: "Invalid email or password." });
    }

    const userRow = rows[0];
    const passwordMatches = await bcrypt.compare(password, userRow.password_hash);

    if (!passwordMatches) {
      return res.status(401).json({ success: false, message: "Invalid email or password." });
    }

    const token = signToken(userRow);
    res.json({ success: true, token, user: toPublicUser(userRow) });
  } catch (err) {
    console.error("login error:", err.message);
    res.status(500).json({
      success: false,
      message: "Could not log you in right now. Please try again later.",
    });
  }
}

// GET /api/auth/me  (requires authRequired middleware)
async function me(req, res) {
  try {
    const [rows] = await pool.query(
      "SELECT id, display_name, email, preferred_voice FROM users WHERE id = ?",
      [req.user.id]
    );

    if (rows.length === 0) {
      return res.status(404).json({ success: false, message: "User account not found." });
    }

    res.json({ success: true, user: toPublicUser(rows[0]) });
  } catch (err) {
    console.error("me error:", err.message);
    res.status(500).json({ success: false, message: "Could not load your profile." });
  }
}

// PATCH /api/auth/me  (requires authRequired middleware)
// Currently only supports updating the preferred TTS voice name — this
// is the hook point for the "custom voice per user" feature.
async function updateMe(req, res) {
  const { preferredVoice } = req.body || {};

  try {
    await pool.query("UPDATE users SET preferred_voice = ? WHERE id = ?", [
      preferredVoice || null,
      req.user.id,
    ]);

    const [rows] = await pool.query(
      "SELECT id, display_name, email, preferred_voice FROM users WHERE id = ?",
      [req.user.id]
    );

    res.json({ success: true, user: toPublicUser(rows[0]) });
  } catch (err) {
    console.error("updateMe error:", err.message);
    res.status(500).json({ success: false, message: "Could not update your profile." });
  }
}

// POST /api/auth/forgot-password
// Always responds with the same generic message whether or not the email
// has an account, so this endpoint can't be used to discover accounts.
async function forgotPassword(req, res) {
  const { email } = req.body || {};

  if (!email || !isValidEmail(email)) {
    return res.status(400).json({ success: false, message: "Please enter a valid email address." });
  }

  const normalizedEmail = email.trim().toLowerCase();
  const genericMessage = "If an account exists for that email, we've sent a password reset code.";

  try {
    const [rows] = await pool.query("SELECT id FROM users WHERE email = ?", [normalizedEmail]);

    if (rows.length > 0) {
      const code = generateResetCode();
      const codeHash = await bcrypt.hash(code, SALT_ROUNDS);
      const expiresAt = new Date(Date.now() + RESET_CODE_EXPIRY_MINUTES * 60 * 1000);

      await pool.query(
        "UPDATE users SET reset_code_hash = ?, reset_code_expires = ? WHERE id = ?",
        [codeHash, expiresAt, rows[0].id]
      );

      try {
        await sendPasswordResetEmail(normalizedEmail, code);
      } catch (mailErr) {
        // Log it, but don't change the response — that would leak whether
        // the email exists based on delivery success/failure.
        console.error("sendPasswordResetEmail error:", mailErr.message);
      }
    }

    res.json({ success: true, message: genericMessage });
  } catch (err) {
    console.error("forgotPassword error:", err.message);
    res.status(500).json({
      success: false,
      message: "Could not process your request right now. Please try again later.",
    });
  }
}

// POST /api/auth/reset-password
async function resetPassword(req, res) {
  const { email, code, newPassword } = req.body || {};

  if (!email || !code || !newPassword) {
    return res.status(400).json({
      success: false,
      message: "Email, code, and new password are all required.",
    });
  }
  if (newPassword.length < 8) {
    return res.status(400).json({
      success: false,
      message: "Password must be at least 8 characters long.",
    });
  }

  const normalizedEmail = email.trim().toLowerCase();
  const invalidCodeMessage = "Invalid or expired reset code.";

  try {
    const [rows] = await pool.query(
      "SELECT id, reset_code_hash, reset_code_expires FROM users WHERE email = ?",
      [normalizedEmail]
    );

    if (rows.length === 0) {
      return res.status(400).json({ success: false, message: invalidCodeMessage });
    }

    const userRow = rows[0];

    if (!userRow.reset_code_hash || !userRow.reset_code_expires) {
      return res.status(400).json({ success: false, message: invalidCodeMessage });
    }

    if (new Date(userRow.reset_code_expires).getTime() < Date.now()) {
      return res.status(400).json({
        success: false,
        message: "This reset code has expired. Please request a new one.",
      });
    }

    const codeMatches = await bcrypt.compare(code, userRow.reset_code_hash);
    if (!codeMatches) {
      return res.status(400).json({ success: false, message: invalidCodeMessage });
    }

    const newPasswordHash = await bcrypt.hash(newPassword, SALT_ROUNDS);

    await pool.query(
      "UPDATE users SET password_hash = ?, reset_code_hash = NULL, reset_code_expires = NULL WHERE id = ?",
      [newPasswordHash, userRow.id]
    );

    res.json({ success: true, message: "Your password has been reset. You can now log in." });
  } catch (err) {
    console.error("resetPassword error:", err.message);
    res.status(500).json({
      success: false,
      message: "Could not reset your password right now. Please try again later.",
    });
  }
}

module.exports = { register, login, me, updateMe, forgotPassword, resetPassword };