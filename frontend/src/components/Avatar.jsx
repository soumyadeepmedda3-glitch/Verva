import "./Avatar.css";

/**
 * Simple friendly SVG avatar. No external avatar API is used.
 * `isSpeaking` toggles a subtle talking animation (mouth + glow ring).
 */
export default function Avatar({ isSpeaking }) {
  return (
    <div className={`avatar-wrap ${isSpeaking ? "avatar-speaking" : "avatar-idle"}`}>
      <div className="avatar-ring" />
      <svg
        viewBox="0 0 200 200"
        width="160"
        height="160"
        className="avatar-svg"
        aria-hidden="true"
      >
        {/* Head */}
        <circle cx="100" cy="100" r="78" fill="url(#faceGradient)" />
        <defs>
          <linearGradient id="faceGradient" x1="0" y1="0" x2="1" y2="1">
            <stop offset="0%" stopColor="#8b7cf6" />
            <stop offset="100%" stopColor="#5b4fe0" />
          </linearGradient>
        </defs>

        {/* Eyes */}
        <ellipse className="avatar-eye avatar-eye-left" cx="72" cy="90" rx="8" ry="10" fill="#ffffff" />
        <ellipse className="avatar-eye avatar-eye-right" cx="128" cy="90" rx="8" ry="10" fill="#ffffff" />
        <circle cx="72" cy="92" r="4" fill="#2a2560" />
        <circle cx="128" cy="92" r="4" fill="#2a2560" />

        {/* Cheeks */}
        <circle cx="55" cy="118" r="9" fill="#ffb4c6" opacity="0.55" />
        <circle cx="145" cy="118" r="9" fill="#ffb4c6" opacity="0.55" />

        {/* Mouth */}
        <path
          className="avatar-mouth"
          d="M75 130 Q100 130 125 130"
          stroke="#2a2560"
          strokeWidth="6"
          strokeLinecap="round"
          fill="none"
        />
      </svg>

      <div className="avatar-indicator">
        {isSpeaking ? (
          <span className="avatar-indicator-dot avatar-indicator-speaking" />
        ) : (
          <span className="avatar-indicator-dot" />
        )}
        <span>{isSpeaking ? "Speaking..." : "Listening"}</span>
      </div>
    </div>
  );
}
