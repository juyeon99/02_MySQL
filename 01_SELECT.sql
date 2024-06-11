/*
SQL (Structured Query Language)

구조화된 질의 언어
단순히 질의만 하는 것이 아니라 DML, DDL, DCL, TCL 이런 DB를 조작 및 조회하기 위해 사용하는 표준 언어
*/

-- SELECT
-- 특정 테이블에서 원하는 데이터 조회
SELECT menu_name   -- which column
FROM tbl_menu;  -- from which table

-- 여러 column 한번에 조회
SELECT menu_code,menu_name,menu_price
FROM tbl_menu;

-- select all columns
SELECT *
FROM tbl_menu;


/*
SELECT 단독 활용
- FROM 없이 단독 사용 가능
- 단독으로 사용할 때는 단순한 테스트 용도로 사용
*/
SELECT (5 + 5);
SELECT (5 - 5);
SELECT (5 * 5);
SELECT (5 / 5);
SELECT (5 % 5);

-- mysql 내장 함수도 사용 가능
SELECT NOW();   -- 현재 시간
SELECT CONCAT('hello','world'); -- 문자열 합치기

-- column에 별칭 사용
SELECT CONCAT('hong',' ','juyeon') AS name;
SELECT CONCAT('hong',' ','juyeon') AS 'Full name';
