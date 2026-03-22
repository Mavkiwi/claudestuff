-- AI Training Hub - D1 Schema
-- Apply: npx wrangler d1 execute ai-training-db --file=./db/schema.sql

CREATE TABLE IF NOT EXISTS participants (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  email TEXT UNIQUE,
  organisation TEXT,
  registered_at TEXT DEFAULT (datetime('now')),
  completed_at TEXT
);

CREATE TABLE IF NOT EXISTS modules (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT UNIQUE NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  sort_order INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS progress (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  participant_id INTEGER NOT NULL REFERENCES participants(id),
  module_id INTEGER NOT NULL REFERENCES modules(id),
  status TEXT DEFAULT 'not_started' CHECK(status IN ('not_started','in_progress','completed')),
  started_at TEXT,
  completed_at TEXT,
  score INTEGER,
  UNIQUE(participant_id, module_id)
);

CREATE TABLE IF NOT EXISTS feedback (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  participant_id INTEGER REFERENCES participants(id),
  module_id INTEGER REFERENCES modules(id),
  rating INTEGER CHECK(rating BETWEEN 1 AND 5),
  comment TEXT,
  created_at TEXT DEFAULT (datetime('now'))
);

-- Seed modules
INSERT OR IGNORE INTO modules (slug, title, description, sort_order) VALUES
  ('ai-strategy', 'AI Strategy', 'Understanding the AI landscape and strategic positioning', 1),
  ('prompt-engineering', 'Prompt Engineering', 'Getting great results from AI conversations', 2),
  ('agentic-ai', 'Agentic AI', 'AI that acts autonomously on your behalf', 3),
  ('governance', 'Governance & Safety', 'Policies, verification tiers, and responsible use', 4),
  ('hands-on', 'Hands-on Labs', 'Building with Claude, Cursor, and automation tools', 5),
  ('cost-roi', 'Cost & ROI', 'Understanding the economics of AI adoption', 6),
  ('ai-teams', 'Building AI Teams', 'Progression from solo user to AI commander', 7),
  ('tools', 'Tools & Platforms', 'The AI toolkit from Tier 1 to Enterprise', 8);
