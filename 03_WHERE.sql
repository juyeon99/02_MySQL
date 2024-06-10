-- WHERE
-- 특정 조건에 맞는 data만을 선택

-- '=' 활용
SELECT menu_name,menu_price,orderable_status
FROM tbl_menu
WHERE orderable_status = 'Y';

SELECT menu_name,menu_price,orderable_status
FROM tbl_menu
WHERE menu_price = 13000;

-- SELECT에 담지 않아도, 다른 column의 속성으로 제한할 수 있다.
SELECT menu_name,menu_price
FROM tbl_menu
WHERE orderable_status = 'Y';


-- !=, <>
SELECT menu_code,menu_name,orderable_status
FROM tbl_menu
WHERE orderable_status <> 'Y';
-- WHERE orderable_status != 'Y';

-- <, <=, >, >=
SELECT menu_code,menu_name,menu_price
FROM tbl_menu
WHERE menu_price >= 20000;


-- AND
-- true가 되는 조건
SELECT 1 AND 1;

-- false가 되는 조건
SELECT 1 AND 0, 0 AND 0, 0 AND NULL;

-- null이 되는 조건
SELECT 1 AND NULL, NULL AND NULL;

SELECT menu_code,menu_name,category_code,orderable_status
FROM tbl_menu
WHERE orderable_status = 'Y' AND category_code = 10;

SELECT menu_name,menu_price,category_code,orderable_status
FROM tbl_menu
WHERE orderable_status = 'Y' AND menu_price <= 10000;


-- OR
-- true가 되는 조건
SELECT 1 OR 1, 0 OR 1, 1 OR NULL;

-- false가 되는 조건
SELECT 0 OR 0;

-- null이 되는 조건
SELECT 0 OR NULL, NULL OR NULL;

SELECT menu_name,menu_price,category_code,orderable_status
FROM tbl_menu
WHERE orderable_status = 'Y' OR category_code = 12;

/*
AND가 OR보다 높은 우선순위
OR의 우선순위를 높이려면 () 이용
*/
SELECT 1 OR 0 AND 0;
SELECT (1 OR 0) AND 0;

SELECT *
FROM tbl_menu
WHERE category_code = 4 OR (menu_price = 9000 AND menu_code > 10);

-- BETWEEN
SELECT menu_name,menu_price,category_code
FROM tbl_menu
WHERE menu_price BETWEEN 10000 AND 25000;   -- 10000 <= price <= 25000

SELECT menu_name,menu_price,category_code
FROM tbl_menu
WHERE menu_price NOT BETWEEN 10000 AND 25000;

/*
LIKE
- 특정 패턴과 일치하는 행을 검색

패턴
- % : 0개 이상의 문자를 의미
ex) '%apple%': apple이 포함된 모든 문자열

_: 1개의 문자
ex) 'a_k': 'a'로 시작하고 'k'로 끝나는 세글자 문자열
*/
SELECT *
FROM tbl_menu
WHERE menu_name LIKE '민트___';

SELECT *
FROM tbl_menu
WHERE menu_name NOT LIKE '%갈치%';

/*
IN
- 특정 열의 값이 지정된 목록 중 하나와 일치하는지 확인

[column_name] IN (4,5,6,...)
*/
SELECT tbl_menu.menu_name,category_code
FROM tbl_menu
WHERE category_code IN (4,5,6);     -- category_code가 (4,5,6) 중에 있는 데이터 조회

/*
IS NULL
*/
SELECT category_code,category_name,ref_category_code
FROM tbl_category
WHERE ref_category_code IS NULL;
-- WHERE ref_category_code IS NOT NULL;
