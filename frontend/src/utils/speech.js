// Azure Speech TTS wrapper.
// The Azure subscription key stays on the backend; the browser only receives audio.

const API_URL = import.meta.env.VITE_API_URL || "http://localhost:5000";

let currentAudio = null;
let currentRequestController = null;

const VOICES = {
  female: {
    name: "Jenny",
    voice: "en-US-JennyNeural",
    lang: "en-US",
  },
  male: {
    name: "Guy",
    voice: "en-US-GuyNeural",
    lang: "en-US",
  },
};

export function isSpeechSupported() {
  return typeof window !== "undefined" && "Audio" in window;
}

export function getVoiceOptions() {
  return [
    { name: VOICES.female.name, lang: VOICES.female.lang, gender: "female" },
    { name: VOICES.male.name, lang: VOICES.male.lang, gender: "male" },
  ];
}

export function pickVoice(genderPreference = "female") {
  const voice = VOICES[genderPreference] || VOICES.female;
  return { voice, isRealMatch: true };
}

/**
 * Generate and play Azure Neural TTS audio.
 *
 * @param {string} text
 * @param {{gender?: "female"|"male", voiceName?: string, onStart?:()=>void, onEnd?:()=>void, onError?:(e:any)=>void}} options
 */
export async function speakText(text, options = {}) {
  const {
    gender = "female",
    voiceName,
    onStart,
    onEnd,
    onError,
  } = options;

  if (!text || !isSpeechSupported()) {
    const error = new Error("Audio playback is not supported in this browser.");
    onError?.(error);
    return;
  }

  cancelSpeech();

  const selectedGender = gender === "male" ? "male" : "female";
  const selected = VOICES[selectedGender];

  currentRequestController = new AbortController();

  try {
    const response = await fetch(`${API_URL}/api/tts`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        text,
        gender: selectedGender,
        voice: voiceName || selected.voice,
      }),
      signal: currentRequestController.signal,
    });

    if (!response.ok) {
      let message = `TTS request failed (${response.status})`;
      try {
        const data = await response.json();
        if (data?.message) message = data.message;
      } catch {
        // Ignore non-JSON error responses.
      }
      throw new Error(message);
    }

    const blob = await response.blob();

    if (!blob.size) {
      throw new Error("Azure returned an empty audio response.");
    }

    const audioUrl = URL.createObjectURL(blob);
    const audio = new Audio(audioUrl);
    currentAudio = audio;

    audio.preload = "auto";
    audio.onplay = () => onStart?.();
    audio.onended = () => {
      URL.revokeObjectURL(audioUrl);
      if (currentAudio === audio) currentAudio = null;
      onEnd?.();
    };
    audio.onerror = () => {
      URL.revokeObjectURL(audioUrl);
      if (currentAudio === audio) currentAudio = null;
      onError?.(new Error("The generated voice audio could not be played."));
    };

    await audio.play();
  } catch (error) {
    if (error?.name === "AbortError") return;
    onError?.(error);
  } finally {
    currentRequestController = null;
  }
}

export function cancelSpeech() {
  if (currentRequestController) {
    currentRequestController.abort();
    currentRequestController = null;
  }

  if (currentAudio) {
    currentAudio.onended = null;
    currentAudio.onerror = null;
    currentAudio.pause();
    currentAudio.src = "";
    currentAudio = null;
  }
}
