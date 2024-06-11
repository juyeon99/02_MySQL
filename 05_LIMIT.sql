-- LIMIT
-- SELECT의 결과 집합에서 반환할 행의 수를 제한

/*
SELECT [columnName]
FROM [tableName]
LIMIT [OFFSET], [ROWCOUNT]

OFFSET: 시작할 행의 번호 (index 체계)
ROWCOUNT: 이후 행부터 반환받을 행의 개수
*/

-- 상위 5줄만 조회
SELECT menu_code,menu_name,menu_price
FROM tbl_menu
ORDER BY menu_code DESC
LIMIT 5;

-- 2번 row부터 5번 row까지 조회
SELECT menu_code,menu_name,menu_price
FROM tbl_menu
ORDER BY menu_code DESC
LIMIT 1,4;

-- 가장 저렴한 순으로 3가지 조회
SELECT menu_name,menu_price
FROM tbl_menu
ORDER BY menu_price
LIMIT 3;
