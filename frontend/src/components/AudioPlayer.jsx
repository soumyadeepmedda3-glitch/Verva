export default function AudioPlayer({ src }) {
  if (!src) {
    return (
      <div className="audio-player-empty">
        No recording is available for this session.
      </div>
    );
  }

  return (
    <div className="audio-player">
      <audio controls src={src} className="audio-player-el">
        Your browser does not support the audio element.
      </audio>
      <a className="audio-player-download" href={src} download="verva-practice-recording.webm">
        Download recording
      </a>
    </div>
  );
}