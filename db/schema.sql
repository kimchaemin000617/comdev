USE comdev;

# DB 생성
DROP DATABASE IF EXISTS comdev;
CREATE DATABASE comdev;
USE comdev;

# 게시물 테이블 생성
CREATE TABLE article (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    title CHAR(100) NOT NULL,
    `body` TEXT NOT NULL
);

# 게시물, 테스트 데이터 생성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목 1',
`body` = '내용 1';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목 2',
`body` = '내용 2';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목 3',
`body` = '내용 3';

CREATE TABLE `member` (
    `id` INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `regDate` DATETIME NOT NULL,
    `updateDate` DATETIME NOT NULL,
    `loginId` CHAR(20) NOT NULL,
    `loginPw` CHAR(60) NOT NULL,
    `authLevel` SMALLINT(2) UNSIGNED DEFAULT 3 COMMENT '3=일반, 7=관리자',
    `name` CHAR(20) NOT NULL,
    `nickname` CHAR(20) NOT NULL,
    `cellphoneNo` CHAR(20) NOT NULL,
    `email` CHAR(50) NOT NULL,
    `delStatus` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴 여부',
    `delDate` DATETIME COMMENT '탈퇴 날짜'
);

-- 회원, 테스트 데이터 (관리자)
INSERT INTO `member`
    SET`regDate` = NOW(),
    `updateDate` = NOW(),
    `loginId` = 'admin',
    `loginPw` = 'admin',
    `authLevel` = 7,
    `name` = '운영자',
    `nickname` = '운영자',
    `cellphoneNo` = '01000000000',
    `email` = 'asd@asd.asd';

-- 회원, 테스트 데이터 (일반)
INSERT INTO `member`
    SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `loginId` = 'asd',
    `loginPw` = '1r4q2e3w',
    `name` = 'user1',
    `nickname` = '유저1',
    `cellphoneNo` = '01000000000',
    `email` = 'asd@asd.asd';

INSERT INTO `member`
    SET `regDate` = NOW(),
    `updateDate` = NOW(),
    `loginId` = 'qwe',
    `loginPw` = '1r4q2e3w',
    `name` = 'user2',
    `nickname` = '유저2',
    `cellphoneNo` = '01000000000',
    `email` = 'asd@asd.asd';

ALTER TABLE article ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER `updateDate`;

UPDATE article
SET memberId = 2
WHERE memberId = 0;


# 게시판 테이블
CREATE TABLE board (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `code` CHAR(100) NOT NULL UNIQUE COMMENT 'notice(공지사항), free1(자유게시판1), free2(자유게시판2)',
    `name` CHAR(100) NOT NULL UNIQUE COMMENT '게시판 이름'
);
# 게시판 테이블 테스트 데이터
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'notice',
`name` = '공지사항';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'free1',
`name` = '자유게시판';

# article 테이블에 boardId 칼럼 추가
ALTER TABLE article ADD COLUMN boardId INT(10) UNSIGNED NOT NULL AFTER memberId;

# article 테스트 데이터
UPDATE article
SET boardId = 1
WHERE id = 1;

UPDATE article
SET boardId = 2
WHERE id = 2;

UPDATE article
SET boardId = 2
WHERE id = 3;

# article 테스트 데이터
INSERT INTO article 
(
	regDate, updateDate, memberId, boardId, title, `body`
)
SELECT NOW(), NOW(), FLOOR(RAND() * 2) + 1, FLOOR(RAND() * 2) + 1, CONCAT('제목 ', RAND()), CONCAT('내용 ', RAND())
FROM article;

# 게시물 테이블에 조회수 칼럼 추가
ALTER TABLE article
ADD COLUMN hitCount INT(10) UNSIGNED NOT NULL DEFAULT 0;

# 좋아요 테이블
CREATE TABLE `likePoint` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relId INT(10) UNSIGNED NOT NULL COMMENT '관련데이터번호',
    `like` BOOLEAN NOT NULL DEFAULT 1
);

## 1번 회원이 2번 article 에 대해서 좋아요.
INSERT INTO likePoint 
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relId = 2;

## 2번 회원이 2번 article 에 대해서 좋아요
INSERT INTO likePoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relId = 2;

## 3번 회원이 1번 article 에 대해서 좋아요
INSERT INTO likePoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relId = 1;

# 댓글 테이블
CREATE TABLE reply (
id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
memberId INT(10) UNSIGNED NOT NULL,
articleId INT(10) UNSIGNED NOT NULL,
`body` TEXT NOT NULL
);

# 댓글 테스트 데이터
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
articleId = 1,
`body` = 1234;

# 댓글 테스트 데이터
INSERT INTO reply
(
	regDate, updateDate, memberId, articleId, `body`
)
SELECT NOW(), NOW(), FLOOR(RAND() * 2) + 1, FLOOR(RAND() * 2) + 1, CONCAT('내용 ', RAND())
FROM reply;

# board 테스트 데이터 추가
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'code question',
`name` = '코드 질문 게시판';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'QnA',
`name` = 'QnA 게시판';
