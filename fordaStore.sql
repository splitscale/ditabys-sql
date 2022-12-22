DROP DATABASE IF EXISTS shield;
CREATE DATABASE shield;
USE shield;

CREATE TABLE public_key (
  key_id binary(16) PRIMARY KEY NOT NULL,
  key_value VARCHAR(3000) NOT NULL
);

DROP DATABASE IF EXISTS store;
CREATE DATABASE store;
USE store;

CREATE TABLE user (
  user_id binary(16) PRIMARY KEY NOT NULL UNIQUE,
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
CREATE TABLE url_credentials (
  credentials_id BIGINT AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  PRIMARY KEY(credentials_id)
);
CREATE TABLE url (
  url_id BIGINT AUTO_INCREMENT NOT NULL,
  url VARCHAR(2000) NOT NULL,
  container_id BIGINT NOT NULL,
  credentials_id BIGINT,
  PRIMARY KEY(url_id),
  FOREIGN KEY(container_id) REFERENCES container(container_id),
  FOREIGN KEY(credentials_id) REFERENCES url_credentials(credentials_id)
);

DELIMITER && 
CREATE PROCEDURE newUser(IN user_id BINARY(16),username VARCHAR(255), password VARCHAR(255))
BEGIN 
INSERT INTO user (user_id, username, password) VALUES (user_id, username, password);
END&&
DELIMITER ;  

DELIMITER && 
CREATE PROCEDURE newContainer(IN user_id BINARY(16), container_title VARCHAR(255))
BEGIN 
INSERT INTO container (user_id, container_title) VALUES  (user_id, container_title);
END&&
DELIMITER ;  

DELIMITER && 
CREATE PROCEDURE newCredentials(IN username VARCHAR(255), password VARCHAR(255))
BEGIN 
INSERT INTO url_credentials (username, password) VALUES (username, password);
END&&
DELIMITER ;  

DELIMITER && 
CREATE PROCEDURE newContent(IN url VARCHAR(2000), container_id BIGINT, credentials_id BIGINT)
BEGIN 
INSERT INTO url (url, container_id, credentials_id) VALUES (url, container_id, credentials_id);
END&&
DELIMITER ;  

DELIMITER && 
CREATE PROCEDURE getUser(IN user_id BIGINT)
BEGIN 
SELECT * FROM user WHERE user_id = user_id;
END&&

DELIMITER && 
CREATE PROCEDURE getUserContainers(IN user_id BIGINT)
BEGIN 
SELECT * FROM container 
WHERE user_id = user_id;
END&&
DELIMITER ;  

DELIMITER && 
CREATE PROCEDURE getContainerContent(IN container_id BIGINT)
BEGIN 
SELECT * FROM container
WHERE container_id = container_id;
END&&
DELIMITER ;  

DELIMITER && 
CREATE PROCEDURE findContent(IN url_id BIGINT)
BEGIN 
SELECT c.*, cc.username, cc.password, co.container_title
FROM url c
LEFT JOIN url_credentials cc ON c.credentials_id = cc.credentials_id
LEFT JOIN container co ON c.container_id = co.container_id
WHERE c.url_id = url_id;
END&&
DELIMITER ;  

DELIMITER && 
CREATE PROCEDURE findContainerIDAndTitle(IN username VARCHAR(255))
BEGIN 
SELECT container_id, container_title 
FROM container 
WHERE user_id = (
SELECT user_id 
FROM user 
WHERE username = username);
END&&
DELIMITER ;  

DELIMITER && 
CREATE PROCEDURE getContainerContentAndCredentials(IN container_title VARCHAR(255))
BEGIN 
SELECT c.*, cc.username, cc.password
FROM url c
LEFT JOIN url_credentials cc ON c.credentials_id = cc.credentials_id
WHERE c.container_id = (SELECT container_id FROM container WHERE container_title = container_title);
END&&
DELIMITER ;

DELIMITER && 
CREATE PROCEDURE getContainerContentIDAndText(IN container_title VARCHAR(255))
BEGIN 
SELECT url_id, url
FROM url
WHERE container_id = (
SELECT container_id
FROM container
WHERE container_title = container_title);
END&&
DELIMITER ;

DELIMITER && 
CREATE PROCEDURE updateUser(IN user_id BIGINT, username VARCHAR(255), password VARCHAR(255),uid VARCHAR(255))
BEGIN 
UPDATE user SET username = username, password = password, uid = uid WHERE user_id = user_id;
END&&
DELIMITER ;

DELIMITER && 
CREATE PROCEDURE updateUsername(IN user_id BIGINT, username VARCHAR(255))
BEGIN 
UPDATE user SET username = username WHERE user_id = user_id;
END&&
DELIMITER ;

DELIMITER && 
CREATE PROCEDURE updateContainer(IN container_id BIGINT, container_title VARCHAR(255))
BEGIN 
UPDATE container
SET container_title =container_title
WHERE container_id = container_id;
END&&
DELIMITER ;

DELIMITER && 
CREATE PROCEDURE deleteContainer(IN container_id BIGINT)
BEGIN 
DELETE FROM container
WHERE container_id = container_id;
END&&
DELIMITER ;

DELIMITER && 
CREATE PROCEDURE updateURL(IN url_id BIGINT, url VARCHAR(2000))
BEGIN 
UPDATE url
SET url = url
WHERE url_id = url_id;
END&&
DELIMITER ;

DELIMITER && 
CREATE PROCEDURE deleteURL(IN url_id BIGINT)
BEGIN 
DELETE FROM url
WHERE url_id = url_id;
END&&
DELIMITER ;

DELIMITER && 
CREATE PROCEDURE updateURLCredentials(IN credentials_id BIGINT, username VARCHAR(255))
BEGIN 
UPDATE url_credentials
SET username = username
WHERE credentials_id = credentials_id;
END&&
DELIMITER ;

DELIMITER && 
CREATE PROCEDURE deleteURLCredentials(IN credentials_id BIGINT)
BEGIN 
DELETE FROM url_credentials
WHERE credentials_id = credentials_id;
END&&
DELIMITER ;