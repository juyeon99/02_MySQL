/*
VIEW
- SELECT 쿼리문을 저장한 객체 -> 가상테이블
- 실질적인 데이터를 물리적으로 저장하고 있지 않음
- 테이블을 사용하는 것과 같이 동일하게 사용 가능

ex) employee 테이블에서 SALARY만 제외하고 VIEW 생성
*/

-- VIEW 생성
CREATE VIEW korean_food AS
SELECT * FROM tbl_menu
WHERE category_code = 4;    -- 한식

-- 베이스 테이블(tbl_menu) 정보가 변경되면 VIEW의 결과도 같이 변경됨
INSERT INTO tbl_menu VALUES (null,'식혜맛국밥',5500,4,'Y');
SELECT * FROM korean_food;
SELECT * FROM tbl_menu;

-- VIEW 통한 INSERT
INSERT INTO korean_food VALUES (null,'수정과맛국밥',5500,4,'Y');

-- VIEW 통한 UPDATE
UPDATE korean_food
SET menu_name = '버터맛국밥', menu_price = 5700
WHERE menu_code = 23;

-- VIEW 통한 DELETE
DELETE FROM korean_food
WHERE menu_code = 23;

/*
사용된 SUBQUERY에 따라 명령어로 조작이 불가능한 경우

1) VIEW 정의에 포함되지 않은 column을 조작하는 경우
2) VIEW에 포함되지 않는 column중에 베이스가 되는 테이블 column이 NOT NULL인 경우
3) 산술 표현식이 정의된 경우
4) JOIN을 이용해 여러 테이블을 연결한 경우
5) DISTINCT를 포함한 경우
6) 그룹함수나 GROUP BY를 포함한 경우
*/

-- VIEW 삭제
DROP VIEW korean_food;

-- VIEW에 쓰인 SUBQUERY 연산 결과도 column으로 사용 가능
CREATE VIEW korean_food AS
    SELECT menu_name AS '메뉴명',
           TRUNCATE(menu_price / 1000, 1) AS '가격(천원)',
           category_name AS '카테고리명'
    FROM tbl_menu a
        JOIN tbl_category b
        ON a.category_code = b.category_code
    WHERE b.category_name = '한식';

SELECT * FROM korean_food;

-- OR REPLACE 옵션
-- 테이블을 DROP하지 않고 기존의 VIEW를 새로운 VIEW로 쉽게 교체 가능
CREATE OR REPLACE VIEW korean_food AS
    SELECT menu_code AS '메뉴코드',
           menu_name AS '메뉴명',
           category_name AS '카테고리명'
    FROM tbl_menu a
        JOIN tbl_category b ON a.category_code = b.category_code
    WHERE b.category_name = '한식';