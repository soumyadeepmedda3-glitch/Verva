// Thin wrapper around the browser's built-in speechSynthesis API.
// No external / paid TTS service is used.

export function isSpeechSupported() {
  return typeof window !== "undefined" && "speechSynthesis" in window;
}

let cachedVoices = [];

function loadVoices() {
  if (!isSpeechSupported()) return [];
  const voices = window.speechSynthesis.getVoices();
  if (voices.length) cachedVoices = voices;
  return cachedVoices;
}

// Voices load asynchronously in some browsers (notably Chrome).
if (isSpeechSupported()) {
  loadVoices();
  window.speechSynthesis.onvoiceschanged = loadVoices;
}

// Name fragments that reliably indicate a voice's gender across the
// major platforms (Windows/Edge, macOS/Safari, Chrome/Android). Browsers
// don't expose a real "gender" field on SpeechSynthesisVoice, so this is
// a best-effort classification based on known voice names.
const FEMALE_NAME_HINTS = [
  "female", "zira", "samantha", "victoria", "karen", "susan", "moira",
  "tessa", "fiona", "kate", "serena", "salli", "joanna", "ivy", "amy",
  "emma", "aria", "jenny", "michelle", "allison", "ava", "hazel",
];
const MALE_NAME_HINTS = [
  "male", "david", "mark", "alex", "daniel", "fred", "james", "oliver",
  "arthur", "aaron", "rishi", "guy", "matthew", "justin", "eric", "ryan",
  "george", "gordon", "lee", "will",
];

// Voice names known to sound noticeably clearer/more natural than the
// average default OS voice — checked first, before falling back to any
// voice of the right gender.
const PREFERRED_FEMALE_NAMES = [
  "Google UK English Female",
  "Google US English",
  "Microsoft Aria Online (Natural) - English (United States)",
  "Microsoft Jenny Online (Natural) - English (United States)",
  "Samantha",
  "Karen",
];
const PREFERRED_MALE_NAMES = [
  "Google UK English Male",
  "Microsoft Guy Online (Natural) - English (United States)",
  "Microsoft Ryan Online (Natural) - English (United Kingdom)",
  "Daniel",
  "David",
  "Alex",
];

function classifyVoiceGender(voice) {
  const name = voice.name.toLowerCase();
  if (FEMALE_NAME_HINTS.some((hint) => name.includes(hint))) return "female";
  if (MALE_NAME_HINTS.some((hint) => name.includes(hint))) return "male";
  return "unknown";
}

function englishVoices() {
  return loadVoices().filter((v) => v.lang && v.lang.toLowerCase().startsWith("en"));
}

/**
 * Returns the list of available English voices, each tagged with a
 * best-effort gender guess — used to build the voice picker on Setup.
 */
export function getVoiceOptions() {
  return englishVoices().map((voice) => ({
    name: voice.name,
    lang: voice.lang,
    gender: classifyVoiceGender(voice),
  }));
}

/**
 * Picks the best available voice for the requested gender ("female" or
 * "male"). Prefers known high-quality/natural-sounding voices first,
 * then any voice classified as that gender, then falls back gracefully
 * so speech always has *some* voice to use.
 *
 * Returns { voice, isRealMatch }. isRealMatch is false when the device
 * had no voice actually classified as the requested gender (common on
 * phones with only one or two built-in English voices) — speakText()
 * uses that flag to apply a small pitch shift so male/female still
 * sound audibly different even when the underlying voice is the same.
 */
export function pickVoice(genderPreference = "female") {
  const voices = englishVoices();
  if (!voices.length) return { voice: null, isRealMatch: false };

  const preferredNames = genderPreference === "male" ? PREFERRED_MALE_NAMES : PREFERRED_FEMALE_NAMES;
  for (const name of preferredNames) {
    const match = voices.find((v) => v.name === name);
    if (match) return { voice: match, isRealMatch: true };
  }

  const matchingGender = voices.find((v) => classifyVoiceGender(v) === genderPreference);
  if (matchingGender) return { voice: matchingGender, isRealMatch: true };

  // No voice matched the requested gender — fall back to the other
  // preferred list, then any English voice at all. This is a fallback,
  // not a real match for the requested gender.
  const otherPreferredNames = genderPreference === "male" ? PREFERRED_FEMALE_NAMES : PREFERRED_MALE_NAMES;
  for (const name of otherPreferredNames) {
    const match = voices.find((v) => v.name === name);
    if (match) return { voice: match, isRealMatch: false };
  }

  return { voice: voices[0], isRealMatch: false };
}

/**
 * Speak a sentence aloud using the browser's speech synthesizer.
 * Cancels any speech currently in progress first.
 *
 * @param {string} text
 * @param {{ gender?: "female"|"male", voiceName?: string, onStart?: () => void, onEnd?: () => void, onError?: (e:any) => void }} options
 */
export function speakText(text, options = {}) {
  const { gender = "female", voiceName, onStart, onEnd, onError } = options;

  if (!isSpeechSupported()) {
    onError && onError(new Error("Speech synthesis is not supported in this browser."));
    return;
  }

  // Always cancel previous speech before starting new speech.
  window.speechSynthesis.cancel();

  const utterance = new SpeechSynthesisUtterance(text);

  let voice = null;
  let isRealMatch = true;

  if (voiceName) {
    voice = englishVoices().find((v) => v.name === voiceName) || null;
    if (!voice) {
      const picked = pickVoice(gender);
      voice = picked.voice;
      isRealMatch = picked.isRealMatch;
    }
  } else {
    const picked = pickVoice(gender);
    voice = picked.voice;
    isRealMatch = picked.isRealMatch;
  }

  if (voice) utterance.voice = voice;
  utterance.lang = voice?.lang || "en-US";

  // Natural pacing/pitch: a full-speed, un-shifted voice reads far more
  // clearly and naturally than an artificially slowed-down or
  // pitch-shifted one — most "robotic" TTS complaints come from
  // over-tuning these two values, not from the voice itself.
  //
  // Exception: when the device has no real male/female voice pair
  // (common on phones with just one built-in English voice), the same
  // voice would be used for both genders and sound identical. In that
  // fallback case only, nudge the pitch so male/female are still
  // audibly distinguishable.
  utterance.rate = 1;
  if (!isRealMatch && !voiceName) {
    utterance.pitch = gender === "male" ? 0.8 : 1.15;
  } else {
    utterance.pitch = 1;
  }
  utterance.volume = 1;

  utterance.onstart = () => onStart && onStart();
  utterance.onend = () => onEnd && onEnd();
  utterance.onerror = (e) => onError && onError(e);

  window.speechSynthesis.speak(utterance);
}

export function cancelSpeech() {
  if (isSpeechSupported()) {
    window.speechSynthesis.cancel();
  }
}