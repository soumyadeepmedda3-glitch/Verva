# Verva

**Practice English. Speak with confidence.**

Verva is a simple spoken-English practice app. An AI avatar speaks a
sentence out loud, shows you a suggested sentence to say back, and records
your microphone continuously through the whole session. At the end you can
listen back to everything you said.

This is intentionally **not** an AI teacher — it does not transcribe,
grade, or correct your speech. It's a guided conversation partner plus a
tape recorder.

---

## 1. Project Overview

- An AI avatar speaks a line of dialogue (browser Text-to-Speech).
- The AI line and a suggested response are shown on screen.
- You say the suggested response out loud.
- Your microphone is recorded continuously for the whole session.
- You press **NEXT** to move to the next line, and so on until your chosen
  practice duration ends.
- At the end, you can play back your complete recording.

## 2. Features

- 19 conversation topics (restaurant, travel, job interview, etc.)
- 3 difficulty levels: Beginner, Intermediate, Advanced
- 4 session lengths: 5 / 10 / 15 / 25 minutes
- Browser-based AI voice (`speechSynthesis`) — no paid API required
- Continuous microphone recording (`MediaRecorder`) for the whole session
- Full session playback at the end (audio stays in the browser, never
  uploaded)
- Animated SVG avatar with idle/speaking states
- Clean, responsive, mobile-first UI
- Optional account system (sign up / log in / log out) with JWT-based
  auth and bcrypt-hashed passwords — practicing still works fully
  without an account; logging in is what unlocks future per-user
  personalization (see section 14)
- REST API backed by MySQL for conversation content, with an offline
  fallback data set baked into the frontend so practice still works even
  if the backend is unreachable

## 3. Tech Stack

**Frontend:** React + Vite (JavaScript), React Router, plain CSS, Web
Speech API, MediaRecorder API.

**Backend:** Node.js + Express (REST API).

**Database:** MySQL (stores topics, conversation sets, and conversation
lines — never audio).

## 4. Folder Structure

```
verva/
├── frontend/
│   ├── src/
│   │   ├── components/       Avatar, ConversationCard, Timer, AudioPlayer, Header
│   │   ├── pages/             Home, Setup, Practice, Complete
│   │   ├── data/               conversations.js (offline fallback data)
│   │   ├── context/            AuthContext.jsx
│   │   ├── utils/              speech.js, recorder.js, api.js, auth.js
│   │   ├── App.jsx
│   │   ├── main.jsx
│   │   └── index.css
│   ├── index.html
│   ├── vite.config.js
│   ├── package.json
│   └── .env.example
├── backend/
│   ├── routes/                topics.js, conversations.js, auth.js
│   ├── controllers/           topicsController.js, conversationsController.js, authController.js
│   ├── middleware/             auth.js (JWT verification)
│   ├── config/                 db.js
│   ├── server.js
│   ├── package.json
│   └── .env.example
├── database/
│   ├── schema.sql
│   ├── seed.sql
│   └── conversation-data.json  (source data used to generate seed.sql)
└── README.md
```

## 5. Requirements

- Node.js 18+ and npm
- MySQL 8+ (or a compatible MySQL-protocol database)
- A modern browser: Chrome, Edge, or Firefox recommended (for
  `speechSynthesis` and `MediaRecorder` support)

## 6. MySQL Setup

Make sure MySQL is installed and running locally, and that you have a
user/password with permission to create databases.

```bash
mysql -u root -p
```

## 7. Database Creation

From the project root:

```bash
mysql -u root -p < database/schema.sql
mysql -u root -p verva < database/seed.sql
```

`schema.sql` creates the `verva` database and three tables:
`topics`, `conversation_sets`, and `conversation_lines`.

`seed.sql` populates all 19 topics × 3 levels with real, natural
conversation lines.

## 8. Environment Variables

Copy the example env files and adjust as needed.

**Backend** (`backend/.env`):

```
PORT=5000
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=
DB_NAME=verva
CORS_ORIGIN=http://localhost:5173
JWT_SECRET=replace_this_with_a_long_random_string
```

Generate a strong `JWT_SECRET` with:

```bash
node -e "console.log(require('crypto').randomBytes(48).toString('hex'))"
```

**Frontend** (`frontend/.env`):

```
VITE_API_URL=http://localhost:5000
```

```bash
cp backend/.env.example backend/.env
cp frontend/.env.example frontend/.env
```

Then edit `backend/.env` with your real MySQL credentials.

## 9. Backend Installation

```bash
cd backend
npm install
```

## 10. Frontend Installation

```bash
cd frontend
npm install
```

## 11. How to Run

Open two terminals.

**Terminal 1 — Backend:**

```bash
cd backend
npm run dev
```

The API starts on `http://localhost:5000`. Check `http://localhost:5000/api/health`
to confirm the server and MySQL connection are both OK.

**Terminal 2 — Frontend:**

```bash
cd frontend
npm run dev
```

The app opens on `http://localhost:5173`.

> If the backend or MySQL isn't reachable, the frontend automatically
> falls back to a bundled offline copy of the conversation data, so you
> can still try the app end-to-end.

## 12. Microphone Permission Requirements

