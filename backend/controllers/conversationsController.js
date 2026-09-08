const { pool } = require("../config/db");

const VALID_LEVELS = ["beginner", "intermediate", "advanced"];

// GET /api/conversations?topic=restaurant&level=beginner
async function getConversations(req, res) {
  const { topic, level } = req.query;

  if (!topic || !level) {
    return res.status(400).json({
      success: false,
      message: "Both 'topic' and 'level' query parameters are required.",
    });
  }

  if (!VALID_LEVELS.includes(level)) {
    return res.status(400).json({
      success: false,
      message: `'level' must be one of: ${VALID_LEVELS.join(", ")}`,
    });
  }

  try {
    const [setRows] = await pool.query(
      `SELECT cs.id AS set_id
       FROM conversation_sets cs
       JOIN topics t ON t.id = cs.topic_id
       WHERE t.topic_key = ? AND cs.level = ?
       LIMIT 1`,
      [topic, level]
    );

    if (setRows.length === 0) {
      return res.status(404).json({
        success: false,
        message: `No conversation set found for topic '${topic}' at level '${level}'.`,
      });
    }

    const setId = setRows[0].set_id;

    const [lines] = await pool.query(
      `SELECT id, sequence_number, ai_text, suggested_answer
       FROM conversation_lines
       WHERE conversation_set_id = ?
       ORDER BY sequence_number ASC`,
      [setId]
    );

    res.json({
      success: true,
      topic,
      level,
      conversations: lines.map((l) => ({
        id: l.id,
        ai: l.ai_text,
        answer: l.suggested_answer,
      })),
    });
  } catch (err) {
    console.error("getConversations error:", err.message);
    res.status(500).json({
      success: false,
      message: "Could not load conversation data. Please try again later.",
    });
  }
}

// GET /api/conversations/:id  (a single conversation line, by id)
async function getConversationById(req, res) {
  const { id } = req.params;

  try {
    const [rows] = await pool.query(
      `SELECT id, sequence_number, ai_text, suggested_answer, conversation_set_id
       FROM conversation_lines
       WHERE id = ?`,
      [id]
    );

    if (rows.length === 0) {
      return res
        .status(404)
        .json({ success: false, message: `No conversation line with id ${id}.` });
    }

    const line = rows[0];
    res.json({
      success: true,
      conversation: {
        id: line.id,
        ai: line.ai_text,
        answer: line.suggested_answer,
        sequence_number: line.sequence_number,
      },
    });
  } catch (err) {
    console.error("getConversationById error:", err.message);
    res.status(500).json({
      success: false,
      message: "Could not load the conversation line. Please try again later.",
    });
  }
}

module.exports = { getConversations, getConversationById };
