DROP DATABASE IF EXISTS fordaStore;
CREATE DATABASE fordaStore;
USE fordaStore;

CREATE TABLE User (
  userID INT AUTO_INCREMENT NOT NULL,
  username VARCHAR(255) NOT NULL,
  userPassword VARCHAR(255) NOT NULL,
  PRIMARY KEY(userID)
);
CREATE TABLE Permission (
  permID INT AUTO_INCREMENT NOT NULL,
  description VARCHAR(255) NOT NULL,
  PRIMARY KEY(permID)
);
CREATE TABLE Container (
  containerID INT AUTO_INCREMENT NOT NULL,
  containerTitle VARCHAR(255) NOT NULL,
  PRIMARY KEY(containerID)
);
CREATE TABLE HasPermission (
  hasPermissionID INT AUTO_INCREMENT NOT NULL,
  userID INT,
  permID INT,
  containerID INT,
  PRIMARY KEY(hasPermissionID),
  FOREIGN KEY(userID) REFERENCES User(userID),
  FOREIGN KEY(permID) REFERENCES Permission(permID),
  FOREIGN KEY(containerID) REFERENCES Container(containerID)
);
CREATE TABLE Content (
  contentID INT AUTO_INCREMENT NOT NULL,
  contentText VARCHAR(255) NOT NULL,
  containerID INT NOT NULL,
  PRIMARY KEY(contentID),
  FOREIGN KEY(containerID) REFERENCES Container(containerID)
);
CREATE TABLE ContentCredentials(
  contentCredentialsID INT AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  contentCredentialsPassword VARCHAR(255) NOT NULL,
  PRIMARY KEY(contentCredentialsID)
);