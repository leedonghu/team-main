use project;
SELECT * from member;
SELECT * from reply;

CREATE TABLE reply
(
rno INT PRIMARY KEY AUTO_INCREMENT,
bno INT NOT NULL,
content VARCHAR(1000) not null,
replyer VARCHAR(50) not null,
replyDate TIMESTAMP DEFAULT now(),
updateDate TIMESTAMP DEFAULT now(),
good INT DEFAULT 0,
bad int DEFAULT 0,
FOREIGN KEY (bno) REFERENCES board (bno)

);

CREATE TABLE reply_reply
(
r_rno int PRIMARY KEY AUTO_INCREMENT,
rno int not null,
r_content VARCHAR(500) not null,
r_replyer VARCHAR(50) not null,
r_replyDate TIMESTAMP DEFAULT now(),
r_updateDate TIMESTAMP DEFAULT now(),
FOREIGN KEY (r_rno) REFERENCES reply(rno)
);