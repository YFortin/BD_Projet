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
	avatar		   VARCHAR(200),
    hashedPassword VARCHAR(128),
    salt           VARCHAR(36),

    PRIMARY KEY (id)
);

CREATE TABLE Follow
(
    followee VARCHAR(36) NOT NULL,
    follower VARCHAR(36) NOT NULL,

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
    date   DATE,

    PRIMARY KEY (memeId),
    FOREIGN KEY (memeId) REFERENCES Memes (id)
);

-- TODO remove before deposit
INSERT INTO Users (id, username, email, hashedPassword, salt)
VALUES ('admin', 'admin', 'admin', 'admin', 'admin');

INSERT INTO Token (userId, token, expiredDate)
VALUES ('admin', 'admin', '2021-01-01');

-- TODO add ONE DELETE and ON UPDATE
-- TODO trigger on Liked to Top
-- TODO trigger verify username validity
-- TODO trigger remove old token

INSERT INTO Memes (id, title, url, category) VALUES ("3ed32cd9-e074-48de-b47e-fefda7f9a206", "Magnam velit porro numquam.", "https://preview.redd.it/bq2j0dw68tr21.png?width=960&crop=smart&auto=webp&s=b490cefdf787c73e562e699adfd961541045e857", "holdmybeer");
INSERT INTO Memes (id, title, url, category) VALUES ("23bfbc77-01c9-4f75-b8cc-afff0c04dc31", "Labore dolor magnam sit.", "https://preview.redd.it/bq2j0dw68tr21.png?width=960&crop=smart&auto=webp&s=b490cefdf787c73e562e699adfd961541045e857", "2meirl4meirl");
INSERT INTO Memes (id, title, url, category) VALUES ("c77ea382-cbee-42b8-96bd-397b77e8455f", "Numquam dolore velit quiquia dolorem.", "https://preview.redd.it/m82pxbpaaur21.jpg?width=640&crop=smart&auto=webp&s=14de48af47c9e10080256a0805e764a8fbca7745", "classic");
INSERT INTO Memes (id, title, url, category) VALUES ("e813f8f4-98bc-4072-9e1a-cb3515162ce5", "Est dolore neque dolor.", "https://preview.redd.it/bq2j0dw68tr21.png?width=960&crop=smart&auto=webp&s=b490cefdf787c73e562e699adfd961541045e857", "dank");
INSERT INTO Memes (id, title, url, category) VALUES ("32a0a290-20e9-42e1-941e-b9b4ca8f53eb", "Amet modi consectetur porro numquam est numquam.", "https://i.redd.it/efks3i9rhtr21.jpg", "holdmybeer");
INSERT INTO Memes (id, title, url, category) VALUES ("1387e323-756b-48a4-bee7-511fdea14915", "Numquam aliquam eius porro etincidunt quiquia quiquia.", "https://i.redd.it/f26bi9089ur21.jpg", "2009");
INSERT INTO Memes (id, title, url, category) VALUES ("dd6c2407-0ac2-4d23-a6f9-8f1ecb5adfca", "Tempora eius magnam consectetur amet labore dolore quaerat.", "https://i.redd.it/5bcqhjdm1tr21.jpg", "dank");
INSERT INTO Memes (id, title, url, category) VALUES ("bd634a0a-3000-47ab-b054-b0a949e78bbf", "Dolor non sit velit aliquam.", "https://preview.redd.it/m82pxbpaaur21.jpg?width=640&crop=smart&auto=webp&s=14de48af47c9e10080256a0805e764a8fbca7745", "holdmybeer");
INSERT INTO Memes (id, title, url, category) VALUES ("f63aaa52-568c-45b8-841d-94c6567b1f78", "Labore labore est magnam sit ut neque magnam.", "https://i.redd.it/00pwop4bjsy11.jpg", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("2d531465-2d92-4a2c-b333-bb00b5cecde6", "Est quisquam velit neque quiquia.", "https://i.redd.it/efks3i9rhtr21.jpg", "2meirl4meirl");
INSERT INTO Memes (id, title, url, category) VALUES ("6d677865-1bb1-4f4c-bfd0-0964282a2381", "Ipsum quiquia aliquam non tempora voluptatem magnam quisquam.", "https://i.redd.it/3c6sylyabur21.png", "classic");
INSERT INTO Memes (id, title, url, category) VALUES ("13399ded-6671-41ee-9c6c-62a5edf835d1", "Quaerat dolor non tempora aliquam porro.", "https://i.redd.it/5bcqhjdm1tr21.jpg", "holdmybeer");
INSERT INTO Memes (id, title, url, category) VALUES ("4331dcc1-618d-4b7d-be49-6c7bc320ee34", "Dolor voluptatem quiquia modi velit.", "https://i.redd.it/aikn8tn0fur21.jpg", "dank");
INSERT INTO Memes (id, title, url, category) VALUES ("670d6e22-dded-4d3e-abf6-8edce8abb3dc", "Numquam porro quaerat labore sit adipisci neque tempora.", "https://i.redd.it/aikn8tn0fur21.jpg", "dank");
INSERT INTO Memes (id, title, url, category) VALUES ("15aa4a6c-df90-4e23-b63a-8c74ee6383fd", "Amet velit quaerat eius ipsum.", "https://i.redd.it/efks3i9rhtr21.jpg", "2meirl4meirl");
INSERT INTO Memes (id, title, url, category) VALUES ("27b250c5-d22f-4b86-98d8-b20ebad34138", "Consectetur ut quaerat eius amet voluptatem eius dolorem.", "https://preview.redd.it/tkbusgmmotr21.jpg?width=960&crop=smart&auto=webp&s=131994de6ebdf657687451229853be42b143da2b", "dank");
INSERT INTO Memes (id, title, url, category) VALUES ("7c4756b4-e8e6-4751-ac11-8eb6480f9c68", "Eius porro magnam sed aliquam quisquam.", "https://i.redd.it/5bcqhjdm1tr21.jpg", "dank");
INSERT INTO Memes (id, title, url, category) VALUES ("4386adda-eca1-4268-af6a-47c6fc2d4a7d", "Labore ipsum modi dolor voluptatem.", "https://i.redd.it/f26bi9089ur21.jpg", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("c30e565d-3c01-4854-bd39-ef486c58f7f6", "Est sed ipsum amet.", "https://i.redd.it/3c6sylyabur21.png", "2009");
INSERT INTO Memes (id, title, url, category) VALUES ("be31055a-19bf-4b69-98a2-03871a529b7c", "Dolore quiquia labore ipsum sed sed velit sit.", "https://i.redd.it/f26bi9089ur21.jpg", "dank");
INSERT INTO Memes (id, title, url, category) VALUES ("b5987c7b-f1eb-43a0-a343-af7567f0ba3d", "Voluptatem modi velit neque numquam porro.", "https://i.redd.it/7fmda1cpwf421.jpg", "holdmybeer");
INSERT INTO Memes (id, title, url, category) VALUES ("9956e984-1a08-45dc-8ba5-0e714c8e0a4c", "Neque quaerat velit sit dolorem.", "https://preview.redd.it/l2wvnktafmi11.jpg?width=960&crop=smart&auto=webp&s=74683b3a070d75d7a12fb5ec63f4717093e7018d", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("d38920e2-8185-4efc-833d-cf9faea63f94", "Consectetur sed amet est.", "https://i.redd.it/efks3i9rhtr21.jpg", "dank");
INSERT INTO Memes (id, title, url, category) VALUES ("38d24caf-84bf-4319-965a-47649c595f94", "Consectetur neque consectetur est quisquam neque velit.", "https://i.redd.it/7fmda1cpwf421.jpg", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("e75ba89e-68ff-444e-9ce7-bd11d7d726a9", "Sit velit modi est dolore quiquia non quiquia.", "https://preview.redd.it/2ya4b0sjbtr21.jpg?width=960&crop=smart&auto=webp&s=fb8d1aa13ccdb73d6b4aa422d9f19b18cc8da05e", "dank");
INSERT INTO Memes (id, title, url, category) VALUES ("ef6e9d53-25ad-4ca5-bc53-1b526bfca0aa", "Modi est velit tempora dolor.", "https://i.redd.it/00pwop4bjsy11.jpg", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("90c2eb73-476b-43f6-990d-29eb0d4c1ca1", "Consectetur magnam numquam dolore.", "https://i.redd.it/aikn8tn0fur21.jpg", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("729b4dce-75ca-483d-b532-ce3f5a550917", "Voluptatem quaerat neque quisquam quiquia consectetur tempora tempora.", "https://i.redd.it/5bcqhjdm1tr21.jpg", "2009");
INSERT INTO Memes (id, title, url, category) VALUES ("929f8d33-9c84-4237-b6f0-70725739d35a", "Magnam quaerat eius dolore adipisci.", "https://i.redd.it/5bcqhjdm1tr21.jpg", "classic");
INSERT INTO Memes (id, title, url, category) VALUES ("c39eac0d-3938-4a42-95d0-aaeab42cd64b", "Magnam magnam neque aliquam amet ut.", "https://i.redd.it/5bcqhjdm1tr21.jpg", "dank");
INSERT INTO Memes (id, title, url, category) VALUES ("c9f2b97d-030c-4928-87d2-1360c4c55bbf", "Quaerat sit velit etincidunt.", "https://i.redd.it/aikn8tn0fur21.jpg", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("fe11cd78-1cd3-43ee-addc-39bbab405c79", "Tempora quaerat quaerat magnam neque ipsum non dolor.", "https://preview.redd.it/2ya4b0sjbtr21.jpg?width=960&crop=smart&auto=webp&s=fb8d1aa13ccdb73d6b4aa422d9f19b18cc8da05e", "holdmybeer");
INSERT INTO Memes (id, title, url, category) VALUES ("025b66e2-ef02-4965-bab2-d4cf631d00ff", "Quaerat adipisci dolorem voluptatem modi.", "https://i.redd.it/f26bi9089ur21.jpg", "dank");
INSERT INTO Memes (id, title, url, category) VALUES ("455e6fca-3ebc-4db7-913a-a7eefff657d9", "Modi tempora neque aliquam tempora quaerat porro magnam.", "https://preview.redd.it/bq2j0dw68tr21.png?width=960&crop=smart&auto=webp&s=b490cefdf787c73e562e699adfd961541045e857", "2009");
INSERT INTO Memes (id, title, url, category) VALUES ("069d3225-0f22-4ff6-9825-2f20c3492e81", "Dolorem aliquam sit sit adipisci modi ut.", "https://i.redd.it/3c6sylyabur21.png", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("7109f5f6-5fc3-4aa1-a3cc-0f098a8f6f7e", "Eius velit dolore eius.", "https://i.redd.it/aikn8tn0fur21.jpg", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("741b0e46-350e-4d46-aec7-571dad3953b5", "Quaerat eius voluptatem dolor magnam.", "https://i.redd.it/aikn8tn0fur21.jpg", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("85d115de-c5b7-4ef2-9147-311c8bb3a34b", "Sit ut quaerat sit modi magnam numquam ipsum.", "https://i.redd.it/7fmda1cpwf421.jpg", "2meirl4meirl");
INSERT INTO Memes (id, title, url, category) VALUES ("832c0bf5-f02c-40de-baf5-0a7ef1a24339", "Velit aliquam labore quaerat numquam sed sed.", "https://preview.redd.it/tkbusgmmotr21.jpg?width=960&crop=smart&auto=webp&s=131994de6ebdf657687451229853be42b143da2b", "2009");
INSERT INTO Memes (id, title, url, category) VALUES ("0199487c-2c49-4202-a69f-a084a2308a78", "Dolor quiquia aliquam consectetur tempora.", "https://i.redd.it/5bcqhjdm1tr21.jpg", "2009");
INSERT INTO Memes (id, title, url, category) VALUES ("01ccca1c-4714-4731-bd9b-f1d229af7884", "Non amet eius modi.", "https://preview.redd.it/tkbusgmmotr21.jpg?width=960&crop=smart&auto=webp&s=131994de6ebdf657687451229853be42b143da2b", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("a3072a70-ad6a-4085-97b6-ead00307de98", "Dolorem quaerat porro quisquam etincidunt labore dolore dolor.", "https://i.redd.it/7fmda1cpwf421.jpg", "2009");
INSERT INTO Memes (id, title, url, category) VALUES ("effc5076-42ff-4ac1-9e4d-caef33d27afd", "Tempora sed ipsum aliquam neque.", "https://preview.redd.it/m82pxbpaaur21.jpg?width=640&crop=smart&auto=webp&s=14de48af47c9e10080256a0805e764a8fbca7745", "2009");
INSERT INTO Memes (id, title, url, category) VALUES ("3321652e-ac0c-4cca-8307-2ba850013ead", "Labore quisquam quisquam est quaerat porro.", "https://preview.redd.it/tkbusgmmotr21.jpg?width=960&crop=smart&auto=webp&s=131994de6ebdf657687451229853be42b143da2b", "classic");
INSERT INTO Memes (id, title, url, category) VALUES ("e7c7a786-a9fb-4801-972e-1511d66b2a49", "Quaerat amet dolor sit velit amet dolor.", "https://i.redd.it/aikn8tn0fur21.jpg", "classic");
INSERT INTO Memes (id, title, url, category) VALUES ("f21d4a55-ac8b-4d03-9051-4b780c3492ba", "Amet numquam ut ut non aliquam ipsum sed.", "https://i.redd.it/5bcqhjdm1tr21.jpg", "dank");
INSERT INTO Memes (id, title, url, category) VALUES ("b7da8f00-ad07-4a5f-8459-72ca55574bc0", "Eius dolor voluptatem porro quisquam.", "https://i.redd.it/3c6sylyabur21.png", "dank");
INSERT INTO Memes (id, title, url, category) VALUES ("b752aee2-bb24-4f92-a227-c9deb2e3b8c1", "Numquam consectetur numquam non non eius labore sed.", "https://preview.redd.it/2ya4b0sjbtr21.jpg?width=960&crop=smart&auto=webp&s=fb8d1aa13ccdb73d6b4aa422d9f19b18cc8da05e", "2meirl4meirl");
INSERT INTO Memes (id, title, url, category) VALUES ("d6ce97a6-110e-4199-81ec-f53c4aef9c65", "Dolorem modi porro voluptatem aliquam sit.", "https://i.redd.it/5bcqhjdm1tr21.jpg", "2meirl4meirl");
INSERT INTO Memes (id, title, url, category) VALUES ("b8d879fc-db51-4296-86b9-344811057c34", "Non sed consectetur non est neque numquam tempora.", "https://i.redd.it/3c6sylyabur21.png", "2meirl4meirl");
INSERT INTO Memes (id, title, url, category) VALUES ("e6c4064f-39bb-4c7c-9f0b-76f5b90f4fbe", "Non modi sed numquam ut est sit aliquam.", "https://preview.redd.it/tkbusgmmotr21.jpg?width=960&crop=smart&auto=webp&s=131994de6ebdf657687451229853be42b143da2b", "dank");
INSERT INTO Memes (id, title, url, category) VALUES ("a31ada11-0fc2-4651-bef2-874be2b71bf7", "Sed magnam magnam amet aliquam ut modi labore.", "https://i.redd.it/00pwop4bjsy11.jpg", "classic");
INSERT INTO Memes (id, title, url, category) VALUES ("138bc407-81de-4ef9-b686-a29520273efb", "Amet labore velit magnam velit non.", "https://i.redd.it/aikn8tn0fur21.jpg", "holdmybeer");
INSERT INTO Memes (id, title, url, category) VALUES ("fdf31c43-89b3-4274-a2ca-09f12d85f4e7", "Modi non labore porro neque.", "https://i.redd.it/7fmda1cpwf421.jpg", "2009");
INSERT INTO Memes (id, title, url, category) VALUES ("7daa29e0-0c67-4e1e-b370-e498b2f8dbcf", "Magnam amet est velit labore quaerat dolor.", "https://preview.redd.it/bq2j0dw68tr21.png?width=960&crop=smart&auto=webp&s=b490cefdf787c73e562e699adfd961541045e857", "classic");
INSERT INTO Memes (id, title, url, category) VALUES ("f910432c-6bbc-4a7b-a2d9-f469c0a2801e", "Porro magnam dolorem ipsum neque dolor.", "https://i.redd.it/00pwop4bjsy11.jpg", "holdmybeer");
INSERT INTO Memes (id, title, url, category) VALUES ("4773faef-f21f-4ca4-ac5e-963f4651db97", "Amet tempora adipisci aliquam porro.", "https://i.redd.it/efks3i9rhtr21.jpg", "dank");
INSERT INTO Memes (id, title, url, category) VALUES ("dd94c7d8-86d8-4305-81f1-c818d21e2db7", "Etincidunt sed ipsum quiquia quiquia.", "https://preview.redd.it/l2wvnktafmi11.jpg?width=960&crop=smart&auto=webp&s=74683b3a070d75d7a12fb5ec63f4717093e7018d", "classic");
INSERT INTO Memes (id, title, url, category) VALUES ("4bbb19c6-9c08-4905-98da-7d537b3120ab", "Velit modi est sed.", "https://i.redd.it/3c6sylyabur21.png", "classic");
INSERT INTO Memes (id, title, url, category) VALUES ("7f63d060-71a3-499b-8e8c-f8c3478c64b3", "Quaerat velit voluptatem labore est est tempora.", "https://i.redd.it/5bcqhjdm1tr21.jpg", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("5525f398-f339-476d-b9b1-0ef634dc1f5f", "Eius dolore labore amet sit quisquam.", "https://preview.redd.it/2ya4b0sjbtr21.jpg?width=960&crop=smart&auto=webp&s=fb8d1aa13ccdb73d6b4aa422d9f19b18cc8da05e", "2meirl4meirl");
INSERT INTO Memes (id, title, url, category) VALUES ("e67dc528-ffb6-499e-950e-c3185183590a", "Neque dolor adipisci eius.", "https://i.redd.it/7fmda1cpwf421.jpg", "2009");
INSERT INTO Memes (id, title, url, category) VALUES ("5e84a969-2c37-47ad-8686-397a75e54a46", "Tempora eius quaerat modi ipsum.", "https://i.redd.it/7fmda1cpwf421.jpg", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("a09a4df4-6c83-4609-bc72-16a90cf932a3", "Etincidunt dolor magnam ipsum sit amet est.", "https://i.redd.it/00pwop4bjsy11.jpg", "2009");
INSERT INTO Memes (id, title, url, category) VALUES ("0955dcbd-14af-409b-afbb-c3e60e0a7678", "Adipisci neque aliquam non eius.", "https://preview.redd.it/bq2j0dw68tr21.png?width=960&crop=smart&auto=webp&s=b490cefdf787c73e562e699adfd961541045e857", "2009");
INSERT INTO Memes (id, title, url, category) VALUES ("2219db45-efa1-41ef-a0d3-f3b050ecb5b3", "Consectetur numquam adipisci eius quaerat velit etincidunt dolore.", "https://i.redd.it/7fmda1cpwf421.jpg", "dank");
INSERT INTO Memes (id, title, url, category) VALUES ("2b60d9d9-2826-472f-a479-c27edd954231", "Est eius porro sit quaerat adipisci.", "https://i.redd.it/5bcqhjdm1tr21.jpg", "2meirl4meirl");
INSERT INTO Memes (id, title, url, category) VALUES ("d72ac365-7046-4c94-960a-5985c388f1b3", "Labore eius tempora aliquam non etincidunt ut.", "https://i.redd.it/f26bi9089ur21.jpg", "holdmybeer");
INSERT INTO Memes (id, title, url, category) VALUES ("8a15ea36-7c2d-42ac-945a-b4a5c05439a8", "Eius etincidunt ut velit est.", "https://i.redd.it/5bcqhjdm1tr21.jpg", "dank");
INSERT INTO Memes (id, title, url, category) VALUES ("6185ac35-209d-46b2-9221-0e584a914c97", "Magnam quiquia labore non quisquam.", "https://preview.redd.it/m82pxbpaaur21.jpg?width=640&crop=smart&auto=webp&s=14de48af47c9e10080256a0805e764a8fbca7745", "holdmybeer");
INSERT INTO Memes (id, title, url, category) VALUES ("be6a4b1a-c429-4c30-bfed-842fa868f123", "Adipisci aliquam voluptatem neque ipsum numquam.", "https://i.redd.it/efks3i9rhtr21.jpg", "classic");
INSERT INTO Memes (id, title, url, category) VALUES ("9387c58c-1184-4e25-a1b8-b9cfd14f2b3c", "Consectetur non quaerat velit ut ut.", "https://i.redd.it/7fmda1cpwf421.jpg", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("d935b5a1-a481-475e-91b7-4c81407ac184", "Dolorem ipsum labore adipisci tempora.", "https://i.redd.it/7fmda1cpwf421.jpg", "classic");
INSERT INTO Memes (id, title, url, category) VALUES ("a1e7c8bb-2431-4adf-8fc3-a452b5bbb173", "Dolorem sed modi voluptatem tempora eius.", "https://i.redd.it/00pwop4bjsy11.jpg", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("d7bd64ac-25d8-49dd-9842-2dbe1a6d7619", "Ut voluptatem consectetur aliquam quisquam neque porro.", "https://i.redd.it/3c6sylyabur21.png", "2009");
INSERT INTO Memes (id, title, url, category) VALUES ("21711025-f16a-492d-b3b5-b8d1c36047d6", "Ipsum consectetur numquam ipsum magnam aliquam neque.", "https://i.redd.it/7fmda1cpwf421.jpg", "2meirl4meirl");
INSERT INTO Memes (id, title, url, category) VALUES ("98dc5415-7129-43e0-9d27-70724bd5fd8e", "Ipsum velit eius aliquam.", "https://i.redd.it/3c6sylyabur21.png", "classic");
INSERT INTO Memes (id, title, url, category) VALUES ("89017ccb-d907-4dc0-a502-068444d5d3fa", "Quaerat aliquam est est tempora aliquam consectetur.", "https://i.redd.it/f26bi9089ur21.jpg", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("f45791cb-c43e-425b-9b74-1934de3cd96a", "Neque adipisci modi quisquam est adipisci.", "https://i.redd.it/f26bi9089ur21.jpg", "classic");
INSERT INTO Memes (id, title, url, category) VALUES ("12319d13-f295-4571-aa58-2c57ac24ca68", "Etincidunt sed quaerat eius.", "https://i.redd.it/aikn8tn0fur21.jpg", "dank");
INSERT INTO Memes (id, title, url, category) VALUES ("ef6b9ec7-c267-4550-8158-c8dc0c60b99a", "Numquam ipsum est dolorem modi.", "https://i.redd.it/efks3i9rhtr21.jpg", "2009");
INSERT INTO Memes (id, title, url, category) VALUES ("aef9758e-72a4-40c3-8906-46c505ee7641", "Etincidunt labore quisquam dolor est numquam modi.", "https://i.redd.it/3c6sylyabur21.png", "2meirl4meirl");
INSERT INTO Memes (id, title, url, category) VALUES ("d223a84b-ac04-4925-a97e-ccd3b6b54f2e", "Voluptatem ut voluptatem porro modi sit magnam.", "https://preview.redd.it/tkbusgmmotr21.jpg?width=960&crop=smart&auto=webp&s=131994de6ebdf657687451229853be42b143da2b", "classic");
INSERT INTO Memes (id, title, url, category) VALUES ("3607e9bc-c9a4-4502-850c-41f9c4b1db78", "Ipsum eius voluptatem consectetur dolor magnam labore.", "https://preview.redd.it/hnikeip39ur21.jpg?width=640&crop=smart&auto=webp&s=72794533a67b87ffeb0fdb525281184da5320a75", "classic");
INSERT INTO Memes (id, title, url, category) VALUES ("28d623fa-256f-46d0-9865-397fb2fecf26", "Eius quiquia dolore magnam est aliquam.", "https://preview.redd.it/tkbusgmmotr21.jpg?width=960&crop=smart&auto=webp&s=131994de6ebdf657687451229853be42b143da2b", "classic");
INSERT INTO Memes (id, title, url, category) VALUES ("3a4d8e8e-0934-4614-bff3-b7b83b874883", "Magnam magnam dolor dolor.", "https://i.redd.it/aikn8tn0fur21.jpg", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("be72061e-dd27-420c-ba8d-be3b00f0ef50", "Porro est labore adipisci.", "https://preview.redd.it/2ya4b0sjbtr21.jpg?width=960&crop=smart&auto=webp&s=fb8d1aa13ccdb73d6b4aa422d9f19b18cc8da05e", "holdmybeer");
INSERT INTO Memes (id, title, url, category) VALUES ("f8d265db-d705-424f-aad3-40b454926523", "Sit modi etincidunt porro tempora est voluptatem consectetur.", "https://preview.redd.it/hnikeip39ur21.jpg?width=640&crop=smart&auto=webp&s=72794533a67b87ffeb0fdb525281184da5320a75", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("32ab3da7-74d9-4c78-a47a-c0e647cab238", "Adipisci numquam sit dolore neque.", "https://preview.redd.it/hnikeip39ur21.jpg?width=640&crop=smart&auto=webp&s=72794533a67b87ffeb0fdb525281184da5320a75", "classic");
INSERT INTO Memes (id, title, url, category) VALUES ("6bec2e6d-923d-4949-8fb9-40c5a6fae4e4", "Sit voluptatem modi ut neque.", "https://preview.redd.it/m82pxbpaaur21.jpg?width=640&crop=smart&auto=webp&s=14de48af47c9e10080256a0805e764a8fbca7745", "2meirl4meirl");
INSERT INTO Memes (id, title, url, category) VALUES ("575c2d32-9d69-4475-8b32-d3a39fe902cc", "Quiquia ipsum velit ipsum magnam velit sit ut.", "https://preview.redd.it/m82pxbpaaur21.jpg?width=640&crop=smart&auto=webp&s=14de48af47c9e10080256a0805e764a8fbca7745", "2009");
INSERT INTO Memes (id, title, url, category) VALUES ("cc0da109-cdd9-4e13-b59d-dae018ef52af", "Modi dolorem dolore quaerat sed.", "https://i.redd.it/5bcqhjdm1tr21.jpg", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("b7c36656-3d34-465b-8a92-5fb3b70f4bac", "Quiquia eius adipisci sed numquam velit modi.", "https://i.redd.it/5bcqhjdm1tr21.jpg", "catz");
INSERT INTO Memes (id, title, url, category) VALUES ("a000c556-1977-441e-97eb-8bbe3b5cb971", "Amet tempora magnam voluptatem.", "https://i.redd.it/aikn8tn0fur21.jpg", "holdmybeer");
INSERT INTO Memes (id, title, url, category) VALUES ("f7a20c7a-dd08-4859-811b-33254b880484", "Labore ut quisquam numquam ut sit.", "https://i.redd.it/7fmda1cpwf421.jpg", "2meirl4meirl");
INSERT INTO Memes (id, title, url, category) VALUES ("aea7c415-2ada-4427-804d-dda892f8fb35", "Est amet quisquam ut non numquam adipisci porro.", "https://i.redd.it/00pwop4bjsy11.jpg", "2meirl4meirl");
INSERT INTO Memes (id, title, url, category) VALUES ("57172965-26a7-400b-bfd5-7f9d27a13da5", "Magnam dolor est adipisci magnam sit ipsum.", "https://preview.redd.it/hnikeip39ur21.jpg?width=640&crop=smart&auto=webp&s=72794533a67b87ffeb0fdb525281184da5320a75", "classic");
INSERT INTO Memes (id, title, url, category) VALUES ("ee3eb93f-a0a7-4c31-9e0e-38782dda4f69", "Quisquam dolore adipisci porro tempora etincidunt velit.", "https://i.redd.it/efks3i9rhtr21.jpg", "2meirl4meirl");
INSERT INTO Memes (id, title, url, category) VALUES ("a890498d-92a2-40a3-aac9-3e356d1827a1", "Quiquia neque numquam magnam sed sit dolor.", "https://i.redd.it/00pwop4bjsy11.jpg", "2009");
INSERT INTO Memes (id, title, url, category) VALUES ("c7dafa03-6aba-4ed9-afc4-3d6084ed33cf", "Magnam eius sit sit ipsum modi porro est.", "https://i.redd.it/efks3i9rhtr21.jpg", "holdmybeer");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("a5b26346-a5a1-4570-95db-d038f1cdc03b", "Dolor", "Quiquia", "472", "149");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("955b335e-f4e0-4d23-84fb-afa35efdf26b", "Modi", "Sed", "956", "708");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("2aca6c5f-bf0a-4ef1-81c5-4c9dea28a541", "Magnam", "Porro", "427", "6");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("795d5e32-c1c2-475f-bb56-2210ee3285a1", "Dolor", "Labore", "127", "32");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("e131fd57-1b6e-45e1-a055-29e64d7f480a", "Labore", "Sit", "495", "90");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("05700b90-90a8-4b54-bdbe-a9ddfa354a5d", "Etincidunt", "Dolorem", "333", "557");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("a0a2a26b-80a2-4af0-b0d0-318d0f37ad3f", "Ipsum", "Dolor", "695", "661");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("6360364d-e454-42e5-8a68-8b6fce893604", "Amet", "Ipsum", "818", "609");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("e8b28e90-3658-42ff-b181-28e188d0ea89", "Eius", "Quiquia", "954", "921");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("058c9b2e-9085-47dc-be74-36c2de9cfb6c", "Quiquia", "Etincidunt", "18", "21");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("d138fb78-6839-47ae-9f0d-47d01e71b1ab", "Dolore", "Adipisci", "863", "927");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("606e5ff3-055e-4736-b3e7-3971234bb8de", "Quisquam", "Aliquam", "794", "137");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("314faca8-cda9-4335-89cd-95cd3c770b17", "Velit", "Ipsum", "894", "127");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("e5035a27-5831-4cef-aff6-86c1a7bf8825", "Aliquam", "Labore", "77", "470");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("9d0b966d-0dec-45e4-ae64-7319d4f73b80", "Porro", "Numquam", "241", "808");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("c1db7398-c2f8-45fa-9f84-831a5dc12724", "Consectetur", "Non", "962", "491");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("72d0d686-b371-4674-a8d7-203027e8d176", "Etincidunt", "Non", "452", "911");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("244d3c4e-e780-4c76-b1ea-d108ec4639f7", "Etincidunt", "Labore", "459", "487");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("ac756b0b-f257-4cc6-80fa-b89b2da5587e", "Aliquam", "Amet", "678", "621");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("43c5152e-d2bc-4ce2-9f10-818f36ef138f", "Voluptatem", "Porro", "919", "843");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("e6c68659-2d37-48c8-a8d4-e501db398bc7", "Sit", "Neque", "756", "339");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("f9fab523-c67d-4752-8fb8-be1f0a5e254f", "Ut", "Ut", "999", "718");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("d677511f-54b0-4071-9436-38c9e8bca2aa", "Modi", "Adipisci", "503", "403");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("c750054e-f128-4766-b293-bae3d681dee1", "Eius", "Non", "1", "170");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("1199f03a-57c1-4b15-b98c-9ca5ae89694d", "Tempora", "Velit", "54", "898");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("e0814f9e-7ae2-4f9c-8728-f530ea6da7a1", "Dolor", "Adipisci", "602", "352");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("1197021e-c6b9-4e5b-b95e-682b8f37ebea", "Tempora", "Ut", "773", "353");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("1b915cf6-a6e7-4210-a23b-41790450b32f", "Quiquia", "Amet", "971", "560");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("5c281687-851d-4a33-9083-9e590d916c74", "Modi", "Velit", "639", "249");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("bc7f6635-9a0d-4347-9ef1-26e948e80365", "Quaerat", "Numquam", "14", "745");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("ead07ca8-d7c8-41ba-a65f-b814e92960a0", "Neque", "Est", "477", "184");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("5f6192f5-0e5c-4172-b933-a77ff18a4d16", "Sed", "Non", "557", "67");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("7a65b48a-80b1-45d1-bb81-52cf65e44396", "Quaerat", "Etincidunt", "714", "911");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("13ce5e70-e7fb-4ada-869d-feb55b143737", "Adipisci", "Porro", "908", "121");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("816f81ea-5684-4c6b-8ae2-ae2d6ef3d72f", "Tempora", "Ut", "124", "27");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("34837bc1-464c-410d-8dea-82668f3bd8c1", "Dolor", "Sed", "286", "576");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("ee55eb63-98df-49fb-b464-440603a56c3f", "Numquam", "Dolorem", "372", "366");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("a2a510b5-3aaf-4dab-864e-7248b7477826", "Dolor", "Eius", "509", "338");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("54bf967f-f476-4934-93b2-b04ba641afda", "Sed", "Labore", "437", "397");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("3c940944-35b2-4afb-955e-3f3156a36b6e", "Ipsum", "Aliquam", "707", "56");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("270935e7-177d-47e6-ab5e-9badcd11138b", "Sit", "Quaerat", "677", "472");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("a58f19e0-3255-4292-b7e0-8da1292ab861", "Dolor", "Eius", "320", "112");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("32523a02-1f54-4d02-a041-1979ef57bb6c", "Dolore", "Porro", "578", "913");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("75200099-1e3f-47ea-a31d-d4d5da85cd61", "Tempora", "Non", "762", "232");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("533cfdf4-1270-4e08-87de-193dcc00d7b3", "Labore", "Dolorem", "976", "369");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("0c3113b9-5db0-4ddd-86bf-1501f4fb0391", "Numquam", "Velit", "239", "988");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("5ea8b618-6704-4d84-9cb4-f4a6438627ac", "Dolor", "Consectetur", "516", "903");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("b9d2a33a-613e-433d-afd4-ce6329ccafa0", "Numquam", "Adipisci", "466", "223");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("a9457ca5-cbc4-4116-9634-a1dc25ebe026", "Ipsum", "Numquam", "188", "553");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("f69b3aaa-e105-4fb2-b253-8cc977bd15a8", "Aliquam", "Magnam", "467", "921");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("f902ccc8-5738-4dbf-81fc-7da213b153ef", "Aliquam", "Non", "978", "78");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("cd20ea0e-bc69-4f8c-9483-69cec2883cb1", "Dolor", "Neque", "620", "366");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("1eaad232-6065-4c18-a4ea-5fd5ec82a8d4", "Ut", "Dolorem", "735", "186");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("14f2cf35-3fd7-40dd-aa38-5204730258ae", "Numquam", "Porro", "836", "480");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("07fbea7f-6116-4992-800b-fa25c09533f3", "Voluptatem", "Sed", "998", "620");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("fb7eeed2-6274-404d-a3d1-dcded5d7aaa5", "Adipisci", "Dolor", "183", "632");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("1efe6717-b2c4-4ac2-94ea-2f5c0a794fa4", "Quaerat", "Adipisci", "715", "209");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("15f8a4bf-de0f-421c-b446-7226e924f3b5", "Quisquam", "Quisquam", "884", "311");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("40fa085b-bb2b-447f-b2de-5b7b18d2c721", "Etincidunt", "Ipsum", "389", "720");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("b37ef1c5-36f7-4a04-a706-4852d9e29ff5", "Aliquam", "Porro", "343", "356");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("ecfaab46-f5de-4fef-a82f-158278f94b56", "Consectetur", "Quaerat", "719", "800");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("63c83e3c-8c6e-424d-a831-34270cabab3b", "Eius", "Sed", "113", "264");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("8ee983e4-c1b2-4238-ba5d-0885cfbf81d0", "Etincidunt", "Modi", "505", "855");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("8e02276c-48d6-4bed-a702-cffecb4187f6", "Ut", "Quiquia", "553", "874");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("3dd38bce-4ba4-4d1a-9e59-a8b507c8bc49", "Voluptatem", "Adipisci", "727", "686");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("2d4f5799-5432-4cfa-9473-141c2cd0a01b", "Sit", "Amet", "990", "994");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("3b9d6cc7-e64c-4649-8893-96c234005558", "Modi", "Dolorem", "600", "467");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("31328fa4-64a4-4a08-a256-9fd7870f61cf", "Aliquam", "Ipsum", "680", "800");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("0db8a938-a058-4bde-830d-8fa73785b32b", "Quaerat", "Labore", "159", "964");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("eb827a72-427d-42a3-97f3-e606f66982d7", "Amet", "Voluptatem", "355", "362");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("d088a774-522b-469a-9ca4-d51faae48948", "Tempora", "Eius", "20", "345");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("6525e15c-9536-4d87-8ffd-0549931b73e8", "Neque", "Dolore", "459", "351");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("72a66861-0732-43aa-8b0f-587d74e54441", "Dolorem", "Magnam", "710", "546");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("8d68c8f6-4fb8-42c0-a509-ba901515b4dd", "Non", "Amet", "572", "229");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("5f6da10d-d573-4321-a2cc-474b47b3bcf3", "Amet", "Ut", "182", "605");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("2bc4ff9d-5fa2-435b-8028-81e224938dd2", "Voluptatem", "Modi", "574", "48");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("93812d24-add1-451a-aea1-dd9b0aa23ffe", "Ipsum", "Adipisci", "19", "511");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("7f422a4c-a7ad-4d05-a98a-218d668b7510", "Quisquam", "Adipisci", "268", "90");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("39c8b1b7-c5e9-4bb9-9405-7c9aca045c72", "Dolor", "Neque", "985", "275");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("86187994-020b-47a7-a055-0ffa48a08eaa", "Etincidunt", "Dolorem", "138", "73");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("17b1e88b-6c42-462c-8a78-e69be166a70a", "Consectetur", "Tempora", "325", "542");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("d280bd1d-a3a1-4afb-8885-5b74c3137c19", "Quisquam", "Ipsum", "508", "275");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("a9acd7b4-5a31-4f18-95ca-a8e844d2c1a5", "Non", "Dolor", "48", "286");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("219e9bd6-563d-437e-bb50-0e89f725a0a1", "Neque", "Velit", "3", "552");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("27bafcc6-8040-4992-a66b-e4edf039a1f6", "Consectetur", "Numquam", "463", "453");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("20cef249-6c91-4624-9e46-628f0b72e697", "Ipsum", "Tempora", "329", "368");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("75ea83fb-9c53-43cb-b744-2d9ceb642624", "Consectetur", "Quisquam", "727", "487");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("89315b4f-ee33-4ba3-9487-ce95c5ca3b27", "Est", "Est", "955", "677");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("2234942a-8460-4895-81e8-4fe540e7efe5", "Est", "Dolore", "740", "436");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("126c9276-93b1-48f9-ac38-ed0aa82fc01c", "Quisquam", "Numquam", "572", "591");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("9903745d-6e53-42e1-a332-39e241ba7311", "Porro", "Modi", "66", "162");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("f2cc3018-0344-48db-a337-7cc461e82a5b", "Non", "Adipisci", "185", "341");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("e70526df-3d92-48a1-afdb-09ffbcb68808", "Non", "Dolorem", "407", "442");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("c38a6fee-35c7-4302-bdb4-b12747a26597", "Velit", "Ipsum", "772", "245");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("c6c8639c-6878-4999-80fc-c8b1427426f1", "Numquam", "Tempora", "488", "353");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("be4c0486-5a5d-4aea-b376-2a7738a6309a", "Ut", "Est", "416", "232");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("b4bd37c8-30f3-41ff-ac2c-89636a1ebb27", "Porro", "Aliquam", "257", "269");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("8dee5976-61fd-4958-bf8c-10770c6e2218", "Aliquam", "Modi", "5", "794");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("46fa9344-aefb-44b6-bf60-6d24cb5546b7", "Consectetur", "Porro", "903", "883");
INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("90035a83-6507-4813-b243-44663a53e0f0", "Etincidunt", "Magnam", "72", "619");
INSERT INTO Follow (followee, follower) VALUES ("75200099-1e3f-47ea-a31d-d4d5da85cd61", "e131fd57-1b6e-45e1-a055-29e64d7f480a");
INSERT INTO Follow (followee, follower) VALUES ("1197021e-c6b9-4e5b-b95e-682b8f37ebea", "795d5e32-c1c2-475f-bb56-2210ee3285a1");
INSERT INTO Follow (followee, follower) VALUES ("f2cc3018-0344-48db-a337-7cc461e82a5b", "13ce5e70-e7fb-4ada-869d-feb55b143737");
INSERT INTO Follow (followee, follower) VALUES ("17b1e88b-6c42-462c-8a78-e69be166a70a", "f2cc3018-0344-48db-a337-7cc461e82a5b");
INSERT INTO Follow (followee, follower) VALUES ("b37ef1c5-36f7-4a04-a706-4852d9e29ff5", "a9acd7b4-5a31-4f18-95ca-a8e844d2c1a5");
INSERT INTO Follow (followee, follower) VALUES ("ee55eb63-98df-49fb-b464-440603a56c3f", "17b1e88b-6c42-462c-8a78-e69be166a70a");
INSERT INTO Follow (followee, follower) VALUES ("a58f19e0-3255-4292-b7e0-8da1292ab861", "0db8a938-a058-4bde-830d-8fa73785b32b");
INSERT INTO Follow (followee, follower) VALUES ("955b335e-f4e0-4d23-84fb-afa35efdf26b", "d280bd1d-a3a1-4afb-8885-5b74c3137c19");
INSERT INTO Follow (followee, follower) VALUES ("e5035a27-5831-4cef-aff6-86c1a7bf8825", "3b9d6cc7-e64c-4649-8893-96c234005558");
INSERT INTO Follow (followee, follower) VALUES ("5c281687-851d-4a33-9083-9e590d916c74", "a0a2a26b-80a2-4af0-b0d0-318d0f37ad3f");
INSERT INTO Follow (followee, follower) VALUES ("8dee5976-61fd-4958-bf8c-10770c6e2218", "d138fb78-6839-47ae-9f0d-47d01e71b1ab");
INSERT INTO Follow (followee, follower) VALUES ("63c83e3c-8c6e-424d-a831-34270cabab3b", "46fa9344-aefb-44b6-bf60-6d24cb5546b7");
INSERT INTO Follow (followee, follower) VALUES ("270935e7-177d-47e6-ab5e-9badcd11138b", "5f6da10d-d573-4321-a2cc-474b47b3bcf3");
INSERT INTO Follow (followee, follower) VALUES ("e5035a27-5831-4cef-aff6-86c1a7bf8825", "e131fd57-1b6e-45e1-a055-29e64d7f480a");
INSERT INTO Follow (followee, follower) VALUES ("2bc4ff9d-5fa2-435b-8028-81e224938dd2", "f2cc3018-0344-48db-a337-7cc461e82a5b");
INSERT INTO Follow (followee, follower) VALUES ("a58f19e0-3255-4292-b7e0-8da1292ab861", "6525e15c-9536-4d87-8ffd-0549931b73e8");
INSERT INTO Follow (followee, follower) VALUES ("ead07ca8-d7c8-41ba-a65f-b814e92960a0", "75ea83fb-9c53-43cb-b744-2d9ceb642624");
INSERT INTO Follow (followee, follower) VALUES ("2234942a-8460-4895-81e8-4fe540e7efe5", "058c9b2e-9085-47dc-be74-36c2de9cfb6c");
INSERT INTO Follow (followee, follower) VALUES ("8e02276c-48d6-4bed-a702-cffecb4187f6", "d088a774-522b-469a-9ca4-d51faae48948");
INSERT INTO Follow (followee, follower) VALUES ("816f81ea-5684-4c6b-8ae2-ae2d6ef3d72f", "8e02276c-48d6-4bed-a702-cffecb4187f6");
INSERT INTO Follow (followee, follower) VALUES ("b9d2a33a-613e-433d-afd4-ce6329ccafa0", "816f81ea-5684-4c6b-8ae2-ae2d6ef3d72f");
INSERT INTO Follow (followee, follower) VALUES ("2234942a-8460-4895-81e8-4fe540e7efe5", "46fa9344-aefb-44b6-bf60-6d24cb5546b7");
INSERT INTO Follow (followee, follower) VALUES ("b4bd37c8-30f3-41ff-ac2c-89636a1ebb27", "795d5e32-c1c2-475f-bb56-2210ee3285a1");
INSERT INTO Follow (followee, follower) VALUES ("6360364d-e454-42e5-8a68-8b6fce893604", "a0a2a26b-80a2-4af0-b0d0-318d0f37ad3f");
INSERT INTO Follow (followee, follower) VALUES ("0c3113b9-5db0-4ddd-86bf-1501f4fb0391", "cd20ea0e-bc69-4f8c-9483-69cec2883cb1");
INSERT INTO Follow (followee, follower) VALUES ("126c9276-93b1-48f9-ac38-ed0aa82fc01c", "795d5e32-c1c2-475f-bb56-2210ee3285a1");
INSERT INTO Follow (followee, follower) VALUES ("93812d24-add1-451a-aea1-dd9b0aa23ffe", "244d3c4e-e780-4c76-b1ea-d108ec4639f7");
INSERT INTO Follow (followee, follower) VALUES ("39c8b1b7-c5e9-4bb9-9405-7c9aca045c72", "40fa085b-bb2b-447f-b2de-5b7b18d2c721");
INSERT INTO Follow (followee, follower) VALUES ("d677511f-54b0-4071-9436-38c9e8bca2aa", "20cef249-6c91-4624-9e46-628f0b72e697");
INSERT INTO Follow (followee, follower) VALUES ("244d3c4e-e780-4c76-b1ea-d108ec4639f7", "219e9bd6-563d-437e-bb50-0e89f725a0a1");
INSERT INTO Follow (followee, follower) VALUES ("75200099-1e3f-47ea-a31d-d4d5da85cd61", "8dee5976-61fd-4958-bf8c-10770c6e2218");
INSERT INTO Follow (followee, follower) VALUES ("219e9bd6-563d-437e-bb50-0e89f725a0a1", "13ce5e70-e7fb-4ada-869d-feb55b143737");
INSERT INTO Follow (followee, follower) VALUES ("e8b28e90-3658-42ff-b181-28e188d0ea89", "39c8b1b7-c5e9-4bb9-9405-7c9aca045c72");
INSERT INTO Follow (followee, follower) VALUES ("8dee5976-61fd-4958-bf8c-10770c6e2218", "816f81ea-5684-4c6b-8ae2-ae2d6ef3d72f");
INSERT INTO Follow (followee, follower) VALUES ("ee55eb63-98df-49fb-b464-440603a56c3f", "1b915cf6-a6e7-4210-a23b-41790450b32f");
INSERT INTO Follow (followee, follower) VALUES ("c1db7398-c2f8-45fa-9f84-831a5dc12724", "270935e7-177d-47e6-ab5e-9badcd11138b");
INSERT INTO Follow (followee, follower) VALUES ("40fa085b-bb2b-447f-b2de-5b7b18d2c721", "90035a83-6507-4813-b243-44663a53e0f0");
INSERT INTO Follow (followee, follower) VALUES ("54bf967f-f476-4934-93b2-b04ba641afda", "20cef249-6c91-4624-9e46-628f0b72e697");
INSERT INTO Follow (followee, follower) VALUES ("46fa9344-aefb-44b6-bf60-6d24cb5546b7", "955b335e-f4e0-4d23-84fb-afa35efdf26b");
INSERT INTO Follow (followee, follower) VALUES ("0c3113b9-5db0-4ddd-86bf-1501f4fb0391", "72d0d686-b371-4674-a8d7-203027e8d176");
INSERT INTO Follow (followee, follower) VALUES ("219e9bd6-563d-437e-bb50-0e89f725a0a1", "54bf967f-f476-4934-93b2-b04ba641afda");
INSERT INTO Follow (followee, follower) VALUES ("244d3c4e-e780-4c76-b1ea-d108ec4639f7", "2d4f5799-5432-4cfa-9473-141c2cd0a01b");
INSERT INTO Follow (followee, follower) VALUES ("46fa9344-aefb-44b6-bf60-6d24cb5546b7", "72d0d686-b371-4674-a8d7-203027e8d176");
INSERT INTO Follow (followee, follower) VALUES ("75200099-1e3f-47ea-a31d-d4d5da85cd61", "39c8b1b7-c5e9-4bb9-9405-7c9aca045c72");
INSERT INTO Follow (followee, follower) VALUES ("533cfdf4-1270-4e08-87de-193dcc00d7b3", "2bc4ff9d-5fa2-435b-8028-81e224938dd2");
INSERT INTO Follow (followee, follower) VALUES ("a58f19e0-3255-4292-b7e0-8da1292ab861", "27bafcc6-8040-4992-a66b-e4edf039a1f6");
INSERT INTO Follow (followee, follower) VALUES ("3c940944-35b2-4afb-955e-3f3156a36b6e", "2bc4ff9d-5fa2-435b-8028-81e224938dd2");
INSERT INTO Follow (followee, follower) VALUES ("d088a774-522b-469a-9ca4-d51faae48948", "e6c68659-2d37-48c8-a8d4-e501db398bc7");
INSERT INTO Follow (followee, follower) VALUES ("3b9d6cc7-e64c-4649-8893-96c234005558", "219e9bd6-563d-437e-bb50-0e89f725a0a1");
INSERT INTO Follow (followee, follower) VALUES ("1199f03a-57c1-4b15-b98c-9ca5ae89694d", "7f422a4c-a7ad-4d05-a98a-218d668b7510");
INSERT INTO Follow (followee, follower) VALUES ("c6c8639c-6878-4999-80fc-c8b1427426f1", "606e5ff3-055e-4736-b3e7-3971234bb8de");
INSERT INTO Follow (followee, follower) VALUES ("d088a774-522b-469a-9ca4-d51faae48948", "0db8a938-a058-4bde-830d-8fa73785b32b");
INSERT INTO Follow (followee, follower) VALUES ("c38a6fee-35c7-4302-bdb4-b12747a26597", "72a66861-0732-43aa-8b0f-587d74e54441");
INSERT INTO Follow (followee, follower) VALUES ("e70526df-3d92-48a1-afdb-09ffbcb68808", "39c8b1b7-c5e9-4bb9-9405-7c9aca045c72");
INSERT INTO Follow (followee, follower) VALUES ("a5b26346-a5a1-4570-95db-d038f1cdc03b", "b4bd37c8-30f3-41ff-ac2c-89636a1ebb27");
INSERT INTO Follow (followee, follower) VALUES ("07fbea7f-6116-4992-800b-fa25c09533f3", "816f81ea-5684-4c6b-8ae2-ae2d6ef3d72f");
INSERT INTO Follow (followee, follower) VALUES ("ecfaab46-f5de-4fef-a82f-158278f94b56", "c750054e-f128-4766-b293-bae3d681dee1");
INSERT INTO Follow (followee, follower) VALUES ("9903745d-6e53-42e1-a332-39e241ba7311", "a0a2a26b-80a2-4af0-b0d0-318d0f37ad3f");
INSERT INTO Follow (followee, follower) VALUES ("3b9d6cc7-e64c-4649-8893-96c234005558", "15f8a4bf-de0f-421c-b446-7226e924f3b5");
INSERT INTO Follow (followee, follower) VALUES ("0db8a938-a058-4bde-830d-8fa73785b32b", "31328fa4-64a4-4a08-a256-9fd7870f61cf");
INSERT INTO Follow (followee, follower) VALUES ("20cef249-6c91-4624-9e46-628f0b72e697", "f9fab523-c67d-4752-8fb8-be1f0a5e254f");
INSERT INTO Follow (followee, follower) VALUES ("219e9bd6-563d-437e-bb50-0e89f725a0a1", "fb7eeed2-6274-404d-a3d1-dcded5d7aaa5");
INSERT INTO Follow (followee, follower) VALUES ("31328fa4-64a4-4a08-a256-9fd7870f61cf", "ecfaab46-f5de-4fef-a82f-158278f94b56");
INSERT INTO Follow (followee, follower) VALUES ("8d68c8f6-4fb8-42c0-a509-ba901515b4dd", "be4c0486-5a5d-4aea-b376-2a7738a6309a");
INSERT INTO Follow (followee, follower) VALUES ("63c83e3c-8c6e-424d-a831-34270cabab3b", "c1db7398-c2f8-45fa-9f84-831a5dc12724");
INSERT INTO Follow (followee, follower) VALUES ("90035a83-6507-4813-b243-44663a53e0f0", "75ea83fb-9c53-43cb-b744-2d9ceb642624");
INSERT INTO Follow (followee, follower) VALUES ("15f8a4bf-de0f-421c-b446-7226e924f3b5", "9d0b966d-0dec-45e4-ae64-7319d4f73b80");
INSERT INTO Follow (followee, follower) VALUES ("86187994-020b-47a7-a055-0ffa48a08eaa", "7a65b48a-80b1-45d1-bb81-52cf65e44396");
INSERT INTO Follow (followee, follower) VALUES ("9903745d-6e53-42e1-a332-39e241ba7311", "e70526df-3d92-48a1-afdb-09ffbcb68808");
INSERT INTO Follow (followee, follower) VALUES ("90035a83-6507-4813-b243-44663a53e0f0", "a0a2a26b-80a2-4af0-b0d0-318d0f37ad3f");
INSERT INTO Follow (followee, follower) VALUES ("e70526df-3d92-48a1-afdb-09ffbcb68808", "244d3c4e-e780-4c76-b1ea-d108ec4639f7");
INSERT INTO Follow (followee, follower) VALUES ("89315b4f-ee33-4ba3-9487-ce95c5ca3b27", "27bafcc6-8040-4992-a66b-e4edf039a1f6");
INSERT INTO Follow (followee, follower) VALUES ("8dee5976-61fd-4958-bf8c-10770c6e2218", "1eaad232-6065-4c18-a4ea-5fd5ec82a8d4");
INSERT INTO Follow (followee, follower) VALUES ("8ee983e4-c1b2-4238-ba5d-0885cfbf81d0", "ead07ca8-d7c8-41ba-a65f-b814e92960a0");
INSERT INTO Follow (followee, follower) VALUES ("15f8a4bf-de0f-421c-b446-7226e924f3b5", "bc7f6635-9a0d-4347-9ef1-26e948e80365");
INSERT INTO Follow (followee, follower) VALUES ("1b915cf6-a6e7-4210-a23b-41790450b32f", "c38a6fee-35c7-4302-bdb4-b12747a26597");
INSERT INTO Follow (followee, follower) VALUES ("7f422a4c-a7ad-4d05-a98a-218d668b7510", "eb827a72-427d-42a3-97f3-e606f66982d7");
INSERT INTO Follow (followee, follower) VALUES ("b4bd37c8-30f3-41ff-ac2c-89636a1ebb27", "86187994-020b-47a7-a055-0ffa48a08eaa");
INSERT INTO Follow (followee, follower) VALUES ("0c3113b9-5db0-4ddd-86bf-1501f4fb0391", "606e5ff3-055e-4736-b3e7-3971234bb8de");
INSERT INTO Follow (followee, follower) VALUES ("2234942a-8460-4895-81e8-4fe540e7efe5", "a5b26346-a5a1-4570-95db-d038f1cdc03b");
INSERT INTO Follow (followee, follower) VALUES ("63c83e3c-8c6e-424d-a831-34270cabab3b", "40fa085b-bb2b-447f-b2de-5b7b18d2c721");
INSERT INTO Follow (followee, follower) VALUES ("5f6192f5-0e5c-4172-b933-a77ff18a4d16", "1b915cf6-a6e7-4210-a23b-41790450b32f");
INSERT INTO Follow (followee, follower) VALUES ("27bafcc6-8040-4992-a66b-e4edf039a1f6", "126c9276-93b1-48f9-ac38-ed0aa82fc01c");
INSERT INTO Follow (followee, follower) VALUES ("8dee5976-61fd-4958-bf8c-10770c6e2218", "3c940944-35b2-4afb-955e-3f3156a36b6e");
INSERT INTO Follow (followee, follower) VALUES ("795d5e32-c1c2-475f-bb56-2210ee3285a1", "8d68c8f6-4fb8-42c0-a509-ba901515b4dd");
INSERT INTO Follow (followee, follower) VALUES ("d138fb78-6839-47ae-9f0d-47d01e71b1ab", "a58f19e0-3255-4292-b7e0-8da1292ab861");
INSERT INTO Follow (followee, follower) VALUES ("270935e7-177d-47e6-ab5e-9badcd11138b", "314faca8-cda9-4335-89cd-95cd3c770b17");
INSERT INTO Follow (followee, follower) VALUES ("6360364d-e454-42e5-8a68-8b6fce893604", "75ea83fb-9c53-43cb-b744-2d9ceb642624");
INSERT INTO Follow (followee, follower) VALUES ("816f81ea-5684-4c6b-8ae2-ae2d6ef3d72f", "46fa9344-aefb-44b6-bf60-6d24cb5546b7");
INSERT INTO Follow (followee, follower) VALUES ("43c5152e-d2bc-4ce2-9f10-818f36ef138f", "058c9b2e-9085-47dc-be74-36c2de9cfb6c");
INSERT INTO Follow (followee, follower) VALUES ("8d68c8f6-4fb8-42c0-a509-ba901515b4dd", "e70526df-3d92-48a1-afdb-09ffbcb68808");
INSERT INTO Follow (followee, follower) VALUES ("eb827a72-427d-42a3-97f3-e606f66982d7", "13ce5e70-e7fb-4ada-869d-feb55b143737");
INSERT INTO Follow (followee, follower) VALUES ("219e9bd6-563d-437e-bb50-0e89f725a0a1", "07fbea7f-6116-4992-800b-fa25c09533f3");
INSERT INTO Follow (followee, follower) VALUES ("86187994-020b-47a7-a055-0ffa48a08eaa", "46fa9344-aefb-44b6-bf60-6d24cb5546b7");
INSERT INTO Follow (followee, follower) VALUES ("d138fb78-6839-47ae-9f0d-47d01e71b1ab", "9d0b966d-0dec-45e4-ae64-7319d4f73b80");
INSERT INTO Follow (followee, follower) VALUES ("2bc4ff9d-5fa2-435b-8028-81e224938dd2", "a9457ca5-cbc4-4116-9634-a1dc25ebe026");
INSERT INTO Follow (followee, follower) VALUES ("0c3113b9-5db0-4ddd-86bf-1501f4fb0391", "3dd38bce-4ba4-4d1a-9e59-a8b507c8bc49");
INSERT INTO Follow (followee, follower) VALUES ("816f81ea-5684-4c6b-8ae2-ae2d6ef3d72f", "be4c0486-5a5d-4aea-b376-2a7738a6309a");
INSERT INTO Follow (followee, follower) VALUES ("f902ccc8-5738-4dbf-81fc-7da213b153ef", "46fa9344-aefb-44b6-bf60-6d24cb5546b7");
INSERT INTO Follow (followee, follower) VALUES ("314faca8-cda9-4335-89cd-95cd3c770b17", "d088a774-522b-469a-9ca4-d51faae48948");
INSERT INTO Seen (userId, memeId, date) VALUES ("955b335e-f4e0-4d23-84fb-afa35efdf26b", "575c2d32-9d69-4475-8b32-d3a39fe902cc", "2016-08-22");
INSERT INTO Seen (userId, memeId, date) VALUES ("34837bc1-464c-410d-8dea-82668f3bd8c1", "d7bd64ac-25d8-49dd-9842-2dbe1a6d7619", "2017-09-05");
INSERT INTO Seen (userId, memeId, date) VALUES ("f902ccc8-5738-4dbf-81fc-7da213b153ef", "12319d13-f295-4571-aa58-2c57ac24ca68", "2017-08-11");
INSERT INTO Seen (userId, memeId, date) VALUES ("8e02276c-48d6-4bed-a702-cffecb4187f6", "98dc5415-7129-43e0-9d27-70724bd5fd8e", "2018-03-16");
INSERT INTO Seen (userId, memeId, date) VALUES ("a0a2a26b-80a2-4af0-b0d0-318d0f37ad3f", "d7bd64ac-25d8-49dd-9842-2dbe1a6d7619", "2018-03-22");
INSERT INTO Seen (userId, memeId, date) VALUES ("b4bd37c8-30f3-41ff-ac2c-89636a1ebb27", "e6c4064f-39bb-4c7c-9f0b-76f5b90f4fbe", "2016-09-18");
INSERT INTO Seen (userId, memeId, date) VALUES ("f902ccc8-5738-4dbf-81fc-7da213b153ef", "aea7c415-2ada-4427-804d-dda892f8fb35", "2018-07-18");
INSERT INTO Seen (userId, memeId, date) VALUES ("cd20ea0e-bc69-4f8c-9483-69cec2883cb1", "e813f8f4-98bc-4072-9e1a-cb3515162ce5", "2016-09-10");
INSERT INTO Seen (userId, memeId, date) VALUES ("2234942a-8460-4895-81e8-4fe540e7efe5", "f910432c-6bbc-4a7b-a2d9-f469c0a2801e", "2017-09-18");
INSERT INTO Seen (userId, memeId, date) VALUES ("a5b26346-a5a1-4570-95db-d038f1cdc03b", "729b4dce-75ca-483d-b532-ce3f5a550917", "2018-01-11");
INSERT INTO Seen (userId, memeId, date) VALUES ("0db8a938-a058-4bde-830d-8fa73785b32b", "ee3eb93f-a0a7-4c31-9e0e-38782dda4f69", "2017-03-13");
INSERT INTO Seen (userId, memeId, date) VALUES ("7a65b48a-80b1-45d1-bb81-52cf65e44396", "455e6fca-3ebc-4db7-913a-a7eefff657d9", "2018-06-06");
INSERT INTO Seen (userId, memeId, date) VALUES ("606e5ff3-055e-4736-b3e7-3971234bb8de", "dd94c7d8-86d8-4305-81f1-c818d21e2db7", "2018-09-22");
INSERT INTO Seen (userId, memeId, date) VALUES ("b9d2a33a-613e-433d-afd4-ce6329ccafa0", "1387e323-756b-48a4-bee7-511fdea14915", "2019-03-21");
INSERT INTO Seen (userId, memeId, date) VALUES ("244d3c4e-e780-4c76-b1ea-d108ec4639f7", "e75ba89e-68ff-444e-9ce7-bd11d7d726a9", "2017-01-16");
INSERT INTO Seen (userId, memeId, date) VALUES ("14f2cf35-3fd7-40dd-aa38-5204730258ae", "13399ded-6671-41ee-9c6c-62a5edf835d1", "2018-10-19");
INSERT INTO Seen (userId, memeId, date) VALUES ("63c83e3c-8c6e-424d-a831-34270cabab3b", "929f8d33-9c84-4237-b6f0-70725739d35a", "2018-06-18");
INSERT INTO Seen (userId, memeId, date) VALUES ("90035a83-6507-4813-b243-44663a53e0f0", "4386adda-eca1-4268-af6a-47c6fc2d4a7d", "2018-03-16");
INSERT INTO Seen (userId, memeId, date) VALUES ("606e5ff3-055e-4736-b3e7-3971234bb8de", "f7a20c7a-dd08-4859-811b-33254b880484", "2018-05-11");
INSERT INTO Seen (userId, memeId, date) VALUES ("f2cc3018-0344-48db-a337-7cc461e82a5b", "f8d265db-d705-424f-aad3-40b454926523", "2016-11-02");
INSERT INTO Seen (userId, memeId, date) VALUES ("e5035a27-5831-4cef-aff6-86c1a7bf8825", "d935b5a1-a481-475e-91b7-4c81407ac184", "2017-08-02");
INSERT INTO Seen (userId, memeId, date) VALUES ("75200099-1e3f-47ea-a31d-d4d5da85cd61", "729b4dce-75ca-483d-b532-ce3f5a550917", "2017-04-14");
INSERT INTO Seen (userId, memeId, date) VALUES ("8d68c8f6-4fb8-42c0-a509-ba901515b4dd", "f8d265db-d705-424f-aad3-40b454926523", "2018-07-29");
INSERT INTO Seen (userId, memeId, date) VALUES ("90035a83-6507-4813-b243-44663a53e0f0", "13399ded-6671-41ee-9c6c-62a5edf835d1", "2017-10-16");
INSERT INTO Seen (userId, memeId, date) VALUES ("ee55eb63-98df-49fb-b464-440603a56c3f", "c30e565d-3c01-4854-bd39-ef486c58f7f6", "2018-11-28");
INSERT INTO Seen (userId, memeId, date) VALUES ("cd20ea0e-bc69-4f8c-9483-69cec2883cb1", "01ccca1c-4714-4731-bd9b-f1d229af7884", "2019-01-31");
INSERT INTO Seen (userId, memeId, date) VALUES ("8ee983e4-c1b2-4238-ba5d-0885cfbf81d0", "b7c36656-3d34-465b-8a92-5fb3b70f4bac", "2019-02-05");
INSERT INTO Seen (userId, memeId, date) VALUES ("955b335e-f4e0-4d23-84fb-afa35efdf26b", "670d6e22-dded-4d3e-abf6-8edce8abb3dc", "2016-12-26");
INSERT INTO Seen (userId, memeId, date) VALUES ("5c281687-851d-4a33-9083-9e590d916c74", "832c0bf5-f02c-40de-baf5-0a7ef1a24339", "2018-06-28");
INSERT INTO Seen (userId, memeId, date) VALUES ("46fa9344-aefb-44b6-bf60-6d24cb5546b7", "7daa29e0-0c67-4e1e-b370-e498b2f8dbcf", "2017-09-24");
INSERT INTO Seen (userId, memeId, date) VALUES ("ee55eb63-98df-49fb-b464-440603a56c3f", "98dc5415-7129-43e0-9d27-70724bd5fd8e", "2018-03-22");
INSERT INTO Seen (userId, memeId, date) VALUES ("a0a2a26b-80a2-4af0-b0d0-318d0f37ad3f", "27b250c5-d22f-4b86-98d8-b20ebad34138", "2018-09-18");
INSERT INTO Seen (userId, memeId, date) VALUES ("cd20ea0e-bc69-4f8c-9483-69cec2883cb1", "3321652e-ac0c-4cca-8307-2ba850013ead", "2019-04-04");
INSERT INTO Seen (userId, memeId, date) VALUES ("126c9276-93b1-48f9-ac38-ed0aa82fc01c", "38d24caf-84bf-4319-965a-47649c595f94", "2016-11-10");
INSERT INTO Seen (userId, memeId, date) VALUES ("058c9b2e-9085-47dc-be74-36c2de9cfb6c", "e67dc528-ffb6-499e-950e-c3185183590a", "2017-02-09");
INSERT INTO Seen (userId, memeId, date) VALUES ("34837bc1-464c-410d-8dea-82668f3bd8c1", "b7c36656-3d34-465b-8a92-5fb3b70f4bac", "2018-08-24");
INSERT INTO Seen (userId, memeId, date) VALUES ("d088a774-522b-469a-9ca4-d51faae48948", "01ccca1c-4714-4731-bd9b-f1d229af7884", "2017-11-06");
INSERT INTO Seen (userId, memeId, date) VALUES ("e5035a27-5831-4cef-aff6-86c1a7bf8825", "670d6e22-dded-4d3e-abf6-8edce8abb3dc", "2018-06-07");
INSERT INTO Seen (userId, memeId, date) VALUES ("2bc4ff9d-5fa2-435b-8028-81e224938dd2", "6bec2e6d-923d-4949-8fb9-40c5a6fae4e4", "2017-04-29");
INSERT INTO Seen (userId, memeId, date) VALUES ("07fbea7f-6116-4992-800b-fa25c09533f3", "4386adda-eca1-4268-af6a-47c6fc2d4a7d", "2017-05-03");
INSERT INTO Seen (userId, memeId, date) VALUES ("e6c68659-2d37-48c8-a8d4-e501db398bc7", "b7da8f00-ad07-4a5f-8459-72ca55574bc0", "2018-10-17");
INSERT INTO Seen (userId, memeId, date) VALUES ("72d0d686-b371-4674-a8d7-203027e8d176", "ee3eb93f-a0a7-4c31-9e0e-38782dda4f69", "2017-12-17");
INSERT INTO Seen (userId, memeId, date) VALUES ("a9457ca5-cbc4-4116-9634-a1dc25ebe026", "9956e984-1a08-45dc-8ba5-0e714c8e0a4c", "2016-12-23");
INSERT INTO Seen (userId, memeId, date) VALUES ("a9acd7b4-5a31-4f18-95ca-a8e844d2c1a5", "c7dafa03-6aba-4ed9-afc4-3d6084ed33cf", "2017-02-01");
INSERT INTO Seen (userId, memeId, date) VALUES ("fb7eeed2-6274-404d-a3d1-dcded5d7aaa5", "57172965-26a7-400b-bfd5-7f9d27a13da5", "2018-07-10");
INSERT INTO Seen (userId, memeId, date) VALUES ("32523a02-1f54-4d02-a041-1979ef57bb6c", "38d24caf-84bf-4319-965a-47649c595f94", "2017-03-30");
INSERT INTO Seen (userId, memeId, date) VALUES ("8ee983e4-c1b2-4238-ba5d-0885cfbf81d0", "832c0bf5-f02c-40de-baf5-0a7ef1a24339", "2017-08-20");
INSERT INTO Seen (userId, memeId, date) VALUES ("5c281687-851d-4a33-9083-9e590d916c74", "e813f8f4-98bc-4072-9e1a-cb3515162ce5", "2017-05-21");
INSERT INTO Seen (userId, memeId, date) VALUES ("07fbea7f-6116-4992-800b-fa25c09533f3", "aef9758e-72a4-40c3-8906-46c505ee7641", "2017-12-31");
INSERT INTO Seen (userId, memeId, date) VALUES ("3dd38bce-4ba4-4d1a-9e59-a8b507c8bc49", "dd6c2407-0ac2-4d23-a6f9-8f1ecb5adfca", "2017-09-20");
INSERT INTO Seen (userId, memeId, date) VALUES ("314faca8-cda9-4335-89cd-95cd3c770b17", "d6ce97a6-110e-4199-81ec-f53c4aef9c65", "2019-02-13");
INSERT INTO Seen (userId, memeId, date) VALUES ("ecfaab46-f5de-4fef-a82f-158278f94b56", "28d623fa-256f-46d0-9865-397fb2fecf26", "2018-11-03");
INSERT INTO Seen (userId, memeId, date) VALUES ("6360364d-e454-42e5-8a68-8b6fce893604", "32a0a290-20e9-42e1-941e-b9b4ca8f53eb", "2018-01-30");
INSERT INTO Seen (userId, memeId, date) VALUES ("a9acd7b4-5a31-4f18-95ca-a8e844d2c1a5", "57172965-26a7-400b-bfd5-7f9d27a13da5", "2017-03-03");
INSERT INTO Seen (userId, memeId, date) VALUES ("f902ccc8-5738-4dbf-81fc-7da213b153ef", "15aa4a6c-df90-4e23-b63a-8c74ee6383fd", "2018-05-09");
INSERT INTO Seen (userId, memeId, date) VALUES ("a58f19e0-3255-4292-b7e0-8da1292ab861", "85d115de-c5b7-4ef2-9147-311c8bb3a34b", "2016-09-11");
INSERT INTO Seen (userId, memeId, date) VALUES ("058c9b2e-9085-47dc-be74-36c2de9cfb6c", "4bbb19c6-9c08-4905-98da-7d537b3120ab", "2018-05-20");
INSERT INTO Seen (userId, memeId, date) VALUES ("0db8a938-a058-4bde-830d-8fa73785b32b", "b8d879fc-db51-4296-86b9-344811057c34", "2016-10-06");
INSERT INTO Seen (userId, memeId, date) VALUES ("f69b3aaa-e105-4fb2-b253-8cc977bd15a8", "7f63d060-71a3-499b-8e8c-f8c3478c64b3", "2018-03-21");
INSERT INTO Seen (userId, memeId, date) VALUES ("f902ccc8-5738-4dbf-81fc-7da213b153ef", "fe11cd78-1cd3-43ee-addc-39bbab405c79", "2018-07-06");
INSERT INTO Seen (userId, memeId, date) VALUES ("e5035a27-5831-4cef-aff6-86c1a7bf8825", "be31055a-19bf-4b69-98a2-03871a529b7c", "2017-11-24");
INSERT INTO Seen (userId, memeId, date) VALUES ("8d68c8f6-4fb8-42c0-a509-ba901515b4dd", "6bec2e6d-923d-4949-8fb9-40c5a6fae4e4", "2017-10-21");
INSERT INTO Seen (userId, memeId, date) VALUES ("32523a02-1f54-4d02-a041-1979ef57bb6c", "e75ba89e-68ff-444e-9ce7-bd11d7d726a9", "2018-12-23");
INSERT INTO Seen (userId, memeId, date) VALUES ("c1db7398-c2f8-45fa-9f84-831a5dc12724", "0199487c-2c49-4202-a69f-a084a2308a78", "2017-03-25");
INSERT INTO Seen (userId, memeId, date) VALUES ("955b335e-f4e0-4d23-84fb-afa35efdf26b", "5e84a969-2c37-47ad-8686-397a75e54a46", "2017-07-20");
INSERT INTO Seen (userId, memeId, date) VALUES ("3c940944-35b2-4afb-955e-3f3156a36b6e", "7109f5f6-5fc3-4aa1-a3cc-0f098a8f6f7e", "2018-07-06");
INSERT INTO Seen (userId, memeId, date) VALUES ("cd20ea0e-bc69-4f8c-9483-69cec2883cb1", "57172965-26a7-400b-bfd5-7f9d27a13da5", "2018-09-08");
INSERT INTO Seen (userId, memeId, date) VALUES ("606e5ff3-055e-4736-b3e7-3971234bb8de", "c7dafa03-6aba-4ed9-afc4-3d6084ed33cf", "2018-04-04");
INSERT INTO Seen (userId, memeId, date) VALUES ("b9d2a33a-613e-433d-afd4-ce6329ccafa0", "3a4d8e8e-0934-4614-bff3-b7b83b874883", "2016-09-24");
INSERT INTO Seen (userId, memeId, date) VALUES ("17b1e88b-6c42-462c-8a78-e69be166a70a", "729b4dce-75ca-483d-b532-ce3f5a550917", "2018-04-06");
INSERT INTO Seen (userId, memeId, date) VALUES ("e8b28e90-3658-42ff-b181-28e188d0ea89", "21711025-f16a-492d-b3b5-b8d1c36047d6", "2017-01-30");
INSERT INTO Seen (userId, memeId, date) VALUES ("c6c8639c-6878-4999-80fc-c8b1427426f1", "7109f5f6-5fc3-4aa1-a3cc-0f098a8f6f7e", "2017-04-27");
INSERT INTO Seen (userId, memeId, date) VALUES ("314faca8-cda9-4335-89cd-95cd3c770b17", "ee3eb93f-a0a7-4c31-9e0e-38782dda4f69", "2018-05-02");
INSERT INTO Seen (userId, memeId, date) VALUES ("b9d2a33a-613e-433d-afd4-ce6329ccafa0", "e7c7a786-a9fb-4801-972e-1511d66b2a49", "2017-01-11");
INSERT INTO Seen (userId, memeId, date) VALUES ("15f8a4bf-de0f-421c-b446-7226e924f3b5", "57172965-26a7-400b-bfd5-7f9d27a13da5", "2017-10-18");
INSERT INTO Seen (userId, memeId, date) VALUES ("ecfaab46-f5de-4fef-a82f-158278f94b56", "025b66e2-ef02-4965-bab2-d4cf631d00ff", "2017-01-18");
INSERT INTO Seen (userId, memeId, date) VALUES ("a0a2a26b-80a2-4af0-b0d0-318d0f37ad3f", "5525f398-f339-476d-b9b1-0ef634dc1f5f", "2017-12-23");
INSERT INTO Seen (userId, memeId, date) VALUES ("e0814f9e-7ae2-4f9c-8728-f530ea6da7a1", "4773faef-f21f-4ca4-ac5e-963f4651db97", "2018-04-25");
INSERT INTO Seen (userId, memeId, date) VALUES ("d677511f-54b0-4071-9436-38c9e8bca2aa", "e813f8f4-98bc-4072-9e1a-cb3515162ce5", "2017-07-16");
INSERT INTO Seen (userId, memeId, date) VALUES ("f2cc3018-0344-48db-a337-7cc461e82a5b", "7c4756b4-e8e6-4751-ac11-8eb6480f9c68", "2017-03-12");
INSERT INTO Seen (userId, memeId, date) VALUES ("34837bc1-464c-410d-8dea-82668f3bd8c1", "a3072a70-ad6a-4085-97b6-ead00307de98", "2017-11-20");
INSERT INTO Seen (userId, memeId, date) VALUES ("244d3c4e-e780-4c76-b1ea-d108ec4639f7", "6185ac35-209d-46b2-9221-0e584a914c97", "2018-07-31");
INSERT INTO Seen (userId, memeId, date) VALUES ("3c940944-35b2-4afb-955e-3f3156a36b6e", "27b250c5-d22f-4b86-98d8-b20ebad34138", "2017-01-24");
INSERT INTO Seen (userId, memeId, date) VALUES ("72a66861-0732-43aa-8b0f-587d74e54441", "6bec2e6d-923d-4949-8fb9-40c5a6fae4e4", "2019-02-01");
INSERT INTO Seen (userId, memeId, date) VALUES ("533cfdf4-1270-4e08-87de-193dcc00d7b3", "57172965-26a7-400b-bfd5-7f9d27a13da5", "2016-08-25");
INSERT INTO Seen (userId, memeId, date) VALUES ("b37ef1c5-36f7-4a04-a706-4852d9e29ff5", "13399ded-6671-41ee-9c6c-62a5edf835d1", "2018-08-22");
INSERT INTO Seen (userId, memeId, date) VALUES ("13ce5e70-e7fb-4ada-869d-feb55b143737", "c9f2b97d-030c-4928-87d2-1360c4c55bbf", "2018-02-22");
INSERT INTO Seen (userId, memeId, date) VALUES ("14f2cf35-3fd7-40dd-aa38-5204730258ae", "a3072a70-ad6a-4085-97b6-ead00307de98", "2019-02-08");
INSERT INTO Seen (userId, memeId, date) VALUES ("e131fd57-1b6e-45e1-a055-29e64d7f480a", "c30e565d-3c01-4854-bd39-ef486c58f7f6", "2017-10-06");
INSERT INTO Seen (userId, memeId, date) VALUES ("20cef249-6c91-4624-9e46-628f0b72e697", "c30e565d-3c01-4854-bd39-ef486c58f7f6", "2017-11-07");
INSERT INTO Seen (userId, memeId, date) VALUES ("e70526df-3d92-48a1-afdb-09ffbcb68808", "8a15ea36-7c2d-42ac-945a-b4a5c05439a8", "2017-12-13");
INSERT INTO Seen (userId, memeId, date) VALUES ("f902ccc8-5738-4dbf-81fc-7da213b153ef", "aef9758e-72a4-40c3-8906-46c505ee7641", "2017-04-13");
INSERT INTO Seen (userId, memeId, date) VALUES ("8d68c8f6-4fb8-42c0-a509-ba901515b4dd", "3a4d8e8e-0934-4614-bff3-b7b83b874883", "2016-09-16");
INSERT INTO Seen (userId, memeId, date) VALUES ("63c83e3c-8c6e-424d-a831-34270cabab3b", "138bc407-81de-4ef9-b686-a29520273efb", "2018-04-03");
INSERT INTO Seen (userId, memeId, date) VALUES ("72d0d686-b371-4674-a8d7-203027e8d176", "f45791cb-c43e-425b-9b74-1934de3cd96a", "2017-02-07");
INSERT INTO Seen (userId, memeId, date) VALUES ("31328fa4-64a4-4a08-a256-9fd7870f61cf", "f21d4a55-ac8b-4d03-9051-4b780c3492ba", "2018-05-08");
INSERT INTO Seen (userId, memeId, date) VALUES ("7a65b48a-80b1-45d1-bb81-52cf65e44396", "c9f2b97d-030c-4928-87d2-1360c4c55bbf", "2017-07-05");
INSERT INTO Seen (userId, memeId, date) VALUES ("eb827a72-427d-42a3-97f3-e606f66982d7", "28d623fa-256f-46d0-9865-397fb2fecf26", "2016-09-17");
INSERT INTO Seen (userId, memeId, date) VALUES ("f9fab523-c67d-4752-8fb8-be1f0a5e254f", "85d115de-c5b7-4ef2-9147-311c8bb3a34b", "2018-03-16");
INSERT INTO Seen (userId, memeId, date) VALUES ("63c83e3c-8c6e-424d-a831-34270cabab3b", "ef6e9d53-25ad-4ca5-bc53-1b526bfca0aa", "2017-11-01");
INSERT INTO Liked (userId, memeId) VALUES ("8ee983e4-c1b2-4238-ba5d-0885cfbf81d0", "32a0a290-20e9-42e1-941e-b9b4ca8f53eb");
INSERT INTO Liked (userId, memeId) VALUES ("533cfdf4-1270-4e08-87de-193dcc00d7b3", "b752aee2-bb24-4f92-a227-c9deb2e3b8c1");
INSERT INTO Liked (userId, memeId) VALUES ("f902ccc8-5738-4dbf-81fc-7da213b153ef", "d6ce97a6-110e-4199-81ec-f53c4aef9c65");
INSERT INTO Liked (userId, memeId) VALUES ("a9457ca5-cbc4-4116-9634-a1dc25ebe026", "6bec2e6d-923d-4949-8fb9-40c5a6fae4e4");
INSERT INTO Liked (userId, memeId) VALUES ("219e9bd6-563d-437e-bb50-0e89f725a0a1", "2b60d9d9-2826-472f-a479-c27edd954231");
INSERT INTO Liked (userId, memeId) VALUES ("a5b26346-a5a1-4570-95db-d038f1cdc03b", "d72ac365-7046-4c94-960a-5985c388f1b3");
INSERT INTO Liked (userId, memeId) VALUES ("89315b4f-ee33-4ba3-9487-ce95c5ca3b27", "2219db45-efa1-41ef-a0d3-f3b050ecb5b3");
INSERT INTO Liked (userId, memeId) VALUES ("270935e7-177d-47e6-ab5e-9badcd11138b", "025b66e2-ef02-4965-bab2-d4cf631d00ff");
INSERT INTO Liked (userId, memeId) VALUES ("2bc4ff9d-5fa2-435b-8028-81e224938dd2", "729b4dce-75ca-483d-b532-ce3f5a550917");
INSERT INTO Liked (userId, memeId) VALUES ("2234942a-8460-4895-81e8-4fe540e7efe5", "c7dafa03-6aba-4ed9-afc4-3d6084ed33cf");
INSERT INTO Liked (userId, memeId) VALUES ("86187994-020b-47a7-a055-0ffa48a08eaa", "3ed32cd9-e074-48de-b47e-fefda7f9a206");
INSERT INTO Liked (userId, memeId) VALUES ("e131fd57-1b6e-45e1-a055-29e64d7f480a", "e75ba89e-68ff-444e-9ce7-bd11d7d726a9");
INSERT INTO Liked (userId, memeId) VALUES ("31328fa4-64a4-4a08-a256-9fd7870f61cf", "dd94c7d8-86d8-4305-81f1-c818d21e2db7");
INSERT INTO Liked (userId, memeId) VALUES ("a9acd7b4-5a31-4f18-95ca-a8e844d2c1a5", "13399ded-6671-41ee-9c6c-62a5edf835d1");
INSERT INTO Liked (userId, memeId) VALUES ("a9457ca5-cbc4-4116-9634-a1dc25ebe026", "d38920e2-8185-4efc-833d-cf9faea63f94");
INSERT INTO Liked (userId, memeId) VALUES ("1b915cf6-a6e7-4210-a23b-41790450b32f", "ef6e9d53-25ad-4ca5-bc53-1b526bfca0aa");
INSERT INTO Liked (userId, memeId) VALUES ("d677511f-54b0-4071-9436-38c9e8bca2aa", "138bc407-81de-4ef9-b686-a29520273efb");
INSERT INTO Liked (userId, memeId) VALUES ("5f6da10d-d573-4321-a2cc-474b47b3bcf3", "a890498d-92a2-40a3-aac9-3e356d1827a1");
INSERT INTO Liked (userId, memeId) VALUES ("63c83e3c-8c6e-424d-a831-34270cabab3b", "57172965-26a7-400b-bfd5-7f9d27a13da5");
INSERT INTO Liked (userId, memeId) VALUES ("6525e15c-9536-4d87-8ffd-0549931b73e8", "dd94c7d8-86d8-4305-81f1-c818d21e2db7");
INSERT INTO Liked (userId, memeId) VALUES ("058c9b2e-9085-47dc-be74-36c2de9cfb6c", "0199487c-2c49-4202-a69f-a084a2308a78");
INSERT INTO Liked (userId, memeId) VALUES ("be4c0486-5a5d-4aea-b376-2a7738a6309a", "fe11cd78-1cd3-43ee-addc-39bbab405c79");
INSERT INTO Liked (userId, memeId) VALUES ("f902ccc8-5738-4dbf-81fc-7da213b153ef", "b752aee2-bb24-4f92-a227-c9deb2e3b8c1");
INSERT INTO Liked (userId, memeId) VALUES ("533cfdf4-1270-4e08-87de-193dcc00d7b3", "f910432c-6bbc-4a7b-a2d9-f469c0a2801e");
INSERT INTO Liked (userId, memeId) VALUES ("2d4f5799-5432-4cfa-9473-141c2cd0a01b", "fdf31c43-89b3-4274-a2ca-09f12d85f4e7");
INSERT INTO Liked (userId, memeId) VALUES ("e0814f9e-7ae2-4f9c-8728-f530ea6da7a1", "32ab3da7-74d9-4c78-a47a-c0e647cab238");
INSERT INTO Liked (userId, memeId) VALUES ("f9fab523-c67d-4752-8fb8-be1f0a5e254f", "f45791cb-c43e-425b-9b74-1934de3cd96a");
INSERT INTO Liked (userId, memeId) VALUES ("cd20ea0e-bc69-4f8c-9483-69cec2883cb1", "069d3225-0f22-4ff6-9825-2f20c3492e81");
INSERT INTO Liked (userId, memeId) VALUES ("d280bd1d-a3a1-4afb-8885-5b74c3137c19", "b752aee2-bb24-4f92-a227-c9deb2e3b8c1");
INSERT INTO Liked (userId, memeId) VALUES ("ee55eb63-98df-49fb-b464-440603a56c3f", "2d531465-2d92-4a2c-b333-bb00b5cecde6");
INSERT INTO Liked (userId, memeId) VALUES ("b9d2a33a-613e-433d-afd4-ce6329ccafa0", "dd94c7d8-86d8-4305-81f1-c818d21e2db7");
INSERT INTO Liked (userId, memeId) VALUES ("7a65b48a-80b1-45d1-bb81-52cf65e44396", "575c2d32-9d69-4475-8b32-d3a39fe902cc");
INSERT INTO Liked (userId, memeId) VALUES ("c750054e-f128-4766-b293-bae3d681dee1", "aef9758e-72a4-40c3-8906-46c505ee7641");
INSERT INTO Liked (userId, memeId) VALUES ("a0a2a26b-80a2-4af0-b0d0-318d0f37ad3f", "d7bd64ac-25d8-49dd-9842-2dbe1a6d7619");
INSERT INTO Liked (userId, memeId) VALUES ("ac756b0b-f257-4cc6-80fa-b89b2da5587e", "dd6c2407-0ac2-4d23-a6f9-8f1ecb5adfca");
INSERT INTO Liked (userId, memeId) VALUES ("be4c0486-5a5d-4aea-b376-2a7738a6309a", "d7bd64ac-25d8-49dd-9842-2dbe1a6d7619");
INSERT INTO Liked (userId, memeId) VALUES ("07fbea7f-6116-4992-800b-fa25c09533f3", "c7dafa03-6aba-4ed9-afc4-3d6084ed33cf");
INSERT INTO Liked (userId, memeId) VALUES ("3b9d6cc7-e64c-4649-8893-96c234005558", "025b66e2-ef02-4965-bab2-d4cf631d00ff");
INSERT INTO Liked (userId, memeId) VALUES ("0c3113b9-5db0-4ddd-86bf-1501f4fb0391", "5e84a969-2c37-47ad-8686-397a75e54a46");
INSERT INTO Liked (userId, memeId) VALUES ("a9457ca5-cbc4-4116-9634-a1dc25ebe026", "6d677865-1bb1-4f4c-bfd0-0964282a2381");
INSERT INTO Liked (userId, memeId) VALUES ("5f6192f5-0e5c-4172-b933-a77ff18a4d16", "ee3eb93f-a0a7-4c31-9e0e-38782dda4f69");
INSERT INTO Liked (userId, memeId) VALUES ("ead07ca8-d7c8-41ba-a65f-b814e92960a0", "670d6e22-dded-4d3e-abf6-8edce8abb3dc");
INSERT INTO Liked (userId, memeId) VALUES ("27bafcc6-8040-4992-a66b-e4edf039a1f6", "2b60d9d9-2826-472f-a479-c27edd954231");
INSERT INTO Liked (userId, memeId) VALUES ("be4c0486-5a5d-4aea-b376-2a7738a6309a", "f21d4a55-ac8b-4d03-9051-4b780c3492ba");
INSERT INTO Liked (userId, memeId) VALUES ("0c3113b9-5db0-4ddd-86bf-1501f4fb0391", "98dc5415-7129-43e0-9d27-70724bd5fd8e");
INSERT INTO Liked (userId, memeId) VALUES ("e70526df-3d92-48a1-afdb-09ffbcb68808", "3a4d8e8e-0934-4614-bff3-b7b83b874883");
INSERT INTO Liked (userId, memeId) VALUES ("7a65b48a-80b1-45d1-bb81-52cf65e44396", "98dc5415-7129-43e0-9d27-70724bd5fd8e");
INSERT INTO Liked (userId, memeId) VALUES ("54bf967f-f476-4934-93b2-b04ba641afda", "21711025-f16a-492d-b3b5-b8d1c36047d6");
INSERT INTO Liked (userId, memeId) VALUES ("7f422a4c-a7ad-4d05-a98a-218d668b7510", "d223a84b-ac04-4925-a97e-ccd3b6b54f2e");
INSERT INTO Liked (userId, memeId) VALUES ("f69b3aaa-e105-4fb2-b253-8cc977bd15a8", "a31ada11-0fc2-4651-bef2-874be2b71bf7");
INSERT INTO Liked (userId, memeId) VALUES ("63c83e3c-8c6e-424d-a831-34270cabab3b", "01ccca1c-4714-4731-bd9b-f1d229af7884");
INSERT INTO Liked (userId, memeId) VALUES ("e70526df-3d92-48a1-afdb-09ffbcb68808", "a1e7c8bb-2431-4adf-8fc3-a452b5bbb173");
INSERT INTO Liked (userId, memeId) VALUES ("c1db7398-c2f8-45fa-9f84-831a5dc12724", "0955dcbd-14af-409b-afbb-c3e60e0a7678");
INSERT INTO Liked (userId, memeId) VALUES ("90035a83-6507-4813-b243-44663a53e0f0", "741b0e46-350e-4d46-aec7-571dad3953b5");
INSERT INTO Liked (userId, memeId) VALUES ("07fbea7f-6116-4992-800b-fa25c09533f3", "7daa29e0-0c67-4e1e-b370-e498b2f8dbcf");
INSERT INTO Liked (userId, memeId) VALUES ("1197021e-c6b9-4e5b-b95e-682b8f37ebea", "2d531465-2d92-4a2c-b333-bb00b5cecde6");
INSERT INTO Liked (userId, memeId) VALUES ("a9457ca5-cbc4-4116-9634-a1dc25ebe026", "2d531465-2d92-4a2c-b333-bb00b5cecde6");
INSERT INTO Liked (userId, memeId) VALUES ("27bafcc6-8040-4992-a66b-e4edf039a1f6", "e67dc528-ffb6-499e-950e-c3185183590a");
INSERT INTO Liked (userId, memeId) VALUES ("ee55eb63-98df-49fb-b464-440603a56c3f", "3ed32cd9-e074-48de-b47e-fefda7f9a206");
INSERT INTO Liked (userId, memeId) VALUES ("54bf967f-f476-4934-93b2-b04ba641afda", "dd94c7d8-86d8-4305-81f1-c818d21e2db7");
INSERT INTO Liked (userId, memeId) VALUES ("8ee983e4-c1b2-4238-ba5d-0885cfbf81d0", "e67dc528-ffb6-499e-950e-c3185183590a");
INSERT INTO Liked (userId, memeId) VALUES ("2234942a-8460-4895-81e8-4fe540e7efe5", "5525f398-f339-476d-b9b1-0ef634dc1f5f");
INSERT INTO Liked (userId, memeId) VALUES ("3b9d6cc7-e64c-4649-8893-96c234005558", "4386adda-eca1-4268-af6a-47c6fc2d4a7d");
INSERT INTO Liked (userId, memeId) VALUES ("72a66861-0732-43aa-8b0f-587d74e54441", "cc0da109-cdd9-4e13-b59d-dae018ef52af");
INSERT INTO Liked (userId, memeId) VALUES ("86187994-020b-47a7-a055-0ffa48a08eaa", "c77ea382-cbee-42b8-96bd-397b77e8455f");
INSERT INTO Liked (userId, memeId) VALUES ("8dee5976-61fd-4958-bf8c-10770c6e2218", "6185ac35-209d-46b2-9221-0e584a914c97");
INSERT INTO Liked (userId, memeId) VALUES ("27bafcc6-8040-4992-a66b-e4edf039a1f6", "c77ea382-cbee-42b8-96bd-397b77e8455f");
INSERT INTO Liked (userId, memeId) VALUES ("b9d2a33a-613e-433d-afd4-ce6329ccafa0", "929f8d33-9c84-4237-b6f0-70725739d35a");
INSERT INTO Liked (userId, memeId) VALUES ("27bafcc6-8040-4992-a66b-e4edf039a1f6", "98dc5415-7129-43e0-9d27-70724bd5fd8e");
INSERT INTO Liked (userId, memeId) VALUES ("0c3113b9-5db0-4ddd-86bf-1501f4fb0391", "90c2eb73-476b-43f6-990d-29eb0d4c1ca1");
INSERT INTO Liked (userId, memeId) VALUES ("a9acd7b4-5a31-4f18-95ca-a8e844d2c1a5", "c77ea382-cbee-42b8-96bd-397b77e8455f");
INSERT INTO Liked (userId, memeId) VALUES ("39c8b1b7-c5e9-4bb9-9405-7c9aca045c72", "025b66e2-ef02-4965-bab2-d4cf631d00ff");
INSERT INTO Liked (userId, memeId) VALUES ("0db8a938-a058-4bde-830d-8fa73785b32b", "28d623fa-256f-46d0-9865-397fb2fecf26");
INSERT INTO Liked (userId, memeId) VALUES ("5c281687-851d-4a33-9083-9e590d916c74", "28d623fa-256f-46d0-9865-397fb2fecf26");
INSERT INTO Liked (userId, memeId) VALUES ("e70526df-3d92-48a1-afdb-09ffbcb68808", "fdf31c43-89b3-4274-a2ca-09f12d85f4e7");
INSERT INTO Liked (userId, memeId) VALUES ("31328fa4-64a4-4a08-a256-9fd7870f61cf", "7f63d060-71a3-499b-8e8c-f8c3478c64b3");
INSERT INTO Liked (userId, memeId) VALUES ("32523a02-1f54-4d02-a041-1979ef57bb6c", "5e84a969-2c37-47ad-8686-397a75e54a46");
INSERT INTO Liked (userId, memeId) VALUES ("27bafcc6-8040-4992-a66b-e4edf039a1f6", "be6a4b1a-c429-4c30-bfed-842fa868f123");
INSERT INTO Liked (userId, memeId) VALUES ("bc7f6635-9a0d-4347-9ef1-26e948e80365", "ef6b9ec7-c267-4550-8158-c8dc0c60b99a");
INSERT INTO Liked (userId, memeId) VALUES ("43c5152e-d2bc-4ce2-9f10-818f36ef138f", "effc5076-42ff-4ac1-9e4d-caef33d27afd");
INSERT INTO Liked (userId, memeId) VALUES ("72d0d686-b371-4674-a8d7-203027e8d176", "6bec2e6d-923d-4949-8fb9-40c5a6fae4e4");
INSERT INTO Liked (userId, memeId) VALUES ("86187994-020b-47a7-a055-0ffa48a08eaa", "be72061e-dd27-420c-ba8d-be3b00f0ef50");
INSERT INTO Liked (userId, memeId) VALUES ("b9d2a33a-613e-433d-afd4-ce6329ccafa0", "0955dcbd-14af-409b-afbb-c3e60e0a7678");
INSERT INTO Liked (userId, memeId) VALUES ("8e02276c-48d6-4bed-a702-cffecb4187f6", "d935b5a1-a481-475e-91b7-4c81407ac184");
INSERT INTO Liked (userId, memeId) VALUES ("1b915cf6-a6e7-4210-a23b-41790450b32f", "fe11cd78-1cd3-43ee-addc-39bbab405c79");
INSERT INTO Liked (userId, memeId) VALUES ("244d3c4e-e780-4c76-b1ea-d108ec4639f7", "729b4dce-75ca-483d-b532-ce3f5a550917");
INSERT INTO Liked (userId, memeId) VALUES ("314faca8-cda9-4335-89cd-95cd3c770b17", "28d623fa-256f-46d0-9865-397fb2fecf26");
INSERT INTO Liked (userId, memeId) VALUES ("314faca8-cda9-4335-89cd-95cd3c770b17", "bd634a0a-3000-47ab-b054-b0a949e78bbf");
INSERT INTO Liked (userId, memeId) VALUES ("8e02276c-48d6-4bed-a702-cffecb4187f6", "4bbb19c6-9c08-4905-98da-7d537b3120ab");
INSERT INTO Liked (userId, memeId) VALUES ("c1db7398-c2f8-45fa-9f84-831a5dc12724", "0955dcbd-14af-409b-afbb-c3e60e0a7678");
INSERT INTO Liked (userId, memeId) VALUES ("07fbea7f-6116-4992-800b-fa25c09533f3", "98dc5415-7129-43e0-9d27-70724bd5fd8e");
INSERT INTO Liked (userId, memeId) VALUES ("7a65b48a-80b1-45d1-bb81-52cf65e44396", "741b0e46-350e-4d46-aec7-571dad3953b5");
INSERT INTO Liked (userId, memeId) VALUES ("e8b28e90-3658-42ff-b181-28e188d0ea89", "be72061e-dd27-420c-ba8d-be3b00f0ef50");
INSERT INTO Liked (userId, memeId) VALUES ("244d3c4e-e780-4c76-b1ea-d108ec4639f7", "025b66e2-ef02-4965-bab2-d4cf631d00ff");
INSERT INTO Liked (userId, memeId) VALUES ("eb827a72-427d-42a3-97f3-e606f66982d7", "741b0e46-350e-4d46-aec7-571dad3953b5");
INSERT INTO Liked (userId, memeId) VALUES ("fb7eeed2-6274-404d-a3d1-dcded5d7aaa5", "be31055a-19bf-4b69-98a2-03871a529b7c");
INSERT INTO Liked (userId, memeId) VALUES ("2aca6c5f-bf0a-4ef1-81c5-4c9dea28a541", "a31ada11-0fc2-4651-bef2-874be2b71bf7");
INSERT INTO Liked (userId, memeId) VALUES ("1197021e-c6b9-4e5b-b95e-682b8f37ebea", "fe11cd78-1cd3-43ee-addc-39bbab405c79");
INSERT INTO Liked (userId, memeId) VALUES ("ac756b0b-f257-4cc6-80fa-b89b2da5587e", "b8d879fc-db51-4296-86b9-344811057c34");
INSERT INTO Liked (userId, memeId) VALUES ("b4bd37c8-30f3-41ff-ac2c-89636a1ebb27", "aea7c415-2ada-4427-804d-dda892f8fb35");
INSERT INTO Disliked (userId, memeId) VALUES ("3c940944-35b2-4afb-955e-3f3156a36b6e", "d935b5a1-a481-475e-91b7-4c81407ac184");
INSERT INTO Disliked (userId, memeId) VALUES ("2bc4ff9d-5fa2-435b-8028-81e224938dd2", "ef6b9ec7-c267-4550-8158-c8dc0c60b99a");
INSERT INTO Disliked (userId, memeId) VALUES ("533cfdf4-1270-4e08-87de-193dcc00d7b3", "a1e7c8bb-2431-4adf-8fc3-a452b5bbb173");
INSERT INTO Disliked (userId, memeId) VALUES ("b9d2a33a-613e-433d-afd4-ce6329ccafa0", "a890498d-92a2-40a3-aac9-3e356d1827a1");
INSERT INTO Disliked (userId, memeId) VALUES ("6360364d-e454-42e5-8a68-8b6fce893604", "fdf31c43-89b3-4274-a2ca-09f12d85f4e7");
INSERT INTO Disliked (userId, memeId) VALUES ("7a65b48a-80b1-45d1-bb81-52cf65e44396", "6bec2e6d-923d-4949-8fb9-40c5a6fae4e4");
INSERT INTO Disliked (userId, memeId) VALUES ("e5035a27-5831-4cef-aff6-86c1a7bf8825", "455e6fca-3ebc-4db7-913a-a7eefff657d9");
INSERT INTO Disliked (userId, memeId) VALUES ("72a66861-0732-43aa-8b0f-587d74e54441", "23bfbc77-01c9-4f75-b8cc-afff0c04dc31");
INSERT INTO Disliked (userId, memeId) VALUES ("6525e15c-9536-4d87-8ffd-0549931b73e8", "c30e565d-3c01-4854-bd39-ef486c58f7f6");
INSERT INTO Disliked (userId, memeId) VALUES ("1199f03a-57c1-4b15-b98c-9ca5ae89694d", "575c2d32-9d69-4475-8b32-d3a39fe902cc");
INSERT INTO Disliked (userId, memeId) VALUES ("8e02276c-48d6-4bed-a702-cffecb4187f6", "4bbb19c6-9c08-4905-98da-7d537b3120ab");
INSERT INTO Disliked (userId, memeId) VALUES ("a9acd7b4-5a31-4f18-95ca-a8e844d2c1a5", "4331dcc1-618d-4b7d-be49-6c7bc320ee34");
INSERT INTO Disliked (userId, memeId) VALUES ("f2cc3018-0344-48db-a337-7cc461e82a5b", "a09a4df4-6c83-4609-bc72-16a90cf932a3");
INSERT INTO Disliked (userId, memeId) VALUES ("8e02276c-48d6-4bed-a702-cffecb4187f6", "a3072a70-ad6a-4085-97b6-ead00307de98");
INSERT INTO Disliked (userId, memeId) VALUES ("1b915cf6-a6e7-4210-a23b-41790450b32f", "b7c36656-3d34-465b-8a92-5fb3b70f4bac");
INSERT INTO Disliked (userId, memeId) VALUES ("c6c8639c-6878-4999-80fc-c8b1427426f1", "4bbb19c6-9c08-4905-98da-7d537b3120ab");
INSERT INTO Disliked (userId, memeId) VALUES ("20cef249-6c91-4624-9e46-628f0b72e697", "d7bd64ac-25d8-49dd-9842-2dbe1a6d7619");
INSERT INTO Disliked (userId, memeId) VALUES ("d677511f-54b0-4071-9436-38c9e8bca2aa", "d72ac365-7046-4c94-960a-5985c388f1b3");
INSERT INTO Disliked (userId, memeId) VALUES ("5ea8b618-6704-4d84-9cb4-f4a6438627ac", "9387c58c-1184-4e25-a1b8-b9cfd14f2b3c");
INSERT INTO Disliked (userId, memeId) VALUES ("2bc4ff9d-5fa2-435b-8028-81e224938dd2", "0955dcbd-14af-409b-afbb-c3e60e0a7678");
INSERT INTO Disliked (userId, memeId) VALUES ("2aca6c5f-bf0a-4ef1-81c5-4c9dea28a541", "d72ac365-7046-4c94-960a-5985c388f1b3");
INSERT INTO Disliked (userId, memeId) VALUES ("ecfaab46-f5de-4fef-a82f-158278f94b56", "23bfbc77-01c9-4f75-b8cc-afff0c04dc31");
INSERT INTO Disliked (userId, memeId) VALUES ("75200099-1e3f-47ea-a31d-d4d5da85cd61", "4331dcc1-618d-4b7d-be49-6c7bc320ee34");
INSERT INTO Disliked (userId, memeId) VALUES ("816f81ea-5684-4c6b-8ae2-ae2d6ef3d72f", "dd6c2407-0ac2-4d23-a6f9-8f1ecb5adfca");
INSERT INTO Disliked (userId, memeId) VALUES ("8e02276c-48d6-4bed-a702-cffecb4187f6", "7109f5f6-5fc3-4aa1-a3cc-0f098a8f6f7e");
INSERT INTO Disliked (userId, memeId) VALUES ("5f6192f5-0e5c-4172-b933-a77ff18a4d16", "c9f2b97d-030c-4928-87d2-1360c4c55bbf");
INSERT INTO Disliked (userId, memeId) VALUES ("39c8b1b7-c5e9-4bb9-9405-7c9aca045c72", "832c0bf5-f02c-40de-baf5-0a7ef1a24339");
INSERT INTO Disliked (userId, memeId) VALUES ("05700b90-90a8-4b54-bdbe-a9ddfa354a5d", "effc5076-42ff-4ac1-9e4d-caef33d27afd");
INSERT INTO Disliked (userId, memeId) VALUES ("1eaad232-6065-4c18-a4ea-5fd5ec82a8d4", "32a0a290-20e9-42e1-941e-b9b4ca8f53eb");
INSERT INTO Disliked (userId, memeId) VALUES ("eb827a72-427d-42a3-97f3-e606f66982d7", "4386adda-eca1-4268-af6a-47c6fc2d4a7d");
INSERT INTO Disliked (userId, memeId) VALUES ("f2cc3018-0344-48db-a337-7cc461e82a5b", "a3072a70-ad6a-4085-97b6-ead00307de98");
INSERT INTO Disliked (userId, memeId) VALUES ("9d0b966d-0dec-45e4-ae64-7319d4f73b80", "069d3225-0f22-4ff6-9825-2f20c3492e81");
INSERT INTO Disliked (userId, memeId) VALUES ("1199f03a-57c1-4b15-b98c-9ca5ae89694d", "89017ccb-d907-4dc0-a502-068444d5d3fa");
INSERT INTO Disliked (userId, memeId) VALUES ("ead07ca8-d7c8-41ba-a65f-b814e92960a0", "d935b5a1-a481-475e-91b7-4c81407ac184");
INSERT INTO Disliked (userId, memeId) VALUES ("46fa9344-aefb-44b6-bf60-6d24cb5546b7", "1387e323-756b-48a4-bee7-511fdea14915");
INSERT INTO Disliked (userId, memeId) VALUES ("1eaad232-6065-4c18-a4ea-5fd5ec82a8d4", "455e6fca-3ebc-4db7-913a-a7eefff657d9");
INSERT INTO Disliked (userId, memeId) VALUES ("c750054e-f128-4766-b293-bae3d681dee1", "15aa4a6c-df90-4e23-b63a-8c74ee6383fd");
INSERT INTO Disliked (userId, memeId) VALUES ("219e9bd6-563d-437e-bb50-0e89f725a0a1", "7c4756b4-e8e6-4751-ac11-8eb6480f9c68");
INSERT INTO Disliked (userId, memeId) VALUES ("eb827a72-427d-42a3-97f3-e606f66982d7", "c30e565d-3c01-4854-bd39-ef486c58f7f6");
INSERT INTO Disliked (userId, memeId) VALUES ("27bafcc6-8040-4992-a66b-e4edf039a1f6", "3a4d8e8e-0934-4614-bff3-b7b83b874883");
INSERT INTO Disliked (userId, memeId) VALUES ("15f8a4bf-de0f-421c-b446-7226e924f3b5", "4bbb19c6-9c08-4905-98da-7d537b3120ab");
INSERT INTO Disliked (userId, memeId) VALUES ("39c8b1b7-c5e9-4bb9-9405-7c9aca045c72", "138bc407-81de-4ef9-b686-a29520273efb");
INSERT INTO Disliked (userId, memeId) VALUES ("5f6da10d-d573-4321-a2cc-474b47b3bcf3", "bd634a0a-3000-47ab-b054-b0a949e78bbf");
INSERT INTO Disliked (userId, memeId) VALUES ("a0a2a26b-80a2-4af0-b0d0-318d0f37ad3f", "b7da8f00-ad07-4a5f-8459-72ca55574bc0");
INSERT INTO Disliked (userId, memeId) VALUES ("1efe6717-b2c4-4ac2-94ea-2f5c0a794fa4", "d6ce97a6-110e-4199-81ec-f53c4aef9c65");
INSERT INTO Disliked (userId, memeId) VALUES ("b4bd37c8-30f3-41ff-ac2c-89636a1ebb27", "4331dcc1-618d-4b7d-be49-6c7bc320ee34");
INSERT INTO Disliked (userId, memeId) VALUES ("13ce5e70-e7fb-4ada-869d-feb55b143737", "98dc5415-7129-43e0-9d27-70724bd5fd8e");
INSERT INTO Disliked (userId, memeId) VALUES ("a0a2a26b-80a2-4af0-b0d0-318d0f37ad3f", "4bbb19c6-9c08-4905-98da-7d537b3120ab");
INSERT INTO Disliked (userId, memeId) VALUES ("27bafcc6-8040-4992-a66b-e4edf039a1f6", "dd94c7d8-86d8-4305-81f1-c818d21e2db7");
INSERT INTO Disliked (userId, memeId) VALUES ("ecfaab46-f5de-4fef-a82f-158278f94b56", "c9f2b97d-030c-4928-87d2-1360c4c55bbf");
INSERT INTO Disliked (userId, memeId) VALUES ("43c5152e-d2bc-4ce2-9f10-818f36ef138f", "a09a4df4-6c83-4609-bc72-16a90cf932a3");
INSERT INTO Disliked (userId, memeId) VALUES ("b37ef1c5-36f7-4a04-a706-4852d9e29ff5", "38d24caf-84bf-4319-965a-47649c595f94");
INSERT INTO Disliked (userId, memeId) VALUES ("e6c68659-2d37-48c8-a8d4-e501db398bc7", "832c0bf5-f02c-40de-baf5-0a7ef1a24339");
INSERT INTO Disliked (userId, memeId) VALUES ("f902ccc8-5738-4dbf-81fc-7da213b153ef", "7daa29e0-0c67-4e1e-b370-e498b2f8dbcf");
INSERT INTO Disliked (userId, memeId) VALUES ("90035a83-6507-4813-b243-44663a53e0f0", "4331dcc1-618d-4b7d-be49-6c7bc320ee34");
INSERT INTO Disliked (userId, memeId) VALUES ("7a65b48a-80b1-45d1-bb81-52cf65e44396", "138bc407-81de-4ef9-b686-a29520273efb");
INSERT INTO Disliked (userId, memeId) VALUES ("270935e7-177d-47e6-ab5e-9badcd11138b", "670d6e22-dded-4d3e-abf6-8edce8abb3dc");
INSERT INTO Disliked (userId, memeId) VALUES ("b4bd37c8-30f3-41ff-ac2c-89636a1ebb27", "2b60d9d9-2826-472f-a479-c27edd954231");
INSERT INTO Disliked (userId, memeId) VALUES ("8ee983e4-c1b2-4238-ba5d-0885cfbf81d0", "575c2d32-9d69-4475-8b32-d3a39fe902cc");
INSERT INTO Disliked (userId, memeId) VALUES ("0c3113b9-5db0-4ddd-86bf-1501f4fb0391", "7c4756b4-e8e6-4751-ac11-8eb6480f9c68");
INSERT INTO Disliked (userId, memeId) VALUES ("2aca6c5f-bf0a-4ef1-81c5-4c9dea28a541", "9956e984-1a08-45dc-8ba5-0e714c8e0a4c");
INSERT INTO Disliked (userId, memeId) VALUES ("72a66861-0732-43aa-8b0f-587d74e54441", "23bfbc77-01c9-4f75-b8cc-afff0c04dc31");
INSERT INTO Disliked (userId, memeId) VALUES ("e6c68659-2d37-48c8-a8d4-e501db398bc7", "ef6e9d53-25ad-4ca5-bc53-1b526bfca0aa");
INSERT INTO Disliked (userId, memeId) VALUES ("7f422a4c-a7ad-4d05-a98a-218d668b7510", "4773faef-f21f-4ca4-ac5e-963f4651db97");
INSERT INTO Disliked (userId, memeId) VALUES ("0db8a938-a058-4bde-830d-8fa73785b32b", "d935b5a1-a481-475e-91b7-4c81407ac184");
INSERT INTO Disliked (userId, memeId) VALUES ("d138fb78-6839-47ae-9f0d-47d01e71b1ab", "9956e984-1a08-45dc-8ba5-0e714c8e0a4c");
INSERT INTO Disliked (userId, memeId) VALUES ("d138fb78-6839-47ae-9f0d-47d01e71b1ab", "32a0a290-20e9-42e1-941e-b9b4ca8f53eb");
INSERT INTO Disliked (userId, memeId) VALUES ("b4bd37c8-30f3-41ff-ac2c-89636a1ebb27", "e6c4064f-39bb-4c7c-9f0b-76f5b90f4fbe");
INSERT INTO Disliked (userId, memeId) VALUES ("8d68c8f6-4fb8-42c0-a509-ba901515b4dd", "3321652e-ac0c-4cca-8307-2ba850013ead");
INSERT INTO Disliked (userId, memeId) VALUES ("15f8a4bf-de0f-421c-b446-7226e924f3b5", "12319d13-f295-4571-aa58-2c57ac24ca68");
INSERT INTO Disliked (userId, memeId) VALUES ("e131fd57-1b6e-45e1-a055-29e64d7f480a", "89017ccb-d907-4dc0-a502-068444d5d3fa");
INSERT INTO Disliked (userId, memeId) VALUES ("72d0d686-b371-4674-a8d7-203027e8d176", "7f63d060-71a3-499b-8e8c-f8c3478c64b3");
INSERT INTO Disliked (userId, memeId) VALUES ("8d68c8f6-4fb8-42c0-a509-ba901515b4dd", "23bfbc77-01c9-4f75-b8cc-afff0c04dc31");
INSERT INTO Disliked (userId, memeId) VALUES ("2d4f5799-5432-4cfa-9473-141c2cd0a01b", "5e84a969-2c37-47ad-8686-397a75e54a46");
INSERT INTO Disliked (userId, memeId) VALUES ("ead07ca8-d7c8-41ba-a65f-b814e92960a0", "a1e7c8bb-2431-4adf-8fc3-a452b5bbb173");
INSERT INTO Disliked (userId, memeId) VALUES ("d677511f-54b0-4071-9436-38c9e8bca2aa", "7daa29e0-0c67-4e1e-b370-e498b2f8dbcf");
INSERT INTO Disliked (userId, memeId) VALUES ("ead07ca8-d7c8-41ba-a65f-b814e92960a0", "bd634a0a-3000-47ab-b054-b0a949e78bbf");
INSERT INTO Disliked (userId, memeId) VALUES ("0db8a938-a058-4bde-830d-8fa73785b32b", "e7c7a786-a9fb-4801-972e-1511d66b2a49");
INSERT INTO Disliked (userId, memeId) VALUES ("8dee5976-61fd-4958-bf8c-10770c6e2218", "138bc407-81de-4ef9-b686-a29520273efb");
INSERT INTO Disliked (userId, memeId) VALUES ("20cef249-6c91-4624-9e46-628f0b72e697", "c9f2b97d-030c-4928-87d2-1360c4c55bbf");
INSERT INTO Disliked (userId, memeId) VALUES ("219e9bd6-563d-437e-bb50-0e89f725a0a1", "3607e9bc-c9a4-4502-850c-41f9c4b1db78");
INSERT INTO Disliked (userId, memeId) VALUES ("c750054e-f128-4766-b293-bae3d681dee1", "c30e565d-3c01-4854-bd39-ef486c58f7f6");
INSERT INTO Disliked (userId, memeId) VALUES ("31328fa4-64a4-4a08-a256-9fd7870f61cf", "a000c556-1977-441e-97eb-8bbe3b5cb971");
INSERT INTO Disliked (userId, memeId) VALUES ("07fbea7f-6116-4992-800b-fa25c09533f3", "7f63d060-71a3-499b-8e8c-f8c3478c64b3");
INSERT INTO Disliked (userId, memeId) VALUES ("fb7eeed2-6274-404d-a3d1-dcded5d7aaa5", "7c4756b4-e8e6-4751-ac11-8eb6480f9c68");
INSERT INTO Disliked (userId, memeId) VALUES ("07fbea7f-6116-4992-800b-fa25c09533f3", "7daa29e0-0c67-4e1e-b370-e498b2f8dbcf");
INSERT INTO Disliked (userId, memeId) VALUES ("8d68c8f6-4fb8-42c0-a509-ba901515b4dd", "0199487c-2c49-4202-a69f-a084a2308a78");
INSERT INTO Disliked (userId, memeId) VALUES ("d280bd1d-a3a1-4afb-8885-5b74c3137c19", "3607e9bc-c9a4-4502-850c-41f9c4b1db78");
INSERT INTO Disliked (userId, memeId) VALUES ("2d4f5799-5432-4cfa-9473-141c2cd0a01b", "9387c58c-1184-4e25-a1b8-b9cfd14f2b3c");
INSERT INTO Disliked (userId, memeId) VALUES ("a9acd7b4-5a31-4f18-95ca-a8e844d2c1a5", "7daa29e0-0c67-4e1e-b370-e498b2f8dbcf");
INSERT INTO Disliked (userId, memeId) VALUES ("a0a2a26b-80a2-4af0-b0d0-318d0f37ad3f", "2d531465-2d92-4a2c-b333-bb00b5cecde6");
INSERT INTO Disliked (userId, memeId) VALUES ("f902ccc8-5738-4dbf-81fc-7da213b153ef", "9956e984-1a08-45dc-8ba5-0e714c8e0a4c");
INSERT INTO Disliked (userId, memeId) VALUES ("a9acd7b4-5a31-4f18-95ca-a8e844d2c1a5", "f7a20c7a-dd08-4859-811b-33254b880484");
INSERT INTO Disliked (userId, memeId) VALUES ("b37ef1c5-36f7-4a04-a706-4852d9e29ff5", "c30e565d-3c01-4854-bd39-ef486c58f7f6");
INSERT INTO Disliked (userId, memeId) VALUES ("15f8a4bf-de0f-421c-b446-7226e924f3b5", "832c0bf5-f02c-40de-baf5-0a7ef1a24339");
INSERT INTO Disliked (userId, memeId) VALUES ("e0814f9e-7ae2-4f9c-8728-f530ea6da7a1", "ee3eb93f-a0a7-4c31-9e0e-38782dda4f69");
INSERT INTO Disliked (userId, memeId) VALUES ("b37ef1c5-36f7-4a04-a706-4852d9e29ff5", "dd6c2407-0ac2-4d23-a6f9-8f1ecb5adfca");
INSERT INTO Disliked (userId, memeId) VALUES ("bc7f6635-9a0d-4347-9ef1-26e948e80365", "4331dcc1-618d-4b7d-be49-6c7bc320ee34");
INSERT INTO Disliked (userId, memeId) VALUES ("533cfdf4-1270-4e08-87de-193dcc00d7b3", "6bec2e6d-923d-4949-8fb9-40c5a6fae4e4");
INSERT INTO Disliked (userId, memeId) VALUES ("20cef249-6c91-4624-9e46-628f0b72e697", "5e84a969-2c37-47ad-8686-397a75e54a46");
INSERT INTO Uploaded (userId, memeId) VALUES ("d677511f-54b0-4071-9436-38c9e8bca2aa", "3ed32cd9-e074-48de-b47e-fefda7f9a206");
INSERT INTO Uploaded (userId, memeId) VALUES ("c1db7398-c2f8-45fa-9f84-831a5dc12724", "23bfbc77-01c9-4f75-b8cc-afff0c04dc31");
INSERT INTO Uploaded (userId, memeId) VALUES ("75ea83fb-9c53-43cb-b744-2d9ceb642624", "c77ea382-cbee-42b8-96bd-397b77e8455f");
INSERT INTO Uploaded (userId, memeId) VALUES ("be4c0486-5a5d-4aea-b376-2a7738a6309a", "e813f8f4-98bc-4072-9e1a-cb3515162ce5");
INSERT INTO Uploaded (userId, memeId) VALUES ("75ea83fb-9c53-43cb-b744-2d9ceb642624", "32a0a290-20e9-42e1-941e-b9b4ca8f53eb");
INSERT INTO Uploaded (userId, memeId) VALUES ("e6c68659-2d37-48c8-a8d4-e501db398bc7", "1387e323-756b-48a4-bee7-511fdea14915");
INSERT INTO Uploaded (userId, memeId) VALUES ("f2cc3018-0344-48db-a337-7cc461e82a5b", "dd6c2407-0ac2-4d23-a6f9-8f1ecb5adfca");
INSERT INTO Uploaded (userId, memeId) VALUES ("72a66861-0732-43aa-8b0f-587d74e54441", "bd634a0a-3000-47ab-b054-b0a949e78bbf");
INSERT INTO Uploaded (userId, memeId) VALUES ("31328fa4-64a4-4a08-a256-9fd7870f61cf", "f63aaa52-568c-45b8-841d-94c6567b1f78");
INSERT INTO Uploaded (userId, memeId) VALUES ("be4c0486-5a5d-4aea-b376-2a7738a6309a", "2d531465-2d92-4a2c-b333-bb00b5cecde6");
INSERT INTO Uploaded (userId, memeId) VALUES ("a9acd7b4-5a31-4f18-95ca-a8e844d2c1a5", "6d677865-1bb1-4f4c-bfd0-0964282a2381");
INSERT INTO Uploaded (userId, memeId) VALUES ("ecfaab46-f5de-4fef-a82f-158278f94b56", "13399ded-6671-41ee-9c6c-62a5edf835d1");
INSERT INTO Uploaded (userId, memeId) VALUES ("5f6192f5-0e5c-4172-b933-a77ff18a4d16", "4331dcc1-618d-4b7d-be49-6c7bc320ee34");
INSERT INTO Uploaded (userId, memeId) VALUES ("2aca6c5f-bf0a-4ef1-81c5-4c9dea28a541", "670d6e22-dded-4d3e-abf6-8edce8abb3dc");
INSERT INTO Uploaded (userId, memeId) VALUES ("a2a510b5-3aaf-4dab-864e-7248b7477826", "15aa4a6c-df90-4e23-b63a-8c74ee6383fd");
INSERT INTO Uploaded (userId, memeId) VALUES ("5ea8b618-6704-4d84-9cb4-f4a6438627ac", "27b250c5-d22f-4b86-98d8-b20ebad34138");
INSERT INTO Uploaded (userId, memeId) VALUES ("6360364d-e454-42e5-8a68-8b6fce893604", "7c4756b4-e8e6-4751-ac11-8eb6480f9c68");
INSERT INTO Uploaded (userId, memeId) VALUES ("be4c0486-5a5d-4aea-b376-2a7738a6309a", "4386adda-eca1-4268-af6a-47c6fc2d4a7d");
INSERT INTO Uploaded (userId, memeId) VALUES ("ac756b0b-f257-4cc6-80fa-b89b2da5587e", "c30e565d-3c01-4854-bd39-ef486c58f7f6");
INSERT INTO Uploaded (userId, memeId) VALUES ("7a65b48a-80b1-45d1-bb81-52cf65e44396", "be31055a-19bf-4b69-98a2-03871a529b7c");
INSERT INTO Uploaded (userId, memeId) VALUES ("219e9bd6-563d-437e-bb50-0e89f725a0a1", "b5987c7b-f1eb-43a0-a343-af7567f0ba3d");
INSERT INTO Uploaded (userId, memeId) VALUES ("1199f03a-57c1-4b15-b98c-9ca5ae89694d", "9956e984-1a08-45dc-8ba5-0e714c8e0a4c");
INSERT INTO Uploaded (userId, memeId) VALUES ("7a65b48a-80b1-45d1-bb81-52cf65e44396", "d38920e2-8185-4efc-833d-cf9faea63f94");
INSERT INTO Uploaded (userId, memeId) VALUES ("5f6192f5-0e5c-4172-b933-a77ff18a4d16", "38d24caf-84bf-4319-965a-47649c595f94");
INSERT INTO Uploaded (userId, memeId) VALUES ("eb827a72-427d-42a3-97f3-e606f66982d7", "e75ba89e-68ff-444e-9ce7-bd11d7d726a9");
INSERT INTO Uploaded (userId, memeId) VALUES ("27bafcc6-8040-4992-a66b-e4edf039a1f6", "ef6e9d53-25ad-4ca5-bc53-1b526bfca0aa");
INSERT INTO Uploaded (userId, memeId) VALUES ("1efe6717-b2c4-4ac2-94ea-2f5c0a794fa4", "90c2eb73-476b-43f6-990d-29eb0d4c1ca1");
INSERT INTO Uploaded (userId, memeId) VALUES ("c6c8639c-6878-4999-80fc-c8b1427426f1", "729b4dce-75ca-483d-b532-ce3f5a550917");
INSERT INTO Uploaded (userId, memeId) VALUES ("e70526df-3d92-48a1-afdb-09ffbcb68808", "929f8d33-9c84-4237-b6f0-70725739d35a");
INSERT INTO Uploaded (userId, memeId) VALUES ("f2cc3018-0344-48db-a337-7cc461e82a5b", "c39eac0d-3938-4a42-95d0-aaeab42cd64b");
INSERT INTO Uploaded (userId, memeId) VALUES ("126c9276-93b1-48f9-ac38-ed0aa82fc01c", "c9f2b97d-030c-4928-87d2-1360c4c55bbf");
INSERT INTO Uploaded (userId, memeId) VALUES ("e6c68659-2d37-48c8-a8d4-e501db398bc7", "fe11cd78-1cd3-43ee-addc-39bbab405c79");
INSERT INTO Uploaded (userId, memeId) VALUES ("d280bd1d-a3a1-4afb-8885-5b74c3137c19", "025b66e2-ef02-4965-bab2-d4cf631d00ff");
INSERT INTO Uploaded (userId, memeId) VALUES ("a58f19e0-3255-4292-b7e0-8da1292ab861", "455e6fca-3ebc-4db7-913a-a7eefff657d9");
INSERT INTO Uploaded (userId, memeId) VALUES ("d677511f-54b0-4071-9436-38c9e8bca2aa", "069d3225-0f22-4ff6-9825-2f20c3492e81");
INSERT INTO Uploaded (userId, memeId) VALUES ("2d4f5799-5432-4cfa-9473-141c2cd0a01b", "7109f5f6-5fc3-4aa1-a3cc-0f098a8f6f7e");
INSERT INTO Uploaded (userId, memeId) VALUES ("fb7eeed2-6274-404d-a3d1-dcded5d7aaa5", "741b0e46-350e-4d46-aec7-571dad3953b5");
INSERT INTO Uploaded (userId, memeId) VALUES ("5f6da10d-d573-4321-a2cc-474b47b3bcf3", "85d115de-c5b7-4ef2-9147-311c8bb3a34b");
INSERT INTO Uploaded (userId, memeId) VALUES ("20cef249-6c91-4624-9e46-628f0b72e697", "832c0bf5-f02c-40de-baf5-0a7ef1a24339");
INSERT INTO Uploaded (userId, memeId) VALUES ("e6c68659-2d37-48c8-a8d4-e501db398bc7", "0199487c-2c49-4202-a69f-a084a2308a78");
INSERT INTO Uploaded (userId, memeId) VALUES ("1197021e-c6b9-4e5b-b95e-682b8f37ebea", "01ccca1c-4714-4731-bd9b-f1d229af7884");
INSERT INTO Uploaded (userId, memeId) VALUES ("e5035a27-5831-4cef-aff6-86c1a7bf8825", "a3072a70-ad6a-4085-97b6-ead00307de98");
INSERT INTO Uploaded (userId, memeId) VALUES ("9d0b966d-0dec-45e4-ae64-7319d4f73b80", "effc5076-42ff-4ac1-9e4d-caef33d27afd");
INSERT INTO Uploaded (userId, memeId) VALUES ("6360364d-e454-42e5-8a68-8b6fce893604", "3321652e-ac0c-4cca-8307-2ba850013ead");
INSERT INTO Uploaded (userId, memeId) VALUES ("ee55eb63-98df-49fb-b464-440603a56c3f", "e7c7a786-a9fb-4801-972e-1511d66b2a49");
INSERT INTO Uploaded (userId, memeId) VALUES ("27bafcc6-8040-4992-a66b-e4edf039a1f6", "f21d4a55-ac8b-4d03-9051-4b780c3492ba");
INSERT INTO Uploaded (userId, memeId) VALUES ("ac756b0b-f257-4cc6-80fa-b89b2da5587e", "b7da8f00-ad07-4a5f-8459-72ca55574bc0");
INSERT INTO Uploaded (userId, memeId) VALUES ("eb827a72-427d-42a3-97f3-e606f66982d7", "b752aee2-bb24-4f92-a227-c9deb2e3b8c1");
INSERT INTO Uploaded (userId, memeId) VALUES ("a0a2a26b-80a2-4af0-b0d0-318d0f37ad3f", "d6ce97a6-110e-4199-81ec-f53c4aef9c65");
INSERT INTO Uploaded (userId, memeId) VALUES ("2aca6c5f-bf0a-4ef1-81c5-4c9dea28a541", "b8d879fc-db51-4296-86b9-344811057c34");
INSERT INTO Uploaded (userId, memeId) VALUES ("93812d24-add1-451a-aea1-dd9b0aa23ffe", "e6c4064f-39bb-4c7c-9f0b-76f5b90f4fbe");
INSERT INTO Uploaded (userId, memeId) VALUES ("54bf967f-f476-4934-93b2-b04ba641afda", "a31ada11-0fc2-4651-bef2-874be2b71bf7");
INSERT INTO Uploaded (userId, memeId) VALUES ("a9acd7b4-5a31-4f18-95ca-a8e844d2c1a5", "138bc407-81de-4ef9-b686-a29520273efb");
INSERT INTO Uploaded (userId, memeId) VALUES ("eb827a72-427d-42a3-97f3-e606f66982d7", "fdf31c43-89b3-4274-a2ca-09f12d85f4e7");
INSERT INTO Uploaded (userId, memeId) VALUES ("31328fa4-64a4-4a08-a256-9fd7870f61cf", "7daa29e0-0c67-4e1e-b370-e498b2f8dbcf");
INSERT INTO Uploaded (userId, memeId) VALUES ("d138fb78-6839-47ae-9f0d-47d01e71b1ab", "f910432c-6bbc-4a7b-a2d9-f469c0a2801e");
INSERT INTO Uploaded (userId, memeId) VALUES ("6360364d-e454-42e5-8a68-8b6fce893604", "4773faef-f21f-4ca4-ac5e-963f4651db97");
INSERT INTO Uploaded (userId, memeId) VALUES ("ee55eb63-98df-49fb-b464-440603a56c3f", "dd94c7d8-86d8-4305-81f1-c818d21e2db7");
INSERT INTO Uploaded (userId, memeId) VALUES ("d138fb78-6839-47ae-9f0d-47d01e71b1ab", "4bbb19c6-9c08-4905-98da-7d537b3120ab");
INSERT INTO Uploaded (userId, memeId) VALUES ("955b335e-f4e0-4d23-84fb-afa35efdf26b", "7f63d060-71a3-499b-8e8c-f8c3478c64b3");
INSERT INTO Uploaded (userId, memeId) VALUES ("5f6da10d-d573-4321-a2cc-474b47b3bcf3", "5525f398-f339-476d-b9b1-0ef634dc1f5f");
INSERT INTO Uploaded (userId, memeId) VALUES ("fb7eeed2-6274-404d-a3d1-dcded5d7aaa5", "e67dc528-ffb6-499e-950e-c3185183590a");
INSERT INTO Uploaded (userId, memeId) VALUES ("795d5e32-c1c2-475f-bb56-2210ee3285a1", "5e84a969-2c37-47ad-8686-397a75e54a46");
INSERT INTO Uploaded (userId, memeId) VALUES ("f9fab523-c67d-4752-8fb8-be1f0a5e254f", "a09a4df4-6c83-4609-bc72-16a90cf932a3");
INSERT INTO Uploaded (userId, memeId) VALUES ("72d0d686-b371-4674-a8d7-203027e8d176", "0955dcbd-14af-409b-afbb-c3e60e0a7678");
INSERT INTO Uploaded (userId, memeId) VALUES ("f902ccc8-5738-4dbf-81fc-7da213b153ef", "2219db45-efa1-41ef-a0d3-f3b050ecb5b3");
INSERT INTO Uploaded (userId, memeId) VALUES ("244d3c4e-e780-4c76-b1ea-d108ec4639f7", "2b60d9d9-2826-472f-a479-c27edd954231");
INSERT INTO Uploaded (userId, memeId) VALUES ("816f81ea-5684-4c6b-8ae2-ae2d6ef3d72f", "d72ac365-7046-4c94-960a-5985c388f1b3");
INSERT INTO Uploaded (userId, memeId) VALUES ("cd20ea0e-bc69-4f8c-9483-69cec2883cb1", "8a15ea36-7c2d-42ac-945a-b4a5c05439a8");
INSERT INTO Uploaded (userId, memeId) VALUES ("8d68c8f6-4fb8-42c0-a509-ba901515b4dd", "6185ac35-209d-46b2-9221-0e584a914c97");
INSERT INTO Uploaded (userId, memeId) VALUES ("1eaad232-6065-4c18-a4ea-5fd5ec82a8d4", "be6a4b1a-c429-4c30-bfed-842fa868f123");
INSERT INTO Uploaded (userId, memeId) VALUES ("244d3c4e-e780-4c76-b1ea-d108ec4639f7", "9387c58c-1184-4e25-a1b8-b9cfd14f2b3c");
INSERT INTO Uploaded (userId, memeId) VALUES ("e131fd57-1b6e-45e1-a055-29e64d7f480a", "d935b5a1-a481-475e-91b7-4c81407ac184");
INSERT INTO Uploaded (userId, memeId) VALUES ("c38a6fee-35c7-4302-bdb4-b12747a26597", "a1e7c8bb-2431-4adf-8fc3-a452b5bbb173");
INSERT INTO Uploaded (userId, memeId) VALUES ("f902ccc8-5738-4dbf-81fc-7da213b153ef", "d7bd64ac-25d8-49dd-9842-2dbe1a6d7619");
INSERT INTO Uploaded (userId, memeId) VALUES ("cd20ea0e-bc69-4f8c-9483-69cec2883cb1", "21711025-f16a-492d-b3b5-b8d1c36047d6");
INSERT INTO Uploaded (userId, memeId) VALUES ("e0814f9e-7ae2-4f9c-8728-f530ea6da7a1", "98dc5415-7129-43e0-9d27-70724bd5fd8e");
INSERT INTO Uploaded (userId, memeId) VALUES ("c6c8639c-6878-4999-80fc-c8b1427426f1", "89017ccb-d907-4dc0-a502-068444d5d3fa");
INSERT INTO Uploaded (userId, memeId) VALUES ("a0a2a26b-80a2-4af0-b0d0-318d0f37ad3f", "f45791cb-c43e-425b-9b74-1934de3cd96a");
INSERT INTO Uploaded (userId, memeId) VALUES ("b4bd37c8-30f3-41ff-ac2c-89636a1ebb27", "12319d13-f295-4571-aa58-2c57ac24ca68");
INSERT INTO Uploaded (userId, memeId) VALUES ("43c5152e-d2bc-4ce2-9f10-818f36ef138f", "ef6b9ec7-c267-4550-8158-c8dc0c60b99a");
INSERT INTO Uploaded (userId, memeId) VALUES ("c6c8639c-6878-4999-80fc-c8b1427426f1", "aef9758e-72a4-40c3-8906-46c505ee7641");
INSERT INTO Uploaded (userId, memeId) VALUES ("75200099-1e3f-47ea-a31d-d4d5da85cd61", "d223a84b-ac04-4925-a97e-ccd3b6b54f2e");
INSERT INTO Uploaded (userId, memeId) VALUES ("ead07ca8-d7c8-41ba-a65f-b814e92960a0", "3607e9bc-c9a4-4502-850c-41f9c4b1db78");
INSERT INTO Uploaded (userId, memeId) VALUES ("7a65b48a-80b1-45d1-bb81-52cf65e44396", "28d623fa-256f-46d0-9865-397fb2fecf26");
INSERT INTO Uploaded (userId, memeId) VALUES ("89315b4f-ee33-4ba3-9487-ce95c5ca3b27", "3a4d8e8e-0934-4614-bff3-b7b83b874883");
INSERT INTO Uploaded (userId, memeId) VALUES ("058c9b2e-9085-47dc-be74-36c2de9cfb6c", "be72061e-dd27-420c-ba8d-be3b00f0ef50");
INSERT INTO Uploaded (userId, memeId) VALUES ("e5035a27-5831-4cef-aff6-86c1a7bf8825", "f8d265db-d705-424f-aad3-40b454926523");
INSERT INTO Uploaded (userId, memeId) VALUES ("7f422a4c-a7ad-4d05-a98a-218d668b7510", "32ab3da7-74d9-4c78-a47a-c0e647cab238");
INSERT INTO Uploaded (userId, memeId) VALUES ("1eaad232-6065-4c18-a4ea-5fd5ec82a8d4", "6bec2e6d-923d-4949-8fb9-40c5a6fae4e4");
INSERT INTO Uploaded (userId, memeId) VALUES ("f9fab523-c67d-4752-8fb8-be1f0a5e254f", "575c2d32-9d69-4475-8b32-d3a39fe902cc");
INSERT INTO Uploaded (userId, memeId) VALUES ("b9d2a33a-613e-433d-afd4-ce6329ccafa0", "cc0da109-cdd9-4e13-b59d-dae018ef52af");
INSERT INTO Uploaded (userId, memeId) VALUES ("f2cc3018-0344-48db-a337-7cc461e82a5b", "b7c36656-3d34-465b-8a92-5fb3b70f4bac");
INSERT INTO Uploaded (userId, memeId) VALUES ("2bc4ff9d-5fa2-435b-8028-81e224938dd2", "a000c556-1977-441e-97eb-8bbe3b5cb971");
INSERT INTO Uploaded (userId, memeId) VALUES ("75200099-1e3f-47ea-a31d-d4d5da85cd61", "f7a20c7a-dd08-4859-811b-33254b880484");
INSERT INTO Uploaded (userId, memeId) VALUES ("5f6da10d-d573-4321-a2cc-474b47b3bcf3", "aea7c415-2ada-4427-804d-dda892f8fb35");
INSERT INTO Uploaded (userId, memeId) VALUES ("3dd38bce-4ba4-4d1a-9e59-a8b507c8bc49", "57172965-26a7-400b-bfd5-7f9d27a13da5");
INSERT INTO Uploaded (userId, memeId) VALUES ("17b1e88b-6c42-462c-8a78-e69be166a70a", "ee3eb93f-a0a7-4c31-9e0e-38782dda4f69");
INSERT INTO Uploaded (userId, memeId) VALUES ("1199f03a-57c1-4b15-b98c-9ca5ae89694d", "a890498d-92a2-40a3-aac9-3e356d1827a1");
INSERT INTO Uploaded (userId, memeId) VALUES ("2d4f5799-5432-4cfa-9473-141c2cd0a01b", "c7dafa03-6aba-4ed9-afc4-3d6084ed33cf");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("b263e67d-55e4-41e6-851f-f68a77ca7ede", "5f6da10d-d573-4321-a2cc-474b47b3bcf3", "b8d879fc-db51-4296-86b9-344811057c34", "2018-08-29", "Ut voluptatem modi labore ut ut.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("31b7883b-b398-4d53-b7ff-f5d204e37894", "05700b90-90a8-4b54-bdbe-a9ddfa354a5d", "e6c4064f-39bb-4c7c-9f0b-76f5b90f4fbe", "2017-08-05", "Consectetur ipsum amet est.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("92eb0705-dc6f-45a1-a3e1-c2e195315c29", "955b335e-f4e0-4d23-84fb-afa35efdf26b", "5e84a969-2c37-47ad-8686-397a75e54a46", "2017-12-21", "Sit ut amet ipsum amet.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("89ce73f6-f41e-4313-a668-872c9ce34fb5", "e0814f9e-7ae2-4f9c-8728-f530ea6da7a1", "5e84a969-2c37-47ad-8686-397a75e54a46", "2016-09-22", "Ut quaerat quisquam velit dolore amet numquam.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("fe9e0403-04dd-48e6-977e-7d930b534cdd", "5c281687-851d-4a33-9083-9e590d916c74", "4773faef-f21f-4ca4-ac5e-963f4651db97", "2016-07-30", "Eius dolor adipisci quaerat.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("4ecd295e-2ff4-4fe8-90f7-674750aec090", "93812d24-add1-451a-aea1-dd9b0aa23ffe", "fe11cd78-1cd3-43ee-addc-39bbab405c79", "2018-05-12", "Dolorem dolor ut porro magnam.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("4477c821-c041-48f7-97a6-41e0ec6b5e6c", "14f2cf35-3fd7-40dd-aa38-5204730258ae", "3ed32cd9-e074-48de-b47e-fefda7f9a206", "2019-02-08", "Dolore quiquia voluptatem aliquam quaerat.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("e7012588-5bdf-46c3-b550-737110d16c57", "d138fb78-6839-47ae-9f0d-47d01e71b1ab", "7daa29e0-0c67-4e1e-b370-e498b2f8dbcf", "2018-08-14", "Ipsum modi porro neque ipsum.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("e7fa5f51-3ac9-45fd-a5eb-2294da500613", "0db8a938-a058-4bde-830d-8fa73785b32b", "6bec2e6d-923d-4949-8fb9-40c5a6fae4e4", "2018-06-12", "Sit sed ipsum magnam amet.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("55fffa63-95fc-4862-8460-6b99eed11b43", "8dee5976-61fd-4958-bf8c-10770c6e2218", "f910432c-6bbc-4a7b-a2d9-f469c0a2801e", "2018-01-12", "Quisquam dolorem consectetur voluptatem est non etincidunt dolor.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("5a84013d-7e61-4849-a21f-10e7137159df", "be4c0486-5a5d-4aea-b376-2a7738a6309a", "d223a84b-ac04-4925-a97e-ccd3b6b54f2e", "2018-07-04", "Dolore dolore eius modi.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("047d0484-6e58-4575-9ce0-6aca335dac0c", "244d3c4e-e780-4c76-b1ea-d108ec4639f7", "12319d13-f295-4571-aa58-2c57ac24ca68", "2017-01-17", "Magnam labore amet velit voluptatem sit consectetur neque.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("eef1438f-e5b5-4be1-a411-8cc5b224c826", "816f81ea-5684-4c6b-8ae2-ae2d6ef3d72f", "c77ea382-cbee-42b8-96bd-397b77e8455f", "2018-01-25", "Neque ipsum quiquia consectetur.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("1917f31a-162d-4ba6-8461-0cfb6ed4e6bd", "533cfdf4-1270-4e08-87de-193dcc00d7b3", "8a15ea36-7c2d-42ac-945a-b4a5c05439a8", "2017-09-25", "Dolore sit labore ipsum.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("664fe37c-3ac0-497d-9910-60947db7cac4", "1199f03a-57c1-4b15-b98c-9ca5ae89694d", "6d677865-1bb1-4f4c-bfd0-0964282a2381", "2019-04-03", "Dolor non etincidunt magnam labore sit magnam ut.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("b68fd81e-34e3-4263-a57e-5aeac1b94c58", "a9457ca5-cbc4-4116-9634-a1dc25ebe026", "b8d879fc-db51-4296-86b9-344811057c34", "2018-09-24", "Neque quaerat velit dolore tempora neque.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("e6fdf41c-9202-4f0e-b414-66aefeb8a011", "1eaad232-6065-4c18-a4ea-5fd5ec82a8d4", "0199487c-2c49-4202-a69f-a084a2308a78", "2018-06-24", "Velit quaerat neque ut sit velit.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("a73aed23-c7d2-4be6-9663-dd0eef96aa32", "533cfdf4-1270-4e08-87de-193dcc00d7b3", "069d3225-0f22-4ff6-9825-2f20c3492e81", "2016-08-07", "Dolorem voluptatem velit quiquia eius.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("4364459f-2ba9-470e-bb6b-7ab875ec7e5d", "07fbea7f-6116-4992-800b-fa25c09533f3", "4773faef-f21f-4ca4-ac5e-963f4651db97", "2017-12-12", "Velit sit adipisci dolor dolore amet.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("3eda29b0-a84b-4ad7-abe9-7884182afa9d", "5c281687-851d-4a33-9083-9e590d916c74", "7daa29e0-0c67-4e1e-b370-e498b2f8dbcf", "2019-02-21", "Ipsum consectetur ut modi dolore.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("403c0366-7197-456f-8639-49b7c19fa641", "219e9bd6-563d-437e-bb50-0e89f725a0a1", "b8d879fc-db51-4296-86b9-344811057c34", "2018-12-12", "Tempora sit dolore adipisci dolorem ipsum neque magnam.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("59948a55-5a85-4d39-9e08-531a11facf0c", "0db8a938-a058-4bde-830d-8fa73785b32b", "32ab3da7-74d9-4c78-a47a-c0e647cab238", "2016-09-09", "Dolore non voluptatem amet eius dolorem labore voluptatem.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("76440987-339e-4c5f-b778-a45325b83770", "5f6192f5-0e5c-4172-b933-a77ff18a4d16", "5e84a969-2c37-47ad-8686-397a75e54a46", "2018-11-11", "Velit dolorem quiquia velit ipsum quiquia.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("936d4bd3-286f-478d-ada9-168edcb02601", "c6c8639c-6878-4999-80fc-c8b1427426f1", "f910432c-6bbc-4a7b-a2d9-f469c0a2801e", "2018-04-08", "Amet velit quaerat labore ut velit.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("d1a9fef9-7d46-4fa3-b808-611a80fa0166", "533cfdf4-1270-4e08-87de-193dcc00d7b3", "12319d13-f295-4571-aa58-2c57ac24ca68", "2018-08-18", "Quiquia velit ut velit ut voluptatem voluptatem.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("1cb790a1-7cc9-4c62-af3b-c4e37349987a", "27bafcc6-8040-4992-a66b-e4edf039a1f6", "ef6b9ec7-c267-4550-8158-c8dc0c60b99a", "2018-09-08", "Numquam quisquam sit quisquam numquam.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("f2f9cb3c-9acb-4ad0-b0a3-474ddd7a6d2d", "fb7eeed2-6274-404d-a3d1-dcded5d7aaa5", "90c2eb73-476b-43f6-990d-29eb0d4c1ca1", "2016-11-04", "Aliquam etincidunt numquam magnam aliquam modi.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("9962fad5-3d6e-425b-85ac-b830a562c9e3", "fb7eeed2-6274-404d-a3d1-dcded5d7aaa5", "12319d13-f295-4571-aa58-2c57ac24ca68", "2019-04-10", "Dolorem voluptatem adipisci sed magnam eius tempora.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("f72a2e59-384a-4daf-82a8-06d77830a26d", "a0a2a26b-80a2-4af0-b0d0-318d0f37ad3f", "5e84a969-2c37-47ad-8686-397a75e54a46", "2017-05-18", "Ipsum dolorem porro sit labore neque sed neque.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("9acaeafc-68d8-406a-a8f1-3fd27387703d", "c6c8639c-6878-4999-80fc-c8b1427426f1", "dd6c2407-0ac2-4d23-a6f9-8f1ecb5adfca", "2019-02-28", "Tempora numquam quiquia voluptatem ipsum dolor.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("edee949a-3076-42f2-89bf-3725171284b2", "c1db7398-c2f8-45fa-9f84-831a5dc12724", "741b0e46-350e-4d46-aec7-571dad3953b5", "2018-11-26", "Voluptatem numquam neque amet.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("920b5405-4be1-460e-bdc9-46d491b5b3b8", "32523a02-1f54-4d02-a041-1979ef57bb6c", "c39eac0d-3938-4a42-95d0-aaeab42cd64b", "2017-07-02", "Dolore porro quisquam non quisquam porro consectetur.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("1f73d1d2-8c3b-4dbf-864c-b32392a49c37", "e131fd57-1b6e-45e1-a055-29e64d7f480a", "b7c36656-3d34-465b-8a92-5fb3b70f4bac", "2018-12-18", "Etincidunt eius velit aliquam velit tempora sit sed.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("29e375dd-5943-40cc-9fe4-4fd22ba56e95", "89315b4f-ee33-4ba3-9487-ce95c5ca3b27", "5e84a969-2c37-47ad-8686-397a75e54a46", "2016-11-26", "Ut velit neque dolore sit sit dolor dolore.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("c6bdb28d-bb4f-4a18-8c35-224ff2d9cccc", "ee55eb63-98df-49fb-b464-440603a56c3f", "138bc407-81de-4ef9-b686-a29520273efb", "2017-03-03", "Consectetur quiquia quiquia consectetur porro.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("e9b8719f-6d5e-47ef-842e-4938ebc2846b", "955b335e-f4e0-4d23-84fb-afa35efdf26b", "21711025-f16a-492d-b3b5-b8d1c36047d6", "2018-07-19", "Sed quiquia amet voluptatem modi amet modi dolorem.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("e2f1e94c-4db7-4fd6-8919-bde2752f113f", "40fa085b-bb2b-447f-b2de-5b7b18d2c721", "0199487c-2c49-4202-a69f-a084a2308a78", "2017-10-19", "Porro labore aliquam dolor labore consectetur dolor.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("d4076975-e9e8-470e-9698-08c3ebaa7d6b", "058c9b2e-9085-47dc-be74-36c2de9cfb6c", "21711025-f16a-492d-b3b5-b8d1c36047d6", "2017-10-22", "Consectetur ipsum quisquam amet quisquam etincidunt eius.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("1703124b-8845-4670-9600-9f6ae8ca33cc", "39c8b1b7-c5e9-4bb9-9405-7c9aca045c72", "575c2d32-9d69-4475-8b32-d3a39fe902cc", "2016-11-28", "Amet tempora dolore est eius.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("97b760ec-6d6e-4040-8543-a4c355df2e57", "07fbea7f-6116-4992-800b-fa25c09533f3", "7109f5f6-5fc3-4aa1-a3cc-0f098a8f6f7e", "2017-08-25", "Dolorem quisquam tempora non quiquia.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("853c16c3-f7f4-4ac6-8409-4cff2b571537", "219e9bd6-563d-437e-bb50-0e89f725a0a1", "069d3225-0f22-4ff6-9825-2f20c3492e81", "2016-09-07", "Sit aliquam quisquam porro sit quisquam porro dolor.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("c06e422b-e008-4fb9-b5ce-747f558539e0", "3b9d6cc7-e64c-4649-8893-96c234005558", "ef6b9ec7-c267-4550-8158-c8dc0c60b99a", "2018-07-12", "Eius neque quaerat porro quisquam.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("643e4b22-4d2e-473d-8b34-c9c91d4b689c", "e0814f9e-7ae2-4f9c-8728-f530ea6da7a1", "4bbb19c6-9c08-4905-98da-7d537b3120ab", "2017-01-05", "Eius adipisci porro labore neque.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("251e7a4a-7620-4070-855d-c1c4077cd638", "ecfaab46-f5de-4fef-a82f-158278f94b56", "23bfbc77-01c9-4f75-b8cc-afff0c04dc31", "2016-07-16", "Est neque ut sed.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("33dd5423-283b-497d-959a-0729e7a70de3", "f902ccc8-5738-4dbf-81fc-7da213b153ef", "effc5076-42ff-4ac1-9e4d-caef33d27afd", "2017-09-29", "Tempora dolor porro porro quaerat non ipsum.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("831fddd9-d84d-487f-bcdb-c43ac56bb2b0", "14f2cf35-3fd7-40dd-aa38-5204730258ae", "8a15ea36-7c2d-42ac-945a-b4a5c05439a8", "2017-01-22", "Amet quiquia ipsum numquam.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("215ffdc8-b5b8-45b3-a0d0-1e249c90e24f", "533cfdf4-1270-4e08-87de-193dcc00d7b3", "13399ded-6671-41ee-9c6c-62a5edf835d1", "2017-09-12", "Neque modi sit numquam sed numquam.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("3541d925-50b9-4ced-a040-2c335905bbd9", "f9fab523-c67d-4752-8fb8-be1f0a5e254f", "b7da8f00-ad07-4a5f-8459-72ca55574bc0", "2018-05-22", "Adipisci neque porro velit dolorem.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("b59f6330-57c1-40ff-ae58-7c518311feea", "7a65b48a-80b1-45d1-bb81-52cf65e44396", "1387e323-756b-48a4-bee7-511fdea14915", "2018-04-10", "Consectetur sed eius quaerat dolore modi.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("952d8244-268f-4799-816d-a46ad138666c", "05700b90-90a8-4b54-bdbe-a9ddfa354a5d", "32ab3da7-74d9-4c78-a47a-c0e647cab238", "2017-06-26", "Numquam voluptatem modi ipsum quisquam non.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("73843a4c-2416-4775-97f9-e511b6c07379", "31328fa4-64a4-4a08-a256-9fd7870f61cf", "e75ba89e-68ff-444e-9ce7-bd11d7d726a9", "2018-03-29", "Consectetur ut dolorem consectetur aliquam ut est amet.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("e30fd6fb-b481-48a9-a662-b53b805c8760", "07fbea7f-6116-4992-800b-fa25c09533f3", "57172965-26a7-400b-bfd5-7f9d27a13da5", "2017-04-11", "Adipisci magnam labore tempora porro.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("54c7d097-1122-4904-be41-1ae28761035b", "f69b3aaa-e105-4fb2-b253-8cc977bd15a8", "28d623fa-256f-46d0-9865-397fb2fecf26", "2017-08-04", "Sed est etincidunt consectetur quisquam.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("4582ebda-1e80-4a78-8bd3-70bd246e7340", "795d5e32-c1c2-475f-bb56-2210ee3285a1", "4331dcc1-618d-4b7d-be49-6c7bc320ee34", "2018-01-05", "Dolor non dolorem quiquia consectetur voluptatem amet.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("a6a99709-8634-4c33-9bc2-8d45e45ce0c6", "ac756b0b-f257-4cc6-80fa-b89b2da5587e", "32ab3da7-74d9-4c78-a47a-c0e647cab238", "2017-01-18", "Est dolor dolor dolore.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("5ce84702-2a6f-43a3-b962-f641fc739186", "b9d2a33a-613e-433d-afd4-ce6329ccafa0", "e75ba89e-68ff-444e-9ce7-bd11d7d726a9", "2018-10-20", "Quaerat sed neque sit.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("72c3323f-ddd8-4e2c-8b83-ada3ca0ebd80", "1197021e-c6b9-4e5b-b95e-682b8f37ebea", "d223a84b-ac04-4925-a97e-ccd3b6b54f2e", "2018-04-13", "Tempora aliquam sit consectetur voluptatem porro non.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("a17de399-ae79-4dd3-833d-9bf7db1d3ede", "ecfaab46-f5de-4fef-a82f-158278f94b56", "670d6e22-dded-4d3e-abf6-8edce8abb3dc", "2019-03-16", "Quisquam velit quiquia sed amet quisquam ipsum.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("ee6eb070-123a-4ca1-b673-0943cb3be2f5", "e5035a27-5831-4cef-aff6-86c1a7bf8825", "dd94c7d8-86d8-4305-81f1-c818d21e2db7", "2017-03-12", "Dolorem est tempora ut ut velit sit.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("738f2950-68d7-4ae3-bc6d-ac8cf246d858", "5f6da10d-d573-4321-a2cc-474b47b3bcf3", "3607e9bc-c9a4-4502-850c-41f9c4b1db78", "2017-08-05", "Eius quiquia modi sit labore tempora etincidunt amet.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("0d270ac0-4262-4af3-b5be-d19bf4b14f7d", "a9457ca5-cbc4-4116-9634-a1dc25ebe026", "effc5076-42ff-4ac1-9e4d-caef33d27afd", "2016-11-05", "Dolor dolore amet dolor sit dolorem velit.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("bab4afd0-73eb-4fb0-ba45-acbf2affc0a3", "955b335e-f4e0-4d23-84fb-afa35efdf26b", "b7da8f00-ad07-4a5f-8459-72ca55574bc0", "2019-01-25", "Sed est eius dolorem dolor quiquia.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("1fb44467-1dd6-4a8f-814b-a918295e43ee", "a9acd7b4-5a31-4f18-95ca-a8e844d2c1a5", "3a4d8e8e-0934-4614-bff3-b7b83b874883", "2019-03-17", "Dolore ipsum quiquia est tempora dolor.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("27ff8cb1-b280-4327-a629-3fba783649cb", "ecfaab46-f5de-4fef-a82f-158278f94b56", "7c4756b4-e8e6-4751-ac11-8eb6480f9c68", "2017-10-07", "Labore neque velit neque ipsum adipisci.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("f94effa6-5166-4f8f-af62-ca1e81b821c5", "d677511f-54b0-4071-9436-38c9e8bca2aa", "aea7c415-2ada-4427-804d-dda892f8fb35", "2018-01-11", "Est labore adipisci porro magnam magnam.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("bc0cf3fb-6711-4997-a9a7-3e82841d770d", "be4c0486-5a5d-4aea-b376-2a7738a6309a", "89017ccb-d907-4dc0-a502-068444d5d3fa", "2018-11-24", "Dolor sit sit dolor.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("0f23a0d2-f1d8-4efb-8984-8636847fb030", "606e5ff3-055e-4736-b3e7-3971234bb8de", "e813f8f4-98bc-4072-9e1a-cb3515162ce5", "2019-03-01", "Porro neque dolorem non consectetur.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("e7463189-912e-4dc9-8898-4429b75ee313", "3c940944-35b2-4afb-955e-3f3156a36b6e", "f910432c-6bbc-4a7b-a2d9-f469c0a2801e", "2017-04-06", "Ipsum consectetur aliquam dolorem.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("fb189708-b955-450d-886f-220bbbcc4450", "b9d2a33a-613e-433d-afd4-ce6329ccafa0", "7daa29e0-0c67-4e1e-b370-e498b2f8dbcf", "2017-02-07", "Eius modi magnam ipsum neque quiquia magnam dolore.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("5fb27642-9234-4c4c-a869-dc76600e24b0", "ecfaab46-f5de-4fef-a82f-158278f94b56", "9956e984-1a08-45dc-8ba5-0e714c8e0a4c", "2017-10-05", "Tempora quaerat quiquia dolore consectetur numquam.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("c54fbb81-ef80-4c57-92c8-71fef25ef31e", "270935e7-177d-47e6-ab5e-9badcd11138b", "f45791cb-c43e-425b-9b74-1934de3cd96a", "2017-10-11", "Labore quisquam dolor porro voluptatem numquam modi.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("6b7f215a-fee3-4e32-8193-edfad4b4a136", "7a65b48a-80b1-45d1-bb81-52cf65e44396", "aea7c415-2ada-4427-804d-dda892f8fb35", "2017-03-22", "Ut quiquia magnam velit.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("35a47a2f-6dd5-4439-8fc8-d221cef7f869", "f2cc3018-0344-48db-a337-7cc461e82a5b", "f8d265db-d705-424f-aad3-40b454926523", "2016-08-21", "Dolorem sed porro dolore sed dolorem consectetur.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("922c472d-96fb-4b1c-99ea-723200aa1c1c", "b9d2a33a-613e-433d-afd4-ce6329ccafa0", "6185ac35-209d-46b2-9221-0e584a914c97", "2018-03-24", "Adipisci magnam porro numquam ut dolorem quisquam.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("7f326e42-5fa9-464f-a655-b3a8374d3944", "5f6192f5-0e5c-4172-b933-a77ff18a4d16", "d6ce97a6-110e-4199-81ec-f53c4aef9c65", "2017-03-06", "Dolorem aliquam tempora porro eius modi dolore sed.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("c4ea6bd9-56f4-471f-9c27-17b2e87d7d85", "ee55eb63-98df-49fb-b464-440603a56c3f", "23bfbc77-01c9-4f75-b8cc-afff0c04dc31", "2019-02-25", "Voluptatem neque neque voluptatem.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("630d2021-a1a5-4f97-aebc-4fc2e013bdfe", "34837bc1-464c-410d-8dea-82668f3bd8c1", "c30e565d-3c01-4854-bd39-ef486c58f7f6", "2017-10-21", "Est eius velit quaerat aliquam dolorem numquam.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("23857b2c-ea39-4841-8547-1186f4c5ac9a", "a2a510b5-3aaf-4dab-864e-7248b7477826", "4331dcc1-618d-4b7d-be49-6c7bc320ee34", "2018-04-10", "Velit ipsum modi amet ut quiquia.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("fa0c99a1-11b4-4cae-932b-1da66060083d", "c1db7398-c2f8-45fa-9f84-831a5dc12724", "f45791cb-c43e-425b-9b74-1934de3cd96a", "2017-11-26", "Etincidunt dolor quaerat quaerat voluptatem eius.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("f4f33345-4918-4866-8d9a-7a6a4c08dbf6", "3c940944-35b2-4afb-955e-3f3156a36b6e", "b8d879fc-db51-4296-86b9-344811057c34", "2016-08-18", "Quiquia eius dolor tempora neque.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("aaac806f-3cd7-454d-9808-223621a13caa", "1199f03a-57c1-4b15-b98c-9ca5ae89694d", "cc0da109-cdd9-4e13-b59d-dae018ef52af", "2017-08-15", "Quisquam ipsum consectetur magnam aliquam velit neque.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("a3914c56-6e20-41ce-a5c4-2be263251e76", "40fa085b-bb2b-447f-b2de-5b7b18d2c721", "b752aee2-bb24-4f92-a227-c9deb2e3b8c1", "2018-08-25", "Ipsum dolorem magnam sed non.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("24ee89f5-5bae-422a-b0f0-85c5c98db9ff", "b9d2a33a-613e-433d-afd4-ce6329ccafa0", "a3072a70-ad6a-4085-97b6-ead00307de98", "2019-01-22", "Amet modi quiquia dolor ipsum numquam porro.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("73041083-f31d-4603-9884-20fa67b942d0", "0db8a938-a058-4bde-830d-8fa73785b32b", "f8d265db-d705-424f-aad3-40b454926523", "2016-07-30", "Quisquam numquam ut dolorem labore numquam sit consectetur.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("028e68cd-67e1-434f-bf6c-77d1c719a793", "d280bd1d-a3a1-4afb-8885-5b74c3137c19", "d6ce97a6-110e-4199-81ec-f53c4aef9c65", "2017-08-27", "Sit voluptatem etincidunt etincidunt tempora aliquam voluptatem adipisci.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("041fbee9-986c-418d-9b1b-69ae90d52cf0", "7a65b48a-80b1-45d1-bb81-52cf65e44396", "13399ded-6671-41ee-9c6c-62a5edf835d1", "2016-08-07", "Magnam labore consectetur non amet adipisci eius.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("ec9ab966-6240-4f36-844d-0408ec798664", "a58f19e0-3255-4292-b7e0-8da1292ab861", "e7c7a786-a9fb-4801-972e-1511d66b2a49", "2019-01-09", "Dolore porro amet labore sed dolor quiquia neque.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("f188bf83-a0e6-4a21-b975-d8d3004f8c4b", "270935e7-177d-47e6-ab5e-9badcd11138b", "85d115de-c5b7-4ef2-9147-311c8bb3a34b", "2017-04-02", "Numquam aliquam eius magnam ut dolore magnam.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("61aa5e5e-a4f1-4437-b00f-e63f5ec648f6", "32523a02-1f54-4d02-a041-1979ef57bb6c", "f63aaa52-568c-45b8-841d-94c6567b1f78", "2016-12-08", "Tempora ut labore velit adipisci sit.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("b7d92720-13f7-4d3c-82ce-e61a3595d367", "c750054e-f128-4766-b293-bae3d681dee1", "670d6e22-dded-4d3e-abf6-8edce8abb3dc", "2016-08-26", "Porro est ut amet neque.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("786ac105-f423-4a43-bbae-8684509304a6", "6360364d-e454-42e5-8a68-8b6fce893604", "a09a4df4-6c83-4609-bc72-16a90cf932a3", "2017-02-11", "Amet ut est velit sed.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("865cd181-b555-4792-a64d-fd660b16eb7f", "72d0d686-b371-4674-a8d7-203027e8d176", "85d115de-c5b7-4ef2-9147-311c8bb3a34b", "2017-05-11", "Ut magnam tempora neque.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("9509ba80-ebe8-4310-8d61-003a1e6a5def", "e70526df-3d92-48a1-afdb-09ffbcb68808", "b752aee2-bb24-4f92-a227-c9deb2e3b8c1", "2018-03-17", "Magnam labore sit consectetur neque est.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("0c10c2cc-64ba-4484-975d-f801a885abdc", "e70526df-3d92-48a1-afdb-09ffbcb68808", "a3072a70-ad6a-4085-97b6-ead00307de98", "2018-04-24", "Ipsum est ipsum numquam velit ut sed.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("8df32e39-4b66-45cb-a926-0391b27f9069", "9d0b966d-0dec-45e4-ae64-7319d4f73b80", "98dc5415-7129-43e0-9d27-70724bd5fd8e", "2016-12-21", "Sit magnam consectetur numquam magnam.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("b323ba94-4a43-45bf-9aae-2e5bff93d85a", "05700b90-90a8-4b54-bdbe-a9ddfa354a5d", "27b250c5-d22f-4b86-98d8-b20ebad34138", "2018-11-14", "Labore modi voluptatem amet modi etincidunt voluptatem aliquam.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("ee2184b5-3ad7-4829-a57c-fd9b395209d1", "c38a6fee-35c7-4302-bdb4-b12747a26597", "c7dafa03-6aba-4ed9-afc4-3d6084ed33cf", "2019-02-15", "Magnam etincidunt modi etincidunt sed dolore magnam.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("87893a8c-2b09-45ad-a294-acf86b49e48e", "244d3c4e-e780-4c76-b1ea-d108ec4639f7", "7c4756b4-e8e6-4751-ac11-8eb6480f9c68", "2019-01-03", "Quaerat numquam ipsum eius.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("458dc1db-8f4b-49ae-9446-d9b5f856a7d4", "6525e15c-9536-4d87-8ffd-0549931b73e8", "e813f8f4-98bc-4072-9e1a-cb3515162ce5", "2016-10-07", "Neque sed porro non ut.");
INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("29df46ef-f422-46a5-a49f-526bf1f11c07", "955b335e-f4e0-4d23-84fb-afa35efdf26b", "4773faef-f21f-4ca4-ac5e-963f4651db97", "2018-03-28", "Tempora sit quaerat sit.");
INSERT INTO Token (userId, token, expiredDate) VALUES ("1eaad232-6065-4c18-a4ea-5fd5ec82a8d4", "b167eee0-3820-48f4-9e31-ae70005eb84e", "2019-03-30");
INSERT INTO Token (userId, token, expiredDate) VALUES ("955b335e-f4e0-4d23-84fb-afa35efdf26b", "d011fcc2-fb8d-4117-96b0-4a17ae55aba7", "2019-03-28");
INSERT INTO Token (userId, token, expiredDate) VALUES ("54bf967f-f476-4934-93b2-b04ba641afda", "e61f1525-652a-4659-9e03-bc200f159d5a", "2019-03-13");
INSERT INTO Token (userId, token, expiredDate) VALUES ("e6c68659-2d37-48c8-a8d4-e501db398bc7", "23492aa0-ab6e-402d-9aaa-5af697334921", "2019-04-03");
INSERT INTO Token (userId, token, expiredDate) VALUES ("40fa085b-bb2b-447f-b2de-5b7b18d2c721", "a807060d-9ff8-4418-809c-bc8dbb0935ff", "2019-04-06");
INSERT INTO Token (userId, token, expiredDate) VALUES ("1199f03a-57c1-4b15-b98c-9ca5ae89694d", "068fa61c-c326-4917-9e91-61c551f97b76", "2019-03-20");
INSERT INTO Token (userId, token, expiredDate) VALUES ("b4bd37c8-30f3-41ff-ac2c-89636a1ebb27", "7616fa7d-94e4-4b97-8139-6ef19540df00", "2019-03-14");
INSERT INTO Token (userId, token, expiredDate) VALUES ("1197021e-c6b9-4e5b-b95e-682b8f37ebea", "829bf9e4-b2ef-4213-a8c1-ee0e50d074ed", "2019-04-10");
INSERT INTO Token (userId, token, expiredDate) VALUES ("cd20ea0e-bc69-4f8c-9483-69cec2883cb1", "01fa155f-cc38-4239-b0af-e36676319bd4", "2019-03-15");
INSERT INTO Token (userId, token, expiredDate) VALUES ("0db8a938-a058-4bde-830d-8fa73785b32b", "e9c616e4-9bd2-46c3-b4df-c5811c55c21c", "2019-04-01");
INSERT INTO Token (userId, token, expiredDate) VALUES ("3dd38bce-4ba4-4d1a-9e59-a8b507c8bc49", "7fa669ae-996e-4c9a-bd0c-550315b52887", "2019-04-10");
INSERT INTO Token (userId, token, expiredDate) VALUES ("533cfdf4-1270-4e08-87de-193dcc00d7b3", "878cae82-207c-403f-b4f5-3e231330c038", "2019-03-22");
INSERT INTO Token (userId, token, expiredDate) VALUES ("a9acd7b4-5a31-4f18-95ca-a8e844d2c1a5", "a1ba44c6-c134-4194-a32e-18bcbd2b556b", "2019-04-10");
INSERT INTO Token (userId, token, expiredDate) VALUES ("c6c8639c-6878-4999-80fc-c8b1427426f1", "860af753-1eb3-4e5f-b3a5-de256915f8a2", "2019-04-07");
INSERT INTO Token (userId, token, expiredDate) VALUES ("be4c0486-5a5d-4aea-b376-2a7738a6309a", "c8f36d53-9314-4db3-accd-60360f56f6de", "2019-03-29");
INSERT INTO Token (userId, token, expiredDate) VALUES ("8e02276c-48d6-4bed-a702-cffecb4187f6", "a2b6956a-4a1a-4280-9c74-f74c2f88669c", "2019-03-26");
INSERT INTO Token (userId, token, expiredDate) VALUES ("d088a774-522b-469a-9ca4-d51faae48948", "1499be1f-2511-4921-9e73-00d3691ad83d", "2019-03-29");
INSERT INTO Token (userId, token, expiredDate) VALUES ("e6c68659-2d37-48c8-a8d4-e501db398bc7", "04065bff-261d-4017-bfc1-cf6d2a8f98c1", "2019-03-24");
INSERT INTO Token (userId, token, expiredDate) VALUES ("c6c8639c-6878-4999-80fc-c8b1427426f1", "617f75a3-7c8e-45d3-99b1-cf20b57d0c81", "2019-03-30");
INSERT INTO Token (userId, token, expiredDate) VALUES ("ee55eb63-98df-49fb-b464-440603a56c3f", "817eb1f5-a6a0-486d-bfa1-73a0ba53c4f0", "2019-03-19");
INSERT INTO Token (userId, token, expiredDate) VALUES ("f69b3aaa-e105-4fb2-b253-8cc977bd15a8", "05ffc889-0243-4406-ba3f-7f8275a0b436", "2019-04-03");
INSERT INTO Token (userId, token, expiredDate) VALUES ("a0a2a26b-80a2-4af0-b0d0-318d0f37ad3f", "47653bd8-9c89-430b-92b9-cc4b1c387dab", "2019-04-04");
INSERT INTO Token (userId, token, expiredDate) VALUES ("20cef249-6c91-4624-9e46-628f0b72e697", "5a26ca8b-6cb2-4106-996b-154b34c49380", "2019-04-03");
INSERT INTO Token (userId, token, expiredDate) VALUES ("cd20ea0e-bc69-4f8c-9483-69cec2883cb1", "6b74417d-5f29-4eb1-b9ac-c37466264f3b", "2019-04-02");
INSERT INTO Token (userId, token, expiredDate) VALUES ("5c281687-851d-4a33-9083-9e590d916c74", "0bde2213-eefb-4b29-b12a-6ce6c87d0258", "2019-03-24");
INSERT INTO Token (userId, token, expiredDate) VALUES ("1b915cf6-a6e7-4210-a23b-41790450b32f", "c47e9153-a9de-4bdd-86ec-93ee156a340a", "2019-03-26");
INSERT INTO Token (userId, token, expiredDate) VALUES ("07fbea7f-6116-4992-800b-fa25c09533f3", "926a11c1-2a26-4ed8-afa7-d5a918527aac", "2019-04-10");
INSERT INTO Token (userId, token, expiredDate) VALUES ("1eaad232-6065-4c18-a4ea-5fd5ec82a8d4", "781f2cb6-5449-43e5-985c-e570ba9c0a07", "2019-04-10");
INSERT INTO Token (userId, token, expiredDate) VALUES ("2bc4ff9d-5fa2-435b-8028-81e224938dd2", "caa43f9d-395b-4bd0-ac7d-50629ed07db7", "2019-03-20");
INSERT INTO Token (userId, token, expiredDate) VALUES ("20cef249-6c91-4624-9e46-628f0b72e697", "b724cf9f-8f2b-4c5a-b37b-7917abcbc0ed", "2019-04-07");
INSERT INTO Token (userId, token, expiredDate) VALUES ("05700b90-90a8-4b54-bdbe-a9ddfa354a5d", "67c36880-fc72-4d3f-ba39-1673b51712eb", "2019-03-13");
INSERT INTO Token (userId, token, expiredDate) VALUES ("f902ccc8-5738-4dbf-81fc-7da213b153ef", "6a6b49e3-b0f3-49b1-8aa7-69818ae3cbd2", "2019-04-12");
INSERT INTO Token (userId, token, expiredDate) VALUES ("2d4f5799-5432-4cfa-9473-141c2cd0a01b", "f1156b3f-e3c7-4583-b362-5ba306ce8a4c", "2019-03-28");
INSERT INTO Token (userId, token, expiredDate) VALUES ("219e9bd6-563d-437e-bb50-0e89f725a0a1", "c1e1e328-f8e4-4069-b781-1c866903962a", "2019-03-15");
INSERT INTO Token (userId, token, expiredDate) VALUES ("2bc4ff9d-5fa2-435b-8028-81e224938dd2", "72ab436a-1629-4070-b5b8-1e210088c885", "2019-04-03");
INSERT INTO Token (userId, token, expiredDate) VALUES ("f9fab523-c67d-4752-8fb8-be1f0a5e254f", "3d6f0279-e3a4-4a0a-a1e2-3ef6c603f9a0", "2019-04-10");
INSERT INTO Token (userId, token, expiredDate) VALUES ("b9d2a33a-613e-433d-afd4-ce6329ccafa0", "75afa0b5-5fde-49fd-ba1f-2657abac8ee7", "2019-04-11");
INSERT INTO Token (userId, token, expiredDate) VALUES ("5ea8b618-6704-4d84-9cb4-f4a6438627ac", "71b61b50-31e4-42d2-abcf-3f8207143439", "2019-03-27");
INSERT INTO Token (userId, token, expiredDate) VALUES ("f9fab523-c67d-4752-8fb8-be1f0a5e254f", "fa08e609-b14e-4e5d-8b1e-9dcab17a4746", "2019-03-30");
INSERT INTO Token (userId, token, expiredDate) VALUES ("e8b28e90-3658-42ff-b181-28e188d0ea89", "7dae6f68-d768-4287-9577-bcc86cf2c42e", "2019-04-01");
INSERT INTO Token (userId, token, expiredDate) VALUES ("9903745d-6e53-42e1-a332-39e241ba7311", "1232b768-ad98-4a72-a93b-ef096b2a767c", "2019-04-02");
INSERT INTO Token (userId, token, expiredDate) VALUES ("2aca6c5f-bf0a-4ef1-81c5-4c9dea28a541", "7469e4af-d82b-4526-b34b-71ba726dddc5", "2019-04-05");
INSERT INTO Token (userId, token, expiredDate) VALUES ("7a65b48a-80b1-45d1-bb81-52cf65e44396", "7bdb3797-4a0c-4862-9f9a-8a6dd0d3b392", "2019-04-07");
INSERT INTO Token (userId, token, expiredDate) VALUES ("6360364d-e454-42e5-8a68-8b6fce893604", "f4b58ac0-6421-4556-9f98-1fdc8edcd61f", "2019-04-09");
INSERT INTO Token (userId, token, expiredDate) VALUES ("c6c8639c-6878-4999-80fc-c8b1427426f1", "d177a79f-b7c5-47c7-87a6-56a736eb75fb", "2019-04-10");
INSERT INTO Token (userId, token, expiredDate) VALUES ("5c281687-851d-4a33-9083-9e590d916c74", "92807cbb-7d47-439b-8996-4cf81c91eca5", "2019-03-20");
INSERT INTO Token (userId, token, expiredDate) VALUES ("86187994-020b-47a7-a055-0ffa48a08eaa", "7db094cb-9de7-4ed6-a224-e2470e0fbcfe", "2019-04-05");
INSERT INTO Token (userId, token, expiredDate) VALUES ("27bafcc6-8040-4992-a66b-e4edf039a1f6", "4ac95385-c7ed-40af-8851-e599925b5060", "2019-03-24");
INSERT INTO Token (userId, token, expiredDate) VALUES ("07fbea7f-6116-4992-800b-fa25c09533f3", "08d17457-eac4-438f-b5f6-29e2dc01fa00", "2019-03-27");
INSERT INTO Token (userId, token, expiredDate) VALUES ("a0a2a26b-80a2-4af0-b0d0-318d0f37ad3f", "a2d84160-6980-42da-ae81-ea97ca6f5c63", "2019-03-16");
INSERT INTO Token (userId, token, expiredDate) VALUES ("b9d2a33a-613e-433d-afd4-ce6329ccafa0", "b164aad7-270f-4ae1-928b-f502d4649c6b", "2019-03-16");
INSERT INTO Token (userId, token, expiredDate) VALUES ("1efe6717-b2c4-4ac2-94ea-2f5c0a794fa4", "cd3c70f8-d5bd-4503-bf56-e4363dc1d2a1", "2019-03-23");
INSERT INTO Token (userId, token, expiredDate) VALUES ("93812d24-add1-451a-aea1-dd9b0aa23ffe", "45f3f18a-36ef-4962-a7aa-3655b9bd2ce7", "2019-04-02");
INSERT INTO Token (userId, token, expiredDate) VALUES ("ac756b0b-f257-4cc6-80fa-b89b2da5587e", "6a1ee3d4-70bd-4406-9051-2ada19aa2e7d", "2019-03-23");
INSERT INTO Token (userId, token, expiredDate) VALUES ("219e9bd6-563d-437e-bb50-0e89f725a0a1", "6ef7d456-e780-4107-90cc-858aa764a47a", "2019-03-17");
INSERT INTO Token (userId, token, expiredDate) VALUES ("05700b90-90a8-4b54-bdbe-a9ddfa354a5d", "454da04d-48ba-4077-9d05-ac9276768e5d", "2019-03-23");
INSERT INTO Token (userId, token, expiredDate) VALUES ("34837bc1-464c-410d-8dea-82668f3bd8c1", "f9449860-a308-4587-b489-468716e2b1e0", "2019-04-11");
INSERT INTO Token (userId, token, expiredDate) VALUES ("314faca8-cda9-4335-89cd-95cd3c770b17", "d3df15d0-6ecc-4188-81f6-861dc7839702", "2019-03-14");
INSERT INTO Token (userId, token, expiredDate) VALUES ("2bc4ff9d-5fa2-435b-8028-81e224938dd2", "41b565c2-40b6-4e5c-91d8-92f0f30928a5", "2019-04-05");
INSERT INTO Token (userId, token, expiredDate) VALUES ("15f8a4bf-de0f-421c-b446-7226e924f3b5", "70e615f1-38d2-461b-b09f-435e3001174c", "2019-03-16");
INSERT INTO Token (userId, token, expiredDate) VALUES ("fb7eeed2-6274-404d-a3d1-dcded5d7aaa5", "24ad0531-86e5-4550-9c24-4f3946407a95", "2019-03-19");
INSERT INTO Token (userId, token, expiredDate) VALUES ("a5b26346-a5a1-4570-95db-d038f1cdc03b", "13633bbe-13cc-4757-93d7-1b98a0ad9ef6", "2019-03-31");
INSERT INTO Token (userId, token, expiredDate) VALUES ("606e5ff3-055e-4736-b3e7-3971234bb8de", "adca0bc1-f86b-4e73-84e2-b01861562552", "2019-04-09");
INSERT INTO Token (userId, token, expiredDate) VALUES ("f902ccc8-5738-4dbf-81fc-7da213b153ef", "ba986b7f-bc7b-43ca-811c-cdb42eb6a723", "2019-03-23");
INSERT INTO Token (userId, token, expiredDate) VALUES ("40fa085b-bb2b-447f-b2de-5b7b18d2c721", "9865662c-24df-4e11-9485-cb817e7806d9", "2019-04-12");
INSERT INTO Token (userId, token, expiredDate) VALUES ("244d3c4e-e780-4c76-b1ea-d108ec4639f7", "3050b88c-7c30-4591-8358-2a79e43c1bad", "2019-03-24");
INSERT INTO Token (userId, token, expiredDate) VALUES ("7f422a4c-a7ad-4d05-a98a-218d668b7510", "e57cd0dc-de30-4570-ac13-de9739d4c654", "2019-03-16");
INSERT INTO Token (userId, token, expiredDate) VALUES ("b9d2a33a-613e-433d-afd4-ce6329ccafa0", "fa6799a8-5289-4b55-8dc7-e109f1bc1c68", "2019-04-03");
INSERT INTO Token (userId, token, expiredDate) VALUES ("ead07ca8-d7c8-41ba-a65f-b814e92960a0", "49f0cc90-7137-44cc-8bdb-226856e910f6", "2019-03-13");
INSERT INTO Token (userId, token, expiredDate) VALUES ("a9acd7b4-5a31-4f18-95ca-a8e844d2c1a5", "d76e8928-a402-4845-93bd-f5a81979943e", "2019-03-17");
INSERT INTO Token (userId, token, expiredDate) VALUES ("07fbea7f-6116-4992-800b-fa25c09533f3", "376e7070-56e4-4cf4-9441-3fc763dd7fa6", "2019-04-12");
INSERT INTO Token (userId, token, expiredDate) VALUES ("c6c8639c-6878-4999-80fc-c8b1427426f1", "6e20dd89-07e6-4337-a0a5-d4fca9761cae", "2019-03-25");
INSERT INTO Token (userId, token, expiredDate) VALUES ("a9457ca5-cbc4-4116-9634-a1dc25ebe026", "d21cd37e-366a-4646-b703-8d882f075487", "2019-04-09");
INSERT INTO Token (userId, token, expiredDate) VALUES ("8ee983e4-c1b2-4238-ba5d-0885cfbf81d0", "d9ddde16-0657-4c11-b20c-ba0ab952ee50", "2019-03-14");
INSERT INTO Token (userId, token, expiredDate) VALUES ("3b9d6cc7-e64c-4649-8893-96c234005558", "4799652e-dbad-4f34-bc1d-b73abc07211b", "2019-03-25");
INSERT INTO Token (userId, token, expiredDate) VALUES ("e70526df-3d92-48a1-afdb-09ffbcb68808", "eff19351-0a52-438b-927e-863e73740905", "2019-03-26");
INSERT INTO Token (userId, token, expiredDate) VALUES ("ac756b0b-f257-4cc6-80fa-b89b2da5587e", "d9b2692d-ccf4-4918-a1ce-5b1ff895de3b", "2019-04-04");
INSERT INTO Token (userId, token, expiredDate) VALUES ("43c5152e-d2bc-4ce2-9f10-818f36ef138f", "3fbdcca4-8497-42f3-9fc1-57ca2c8ed0b2", "2019-03-21");
INSERT INTO Token (userId, token, expiredDate) VALUES ("1b915cf6-a6e7-4210-a23b-41790450b32f", "e62a25fc-37ab-43b5-b7ce-f6aa7d484037", "2019-03-23");
INSERT INTO Token (userId, token, expiredDate) VALUES ("8dee5976-61fd-4958-bf8c-10770c6e2218", "e2a44ef0-68f5-446a-9fde-6f1ffc760078", "2019-03-21");
INSERT INTO Token (userId, token, expiredDate) VALUES ("7a65b48a-80b1-45d1-bb81-52cf65e44396", "db1e1990-2ede-4d11-8b17-4b40941c4cad", "2019-03-28");
INSERT INTO Token (userId, token, expiredDate) VALUES ("8e02276c-48d6-4bed-a702-cffecb4187f6", "ca9046d2-ce81-4e38-8d65-ce2a632e91cb", "2019-03-13");
INSERT INTO Token (userId, token, expiredDate) VALUES ("fb7eeed2-6274-404d-a3d1-dcded5d7aaa5", "b0611f90-4ab6-470d-9f25-5e0b845a5bac", "2019-04-11");
INSERT INTO Token (userId, token, expiredDate) VALUES ("a58f19e0-3255-4292-b7e0-8da1292ab861", "a49ae93d-e06a-4788-8486-40193af23d9a", "2019-04-11");
INSERT INTO Token (userId, token, expiredDate) VALUES ("1b915cf6-a6e7-4210-a23b-41790450b32f", "522a877b-9842-48a5-902f-d3d99ea48178", "2019-03-16");
INSERT INTO Token (userId, token, expiredDate) VALUES ("90035a83-6507-4813-b243-44663a53e0f0", "f4d49d50-06d2-45df-a593-2f62b5d643cd", "2019-03-24");
INSERT INTO Token (userId, token, expiredDate) VALUES ("5f6192f5-0e5c-4172-b933-a77ff18a4d16", "ec45411e-13f1-4594-bd63-d5f91ea74cc9", "2019-04-01");
INSERT INTO Token (userId, token, expiredDate) VALUES ("b9d2a33a-613e-433d-afd4-ce6329ccafa0", "4c97e169-5773-4281-b14f-70438f2dcb2a", "2019-04-07");
INSERT INTO Token (userId, token, expiredDate) VALUES ("126c9276-93b1-48f9-ac38-ed0aa82fc01c", "96f4b180-ee84-4612-ad11-2c726e80c330", "2019-03-19");
INSERT INTO Token (userId, token, expiredDate) VALUES ("39c8b1b7-c5e9-4bb9-9405-7c9aca045c72", "394529ae-a9ef-4b94-8ae9-56357113449d", "2019-03-17");
INSERT INTO Token (userId, token, expiredDate) VALUES ("20cef249-6c91-4624-9e46-628f0b72e697", "c458b2ac-7228-4aba-9ddd-3ab0b15fbce7", "2019-04-06");
INSERT INTO Token (userId, token, expiredDate) VALUES ("c750054e-f128-4766-b293-bae3d681dee1", "8d4f0c2d-b1ef-48f4-bac2-45102f3d3863", "2019-04-12");
INSERT INTO Token (userId, token, expiredDate) VALUES ("b4bd37c8-30f3-41ff-ac2c-89636a1ebb27", "4fbf565c-f340-4c52-bcfa-47a2f0045c3f", "2019-03-21");
INSERT INTO Token (userId, token, expiredDate) VALUES ("a0a2a26b-80a2-4af0-b0d0-318d0f37ad3f", "d31c0351-8bad-410f-9b26-d5670a4b42c9", "2019-04-09");
INSERT INTO Token (userId, token, expiredDate) VALUES ("c6c8639c-6878-4999-80fc-c8b1427426f1", "9b932613-d897-4b22-a5e9-aeddce34c5f1", "2019-04-04");
INSERT INTO Token (userId, token, expiredDate) VALUES ("cd20ea0e-bc69-4f8c-9483-69cec2883cb1", "83fb3515-b59c-4ca1-b800-e52de672dc1d", "2019-03-27");
INSERT INTO Token (userId, token, expiredDate) VALUES ("c750054e-f128-4766-b293-bae3d681dee1", "f0224364-9238-45d8-8b55-9841c872d239", "2019-04-09");
INSERT INTO Token (userId, token, expiredDate) VALUES ("244d3c4e-e780-4c76-b1ea-d108ec4639f7", "e8fe7658-d805-4f9e-849e-fbf0235353ca", "2019-03-31");
INSERT INTO Token (userId, token, expiredDate) VALUES ("72d0d686-b371-4674-a8d7-203027e8d176", "d6972656-90f7-4d7c-9d08-1a608fc77fab", "2019-03-27");
INSERT INTO Token (userId, token, expiredDate) VALUES ("c6c8639c-6878-4999-80fc-c8b1427426f1", "4a78cd55-9658-4e1b-842e-49a4f27bf9a0", "2019-04-01");
INSERT INTO Top (memeId, date) VALUES ("21711025-f16a-492d-b3b5-b8d1c36047d6", "2018-04-05");
INSERT INTO Top (memeId, date) VALUES ("e6c4064f-39bb-4c7c-9f0b-76f5b90f4fbe", "2018-08-23");
INSERT INTO Top (memeId, date) VALUES ("a09a4df4-6c83-4609-bc72-16a90cf932a3", "2018-09-02");
INSERT INTO Top (memeId, date) VALUES ("32ab3da7-74d9-4c78-a47a-c0e647cab238", "2018-01-24");
INSERT INTO Top (memeId, date) VALUES ("670d6e22-dded-4d3e-abf6-8edce8abb3dc", "2017-04-15");
INSERT INTO Top (memeId, date) VALUES ("aea7c415-2ada-4427-804d-dda892f8fb35", "2016-09-27");
INSERT INTO Top (memeId, date) VALUES ("7109f5f6-5fc3-4aa1-a3cc-0f098a8f6f7e", "2018-07-13");
INSERT INTO Top (memeId, date) VALUES ("d72ac365-7046-4c94-960a-5985c388f1b3", "2017-10-13");
INSERT INTO Top (memeId, date) VALUES ("d38920e2-8185-4efc-833d-cf9faea63f94", "2017-05-05");
INSERT INTO Top (memeId, date) VALUES ("e67dc528-ffb6-499e-950e-c3185183590a", "2017-12-05");
