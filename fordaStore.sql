DROP DATABASE IF EXISTS sessions;
CREATE DATABASE sessions;
USE sessions;

CREATE TABLE token (
  token_id BIGINT AUTO_INCREMENT NOT NULL,
  uid VARCHAR(255) UNIQUE NOT NULL,
  public_key VARCHAR(1024) UNIQUE NOT NULL,
  PRIMARY KEY(token_id)
);

DROP DATABASE IF EXISTS fordastore;
CREATE DATABASE fordastore;
USE fordastore;

CREATE TABLE user (
  user_id BIGINT AUTO_INCREMENT NOT NULL,
  username VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  uid VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY(user_id)
);
CREATE TABLE container (
  container_id BIGINT AUTO_INCREMENT NOT NULL,
  container_title VARCHAR(255) NOT NULL,
  user_id BIGINT NOT NULL,
  PRIMARY KEY(container_id),
  FOREIGN KEY(user_id) REFERENCES user(user_id)
);
CREATE TABLE url_credentials (
  credentials_id BIGINT AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  PRIMARY KEY(credentials_id)
);
CREATE TABLE url (
  url_id BIGINT AUTO_INCREMENT NOT NULL,
  url VARCHAR(255) NOT NULL,
  container_id BIGINT NOT NULL,
  credentials_id BIGINT,
  PRIMARY KEY(url_id),
  FOREIGN KEY(container_id) REFERENCES container(container_id),
  FOREIGN KEY(credentials_id) REFERENCES url_credentials(credentials_id)
);