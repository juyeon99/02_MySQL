-- GROUP BY
-- 결과 집합을 특정 열의 값에 따라 그룹화하는데 사용
-- HAVING은 GROUP BY와 함께 사용해야 하며, 그룹에 대한 조건을 적용하는데 사용

-- 카테고리 그룹 조회
SELECT category_code
FROM tbl_menu
GROUP BY category_code;

-- 카테고리 그룹에서 COUNT()를 사용하여 개수 조회
SELECT category_code,
       COUNT(*)     -- parameter와 위치에 따라 여러 사용법이 있음
                    -- 전체 행 중 일치하는 행이 몇개인지 개수 반환
FROM tbl_menu
GROUP BY category_code;

-- SUM()으로 그룹화된 값의 총합을 구할 수 있다.
SELECT category_code,
       SUM(menu_price)
FROM tbl_menu
GROUP BY category_code;

-- AVG()로 그룹화된 값의 평균을 구할 수 있다.
SELECT category_code,
       COUNT(*) 총개수,
       SUM(menu_price) 총합,
       AVG(menu_price) 평균
FROM tbl_menu
GROUP BY category_code;

-- 2개 이상의 조건으로 그룹 생성
SELECT menu_price,category_code,COUNT(*)
FROM tbl_menu
GROUP BY menu_price, category_code;

-- category_code, orderable_status로 그룹화
-- 총개수, 평균, 총합
SELECT category_code,
       orderable_status,
       COUNT(*) 총개수,
       SUM(menu_price) 총합,
       AVG(menu_price) 평균
FROM tbl_menu
GROUP BY category_code, orderable_status;

/*
HAVING
- GROUP BY와 함께 사용해야 하며, 그룹화된 결과에 조건을 적용할 때 사용
- WHERE는 개별 행에 조건 적용 <=> HAVING은 그룹화된 데이터에 조건 적용
*/
-- menu_price,category_code로 grouping
-- category_code가 5이상, 8이하인 데이터 조회
SELECT menu_price,category_code
FROM tbl_menu
GROUP BY menu_price,category_code
HAVING category_code >= 5 AND category_code <= 8
ORDER BY menu_price;

-- WHERE로도 가능
SELECT menu_price,category_code
FROM tbl_menu
WHERE category_code >= 5 AND category_code <= 8
GROUP BY menu_price,category_code
ORDER BY menu_price;

-- grouping 전에 필터링을 할 수 없는 경우에는 HAVING만 가능
SELECT category_code,AVG(menu_price)
FROM tbl_menu
GROUP BY category_code
HAVING AVG(menu_price) >= 8000; -- WHERE은 사용 불가

/*
WITH ROLLUP
- GROUP BY에서 사용되는 확장기능
- 다양한 수준의 집계 데이터 생성 가능
*/
-- 총합을 구할 때
SELECT category_code,SUM(menu_price)
FROM tbl_menu
GROUP BY category_code
WITH ROLLUP;

-- column 두 개를 활용한 WITH ROLLUP
-- menu_price별 총합 및 해당 menu_price별 같은 카테고리의 총합
SELECT menu_price,
       category_code,
       COUNT(*),
       SUM(menu_price)
FROM tbl_menu
GROUP BY menu_price,category_code
WITH ROLLUP;


-- 1. 특정 카테고리 총 메뉴 가격이 20000원 이상
SELECT category_code,
       COUNT(*),
       SUM(menu_price)
FROM tbl_menu
GROUP BY category_code
HAVING SUM(menu_price) >= 20000;

-- 2. 특정 카테고리 메뉴 수가 3개 이상
SELECT category_code,
       COUNT(menu_code)
FROM tbl_menu
GROUP BY category_code
HAVING COUNT(menu_code) >= 3;

-- 3. 특정 카테고리에서 주문 가능한 메뉴의 평균 가격이 10000원 이상
SELECT category_code,
       AVG(menu_price)
FROM tbl_menu
WHERE orderable_status = 'Y'
GROUP BY category_code
HAVING AVG(menu_price) >= 10000;