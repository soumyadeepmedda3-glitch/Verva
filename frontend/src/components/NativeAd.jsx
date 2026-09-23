import { useEffect } from "react";

export default function NativeAd() {
  useEffect(() => {
    const script = document.createElement("script");

    script.async = true;
    script.setAttribute("data-cfasync", "false");
    script.src =
      "https://pl31476051.profitableratecpmnetwork.com/19267cccf7a517e246c5357ca98e4c21/invoke.js";

    const container = document.getElementById(
      "container-19267cccf7a517e246c5357ca98e4c21"
    );

    if (container && !container.querySelector("script")) {
      container.appendChild(script);
    }

    return () => {
      if (container) {
        container.innerHTML = "";
      }
    };
  }, []);

  return (
    <div
      id="container-19267cccf7a517e246c5357ca98e4c21"
      style={{
        width: "100%",
        minHeight: "100px",
      }}
    />
  );
}