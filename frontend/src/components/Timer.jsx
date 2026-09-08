function formatTime(totalSeconds) {
  const m = Math.floor(totalSeconds / 60)
    .toString()
    .padStart(2, "0");
  const s = Math.floor(totalSeconds % 60)
    .toString()
    .padStart(2, "0");
  return `${m}:${s}`;
}

/**
 * Presentational timer. The actual counting logic lives in the Practice
 * page (a single interval, cleared on unmount) — this component just
 * renders the current values plus a progress bar.
 */
export default function Timer({ elapsedSeconds, totalSeconds }) {
  const pct = Math.min(100, (elapsedSeconds / totalSeconds) * 100);

  return (
    <div className="timer">
      <div className="timer-row">
        <span className="timer-time">{formatTime(elapsedSeconds)}</span>
        <span className="timer-total"> / {formatTime(totalSeconds)}</span>
      </div>
      <div className="timer-bar">
        <div className="timer-bar-fill" style={{ width: `${pct}%` }} />
      </div>
    </div>
  );
}
