CREATE DATABASE IF NOT EXISTS analytics;

CREATE TABLE IF NOT EXISTS analytics.events
(
  event_id UUID,
  type LowCardinality(String),
  game_ts DateTime64(3, 'UTC'),
  user_id String,
  match_id String,
  latency_ms UInt32,
  payload_json String
)
ENGINE = MergeTree
PARTITION BY toDate(game_ts)
ORDER BY (game_ts, type)
SETTINGS index_granularity = 8192;
