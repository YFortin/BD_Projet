DROP DATABASE IF EXISTS Memer;

CREATE DATABASE Memer;
use Memer;

DROP TABLE IF EXISTS Memes;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Liked;
DROP TABLE IF EXISTS Disliked;
DROP TABLE IF EXISTS Seen;
DROP TABLE IF EXISTS Uploaded;
DROP TABLE IF EXISTS Comment;
DROP TABLE IF EXISTS Token;
DROP TABLE IF EXISTS Top;

CREATE TABLE Memes
(
    id       VARCHAR(36) UNIQUE NOT NULL,
    title    VARCHAR(100),
    url      VARCHAR(200),
    category VARCHAR(100),

    PRIMARY KEY (id)
);

CREATE TABLE Users
(
    id             VARCHAR(36) UNIQUE NOT NULL,
    username       VARCHAR(30) UNIQUE,
	avatar		   VARCHAR(200),
    email          VARCHAR(50) UNIQUE,
    hashedPassword VARCHAR(128),
    salt           VARCHAR(36),

    PRIMARY KEY (id)
);

CREATE TABLE Follow
(
    followee VARCHAR(36) NOT NULL,
    follower VARCHAR(36) NOT NULL,

    FOREIGN KEY (follower) REFERENCES Users (id)
        ON UPDATE CASCADE,
    FOREIGN KEY (followee) REFERENCES Users (id)
        ON UPDATE CASCADE
);


CREATE TABLE Seen
(
    userId VARCHAR(36) NOT NULL,
    memeId VARCHAR(36) NOT NULL,
    date   DATE,


    FOREIGN KEY (userId) REFERENCES Users (id)
        ON UPDATE CASCADE,
    FOREIGN KEY (memeId) REFERENCES Memes (id)
        ON UPDATE CASCADE
);

CREATE TABLE Liked
(
    userId VARCHAR(36) NOT NULL,
    memeId VARCHAR(36) NOT NULL,


    FOREIGN KEY (userId) REFERENCES Users (id)
        ON UPDATE CASCADE,
    FOREIGN KEY (memeId) REFERENCES Memes (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Disliked
(
    userId VARCHAR(36) NOT NULL,
    memeId VARCHAR(36) NOT NULL,


    FOREIGN KEY (userId) REFERENCES Users (id)
        ON UPDATE CASCADE,
    FOREIGN KEY (memeId) REFERENCES Memes (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Uploaded
(
    userId VARCHAR(36) NOT NULL,
    memeId VARCHAR(36) NOT NULL,
    date   DATE,

    FOREIGN KEY (userId) REFERENCES Users (id)
        ON UPDATE CASCADE,
    FOREIGN KEY (memeId) REFERENCES Memes (id)
        ON DELETE CASCADE
);

CREATE TABLE Comment
(
    commentId VARCHAR(36) NOT NULL,
    userId    VARCHAR(36) NOT NULL,
    memeId    VARCHAR(36) NOT NULL,
    date      DATE,
    text      VARCHAR(1000),

    PRIMARY KEY (commentId),
    FOREIGN KEY (userId) REFERENCES Users (id)
        ON UPDATE CASCADE,
    FOREIGN KEY (memeId) REFERENCES Memes (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Token
(
    id          INTEGER AUTO_INCREMENT,
    userId      VARCHAR(36) NOT NULL,
    token       VARCHAR(36) UNIQUE,
    expiredDate DATE,

    PRIMARY KEY (id),
    FOREIGN KEY (userId) REFERENCES Users (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


CREATE TABLE Top
(
    memeId VARCHAR(36) NOT NULL,

    PRIMARY KEY (memeId),
    FOREIGN KEY (memeId) REFERENCES Memes (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- TODO remove before deposit
INSERT INTO Users (id, username, avatar, email, hashedPassword, salt)
VALUES ('admin', 'admin', 'https://store.playstation.com/store/api/chihiro/00_09_000/container/FR/fr/999/EP0149-CUSA09988_00-AV00000000000001/1553560094000/image?w=240&h=240&bg_color=000000&opacity=100&_version=00_09_000', 'admin@admin.com', 'admin', 'admin');

INSERT INTO Token (userId, token, expiredDate)
VALUES ('admin', 'admin', '2021-01-01');

-- TODO add ONE DELETE and ON UPDATE
-- TODO trigger on Liked to Top
-- TODO trigger verify username validity
-- TODO trigger remove old token

-- Triggers
-- delimiter //
DROP PROCEDURE IF EXISTS remove_old_token;
CREATE DEFINER = 'memer_api' PROCEDURE remove_old_token() DELETE FROM Token WHERE expiredDate <= CURRENT_DATE();
-- delimiter ;

-- Indexes
CREATE UNIQUE INDEX token_index ON Token (token) USING HASH;
CREATE FULLTEXT INDEX username_index ON Users (username);

-- User
DROP USER IF EXISTS 'memer_api';
CREATE USER 'memer_api' IDENTIFIED BY '4215Hello!@';
GRANT SELECT, INSERT, UPDATE, DELETE ON Memer.* TO 'memer_api';
GRANT EXECUTE ON PROCEDURE Memer.remove_old_token TO 'memer_api';

-- Insert data
