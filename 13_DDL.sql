/*
DDL (Data Definition Language)
- 데이터 정의어, DB를 정의하는 언어
- 테이블을 생성, 수정, 삭제하는 등의 데이터 전체의 골격을 결정하는 역할
*/

-- CREATE: DB, 테이블 등을 생성
-- ALTER:  테이블 수정
-- DROP:   DB, 테이블을 삭제
-- TRUNCATE: 테이블 초기화

/*
CREATE
- DB, 테이블을 생성하는 구문
- IF NOT EXISTS
-> 기존에 존재하는 테이블이 있더라도 에러가 발생하는 않는다.
*/
CREATE TABLE IF NOT EXISTS tb1(
    pk int PRIMARY KEY,
    fk int,
    col1 varchar(255) DEFAULT 'MySQL',
    CHECK (col1 IN ('Y','N'))
);

-- 테이블 구조 확인
DESCRIBE tb1;

INSERT INTO tb1 VALUES (1,10,'Y');
SELECT * FROM tb1;

-- AUTO INCREMENT
-- INSERT 시 pk에 해당하는 column에 자동으로 번호 발생 (중복되지 않게)
CREATE TABLE IF NOT EXISTS tb2(
    pk int AUTO_INCREMENT PRIMARY KEY,
    fk int,
    col1 varchar(255) DEFAULT 'MySQL',
    CHECK (col1 IN ('Y','N'))
);
DESCRIBE tb2;
INSERT INTO tb2 VALUES (null,10,'Y');
SELECT * FROM tb2;

/*
ALTER
- 테이블에 추가/변경/수정/삭제를 할 수 있다.
*/
-- column 추가
ALTER TABLE tb2
    ADD col2 int NOT NULL;

-- column 삭제
ALTER TABLE tb2
    DROP col2;

-- column명 및 형식 변경
ALTER TABLE tb2
    CHANGE COLUMN fk change_fk int NOT NULL;

-- row 제약 조건 추가, 삭제
ALTER TABLE tb2
    DROP PRIMARY KEY;   -- [42000][1075] Incorrect table definition; there can be only one auto column and it must be defined as a key => PRIMARY KEY는 삭제 불가

-- MODIFY 컬럼의 정의를 바꾸는 것
ALTER TABLE tb2
    MODIFY pk int;

ALTER TABLE tb2
    ADD PRIMARY KEY(pk);  -- PRIMARY KEY 설정

-- 기존 데이터가 있는 경우, NOT NULL 옵션의 column이 생기면 기본값으로 들어가게 됨
ALTER TABLE tb2
    ADD col3 date NOT NULL;
#     ADD col4 tinyint NOT NULL;

-- mysql 자체에서 전역적인 유효성 검사 모드 사용 (쓸 일 별로 X)
-- ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION
SELECT @@global.sql_mode;
SET GLOBAL sql_mode = '';

/*
DROP
- 테이블 삭제
- IF EXISTS를 적용하면 존재하지 않는 테이블이라도 에러가 발생하지 X
*/
CREATE TABLE IF NOT EXISTS tb3(
      pk int AUTO_INCREMENT PRIMARY KEY,
      fk int,
      col1 varchar(255) DEFAULT 'MySQL',
      CHECK (col1 IN ('Y','N'))
);
CREATE TABLE IF NOT EXISTS tb4(
      pk int AUTO_INCREMENT PRIMARY KEY,
      fk int,
      col1 varchar(255) DEFAULT 'MySQL',
      CHECK (col1 IN ('Y','N'))
);
CREATE TABLE IF NOT EXISTS tb5(
      pk int AUTO_INCREMENT PRIMARY KEY,
      fk int,
      col1 varchar(255) DEFAULT 'MySQL',
      CHECK (col1 IN ('Y','N'))
);
-- 테이블 여러개 삭제
DROP TABLE IF EXISTS tb1,tb2,tb3,tb4,tb5,tb6;

/*
TRUNCATE
- 삭제할 때 사용
- DELETE   -> 데이터를 삭제할때 행마다 하나씩 지워진다.
- TRUNCATE -> 테이블 drop, 테이블 생성 진행
- AUTO_INCREMENT 컬럼이 있는 경우 시작값도 0으로 초기화된다.
*/
CREATE TABLE IF NOT EXISTS tb6(
    pk int AUTO_INCREMENT PRIMARY KEY,
    fk int,
    col1 varchar(255) DEFAULT 'MySQL',
    CHECK (col1 IN ('Y','N'))
);

INSERT INTO tb6 VALUES (null,10,'y');
INSERT INTO tb6 VALUES (null,10,'y');
INSERT INTO tb6 VALUES (null,10,'y');
INSERT INTO tb6 VALUES (null,10,'y');

SELECT * FROM tb6;
TRUNCATE tb6;