// Thin wrapper around navigator.mediaDevices.getUserMedia + MediaRecorder.
// Keeps ONE continuous recording for the whole practice session.

export function isRecordingSupported() {
  return (
    typeof navigator !== "undefined" &&
    !!navigator.mediaDevices &&
    typeof navigator.mediaDevices.getUserMedia === "function" &&
    typeof window.MediaRecorder !== "undefined"
  );
}

function pickMimeType() {
  const candidates = [
    "audio/webm;codecs=opus",
    "audio/webm",
    "audio/ogg;codecs=opus",
    "audio/mp4",
  ];
  for (const type of candidates) {
    if (window.MediaRecorder && MediaRecorder.isTypeSupported(type)) {
      return type;
    }
  }
  return ""; // let the browser pick a default
}

export class SessionRecorder {
  constructor() {
    this.stream = null;
    this.mediaRecorder = null;
    this.chunks = [];
    this.mimeType = "";
  }

  /**
   * Ask for microphone permission and start recording immediately.
   * Throws an error with a descriptive message on failure (permission
   * denied, no microphone, unsupported browser, etc.)
   */
  async start() {
    if (!isRecordingSupported()) {
      throw new Error("UNSUPPORTED_BROWSER");
    }

    try {
      this.stream = await navigator.mediaDevices.getUserMedia({ audio: true });
    } catch (err) {
      if (err && (err.name === "NotAllowedError" || err.name === "PermissionDeniedError")) {
        throw new Error("PERMISSION_DENIED");
      }
      if (err && err.name === "NotFoundError") {
        throw new Error("NO_MICROPHONE");
      }
      throw new Error("MICROPHONE_ERROR");
    }

    this.mimeType = pickMimeType();
    this.chunks = [];
    this.mediaRecorder = this.mimeType
      ? new MediaRecorder(this.stream, { mimeType: this.mimeType })
      : new MediaRecorder(this.stream);

    this.mediaRecorder.ondataavailable = (e) => {
      if (e.data && e.data.size > 0) {
        this.chunks.push(e.data);
      }
    };

    // Collect data in small time slices so we always have something
    // even if the session ends abruptly.
    this.mediaRecorder.start(1000);
  }

  get isRecording() {
    return !!this.mediaRecorder && this.mediaRecorder.state === "recording";
  }

  get state() {
    return this.mediaRecorder ? this.mediaRecorder.state : "inactive";
  }

  /**
   * Stop recording and release the microphone. Resolves with the final
   * audio Blob for the whole session.
   */
  stop() {
    return new Promise((resolve) => {
      if (!this.mediaRecorder || this.mediaRecorder.state === "inactive") {
        resolve(this.chunks.length ? new Blob(this.chunks, { type: this.mimeType || "audio/webm" }) : null);
        return;
      }

      this.mediaRecorder.onstop = () => {
        const blob = new Blob(this.chunks, { type: this.mimeType || "audio/webm" });
        this._releaseStream();
        resolve(blob);
      };

      this.mediaRecorder.stop();
    });
  }

  _releaseStream() {
    if (this.stream) {
      this.stream.getTracks().forEach((track) => track.stop());
      this.stream = null;
    }
  }
}
