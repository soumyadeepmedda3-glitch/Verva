import { useEffect, useState } from "react";
import "./CurtainTransition.css";

/**
 * Full-screen stage-curtain reveal animation used when leaving the
 * Home page for Setup ("Get Started"). Two panels meet in the middle,
 * then slide apart to either side — like stepping onto a stage —
 * before calling onFinish() to complete the navigation.
 */
export default function CurtainTransition({ onFinish }) {
  const [opening, setOpening] = useState(false);

  useEffect(() => {
    // A single requestAnimationFrame can sometimes fire before the browser
    // has actually painted the "closed" state, which makes the CSS
    // transition skip straight to "open" with no visible animation.
    // Nesting two rAF calls guarantees a paint happens first.
    let secondFrame;
    const firstFrame = requestAnimationFrame(() => {
      secondFrame = requestAnimationFrame(() => setOpening(true));
    });

    const timer = setTimeout(() => {
      onFinish && onFinish();
    }, 900);

    return () => {
      cancelAnimationFrame(firstFrame);
      if (secondFrame) cancelAnimationFrame(secondFrame);
      clearTimeout(timer);
    };
  }, [onFinish]);

  return (
    <div className="curtain-overlay" aria-hidden="true">
      <div className={`curtain-panel curtain-left ${opening ? "curtain-open" : ""}`}>
        <div className="curtain-fold" />
      </div>
      <div className={`curtain-panel curtain-right ${opening ? "curtain-open" : ""}`}>
        <div className="curtain-fold" />
      </div>
      <div className={`curtain-spark ${opening ? "curtain-spark-fade" : ""}`} />
    </div>
  );
}
