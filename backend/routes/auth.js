const express = require("express");
const router = express.Router();
const {
  register,
  login,
  me,
  updateMe,
  forgotPassword,
  resetPassword,
} = require("../controllers/authController");
const { authRequired } = require("../middleware/auth");

router.post("/register", register);
router.post("/login", login);
router.get("/me", authRequired, me);
router.patch("/me", authRequired, updateMe);
router.post("/forgot-password", forgotPassword);
router.post("/reset-password", resetPassword);

module.exports = router;