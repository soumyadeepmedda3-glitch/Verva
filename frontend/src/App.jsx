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
import { AuthProvider } from "./context/AuthContext";

export default function App() {
  const [practiceConfig, setPracticeConfig] = useState(null);
  const [practiceResult, setPracticeResult] = useState(null);

  function handleStartPractice(config) {
    setPracticeConfig(config);
    setPracticeResult(null);
  }

  function handleFinishPractice(result) {
    setPracticeResult(result);
  }

  function handlePracticeAgain() {
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