- The browser will prompt for microphone access when you press **Start
  Practice** on the Setup page.
- You must click **Allow** for recording to work.
- Recording requires a **secure context**: `localhost` works fine for
  development; in production you'll need **HTTPS**.
- If you accidentally deny access, your browser's address-bar site
  settings let you reset the microphone permission and reload the page.

## 13. Login System

A simple, optional account system is included:

- `POST /api/auth/register` — create an account (name, email, password ≥ 8 chars)
- `POST /api/auth/login` — log in, returns a JWT
- `GET /api/auth/me` — get the logged-in user's profile (requires `Authorization: Bearer <token>`)
- `PATCH /api/auth/me` — update the logged-in user's profile (currently supports `preferredVoice`)

Passwords are hashed with **bcrypt** before being stored — never in
plain text. Login issues a **JWT** valid for 7 days, stored in the
browser's `localStorage` as `verva_token`, and attached automatically
to API requests by `frontend/src/utils/auth.js`.

**Practicing does *not* require an account.** Setup → Practice → Complete
work the same whether you're logged in or not. Logging in is the
foundation for *personalizing* the experience per user (see below) —
it doesn't gate any existing feature.

Frontend pieces:
- `src/context/AuthContext.jsx` — exposes `{ user, loading, login, register, logout, updateUser }` app-wide via `useAuth()`
- `src/pages/Login.jsx`, `src/pages/Register.jsx` — the forms
- `src/components/Header.jsx` — shows Log In / Sign Up, or the user's name + Log Out

### How to add per-user personalization on top of this

The login system already includes two hooks for the features discussed
earlier — they're wired up in the database and API, but not yet used in
the UI. Here's how to finish each one:

**A) Per-user preferred AI voice**

1. `users.preferred_voice` already exists in the schema, and
   `PATCH /api/auth/me` already accepts `{ preferredVoice }`.
2. On the Setup page, when `user` is present (from `useAuth()`), show a
   `<select>` populated from `window.speechSynthesis.getVoices()`
   (see `pickEnglishVoice()` in `utils/speech.js` for reference).
3. When the user picks a voice, call `updatePreferredVoice(voiceName)`
   from `utils/auth.js` and `updateUser({ preferredVoice: voiceName })`
   from the auth context so the UI reflects it immediately.
4. In `Practice.jsx`, before calling `speakText()`, look up
   `user?.preferredVoice` and pass it through so `speech.js` selects
   that exact voice by name instead of auto-picking one — a small
   change to `pickEnglishVoice()` to accept an optional `voiceName` and
   `voices.find(v => v.name === voiceName)` first.

**B) Per-user custom conversation content**

1. `conversation_sets.user_id` already exists (nullable — `NULL` means
   shared/global content, exactly what's seeded today).
2. Add backend endpoints (protected by `authRequired`) for a user to
   manage their own lines, e.g.:
   - `POST /api/my-conversations` — create a custom set for a topic/level (insert into `conversation_sets` with `user_id = req.user.id`, then rows into `conversation_lines`)
   - `GET /api/my-conversations?topic=...&level=...` — list the user's own sets
   - `PUT /api/my-conversations/:id` / `DELETE /api/my-conversations/:id` — edit/remove
3. Update `getConversations` in `conversationsController.js` to prefer a
   matching row where `user_id = req.user.id` (if logged in and one
   exists) over the shared `user_id IS NULL` row for that topic/level.
4. On the frontend, add a small "Customize this topic" screen (a form
   with repeatable AI-line / suggested-answer pairs) that calls the new
   endpoints, gated behind `useAuth().user` being present.

Neither of these is required for the app to work — they're the natural
next step once you're ready to build them.

## 14. Troubleshooting

**"Microphone access is required..." keeps appearing**
Check your browser's site settings (the padlock/info icon in the address
bar) and make sure microphone access is allowed for this site, then
reload and try again.

**Backend won't start / "MySQL connection: FAILED"**
Double check `backend/.env` — host, user, password, and database name.
Confirm MySQL is running (`mysql -u root -p` should connect) and that
you've run `schema.sql` and `seed.sql`.

**Frontend shows "Using built-in offline conversation data"**
This means the frontend couldn't reach the backend API within a few
seconds. The app still works using bundled data — check that the backend
is running on the port set in `VITE_API_URL` and that CORS_ORIGIN in the
backend `.env` matches your frontend URL.

**No AI voice / it sounds robotic or silent**
`speechSynthesis` voice quality and availability depends on your OS and
browser. Chrome and Edge generally have the best built-in voices. If no
voice speaks at all, check your OS volume and that the tab isn't muted.

**Recording doesn't start / NEXT button does nothing about audio**
Recording is continuous for the whole session — you only need to grant
microphone permission once at the start. If `MediaRecorder` isn't
supported in your browser, you'll see a clear message on the Practice
screen instead of a crash.

**Playback on the Complete screen is empty**
This happens if the session ended before any audio was captured (e.g.
permission was revoked mid-session) or if you refreshed the page — per
the app's design, recordings are session-only and are not saved to any
server or database.

---

Built with a simple, focused stack — no logins, no payments, no AI
grading, just guided speaking practice.
