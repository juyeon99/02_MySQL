-- DML(Data Manipulation Language)
-- 데이터 조작 언어, 테이블에 값을 삽입/수정/삭제하는 SQL

SELECT * FROM tbl_menu;

/*
INSERT
- 새로운 행을 추가하는 구문
- 테이블의 행의 수가 증가한다.
- null 허용 가능한 column이나, auto-increment가 있는 column을 제외하고
  INSERT하고 싶은 데이터 컬럼을 지정해서 INSERT 가능
*/
-- INSERT INTO [테이블명] VALUES ([컬럼 내용] ...)
INSERT INTO tbl_menu VALUES (null,'바나나해장국',8500,4,'Y');

INSERT INTO tbl_menu(orderable_status,menu_price,menu_name,category_code)
    VALUES ('Y',5500,'파인애플탕',4);

-- 여러 column을 한번에 INSERT
INSERT INTO tbl_menu
    VALUES (null,'참치맛아이스크림',1700,12,'Y'),
           (null,'멸치맛아이스크림',1500,11,'Y'),
           (null,'소시지맛커피',2500,8,'Y');

/*
UPDATE
- 테이블에 기록된 column의 값을 수정하는 구문
- 테이블의 전체 행 개수는 변화가 없다.
*/
SELECT * FROM tbl_menu WHERE menu_name = '파인애플탕';
UPDATE tbl_menu SET category_code = 7 WHERE menu_code = 23;

/*
DELETE
- 테이블의 행을 삭제하는 구문
- 테이블의 행의 개수가 줄어듦
*/
-- LIMIT를 사용한 삭제
-- 20000원 이상인 데이터 중 가격이 높은 순으로 2개 삭제
DELETE
FROM tbl_menu
WHERE menu_price >= 20000
ORDER BY menu_price DESC
LIMIT 2;

-- 20000원 이상인 데이터 중 가격이 높은 순으로 조회
SELECT menu_name,menu_price
FROM tbl_menu
WHERE menu_price >= 20000
ORDER BY menu_price DESC;

-- 단일 행 삭제
DELETE
FROM tbl_menu
WHERE menu_code = 29;

SELECT * FROM tbl_menu;

-- 테이블 전체 행 삭제
DELETE
FROM tbl_menu
WHERE menu_code > 0;

/*
REPLACE
- REPLACE를 통해 중복된 데이터를 덮어 쓸 수 있다.
- 해당 행을 삭제하고 새로운 값 삽입

- INSERT시 PRIMARY KEY 또는 UNIQUE KEY 충돌 발생 가능

- UPDATE 조건을 충족하는 모든 행을 수정할 수 있지만, REPLACE는 무조건 한 행에 대해 수행 가능
*/

/*
PRIMARY KEY: 기본키, PK 유일성과 최소성을 충족한다. 해당 행을 식별할 때 기준이 되는 필수 키
UNIQUE KEY:  테이블 내에서 유일성을 만족하는 키, 해당 행을 식별할 때 사용 가능

최소성: 키를 구성하는 속성들 중 가장 최소로 필요한 속성들로만 키를 구성하는 성질
유일성: 여러개의 데이터가 존재할 때, 각각의 행을 유일하게 식별 가능한 조건
*/
SELECT * FROM tbl_menu;
-- [23000][1062] Duplicate entry '17' for key 'tbl_menu.PRIMARY'
-- INSERT INTO tbl_menu VALUES (17,'참기름소주',5000,10,'Y');

REPLACE INTO tbl_menu VALUES (17,'참기름소주',5000,10,'Y');

REPLACE tbl_menu    -- INTO 생략 가능
SET menu_code = 2,
    menu_name = '우럭쥬스',
    menu_price = 2000,
    category_code = 9,
    orderable_status = 'N';