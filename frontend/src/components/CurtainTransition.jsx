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
    // Render closed for one frame first, then trigger the open animation
    // so the CSS transition actually has something to animate from.
    const raf = requestAnimationFrame(() => setOpening(true));
    const timer = setTimeout(() => {
      onFinish && onFinish();
    }, 900);

    return () => {
      cancelAnimationFrame(raf);
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