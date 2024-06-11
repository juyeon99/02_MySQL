-- DISTINCT
-- 중복된 값을 제거하는데 사용된다.
-- 중복을 제거해서 컬럼에 있는 컬럼값의 종류를 쉽게 파악 할 수 있다.

SELECT DISTINCT category_code
FROM tbl_menu
ORDER BY category_code;

-- null 값을 포함하는 column에 DISTINCT 사용 (null 값 또한 종류로 취급)
SELECT DISTINCT ref_category_code
FROM tbl_category;

-- 다중열 DISTINCT 사용
-- 다중열의 값들이 모두 동일하면 중복된 것으로 판별
SELECT DISTINCT category_code,orderable_status
FROM tbl_menu;