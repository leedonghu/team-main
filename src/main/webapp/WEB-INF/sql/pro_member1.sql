SELECT * from member_auth;
DESC member_auth;


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

SELECT reqId from approve_auth
where appId = 'aaa';



	