DROP DATABASE IF EXISTS sessions;
CREATE DATABASE sessions;
USE sessions;

CREATE TABLE token (
  token_id BIGINT NOT NULL,
  uid VARCHAR(255) UNIQUE NOT NULL,
  public_key VARCHAR(3000) NOT NULL,
  PRIMARY KEY(token_id)
);
