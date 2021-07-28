CREATE TABLE quiz
(
qid int PRIMARY KEY AUTO_INCREMENT,
que VARCHAR(1024) not null,
ans VARCHAR(1024) not null,
date VARCHAR(15) not null
);

SELECT * FROM member;

SELECT * from quiz_check;
DELETE FROM quiz_check
where qid = 2 and userId = 'aaa';
CREATE TABLE quiz_check
(
id int PRIMARY key AUTO_INCREMENT,
qid int not null,
userId VARCHAR(50) NOT null,
enabled TINYINT DEFAULT 1,
FOREIGN KEY (qid) REFERENCES quiz (qid)
);

CREATE TABLE quiz_att
(
id int PRIMARY KEY AUTO_INCREMENT,
qid int not null,
userId VARCHAR(50) not null,
point int NOT null,
enabled TINYINT DEFAULT 1,
FOREIGN KEY (qid) REFERENCES quiz (qid)
);

SELECT * FROM quiz_att;
SELECT count(*) FROM quiz_att
where qid = 2 and userId = 'aaa';

use project;
DELETE FROM quiz_att
where qid=2;

INSERT into quiz
(que, ans, date)
VALUES
('다리미가 좋아하는 음식은?', '피자', '2021-08-11');