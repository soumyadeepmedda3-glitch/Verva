import { useEffect, useRef } from "react";

export default function AdBanner() {
  const adRef = useRef(null);

  useEffect(() => {
    const script = document.createElement("script");
    script.src =
      "https://www.highrevenueformat.com/882b0da98d36a3d4a49fab5a66cc5789/invoke.js";
    script.async = true;

    window.atOptions = {
      key: "882b0da98d36a3d4a49fab5a66cc5789",
      format: "iframe",
      height: 300,
      width: 160,
      params: {},
    };

    if (adRef.current) {
      adRef.current.appendChild(script);
    }

    return () => {
      if (adRef.current) {
        adRef.current.innerHTML = "";
      }
    };
  }, []);

  return (
    <div
      ref={adRef}
      style={{
        width: "160px",
        minHeight: "300px",
        margin: "20px auto",
      }}
    />
  );
}