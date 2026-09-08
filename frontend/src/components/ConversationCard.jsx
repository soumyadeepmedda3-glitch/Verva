export default function ConversationCard({ aiText, answerText }) {
  return (
    <div className="conversation-card">
      <div className="conversation-block conversation-ai">
        <span className="conversation-label">AI says</span>
        <p className="conversation-text">&ldquo;{aiText}&rdquo;</p>
      </div>

      <div className="conversation-divider" />

      <div className="conversation-block conversation-user">
        <span className="conversation-label">You can say</span>
        <p className="conversation-text">&ldquo;{answerText}&rdquo;</p>
      </div>
    </div>
  );
}
