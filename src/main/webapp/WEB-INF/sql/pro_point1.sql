use project;
select * from member;

ALTER TABLE member
ADD login VARCHAR(50) DEFAULT '2000-01-02';

ALTER TABLE member
DROP COLUMN login;

DESC member;

UPDATE member
set point=11
where userId = 'bbb';

SELECT point from member
where userId='aaa';