const jwt = require("jsonwebtoken");

/**
 * Requires a valid "Authorization: Bearer <token>" header.
 * On success, attaches req.user = { id, email, displayName }.
 * On failure, responds 401 and does not call next().
 */
function authRequired(req, res, next) {
  const header = req.headers.authorization;

  if (!header || !header.startsWith("Bearer ")) {
    return res.status(401).json({
      success: false,
      message: "You must be logged in to do that.",
    });
  }

  const token = header.slice(7);

  try {
    const payload = jwt.verify(token, process.env.JWT_SECRET);
    req.user = { id: payload.sub, email: payload.email, displayName: payload.displayName };
    next();
  } catch (err) {
    return res.status(401).json({
      success: false,
      message: "Your session has expired. Please log in again.",
    });
  }
}

/**
 * Like authRequired, but never blocks the request — useful for routes
 * that behave differently for logged-in vs. anonymous users (e.g. a
 * future "show my custom conversations if logged in" feature) without
 * requiring login. req.user is undefined if there's no valid token.
 */
function optionalAuth(req, res, next) {
  const header = req.headers.authorization;

  if (header && header.startsWith("Bearer ")) {
    try {
      const payload = jwt.verify(header.slice(7), process.env.JWT_SECRET);
      req.user = { id: payload.sub, email: payload.email, displayName: payload.displayName };
    } catch (err) {
      // Invalid/expired token on an optional route — just proceed as anonymous.
    }
  }

  next();
}

module.exports = { authRequired, optionalAuth };