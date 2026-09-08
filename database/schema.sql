-- Verva - Database Schema
-- MySQL 8+

CREATE DATABASE IF NOT EXISTS verva CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE verva;

-- ---------------------------------------------------------------
-- topics
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS topics (
  id INT AUTO_INCREMENT PRIMARY KEY,
  topic_key VARCHAR(64) NOT NULL UNIQUE,   -- e.g. "restaurant"
  name VARCHAR(128) NOT NULL,              -- e.g. "Restaurant"
  description VARCHAR(255) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ---------------------------------------------------------------
-- users
-- Account table for the login system. Passwords are stored as
-- bcrypt hashes only — never plain text.
-- preferred_voice is reserved for the "per-user AI voice" feature:
-- store the browser SpeechSynthesisVoice.name the user picked.
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  display_name VARCHAR(100) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  preferred_voice VARCHAR(255) DEFAULT NULL,
  reset_code_hash VARCHAR(255) DEFAULT NULL,
  reset_code_expires DATETIME DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ---------------------------------------------------------------
-- conversation_sets
-- one set = one topic + one difficulty level.
-- user_id is nullable and reserved for the future "custom per-user
-- conversation content" feature: NULL = shared/global content (the
-- current app data), a value = a private set only that user sees.
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS conversation_sets (
  id INT AUTO_INCREMENT PRIMARY KEY,
  topic_id INT NOT NULL,
  level ENUM('beginner', 'intermediate', 'advanced') NOT NULL,
  user_id INT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (topic_id) REFERENCES topics(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE KEY uniq_topic_level_user (topic_id, level, user_id)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------
-- conversation_lines
-- individual AI line + suggested user answer, in sequence
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS conversation_lines (
  id INT AUTO_INCREMENT PRIMARY KEY,
  conversation_set_id INT NOT NULL,
  sequence_number INT NOT NULL,
  ai_text TEXT NOT NULL,
  suggested_answer TEXT NOT NULL,
  FOREIGN KEY (conversation_set_id) REFERENCES conversation_sets(id) ON DELETE CASCADE,
  INDEX idx_set_seq (conversation_set_id, sequence_number)
) ENGINE=InnoDB;
