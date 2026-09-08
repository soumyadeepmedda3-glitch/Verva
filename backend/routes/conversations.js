const express = require("express");
const router = express.Router();
const {
  getConversations,
  getConversationById,
} = require("../controllers/conversationsController");

router.get("/", getConversations);
router.get("/:id", getConversationById);

module.exports = router;
