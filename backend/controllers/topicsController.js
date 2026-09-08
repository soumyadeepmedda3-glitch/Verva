const { pool } = require("../config/db");

// GET /api/topics
async function getTopics(req, res) {
  try {
    const [rows] = await pool.query(
      "SELECT topic_key, name, description FROM topics ORDER BY name ASC"
    );
    res.json({ success: true, topics: rows });
  } catch (err) {
    console.error("getTopics error:", err.message);
    res.status(500).json({
      success: false,
      message: "Could not load topics. Please try again later.",
    });
  }
}

module.exports = { getTopics };
