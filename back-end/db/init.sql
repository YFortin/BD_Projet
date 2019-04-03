CREATE DATABASE memeber;
use memeber;

CREATE TABLE Memes
(
    memeId VARCHAR(36) NOT NULL,
    title  VARCHAR(100),
    url    VARCHAR(200),

    PRIMARY KEY (memeId)
);

/*
INSERT INTO memes
	(name,url,memeId)
VALUES
	("no gaz", "https://img-9gag-fun.9cache.com/photo/aKxewzj_700bwp.webp",0),
	("Probably the happiest guy alive right now <3", "https://img-9gag-fun.9cache.com/photo/a1QV4Wb_700bwp.webp",1),
	("That subtle marble thigh softness", "https://img-9gag-fun.9cache.com/photo/an9EeR5_700bwp.webp",2),
	("2019 be like", "https://img-9gag-fun.9cache.com/photo/a6O2rgR_700bwp.webp",3),
	("Sometimes I just can't stand her", "https://img-9gag-fun.9cache.com/photo/a739m9b_460swp.webp",4),
	("Think about it, Google ", "https://img-9gag-fun.9cache.com/photo/aB0EMG2_460swp.webp",5),
	("Nice view you've got there mate", "https://preview.redd.it/zrid66bv7ho21.jpg?width=960&crop=smart&auto=webp&s=321fdfb6948eb2c077160062ff7846b37ac65dab",6);
*/

CREATE TABLE Users
(
    userId         VARCHAR(36) NOT NULL,
    username       VARCHAR(30),
    email          VARCHAR(50),
    hashedPassword VARCHAR(64),
    salt           VARCHAR(16),

    PRIMARY KEY (userId)
);

CREATE TABLE Follow
(
    followee VARCHAR(36) NOT NULL,
    follower VARCHAR(36) NOT NULL,

    PRIMARY KEY (followee),
    FOREIGN KEY (follower) REFERENCES Users (userId),
    FOREIGN KEY (followee) REFERENCES Users (userId)
);

CREATE TABLE Liked
(
    userId VARCHAR(36) NOT NULL,
    memeId VARCHAR(36) NOT NULL,
    date   DATE,

    PRIMARY KEY (userId),
    FOREIGN KEY (userId) REFERENCES Users (userId),
    FOREIGN KEY (memeId) REFERENCES Memes (memeId)
);

CREATE TABLE Disliked
(
    userId VARCHAR(36) NOT NULL,
    memeId VARCHAR(36) NOT NULL,
    date   DATE,

    PRIMARY KEY (userId),
    FOREIGN KEY (userId) REFERENCES Users (userId),
    FOREIGN KEY (memeId) REFERENCES Memes (memeId)
);

CREATE TABLE Seen
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    userId    VARCHAR(36) NOT NULL,
    memeId    VARCHAR(36) NOT NULL,
    startTime DATE,
    endTime   DATE,

    PRIMARY KEY (id),
    FOREIGN KEY (userId) REFERENCES Users (userId),
    FOREIGN KEY (memeId) REFERENCES Memes (memeId)
);

CREATE TABLE Uploaded
(
    userId VARCHAR(36) NOT NULL,
    memeId VARCHAR(36),
    date   DATE,

    PRIMARY KEY (userId),
    FOREIGN KEY (userId) REFERENCES Users (userId),
    FOREIGN KEY (memeId) REFERENCES Memes (memeId)
);

CREATE TABLE Comment
(
    commentId INTEGER AUTO_INCREMENT,
    userId    INTEGER NOT NULL,
    memeId    INTEGER NOT NULL,
    date      DATE,
    text      VARCHAR(1000),

    PRIMARY KEY (commentId),
    FOREIGN KEY (userId) REFERENCES Users (userId),
    FOREIGN KEY (memeId) REFERENCES Memes (memeId)
);

CREATE TABLE Token
(
    id     INTEGER AUTO_INCREMENT,
    userId VARCHAR(36) NOT NULL,
    token  VARCHAR(36),

    PRIMARY KEY (id),
    FOREIGN KEY (userId) REFERENCES Users (userId)
);

CREATE TABLE Top
(
    memeId VARCHAR(36) NOT NULL,
    data   DATE,

    PRIMARY KEY (memeId),
    FOREIGN KEY (memeId) REFERENCES Memes (memeId)
);

/* TODO trigger on Liked to Top*/
/* TODO trigger verify username validity */
