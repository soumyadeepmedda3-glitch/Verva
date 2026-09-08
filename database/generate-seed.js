/**
 * One-time generator script (not part of the running app).
 * Reads conversation-data.json and produces:
 *   - database/seed.sql            (MySQL seed data)
 *   - frontend/src/data/conversations.js (offline fallback data for the frontend)
 *
 * Run with: node generate-seed.js
 */
const fs = require("fs");
const path = require("path");

const data = JSON.parse(
  fs.readFileSync(path.join(__dirname, "conversation-data.json"), "utf8")
);

function esc(str) {
  return String(str).replace(/\\/g, "\\\\").replace(/'/g, "\\'");
}

let sql = `-- SpeakEasy AI - Seed Data
-- Generated automatically from conversation-data.json
-- Run after schema.sql

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE conversation_lines;
TRUNCATE TABLE conversation_sets;
TRUNCATE TABLE topics;
SET FOREIGN_KEY_CHECKS = 1;

`;

// Topics
sql += `-- ---------------------------------------------------------------\n-- Topics\n-- ---------------------------------------------------------------\n`;
sql += `INSERT INTO topics (topic_key, name, description) VALUES\n`;
const topicRows = data.topics.map(
  (t) => `('${esc(t.key)}', '${esc(t.name)}', '${esc(t.description)}')`
);
sql += topicRows.join(",\n") + ";\n\n";

// Conversation sets + lines
sql += `-- ---------------------------------------------------------------\n-- Conversation Sets & Lines\n-- ---------------------------------------------------------------\n`;

const levels = ["beginner", "intermediate", "advanced"];

for (const topic of data.topics) {
  const topicKey = topic.key;
  const sets = data.conversations[topicKey];
  if (!sets) continue;

  for (const level of levels) {
    const lines = sets[level];
    if (!lines || lines.length === 0) continue;

    sql += `\nINSERT INTO conversation_sets (topic_id, level) SELECT id, '${level}' FROM topics WHERE topic_key = '${esc(
      topicKey
    )}';\n`;
    sql += `SET @set_id = LAST_INSERT_ID();\n`;
    sql += `INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES\n`;
    const lineRows = lines.map(
      (line, idx) =>
        `(@set_id, ${idx + 1}, '${esc(line.ai)}', '${esc(line.answer)}')`
    );
    sql += lineRows.join(",\n") + ";\n";
  }
}

fs.writeFileSync(path.join(__dirname, "seed.sql"), sql, "utf8");
console.log("seed.sql written:", (sql.length / 1024).toFixed(1), "KB");

// Frontend fallback JS data file
let js = `// Auto-generated offline fallback data.
// Used by the frontend when the backend API is unavailable, so practice
// sessions still work without a live MySQL connection.
// (Generated from database/conversation-data.json)

export const TOPICS = ${JSON.stringify(data.topics, null, 2)};

export const CONVERSATIONS = ${JSON.stringify(data.conversations, null, 2)};
`;

fs.writeFileSync(
  path.join(__dirname, "..", "frontend", "src", "data", "conversations.js"),
  js,
  "utf8"
);
console.log("frontend/src/data/conversations.js written");
