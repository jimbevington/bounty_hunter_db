DROP TABLE IF EXISTS bounty_list;

CREATE TABLE bounty_list(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  bounty INT,
  danger_level VARCHAR(255),
  cashed_in BOOLEAN
);
