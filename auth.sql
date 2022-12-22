DROP DATABASE IF EXISTS auth;
CREATE DATABASE auth;
USE auth;

CREATE TABLE token (
  token_id BIGINT AUTO_INCREMENT NOT NULL,
  uid VARCHAR(255) UNIQUE NOT NULL,
  public_key VARCHAR(3000) NOT NULL,
  PRIMARY KEY(token_id)
);

DELIMITER && 
CREATE PROCEDURE newToken(IN uid BIGINT, public_key VARCHAR(3000))
BEGIN 
INSERT INTO token (uid, public_key)
VALUES (uid, public_key)
END&&
DELIMITER ;

DELIMITER && 
CREATE PROCEDURE updateToken(IN token_id BIGINT, uid VARCHAR(255), public_key VARCHAR(3000) )
BEGIN 
UPDATE token
SET token_id = token_id, uid= uid, public_key = public_key
WHERE token_id = token_id;
END&&
DELIMITER ;

DELIMITER && 
CREATE PROCEDURE deleteToken(IN token_id BIGINT)
BEGIN 
DELETE FROM token
WHERE token_id = token_id;
END&&
DELIMITER ;

