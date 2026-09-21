const nodemailer = require("nodemailer");
require("dotenv").config();

let transporter = null;

function getTransporter() {
  if (transporter) return transporter;

  if (!process.env.SMTP_HOST) {
    return null;
  }

  transporter = nodemailer.createTransport({
    host: process.env.SMTP_HOST,
    port: Number(process.env.SMTP_PORT) || 587,
    secure: Number(process.env.SMTP_PORT) === 465,
    auth: process.env.SMTP_USER
      ? {
          user: process.env.SMTP_USER,
          pass: process.env.SMTP_PASS,
        }
      : undefined,
  });

  return transporter;
}

/**
 * Sends a password reset code to the given email address.
 */
async function sendPasswordResetEmail(toEmail, code) {
  const appName = process.env.APP_NAME || "Verva";

  const subject = `${appName} password reset code`;

  const text = `Your ${appName} password reset code is: ${code}

This code expires in 15 minutes.
If you didn't request this, you can safely ignore this email.`;

  const html = `
    <div style="
      font-family: Arial, sans-serif;
      max-width: 480px;
      margin: 0 auto;
      color: #1f1b3a;
    ">
      <h2 style="margin-bottom: 4px;">${appName}</h2>

      <p>Your password reset code is:</p>

      <p style="
        font-size: 30px;
        font-weight: bold;
        letter-spacing: 6px;
        margin: 12px 0;
      ">
        ${code}
      </p>

      <p style="
        color: #6b6584;
        font-size: 14px;
      ">
        This code expires in 15 minutes.
        If you didn't request this, you can safely ignore this email.
      </p>
    </div>
  `;

  const t = getTransporter();

  // SMTP is not configured
  if (!t) {
    console.warn(
      `[mailer] SMTP not configured — password reset code for ${toEmail}: ${code}`
    );

    return {
      delivered: false,
      message: "SMTP is not configured.",
    };
  }

  try {
    // Verify SMTP connection before sending
    await t.verify();

    console.log("[mailer] SMTP connection verified.");

    const info = await t.sendMail({
      from: process.env.SMTP_FROM || process.env.SMTP_USER,
      to: toEmail,
      subject,
      text,
      html,
    });

    console.log("[mailer] Password reset email sent successfully.");
    console.log("[mailer] Message ID:", info.messageId);

    return {
      delivered: true,
      messageId: info.messageId,
    };
  } catch (error) {
    console.error("[mailer] SMTP ERROR");
    console.error("Code:", error.code);
    console.error("Command:", error.command);
    console.error("Response:", error.response);
    console.error("Response Code:", error.responseCode);
    console.error("Message:", error.message);

    throw error;
  }
}

module.exports = {
  sendPasswordResetEmail,
};