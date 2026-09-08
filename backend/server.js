require("dotenv").config();
const express = require("express");
const cors = require("cors");
const { testConnection } = require("./config/db");

const topicsRouter = require("./routes/topics");
const conversationsRouter = require("./routes/conversations");
const authRouter = require("./routes/auth");

const app = express();
const PORT = process.env.PORT || 5000;

// ---- Middleware ----
const allowedOrigins = (process.env.CORS_ORIGIN || "http://localhost:5173")
  .split(",")
  .map((o) => o.trim());

app.use(
  cors({
    origin: allowedOrigins,
  })
);
app.use(express.json());

// ---- Routes ----
app.get("/api/health", async (req, res) => {
  const dbOk = await testConnection();
  res.json({
    success: true,
    server: "ok",
    database: dbOk ? "connected" : "unavailable",
  });
});

app.use("/api/topics", topicsRouter);
app.use("/api/conversations", conversationsRouter);
app.use("/api/auth", authRouter);


// ---- Azure Neural TTS ----
// The Azure key/region are kept on the server. The frontend never receives them.
const AZURE_TTS_VOICES = {
  female: "en-US-JennyNeural",
  male: "en-US-GuyNeural",
};

app.post("/api/tts", async (req, res) => {
  const { text, gender, voice } = req.body || {};

  if (typeof text !== "string" || !text.trim()) {
    return res.status(400).json({
      success: false,
      message: "Text is required.",
    });
  }

  if (text.length > 2000) {
    return res.status(400).json({
      success: false,
      message: "Text is too long.",
    });
  }

  if (!process.env.AZURE_SPEECH_KEY || !process.env.AZURE_SPEECH_REGION) {
    return res.status(503).json({
      success: false,
      message: "Azure Speech is not configured on the backend.",
    });
  }

  const selectedGender = gender === "male" ? "male" : "female";
  const selectedVoice =
    typeof voice === "string" && /^en-US-[A-Za-z]+Neural$/.test(voice)
      ? voice
      : AZURE_TTS_VOICES[selectedGender];

  const endpoint =
    `https://${process.env.AZURE_SPEECH_REGION}.tts.speech.microsoft.com` +
    "/cognitiveservices/v1";

  const ssml = `
<speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis"
       xml:lang="en-US">
  <voice name="${selectedVoice}">${escapeXml(text)}</voice>
</speak>`.trim();

  try {
    const response = await fetch(endpoint, {
      method: "POST",
      headers: {
        "Ocp-Apim-Subscription-Key": process.env.AZURE_SPEECH_KEY,
        "Content-Type": "application/ssml+xml",
        "X-Microsoft-OutputFormat": "audio-24khz-48kbitrate-mono-mp3",
        "User-Agent": "Verva",
      },
      body: ssml,
    });

    if (!response.ok) {
      const errorText = await response.text();
      console.error("Azure TTS error:", response.status, errorText);
      return res.status(502).json({
        success: false,
        message: "Azure Speech could not generate the voice audio.",
      });
    }

    const audioBuffer = await response.arrayBuffer();
    res.set({
      "Content-Type": "audio/mpeg",
      "Cache-Control": "no-store",
    });
    return res.send(Buffer.from(audioBuffer));
  } catch (error) {
    console.error("Azure TTS request failed:", error);
    return res.status(502).json({
      success: false,
      message: "Unable to reach Azure Speech.",
    });
  }
});

function escapeXml(value) {
  return value
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&apos;");
}

// ---- 404 handler ----
app.use((req, res) => {
  res.status(404).json({ success: false, message: "Route not found." });
});

// ---- Global error handler ----
app.use((err, req, res, next) => {
  console.error("Unhandled error:", err);
  res.status(500).json({
    success: false,
    message: "Something went wrong on the server.",
  });
});

if (!process.env.JWT_SECRET) {
  console.warn(
    "WARNING: JWT_SECRET is not set in .env — login/register will fail to sign tokens. " +
      "Set JWT_SECRET to a long random string."
  );
}

app.listen(PORT, async () => {
  console.log(`Verva backend running on http://localhost:${PORT}`);
  const dbOk = await testConnection();
  if (dbOk) {
    console.log("MySQL connection: OK");
  } else {
    console.warn(
      "MySQL connection: FAILED — the API will return errors until the database is reachable. " +
        "Check your .env settings and that MySQL is running."
    );
  }
});