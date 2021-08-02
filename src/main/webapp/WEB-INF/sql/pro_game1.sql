CREATE TABLE quiz
(
qid int PRIMARY KEY AUTO_INCREMENT,
que VARCHAR(1024) not null,
ans VARCHAR(1024) not null,
date VARCHAR(15) not null
);

SELECT * FROM member;
DESC member;


SELECT * from quiz;
DELETE FROM quiz_state
where qid = 3 and userId = 'aaa';


CREATE TABLE quiz_state
(
id int PRIMARY KEY AUTO_INCREMENT,
qid int not null,
userId VARCHAR(50) not null,
contact TINYINT DEFAULT 0,
click TINYINT DEFAULT 0,
solve TINYINT DEFAULT 0,
point int NOT null DEFAULT 0,

FOREIGN KEY (qid) REFERENCES quiz (qid)
);


DROP TABLE quiz_state;
use project;



INSERT into quiz
(que, ans, date)
VALUES
('다리미가 좋아하는 음식은?', '피자', '2021-08-11');