DROP DATABASE IF EXISTS fordaStore;
CREATE DATABASE fordaStore;
USE fordaStore;

CREATE TABLE User (
  userID BIGINT AUTO_INCREMENT NOT NULL,
  username VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  PRIMARY KEY(userID)
);
CREATE TABLE Container (
  containerID BIGINT AUTO_INCREMENT NOT NULL,
  containerTitle VARCHAR(255) NOT NULL,
  userID BIGINT,
  PRIMARY KEY(containerID),
  FOREIGN KEY(userID) REFERENCES User(userID)
);
CREATE TABLE ContentCredentials(
  contentCredentialsID BIGINT AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  PRIMARY KEY(contentCredentialsID)
);
CREATE TABLE Content (
  contentID BIGINT AUTO_INCREMENT NOT NULL,
  contentText VARCHAR(255) NOT NULL,
  containerID BIGINT NOT NULL,
  contentCredentialsID BIGINT,
  PRIMARY KEY(contentID),
  FOREIGN KEY(containerID) REFERENCES Container(containerID),
  FOREIGN KEY(contentCredentialsID) REFERENCES ContentCredentials( contentCredentialsID)
);
DELIMITER && 
CREATE PROCEDURE getUserContainers(IN userID BIGINT)
BEGIN 
SELECT * FROM Container 
WHERE Container.userID = userID;
END&&
DELIMITER ;  

DELIMITER && 
CREATE PROCEDURE getContainerContent(IN containerID BIGINT)
BEGIN 
SELECT * FROM Content 
WHERE Content.contentID = containerID;
END&&
DELIMITER ;  