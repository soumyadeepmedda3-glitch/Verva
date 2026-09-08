import { TOPICS, CONVERSATIONS } from "../data/conversations";

const API_URL = import.meta.env.VITE_API_URL || "http://localhost:5000";

// Small timeout so a dead backend doesn't hang the UI for too long.
async function fetchWithTimeout(url, ms = 4000) {
  const controller = new AbortController();
  const timer = setTimeout(() => controller.abort(), ms);
  try {
    const res = await fetch(url, { signal: controller.signal });
    clearTimeout(timer);
    if (!res.ok) throw new Error(`Request failed with status ${res.status}`);
    return await res.json();
  } catch (err) {
    clearTimeout(timer);
    throw err;
  }
}

/**
 * Fetch the topic list. Falls back to local bundled data if the
 * backend/database is unavailable, so the app still works offline.
 */
export async function fetchTopics() {
  try {
    const data = await fetchWithTimeout(`${API_URL}/api/topics`);
    if (data.success && data.topics && data.topics.length > 0) {
      return { topics: data.topics, source: "api" };
    }
    throw new Error("Empty topics response");
  } catch (err) {
    return { topics: TOPICS, source: "fallback" };
  }
}

/**
 * Fetch a conversation set for a topic + level. Falls back to local
 * bundled data if the backend/database is unavailable.
 */
export async function fetchConversations(topicKey, level) {
  try {
    const data = await fetchWithTimeout(
      `${API_URL}/api/conversations?topic=${encodeURIComponent(topicKey)}&level=${encodeURIComponent(level)}`
    );
    if (data.success && data.conversations && data.conversations.length > 0) {
      return { conversations: data.conversations, source: "api" };
    }
    throw new Error("Empty conversations response");
  } catch (err) {
    const fallback = CONVERSATIONS[topicKey]?.[level] || [];
    return { conversations: fallback, source: "fallback" };
  }
}
