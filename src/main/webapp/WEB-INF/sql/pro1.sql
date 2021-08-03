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
use project;

SELECT * FROM member_profile;
DESC member; 

SELECT * FROM file;

insert into member_auth
(userId, auth)
values ('bbb', 'ROLE_USER');

create table member_profile
(
pfId int PRIMARY key AUTO_INCREMENT,
userId VARCHAR(50) not null,
fileName VARCHAR(100) not null
);


	SELECT m.userId userId,
		   m.userName userName,
		   m.userNickName userNickName,
		   m.point point,
		   f.fileName fileName
	FROM member m left join member_profile f on m.userId = f.userId
    WHERE m.userId = 'bbb';
    
DELETE FROM member_profile
where pfId = 2;

CREATE TABLE point_inout
(
pid int PRIMARY key AUTO_INCREMENT,
userId VARCHAR(50) not null,
point DECIMAL(60, 15) NOT null,
pointInOut VARCHAR(100) not null,
regdate DATE DEFAULT now()
);

SELECT sum(point), pointInOut from point_inout
WHERE userId = 'aaa' 
GROUP BY pointInOut;

SELECT * from member;


DESC point_inout;
use project;
SELECT 
		   userId,
		   SUM(point) point,
		   pointInOut
		   
	FROM point_inout
	WHERE userId = 'ddd'
  
	GROUP BY pointInOut
	ORDER BY point DESC;
    
    SELECT 
		   userId,
		   count(pointInOut) point,
		   pointInOut
		   
	FROM point_inout
	WHERE userId = 'ddd'
  
	GROUP BY pointInOut
    HAVING point < 0;
    
     SELECT userId, pointInOut, count(1) from point_inout
    where userId = 'eee' and point > 0
   GROUP BY pointInOut;
    
    
    SELECT userId, count(pointInOut), pointInOut from point_inout
    where userId = 'ddd' and point < 0
    ;
