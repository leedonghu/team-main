DESC Account;
USE project;

CREATE TABLE member_auth
(
id int PRIMARY KEY AUTO_INCREMENT,
userId VARCHAR(50) NOT NULL,
auth VARCHAR(50) not null,
FOREIGN KEY(userId) REFERENCES member(userId)
);

CREATE TABLE member
(

userId VARCHAR(50) PRIMARY KEY,
userPw VARCHAR(50) not null,
userName VARCHAR(50) not null,
userNickName VARCHAR(50) not null DEFAULT '',
mobileNum VARCHAR(15) not null,
email VARCHAR(50) not null,
address VARCHAR(70) not null,
birth DATE not null,
regdate TIMESTAMP DEFAULT now(),
updateDate TIMESTAMP DEFAULT now(),
enabled TINYINT(1) DEFAULT 1
);
ALTER TABLE member
CHANGE userPw userPw VARCHAR(100) NOT NULL;

DROP TABLE member;
use spr1;

SELECT * FROM member;
DESC member; 

SELECT * FROM member_auth;

insert into member_auth
(userId, auth)
values ('bbb', 'ROLE_USER');