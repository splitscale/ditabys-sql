DROP DATABASE IF EXISTS dev;
CREATE DATABASE dev;
USE dev;

CREATE TABLE user (
	user_id binary(16) PRIMARY KEY NOT NULL,
	username VARCHAR(50) NOT NULL UNIQUE,
	password VARCHAR(255) NOT NULL
);

CREATE TABLE container (
  container_id BIGINT AUTO_INCREMENT NOT NULL,
  container_title VARCHAR(255) NOT NULL,
  user_id binary(16) NOT NULL,
  PRIMARY KEY(container_id),
  FOREIGN KEY(user_id) REFERENCES user(user_id)
);

CREATE TABLE url (
  url_id BIGINT AUTO_INCREMENT NOT NULL,
  url VARCHAR(2000) NOT NULL,
  container_id BIGINT NOT NULL,
  PRIMARY KEY(url_id),
  FOREIGN KEY(container_id) REFERENCES container(container_id)
);
