CREATE DATABASE user_db;        -- DB 생성
SHOW DATABASES;                 -- 전체 DB 목록 조회
GRANT ALL PRIVILEGES ON user_db.* TO 'ohgiraffers'@'%'; -- 권한 부여
SHOW GRANTS FOR 'ohgiraffers'@'%';  -- 권한 조회
USE user_db;                    -- user_db 사용

/*
CONSTRAINTS
- 제약조건, 테이블에 데이터가 입력되거나 수정될 때의 규칙 정의
- 데이터 무결성을 보장하는데 도움이 된다.
*/

-- NOT NULL
-- NULL 허용 X
DROP TABLE IF EXISTS user_notnull;
CREATE TABLE IF NOT EXISTS user_notnull(
    user_no int NOT NULL,
    user_id varchar(255) NOT NULL,
    user_pwd varchar(255) NOT NULL,
    user_name varchar(255) NOT NULL,
    gender varchar(3),
    phone varchar(255) NOT NULL,
    email varchar(255)
);

INSERT INTO user_notnull (user_no, user_id, user_pwd, user_name, gender, phone, email)
    VALUES (1,'user01','pass01','홍길동','남','010-1234-5678','hon123@gmail.com'),
           (2,'user02','pass02','유관순','여','010-7777-7777',null);

-- UNIQUE
-- 중복값 허용 X
DROP TABLE IF EXISTS user_unique;
CREATE TABLE IF NOT EXISTS user_unique(
   user_no int NOT NULL UNIQUE, -- PK
   user_id varchar(255) NOT NULL,
   user_pwd varchar(255) NOT NULL,
   user_name varchar(255) NOT NULL,
   gender varchar(3),
   phone varchar(255) NOT NULL,
   email varchar(255)
);

-- 같은 내용을 두 번 insert 했을 때 unique 키 중복
-- [23000][1062] Duplicate entry '1' for key 'user_unique.user_no' 발생
INSERT INTO user_unique (user_no, user_id, user_pwd, user_name, gender, phone, email)
    VALUES (1,'user01','pass01','홍길동','남','010-1234-5678','hon123@gmail.com'),
           (2,'user02','pass02','유관순','여','010-7777-7777','yu77@gmail.com');

/*
PRIMARY KEY
- 테이블에서 한 행의 정보를 찾기 위해 사용할 column을 의미
- NOT NULL + UNIQUE 제약조건을 의미
- 한 테이블 당 한 개
- 한 개의 column에 설정할 수도 있고, 여러개의 column을 묶어서 설정할 수도 있다. (복합키)
*/
DROP TABLE IF EXISTS user_primarykey;
CREATE TABLE IF NOT EXISTS user_primarykey(
    user_no int,
    -- user_no int PRIMARY KEY
    user_id varchar(255) NOT NULL,
    user_pwd varchar(255) NOT NULL,
    user_name varchar(255) NOT NULL,
    gender varchar(3),
    phone varchar(255) NOT NULL,
    email varchar(255),
    PRIMARY KEY (user_no)
);

INSERT INTO user_primarykey (user_no, user_id, user_pwd, user_name, gender, phone, email)
    VALUES (1,'user01','pass01','홍길동','남','010-1234-5678','hon123@gmail.com'),
           (2,'user02','pass02','유관순','여','010-7777-7777','yu77@gmail.com');

/*
FOREIGN KEY
- 참조된 다른 테이블에서 제공하는 값만 사용 가능
- 참조 무결성을 위배하지 않기 위해 사용
- FOREIGN KEY 제약 조건에 의해 테이블 간의 relationship 형성
- 제공되는 값(참조하는 테이블의 값) 이외에는 NULL 사용 가능
*/

/*
참조 무결성
- PK와 FK 간의 관계가 항상 유지되도록 보장하는 것
*/
DROP TABLE IF EXISTS user_grade;
CREATE TABLE IF NOT EXISTS user_grade(
    grade_code int NOT NULL UNIQUE,
    grade_name varchar(255) NOT NULL
) ENGINE = INNODB;

INSERT INTO user_grade VALUES (10,'일반회원'),
                              (20,'우수회원'),
                              (30,'특별회원');

DROP TABLE IF EXISTS user_foreignkey1;
CREATE TABLE IF NOT EXISTS user_foreignkey1(
    user_no int PRIMARY KEY,
    user_id varchar(255) NOT NULL,
    user_pwd varchar(255) NOT NULL,
    user_name varchar(255) NOT NULL,
    gender varchar(3),
    phone varchar(255) NOT NULL,
    email varchar(255),
    grade_code int,
    FOREIGN KEY (grade_code) REFERENCES user_grade (grade_code)
);

INSERT INTO user_foreignkey1 (user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES (1,'user01','pass01','홍길동','남','010-1234-5678','hon123@gmail.com', 10),
       (2,'user02','pass02','유관순','여','010-7777-7777','yu77@gmail.com', 20);

-- FK 제약 조건
-- 참조 column에 없는 값(50) 적용
-- [23000][1452] Cannot add or update a child row: a foreign key constraint fails (`user_db`.`user_foreignkey1`, CONSTRAINT `user_foreignkey1_ibfk_1` FOREIGN KEY (`grade_code`) REFERENCES `user_grade` (`grade_code`))
INSERT INTO user_foreignkey1 (user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES (3,'user03','pass03','이순신','남','010-4321-8765','lee321@gmail.com', 50);

-- 참조 무결성에 의해 일반적으로는 관계가 맺어진 column을 변경할 수 없다.
-- [23000][1452] Cannot add or update a child row: a foreign key constraint fails (`user_db`.`user_foreignkey1`, CONSTRAINT `user_foreignkey1_ibfk_1` FOREIGN KEY (`grade_code`) REFERENCES `user_grade` (`grade_code`))
UPDATE user_foreignkey1 SET grade_code = 5 WHERE user_no = 2;

/*
CHECK
- CHECK 제약 조건을 위반시 허용하지 X
*/
DROP TABLE IF EXISTS user_check;
CREATE TABLE IF NOT EXISTS user_check(
    user_no int AUTO_INCREMENT PRIMARY KEY,
    user_name varchar(255) NOT NULL,
    gender varchar(255) CHECK (gender IN ('남','여')),    -- 조건
    age int CHECK (age >= 19)   -- 조건
);

INSERT INTO user_check
    VALUES (null,'홍길동','남',25),
           (null,'이순신','남',35);

-- gender check 제약 조건 확인
-- [HY000][3819] Check constraint 'user_check_chk_1' is violated.
INSERT INTO user_check
VALUES (null,'안중근','남자',27);

-- age check 제약 조건 확인
-- [HY000][3819] Check constraint 'user_check_chk_1' is violated.
INSERT INTO user_check
VALUES (null,'유관순','여자',17);

/*
DEFAULT
- column에 null대신 기본값 적용
- column 타입이 DATE일 시, current_date만 가능
- DATETIME일 시, current_time, current_timestamp, now() 모두 사용가능
*/
DROP TABLE IF EXISTS tbl_country;
CREATE TABLE IF NOT EXISTS tbl_country(
    country_code int AUTO_INCREMENT PRIMARY KEY,
    country_name varchar(255) DEFAULT '한국',
    population varchar(255) DEFAULT '0명',
    added_day date DEFAULT (current_date),
    added_time datetime DEFAULT (current_time)
);

INSERT INTO tbl_country
VALUES (null,default,default,default,default);

DROP TABLE IF EXISTS tbl_country,user_check,user_foreignkey1,user_grade,user_notnull,user_primarykey,user_unique;