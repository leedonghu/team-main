use project;
CREATE TABLE album
(
ano INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(100) not null,
comment VARCHAR(500) not null,
writer VARCHAR(50) not null,
regdate TIMESTAMP DEFAULT now(),
updateDate TIMESTAMP DEFAULT now()
);

CREATE TABLE file
(
id int PRIMARY KEY AUTO_INCREMENT,
ano INT,
fileName VARCHAR(500) not null,
FOREIGN KEY (ano) REFERENCES album (ano)
);

SELECT * FROM album;
SELECT * FROM file;

SELECT a.ano, 
	   a.title, 
       a.comment, 
       a.writer, 
       a.regdate, 
       a.updateDate, 
       f.fileName 
FROM album a left JOIN file f on a.ano = f.ano;

use spr1;
SELECT * from tbl_member;
SELECT * from tbl_member_auth;