const mysql = require("mysql2/promise");

require("dotenv").config();

// Connection pool. mysql2's pool handles reconnects for us.

const pool = mysql.createPool({
  host: process.env.DB_HOST || "localhost",

  port: process.env.DB_PORT || 3306,

  user: process.env.DB_USER || "root",

  password: process.env.DB_PASSWORD || "",

  database: process.env.DB_NAME || "verva",

  ssl: {
    rejectUnauthorized: false,
  },

  waitForConnections: true,

  connectionLimit: 10,

  queueLimit: 0,
});

// Quick helper used at startup to verify the DB is reachable.

async function testConnection() {
  try {
    const conn = await pool.getConnection();

    await conn.ping();

    conn.release();

    return true;
  } catch (err) {
    return false;
  }
}

module.exports = { pool, testConnection };