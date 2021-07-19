use spr1;
DESC tbl_reply;
SELECT * from tbl_reply;


use project;
CREATE TABLE reply
(
rno INT PRIMARY KEY AUTO_INCREMENT,
bno INT NOT NULL,
content VARCHAR(500) not null,
replyer VARCHAR(50) not null,
replyDate TIMESTAMP DEFAULT now(),
updateDate TIMESTAMP DEFAULT now(),
FOREIGN KEY (bno) REFERENCES board (bno)

);
CREATE TABLE board
(
bno INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(255) not null,
content VARCHAR(2000) not null,
writer VARCHAR(50) not null,
regdate TIMESTAMP DEFAULT now(),
updateDate TIMESTAMP DEFAULT now(),
cnt int DEFAULT 0,
FOREIGN KEY (writer) REFERENCES member(userId)
);
DESC member;
SELECT * from member;
SELECT * from reply_reply;
SELECT * from reply;
SELECT * from board ORDER BY bno DESC;




DROP TABLE board;