import { useState } from "react";
import { Routes, Route } from "react-router-dom";
import Home from "./pages/Home";
import Setup from "./pages/Setup";
import Practice from "./pages/Practice";
import Complete from "./pages/Complete";
import Login from "./pages/Login";
import Register from "./pages/Register";
import ForgotPassword from "./pages/ForgotPassword";
import ResetPassword from "./pages/ResetPassword";
import HowToUse from "./pages/HowToUse";
import About from "./pages/About";
import { AuthProvider } from "./context/AuthContext";

export default function App() {
  // Practice configuration chosen on the Setup page (topic, level, duration).
  const [practiceConfig, setPracticeConfig] = useState(null);

  // Result of the last finished practice session (recording blob/url etc.)
  // Kept only in memory — refreshing the page clears it, which is fine per spec.
  const [practiceResult, setPracticeResult] = useState(null);

  function handleStartPractice(config) {
    setPracticeConfig(config);
    setPracticeResult(null);
  }

  function handleFinishPractice(result) {
    setPracticeResult(result);
  }

  function handlePracticeAgain() {
    // Release the previous session's recording from memory now that
    // we're done with it — this is a deliberate lifecycle point (not a
    // component mount/unmount), so it isn't affected by React
    // StrictMode's development-only double-invoking of effects.
    if (practiceResult?.url) {
      URL.revokeObjectURL(practiceResult.url);
    }
    setPracticeResult(null);
    setPracticeConfig(null);
  }

  return (
    <AuthProvider>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route path="/forgot-password" element={<ForgotPassword />} />
        <Route path="/reset-password" element={<ResetPassword />} />
        <Route path="/how-to-use" element={<HowToUse />} />
        <Route path="/about" element={<About />} />
        <Route path="/setup" element={<Setup onStartPractice={handleStartPractice} />} />
        <Route
          path="/practice"
          element={<Practice config={practiceConfig} onFinishPractice={handleFinishPractice} />}
        />
        <Route
          path="/complete"
          element={<Complete result={practiceResult} onPracticeAgain={handlePracticeAgain} />}
        />
      </Routes>
    </AuthProvider>
  );
}
