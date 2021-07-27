CREATE TABLE quiz
(
qid int PRIMARY KEY AUTO_INCREMENT,
que VARCHAR(1024) not null,
ans VARCHAR(1024) not null,
date VARCHAR(15) not null
);

SELECT * from quiz;
CREATE TABLE quiz_check
(
id int PRIMARY key AUTO_INCREMENT,
qid int not null,
userId VARCHAR(50) NOT null,
enabled TINYINT DEFAULT 1,
FOREIGN KEY (qid) REFERENCES quiz (qid)
);

use project;
DELETE FROM quiz
where qid=15;

INSERT into quiz
(que, ans, date)
VALUES
('다리미가 좋아하는 음식은?', '피자', '2021-08-11');