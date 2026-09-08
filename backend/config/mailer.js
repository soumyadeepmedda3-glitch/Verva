const nodemailer = require("nodemailer");
require("dotenv").config();

let transporter = null;

function getTransporter() {
  if (transporter) return transporter;

  if (!process.env.SMTP_HOST) {
    return null; // not configured — caller falls back to console logging
  }

  transporter = nodemailer.createTransport({
    host: process.env.SMTP_HOST,
    port: Number(process.env.SMTP_PORT) || 587,
    secure: Number(process.env.SMTP_PORT) === 465,
    auth: process.env.SMTP_USER
      ? { user: process.env.SMTP_USER, pass: process.env.SMTP_PASS }
      : undefined,
  });

  return transporter;
}

/**
 * Sends a password reset code to the given email address.
 * If SMTP isn't configured (no SMTP_HOST in .env), the code is logged
 * to the server console instead, so local development works without a
 * real mail server.
 */
async function sendPasswordResetEmail(toEmail, code) {
  const appName = process.env.APP_NAME || "Verva";
  const subject = `${appName} password reset code`;
  const text = `Your ${appName} password reset code is: ${code}\n\nThis code expires in 15 minutes. If you didn't request this, you can safely ignore this email.`;
  const html = `
    <div style="font-family: Arial, sans-serif; max-width: 480px; margin: 0 auto; color:#1f1b3a;">
      <h2 style="margin-bottom: 4px;">${appName}</h2>
      <p>Your password reset code is:</p>
      <p style="font-size: 30px; font-weight: bold; letter-spacing: 6px; margin: 12px 0;">${code}</p>
      <p style="color:#6b6584; font-size: 14px;">This code expires in 15 minutes. If you didn't request this, you can safely ignore this email.</p>
    </div>
  `;

  const t = getTransporter();

  if (!t) {
    console.warn(
      `[mailer] SMTP not configured — password reset code for ${toEmail}: ${code} (expires in 15 minutes)`
    );
    return { delivered: false };
  }

  await t.sendMail({
    from: process.env.SMTP_FROM || process.env.SMTP_USER,
    to: toEmail,
    subject,
    text,
    html,
  });

  return { delivered: true };
}

module.exports = { sendPasswordResetEmail };