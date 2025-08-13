CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  apple_sub TEXT UNIQUE,         -- Sign in with Apple subject
  username TEXT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS questions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  category TEXT NOT NULL,
  difficulty TEXT NOT NULL,      -- easy|medium|hard
  body TEXT NOT NULL,
  choices TEXT[] NOT NULL,       -- 4 options
  correct_index SMALLINT NOT NULL
);

CREATE TABLE IF NOT EXISTS matches (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  region TEXT NOT NULL DEFAULT 'eu-central',
  status TEXT NOT NULL DEFAULT 'finished'  -- future: queued|live|finished
);

CREATE TABLE IF NOT EXISTS match_players (
  match_id UUID REFERENCES matches(id) ON DELETE CASCADE,
  user_id  UUID REFERENCES users(id)   ON DELETE CASCADE,
  score    INT NOT NULL DEFAULT 0,
  elo_delta INT NOT NULL DEFAULT 0,
  PRIMARY KEY (match_id, user_id)
);

CREATE TABLE IF NOT EXISTS answers (
  match_id UUID REFERENCES matches(id) ON DELETE CASCADE,
  user_id  UUID REFERENCES users(id)   ON DELETE CASCADE,
  q_index  SMALLINT NOT NULL,          -- 0..9 for a 10Q match
  question_id UUID REFERENCES questions(id),
  correct  BOOLEAN NOT NULL,
  latency_ms INT NOT NULL,
  submitted_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (match_id, user_id, q_index)
);

CREATE TABLE IF NOT EXISTS elo_history (
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  at TIMESTAMPTZ NOT NULL DEFAULT now(),
  elo INT NOT NULL,
  PRIMARY KEY (user_id, at)
);
