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
FOREIGN KEY (rno) REFERENCES reply(rno)
);
-- DELETE FROM reply_reply
-- where rno in (SELECT rno FROM reply WHERE bno = 10);

-- DELETE FROM reply
-- where bno = #{bno}
-- DELETE FROM board
-- where bno = 10;
SELECT * FROM reply_reply
WHERE rno in (SELECT rno FROM reply WHERE bno = 10);
SELECT * from reply
where bno = 10;
SELECT r_r.r_rno, b.bno, r.rno FROM reply_reply r_r JOIN reply r on r_r.rno = r.rno JOIN board b ON b.bno = r.bno
WHERE b.bno=10;

SELECT * FROM reply WHERE bno = 14
ORDER BY good DESC;