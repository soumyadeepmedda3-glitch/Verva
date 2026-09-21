// Handles microphone access and one continuous recording
// for the whole Verva practice session.

export function isRecordingSupported() {
  return (
    typeof navigator !== "undefined" &&
    !!navigator.mediaDevices &&
    typeof navigator.mediaDevices.getUserMedia === "function" &&
    typeof window !== "undefined" &&
    typeof window.MediaRecorder !== "undefined"
  );
}

function pickMimeType() {
  const candidates = [
    "audio/webm;codecs=opus",
    "audio/webm",
    "audio/mp4",
    "audio/ogg;codecs=opus",
    "audio/ogg",
  ];

  if (typeof MediaRecorder === "undefined") {
    return "";
  }

  for (const type of candidates) {
    try {
      if (MediaRecorder.isTypeSupported(type)) {
        return type;
      }
    } catch {
      // Ignore unsupported MIME types
    }
  }

  return "";
}

export class SessionRecorder {
  constructor() {
    this.stream = null;
    this.mediaRecorder = null;
    this.chunks = [];
    this.mimeType = "";
  }

  async start() {
    if (!isRecordingSupported()) {
      throw new Error("UNSUPPORTED_BROWSER");
    }

    // Microphone access must be requested from the browser.
    try {
      this.stream = await navigator.mediaDevices.getUserMedia({
        audio: {
          echoCancellation: true,
          noiseSuppression: true,
          autoGainControl: true,
        },
      });
    } catch (err) {
      console.error("Microphone error:", err);

      if (
        err?.name === "NotAllowedError" ||
        err?.name === "PermissionDeniedError"
      ) {
        throw new Error("PERMISSION_DENIED");
      }

      if (
        err?.name === "NotFoundError" ||
        err?.name === "DevicesNotFoundError"
      ) {
        throw new Error("NO_MICROPHONE");
      }

      if (err?.name === "NotReadableError") {
        throw new Error("MICROPHONE_BUSY");
      }

      throw new Error("MICROPHONE_ERROR");
    }

    this.mimeType = pickMimeType();
    this.chunks = [];

    try {
      this.mediaRecorder = this.mimeType
        ? new MediaRecorder(this.stream, {
            mimeType: this.mimeType,
          })
        : new MediaRecorder(this.stream);
    } catch (err) {
      console.error("MediaRecorder creation failed:", err);
      this._releaseStream();
      throw new Error("UNSUPPORTED_RECORDING_FORMAT");
    }

    this.mediaRecorder.ondataavailable = (event) => {
      if (event.data && event.data.size > 0) {
        this.chunks.push(event.data);
      }
    };

    this.mediaRecorder.onerror = (event) => {
      console.error("MediaRecorder error:", event.error);
    };

    // Collect audio every second.
    this.mediaRecorder.start(1000);
  }

  get isRecording() {
    return (
      !!this.mediaRecorder &&
      this.mediaRecorder.state === "recording"
    );
  }

  get state() {
    return this.mediaRecorder
      ? this.mediaRecorder.state
      : "inactive";
  }

  stop() {
    return new Promise((resolve) => {
      if (!this.mediaRecorder) {
        resolve(null);
        return;
      }

      if (this.mediaRecorder.state === "inactive") {
        const blob =
          this.chunks.length > 0
            ? new Blob(this.chunks, {
                type: this.mimeType || "audio/webm",
              })
            : null;

        this._releaseStream();
        resolve(blob);
        return;
      }

      this.mediaRecorder.onstop = () => {
        const blob =
          this.chunks.length > 0
            ? new Blob(this.chunks, {
                type: this.mimeType || "audio/webm",
              })
            : null;

        this._releaseStream();
        resolve(blob);
      };

      try {
        this.mediaRecorder.stop();
      } catch (err) {
        console.error("Stopping recorder failed:", err);
        this._releaseStream();
        resolve(null);
      }
    });
  }

  cancel() {
    if (this.mediaRecorder) {
      try {
        if (this.mediaRecorder.state !== "inactive") {
          this.mediaRecorder.stop();
        }
      } catch {
        // Ignore stop errors
      }
    }

    this.chunks = [];
    this._releaseStream();
  }

  _releaseStream() {
    if (this.stream) {
      this.stream.getTracks().forEach((track) => {
        try {
          track.stop();
        } catch {
          // Ignore track stop errors
        }
      });

      this.stream = null;
    }
  }
}