use spr1;
DESC tbl_board;

use project;
CREATE TABLE board
(
bno INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(255) not null,
content VARCHAR(2000) not null,
writer VARCHAR(50) not null,
regdate TIMESTAMP DEFAULT now(),
updateDate TIMESTAMP DEFAULT now(),
FOREIGN KEY (writer) REFERENCES member(userId)
);
DESC member;
SELECT * from member_auth;