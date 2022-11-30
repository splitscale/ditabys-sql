CREATE DATABASE fordaStore;
USE fordaStore;
CREATE TABLE users(
    userID INT AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL,
    userPassword VARCHAR(255) NOT NULL,
    PRIMARY KEY(userID)
);
CREATE TABLE permission(
    permID INT AUTO_INCREMENT,
    description VARCHAR(255),
    PRIMARY KEY(permID)
);
CREATE TABLE hasPermission(
    hasPermissionID INT AUTO_INCREMENT,
    userID INT,
    permiID INT,
    PRIMARY KEY(hasPermissionID),
    FOREIGN KEY(userID) REFERENCES users(userID),
    FOREIGN KEY(permiID) REFERENCES permission(permID)
);
CREATE TABLE container(
    containerID INT AUTO_INCREMENT,
    hasPermissionID INT,
    containerTitle VARCHAR(255),
    PRIMARY KEY(containerID),
    FOREIGN KEY(hasPermissionID) REFERENCES hasPermission(hasPermissionID)
);
CREATE TABLE content(
    contentID INT AUTO_INCREMENT,
    contentText VARCHAR(255),
    containerID INT,
    PRIMARY KEY(contentID),
    FOREIGN KEY(containerID) REFERENCES container(ContainerID)
);