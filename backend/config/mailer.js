const { Resend } = require("resend");
require("dotenv").config();

let resend = null;

function getResend() {
  if (resend) return resend;

  if (!process.env.RESEND_API_KEY) {
    return null;
  }

  resend = new Resend(process.env.RESEND_API_KEY);

  return resend;
}

async function sendPasswordResetEmail(toEmail, code) {
  const appName = process.env.APP_NAME || "SayVixa";

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
      <h2>${appName}</h2>

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

  const client = getResend();

  if (!client) {
    console.error("[mailer] RESEND_API_KEY is not configured.");
    throw new Error("Email service is not configured.");
  }

  try {
    const { data, error } = await client.emails.send({
      from: process.env.RESEND_FROM || "onboarding@resend.dev",
      to: [toEmail],
      subject,
      text,
      html,
    });

    if (error) {
      console.error("[mailer] Resend ERROR:", error);
      throw new Error(error.message || "Failed to send email.");
    }

    console.log("[mailer] Password reset email sent successfully.");
    console.log("[mailer] Message ID:", data?.id);

    return {
      delivered: true,
      messageId: data?.id,
    };
  } catch (error) {
    console.error("[mailer] Email sending failed:", error.message);
    throw error;
  }
}

module.exports = {
  sendPasswordResetEmail,
};