import { useEffect } from "react";
import { useLocation } from "react-router-dom";

/**
 * Without this, navigating to a new page keeps the previous page's
 * scroll position — so a new page can appear to start mid-way down
 * until you manually scroll up. This resets to the top on every
 * route change.
 */
export default function ScrollToTop() {
  const { pathname } = useLocation();

  useEffect(() => {
    window.scrollTo(0, 0);
  }, [pathname]);

  return null;
}