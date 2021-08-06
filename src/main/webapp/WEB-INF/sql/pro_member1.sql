SELECT * from member_auth;
SELECT * from approve_auth;
where auth = 'ROLE_MEMBER';
SELECT * from member;
DELETE from approve_auth;
WHERE id = 21;
DELETE from member_auth
WHERE userId = 'www';
DELETE from member
WHERE userId = 'www';

CREATE TABLE approve_auth
(
aid int PRIMARY key AUTO_INCREMENT,
reqId VARCHAR(50) not null,
appId VARCHAR(50) not null,
state TINYINT DEFAULT 1
);

INSERT INTO approve_auth
(reqId, appId)
VALUES
('fff', 'eee');

SELECT userId from member_auth
where auth = 'ROLE_MEMBER';

SELECT * from approve_auth;

SELECT state, reqId from approve_auth
where appId = 'aaa' and state = 1;

SELECT * from approve_auth
where reqId = 'qqq';

SELECT count(*) from member_auth
where (SELECT auth from member_auth where userId = 'aaa' and auth = 'ROLE_MEMBER');

SELECT * from member;

ALTER TABLE member
ADD birthday VARCHAR(50) DEFAULT '0000-00-00';



	