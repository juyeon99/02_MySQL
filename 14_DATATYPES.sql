-- CAST FUNCTIONS

/*
명시적 형변환
-- CAST ([표현방식] AS [데이터형식] [(길이)])
-- CONVERT ([표현방식], [데이터형식] [(길이)])

-- 데이터 형식으로 가능한 것
-- BINARY, CHAR, DATE, DATETIME, DECIMAL, JSON, SIGNED INTEGER, TIME, UNSIGNED INTEGER
*/
SELECT AVG(menu_price)
FROM tbl_menu;

SELECT CAST(AVG(menu_price) AS SIGNED INTEGER) AS '평균 메뉴 가격'
FROM tbl_menu;

SELECT CONVERT(AVG(menu_price), SIGNED INTEGER) AS '평균 메뉴 가격'
FROM tbl_menu;

-- DATE형 CAST
SELECT CAST('2024$06$13' AS DATE);
SELECT CAST('2024/06/13' AS DATE);
SELECT CAST('2024@06@13' AS DATE);
SELECT CAST('2024%06%13' AS DATE);

-- 카테고리별 메뉴 가격 합계 구하기
-- 0000원
SELECT CONCAT(CAST(menu_price AS CHAR(5)), '원') FROM tbl_menu;

SELECT category_code,
       CONCAT(CAST(SUM(menu_price) AS CHAR(5)), '원')
FROM tbl_menu
GROUP BY category_code;

-- 암시적 형변환
SELECT '1' + '2';   -- 3 ('12'가 아니라 정수형으로 연산이 되어 3이 출력)

SELECT CONCAT(menu_price, '원')  -- menu_price가 자동으로 문자로 변환됨
FROM tbl_menu;

SELECT 3 > 'MAY';   -- 문자가 0으로 변환됨
SELECT 5 > '6MAY';  -- 문자에서 첫번째로 나온 숫자는 정수로 변환
SELECT 5 > 'M6AY';  -- 숫자가 뒤에 나오면 문자로 인식됨
SELECT '2024-6-13'; -- 날짜형으로 바뀔 수 있는 문자 -> DATE형으로 변환