-- JOIN
-- 여러개의 분산된 표를 조합해서 하나의 표로 만드는 기능
-- 관계형 데이터베이스(RDBMS)에서 가장 중요한 파트이다.

-- 두개 이상 테이블을 관련있는 column을 통해 결합하는데 사용된다.
-- 두개 이상 테이블은 반드시 연관있는 column이 존재해야 하며
-- JOIN된 table들의 column을 모두 확인 가능

/*
ALIAS
- SQL의 column 또는 table의 별칭
*/

SELECT menu_code AS 'code', -- alias에 space나 특수기호가 없으면 '' 생략 가능
       t.menu_name AS name,
       menu_price AS price
FROM tbl_menu t
ORDER BY price;


/*
INNER JOIN
- 두 테이블의 교집합을 반환
- INNER 키워드는 생략 가능
- column명이 같거나, 다를경우 ON으로 서로 연관있는 column에 대한 조건을 작성하여 JOIN
*/
SELECT a.menu_name,
       b.category_name
FROM tbl_menu a
    INNER JOIN tbl_category b
        ON a.category_code = b.category_code
ORDER BY b.category_name;

-- INNER JOIN은 교집합을 반환하기 때문에 JOIN의 순서를 바꾸어도 영향 X
SELECT a.menu_name,
       b.category_name,
       a.category_code ACode,
       b.category_code BCode
FROM tbl_category b
    INNER JOIN tbl_menu a
        ON a.category_code = b.category_code
ORDER BY b.category_name;

-- USING()
-- column명이 같을 경우 JOIN에 사용 가능
SELECT a.menu_name,
       b.category_name
FROM tbl_menu a
    INNER JOIN tbl_category b USING(category_code)
ORDER BY b.category_name;

/*
LEFT JOIN
- 첫번째(왼쪽) 테이블을 모두 조회하고 왼쪽과 일치하는 오른쪽 테이블을 JOIN
*/
SELECT a.menu_name,
       b.category_name
FROM tbl_menu a
    LEFT JOIN tbl_category b ON a.category_code = b.category_code;

/*
RIGHT JOIN
- 두번째(오른쪽) 테이블을 모두 조회하고 오른쪽과 일치하는 왼쪽 테이블을 JOIN
*/
SELECT a.menu_name,
       b.category_name
FROM tbl_menu a
    RIGHT JOIN tbl_category b ON a.category_code = b.category_code;

/*
CROSS JOIN
- 두 테이블의 모든 가능한 조합을 반환 (모든 경우의 수를 다 구함 => 성능 하락)
- Cartesian Product
*/
SELECT a.menu_name,
       b.category_name
FROM tbl_menu a
    CROSS JOIN tbl_category b;

/*
SELF JOIN
- 같은 테이블 내에서 행과 행 사이의 관계를 찾기 위해 사용
*/
SELECT a.category_name 카테고리,
       b.category_name 대분류
FROM tbl_category a
    JOIN tbl_category b ON a.ref_category_code = b.category_code;
