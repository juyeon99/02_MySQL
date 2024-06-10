-- ORDER BY
-- SELECT와 함께 사용하며 결과 집합을 특정 열이나 값에 따라 정렬
SELECT
    menu_code,
    menu_name,
    menu_price
FROM tbl_menu
ORDER BY
--     menu_price asc;
--     menu_price desc;
    menu_price;

-- column에 따라 여러번 정렬 가능
-- price를 기준으로 내림차순 정렬 뒤 같은 가격이 있다면, menu_name에 따라 오름차순 정렬
SELECT
    menu_code,
    menu_name,
    menu_price
FROM tbl_menu
ORDER BY
    menu_price desc,
    menu_name;

-- column을 연산해서 연산결과와 함께 정렬 가능
-- order by를 이용해 연산결과와 함께 정렬
SELECT
    menu_code,
    menu_name,
    menu_code * menu_name AS multiple
FROM tbl_menu
ORDER BY multiple desc;

/*
FIELD('비교할 값','비교 대상','비교 대상',...)

첫번째 인자가 두번째 인자 이후의 값들과 비교해서 일치하면
첫번째로 일치하는 값의 위치의 index를 보여준다.
*/

SELECT field('A',  'A','B','C');
SELECT field('B',  'A','B','C');

-- DB의 데이터를 비교
SELECT field(orderable_status,  'N','Y')
FROM tbl_menu;

-- order by, field 같이 써서 사용
SELECT menu_name, orderable_status
FROM tbl_menu
ORDER BY field(orderable_status, 'N','Y');

-- null값이 있는 column에 대한 정렬
SELECT category_code, category_name, ref_category_code
FROM tbl_category
ORDER BY ref_category_code; -- 오름차순 정렬했을 때 null이 상단으로 온다.

-- null값 위치에 따라 정렬할 때
-- asc: null이 마지막으로 정렬
-- desc: null이 첫번부터 정렬
SELECT category_code, category_name, ref_category_code
FROM tbl_category
ORDER BY ref_category_code is null desc;

-- 한 개를 조회해서 두 번 정렬할 때
SELECT category_code, category_name, ref_category_code
FROM tbl_category
ORDER BY ref_category_code is null desc,    -- null값의 위치를 맨 위로 정하고
         ref_category_code asc;             -- 나머지를 오름차순으로 정렬
