CREATE DATABASE memeber;
use memeber;

CREATE TABLE memes
(
	name VARCHAR(100),
	url VARCHAR(200)
);

INSERT INTO memes
	(name,url)
VALUES
	("no gaz", "https://img-9gag-fun.9cache.com/photo/aKxewzj_700bwp.webp"),
	("Probably the happiest guy alive right now <3", "https://img-9gag-fun.9cache.com/photo/a1QV4Wb_700bwp.webp"),
	("That subtle marble thigh softness", "https://img-9gag-fun.9cache.com/photo/an9EeR5_700bwp.webp"),
	("2019 be like", "https://img-9gag-fun.9cache.com/photo/a6O2rgR_700bwp.webp"),
	("Sometimes I just can't stand her", "https://img-9gag-fun.9cache.com/photo/a739m9b_460swp.webp"),
	("Think about it, Google ", "https://img-9gag-fun.9cache.com/photo/aB0EMG2_460swp.webp"),
	("Nice view you've got there mate", "https://preview.redd.it/zrid66bv7ho21.jpg?width=960&crop=smart&auto=webp&s=321fdfb6948eb2c077160062ff7846b37ac65dab");

	
CREATE TABLE user
(
	id INTEGER NOT NULL,
	username VARCHAR(30),
	email VARCHAR(50),
	hashedPassword VARCHAR(64),
	salt VARCHAR(16),
	PRIMARY KEY(id),
);

