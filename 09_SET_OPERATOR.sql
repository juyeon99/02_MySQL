/*
SET OPERATORS(연산자)

- 두 개 이상의 SELECT문의 결과 집합을 결합하는데 사용된다.
- SET 연산자를 통해 결합하는 결과 집합의 column이 동일해야 한다.
*/

/*
UNION
- 두 개 이상의 SELECT 결과문을 결합하여 중복된 레코드를 제거한 후 반환
*/
SELECT menu_name
FROM tbl_menu
WHERE category_code = 10    -- 카테고리 코드가 10인 데이터 조회
UNION
SELECT menu_name
FROM tbl_menu
WHERE menu_price < 9000;    -- 메뉴 가격이 9000원보다 작은 경우 조회

/*
UNION ALL
- 두 개 이상의 SELECT문의 결과를 결합하여 중복된 레코드를 제거하지 않고 모두 반환
*/
SELECT menu_name
FROM tbl_menu
WHERE category_code = 10
UNION ALL
SELECT menu_name
FROM tbl_menu
WHERE menu_price < 9000;

/*
INTERSECT
- 두 SELECT 문의 결과 중 공통되는 레코드만 반환
- MySQL은 INTERSECT를 제공하지 않지만 INNER JOIN 또는 IN 연산자를 활용해 구현 가능
*/
-- INNER JOIN 활용
SELECT a.*
FROM tbl_menu a
INNER JOIN (
    SELECT *
    FROM tbl_menu
    WHERE menu_price < 9000
) b ON (a.menu_code = b.menu_code)
WHERE a.category_code = 10;

-- IN 연산자 활용
SELECT a.*
FROM tbl_menu a
WHERE category_code = 10 AND
      menu_code IN (
          SELECT menu_code
          FROM tbl_menu
          WHERE menu_price < 9000
          );

/*
MINUS
- 첫번째 SELECT문의 결과에서 두번째 SELECT문의 결과가 포함하는 레코드를 제외해서 반환하는 SQL 연산자
- MySQL은 MINUS를 제공하지 않지만 LEFT JOIN을 활용해서 구현 가능
*/
SELECT a.*
FROM tbl_menu a
LEFT JOIN (
    SELECT *
    FROM tbl_menu
    WHERE menu_price < 9000
) b ON (a.menu_code = b.menu_code)
WHERE a.category_code = 10 AND
      b.menu_code IS NULL;