-- SUBQUERY
-- 다른 쿼리 안에서 실행되는 쿼리
-- 존재하지 않는 조건에 근거한 값들을 검색하고자 할 때 사용
-- 메인쿼리가 서브쿼리를 포함하는 종속적인 관계

/*
서브쿼리의 유형

1. 일반 서브쿼리
  1-a. 단일행 일반 서브쿼리
  1-b. 다중행 일반 서브쿼리
2. 상관 서브쿼리
  2-a. 스칼라 서브쿼리
*/

/*
서브쿼리의 규칙

- 반드시 ()로 묶어야한다. (SELECT ...) 형태
- 서브쿼리는 연산자의 오른쪽에 위치
- 서브쿼리 내에서 ORDER BY는 지원 X
*/

-- 단일 행 서브쿼리
-- 민트미역국이랑 같은 카테고리의 메뉴 조회
-- 1. 쿼리를 2번 사용하여 결과 구하기
SELECT category_code
FROM tbl_menu
WHERE menu_name = '민트미역국';

SELECT menu_code 메뉴코드,
       menu_name 메뉴명,
       menu_price 메뉴가격,
       orderable_status 주문가능여부
FROM tbl_menu
WHERE category_code = 4;

-- 2. 서브쿼리 이용
SELECT menu_code 메뉴코드,
       menu_name 메뉴명,
       menu_price 메뉴가격,
       orderable_status 주문가능여부
FROM tbl_menu
WHERE category_code = (
    SELECT category_code
    FROM tbl_menu
    WHERE menu_name = '민트미역국'
    );

-- 다중행 서브쿼리
-- 카테고리가 식사인 모든 category_code 조회
SELECT category_code
FROM tbl_category
WHERE ref_category_code = 1;

SELECT *
FROM tbl_menu
WHERE category_code IN (
    SELECT category_code
    FROM tbl_category
    WHERE ref_category_code = 1
    );

/*
ALL
- 서브쿼리의 결과 모두에 대해 연산결과가 참이면 참 반환

x > ALL(..)  : 모든 값보다 크면 참, 최대값보다도 크면 참
x >= ALL(..) : 모든 값보다 크거나 같으면 참, 최대값보다도 크거나 같으면 참
x < ALL(..)  : 모든 값보다 작으면 참, 최소값보다도 작으면 참
x <= ALL(..) : 모든 값보다 작거나 같으면 참, 최소값보다도 작거나 같으면 참
x = ALL(..)  : 모든 값과 같으면 참
x != ALL(..) : 모든 값과 다르면 참 (= NOT IN)
*/

-- 가장 비싼 메뉴 조회
SELECT MAX(menu_price)
FROM tbl_menu;

SELECT *
FROM tbl_menu
WHERE menu_price >= ALL(
        SELECT menu_price   -- tbl_menu에 있는 모든 메뉴 가격들
        FROM tbl_menu
    );

-- 한식보다 비싼 일식 or 중식
SELECT *
FROM tbl_menu
WHERE category_code IN (5,6) AND
      menu_price > ALL(
          SELECT menu_price     -- 한식의 메뉴 가격들
          FROM tbl_menu
          WHERE category_code = 4
      );

/*
상관 서브쿼리
- 메인쿼리가 서브쿼리의 결과에 영향을 주는 경우를 의미
- 메인쿼리의 값을 서브쿼리에게 주고 서브쿼리를 수행한 다음 그 결과를 다시 메인쿼리로 반환하는 형식

- 서브쿼리의 WHERE절 수행을 위해 메인쿼리가 먼저 수행되는 구조
- 메인쿼리 테이블의 행에 따라 서브쿼리의 결과값도 바뀐다.
*/

-- 카테고리 별 평균 가격이 가장 비싼 메뉴 조회
SELECT category_code,MAX(menu_price)
FROM tbl_menu
GROUP BY category_code;

SELECT *
FROM tbl_menu a     -- 이 테이블을
WHERE menu_price = (
    SELECT MAX(menu_price)
    FROM tbl_menu
    WHERE category_code = a.category_code   -- 여기서 가져다 씀
    );


/*
EXISTS
- 서브쿼리 결과 집합에 행이 존재하면 참, 행이 존재하지 않으면 거짓
*/
-- tbl_menu에서 사용되는 카테고리만 조회
SELECT a.category_code, a.category_name
FROM tbl_category a
WHERE EXISTS(
    SELECT category_code
    FROM tbl_menu b
    WHERE b.category_code = a.category_code
    );

/*
스칼라 서브쿼리
- 결과값이 1개인 서브쿼리, 주로 SELECT문에서 사용
- 스칼라 = 단일문
*/

-- 메뉴명, 카테고리명 조회
SELECT a.menu_name, b.category_name
FROM tbl_menu a
LEFT JOIN tbl_category b ON a.category_code = b.category_code;

-- 스칼라 서브쿼리
SELECT a.menu_name,
       (SELECT category_name
        FROM tbl_category b
        WHERE b.category_code = a.category_code) '카테고리명'
FROM tbl_menu a;

-- 스칼라 서브쿼리의 반환 개수가 1행보다 많을 수 X
# SELECT menu_name,
#        (SELECT category_name
#         FROM tbl_category) category_name
# FROM tbl_menu;

/*
CTE(Common Table Expressions)
- 서브쿼리랑 비슷한 개념
- 코드의 가독성과 재사용성을 위해 사용
- FROM절에서만 사용 (JOIN일시 JOIN 구문에서 가능)
*/
-- 메뉴명과 카테고리명을 함께 출력
WITH menucategory AS (
    SELECT menu_name,category_name
    FROM tbl_menu a
    JOIN tbl_category b ON a.category_code = b.category_code
)

SELECT *
FROM menucategory
ORDER BY menu_name;