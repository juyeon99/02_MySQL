/*
TRANSACTION
- DB에서 한 번에 수행되는 작업 단위
- 시작,진행,종료 단계를 가지며, 중간에 오류가 발생하면 ROLL BACK
- ROLL BACK: 시작 이전 단계로 되돌리는 작업
- MySQL은 기본적으로 자동 커밋 설정이 되어있음 (롤백이 안됨)
*/

SELECT * FROM tbl_menu;

-- autocommit 비활성화
SET autocommit = 0;
SET autocommit = OFF;

-- ROLLBACK
start transaction;
    INSERT INTO tbl_menu VALUES (null,'바나나스플릿',8500,4,'Y');
    UPDATE tbl_menu SET menu_name = '수정된메뉴' WHERE menu_code = 5;
    DELETE FROM tbl_menu WHERE menu_code = 9;
# COMMIT;
ROLLBACK;   -- 위의 insert,update,delete 실행취소

-- autocommit 다시 활성화
SET autocommit = 1;
SET autocommit = ON;