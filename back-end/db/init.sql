CREATE DATABASE memeber;
use memeber;

CREATE TABLE memes
(
	name VARCHAR(100),
	url VARCHAR(200),
	memeId INTEGER(10),

	PRIMARY KEY(memeId)

);

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

	
CREATE TABLE user
(
	userId INTEGER NOT NULL,
	username VARCHAR(30),
	email VARCHAR(50),
	hashedPassword VARCHAR(64),
	salt VARCHAR(16),
	PRIMARY KEY(userId),
);

CREATE TABLE follow
(
	userId INTEGER NOT NULL,
	followerId INTEGER NOT NULL,
)

CREATE TABLE liked
(
	userId INTEGER NOT NULL,
	memeId INTEGER(10)
	date DATE
)

CREATE TABLE seen
(
	userId INTEGER NOT NULL,
	memeId INTEGER(10)
	time INT(5)
)

CREATE TABLE disliked
(
	userId INTEGER NOT NULL,
	memeId INTEGER(10)
	date DATE
)

CREATE TABLE uploaded
(
	userId INTEGER NOT NULL,
	memeId INTEGER(10)
	date DATE
)

CREATE TABLE comment
(
	userId INTEGER NOT NULL,
	date DATE,
	commentId INTEGER NOT NULL,
	text VARCHAR(1000),
	PRIMARY KEY(commentId),
)

CREATE TABLE token
(
	userId INTEGER NOT NULL,
	token VARCHAR(200),
)

CREATE TABLE nbLike
(
	memeId INTEGER(10),
	nbLike INTEGER(6),
	top BOOLEAN,
)

CREATE TRIGGER isTop
AFTER UPDATE
ON nbLike  
FOR EACH ROW
IF (NEW.nbLike > 10)
SET NEW.top = TRUE 
ELSE NEW.top = FALSE
