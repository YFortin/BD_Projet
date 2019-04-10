DROP DATABASE IF EXISTS Memeber;

CREATE DATABASE Memeber;
use Memeber;

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
    id       VARCHAR(36) NOT NULL,
    title    VARCHAR(100),
    url      VARCHAR(200),
    category VARCHAR(100),

    PRIMARY KEY (id)
);

CREATE TABLE Users
(
    id             VARCHAR(36) NOT NULL,
    username       VARCHAR(30),
    email          VARCHAR(50),
    hashedPassword VARCHAR(128),
    salt           VARCHAR(36),

    PRIMARY KEY (id)
);

CREATE TABLE Follow
(
    followee VARCHAR(36) NOT NULL,
    follower VARCHAR(36) NOT NULL,

    PRIMARY KEY (followee),
    FOREIGN KEY (follower) REFERENCES Users (id),
    FOREIGN KEY (followee) REFERENCES Users (id)
);


CREATE TABLE Seen
(
    userId VARCHAR(36) NOT NULL,
    memeId VARCHAR(36) NOT NULL,
    date   DATE,


    FOREIGN KEY (userId) REFERENCES Users (id),
    FOREIGN KEY (memeId) REFERENCES Memes (id)
);

CREATE TABLE Liked
(
    userId VARCHAR(36) NOT NULL,
    memeId VARCHAR(36) NOT NULL,


    FOREIGN KEY (userId) REFERENCES Users (id),
    FOREIGN KEY (memeId) REFERENCES Memes (id)


);

CREATE TABLE Disliked
(
    userId VARCHAR(36) NOT NULL,
    memeId VARCHAR(36) NOT NULL,


    FOREIGN KEY (userId) REFERENCES Users (id),
    FOREIGN KEY (memeId) REFERENCES Memes (id)

);



CREATE TABLE Uploaded
(
    userId VARCHAR(36) NOT NULL,
    memeId VARCHAR(36) NOT NULL,
    date   DATE,

    FOREIGN KEY (userId) REFERENCES Users (id)
        ON DELETE CASCADE,
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
    FOREIGN KEY (userId) REFERENCES Users (id),
    FOREIGN KEY (memeId) REFERENCES Memes (id)
);

CREATE TABLE Token
(
    id          INTEGER AUTO_INCREMENT,
    userId      VARCHAR(36) NOT NULL,
    token       VARCHAR(36),
    expiredDate DATE,

    PRIMARY KEY (id),
    FOREIGN KEY (userId) REFERENCES Users (id)
);


CREATE TABLE Top
(
    memeId VARCHAR(36) NOT NULL,
    data   DATE,

    PRIMARY KEY (memeId),
    FOREIGN KEY (memeId) REFERENCES Memes (id)
);

-- TODO add ONE DELETE and ON UPDATE
-- TODO trigger on Liked to Top
-- TODO trigger verify username validity
-- TODO trigger remove old token
