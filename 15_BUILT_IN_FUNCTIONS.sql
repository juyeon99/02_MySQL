-- BUILT IN FUNCTIONS

/*
문자열 관련 함수
*/
-- ASCII: 아스키 코드 값 추출
-- CHAR:  아스키 코드로 문자 추출
SELECT ASCII('A'), CHAR(65);    -- 65, A

-- BIT_LENGTH(문자열): 할당된 bit 크기 반환
-- CHAR_LENGTH(문자열): 문자열의 길이 반환
-- LENGTH(문자열): 할당된 byte 크기 반환
SELECT BIT_LENGTH('pie'), CHAR_LENGTH('pie'), LENGTH('pie');    -- 24, 3, 3

SELECT menu_name,
       BIT_LENGTH(menu_name),
       CHAR_LENGTH(menu_name),
       LENGTH(menu_name)
FROM tbl_menu;

-- CONCAT(문자열1, 문자열2, ...): Concatenate 문자열
-- CONCAT_WS(delimiter, 문자열1, 문자열2, ...): 문자열을 구분자와 concatenate
SELECT CONCAT('호랑이','기린','토끼');         -- 호랑이기린토끼
SELECT CONCAT_WS('-','호랑이','기린','토끼');  -- 호랑이-기린-토끼
SELECT CONCAT_WS(',','호랑이','기린','토끼');  -- 호랑이,기린,토끼

-- ELT(위치, 문자열1, 문자열2, ...): 해당 위치의 문자열 반환
-- FIELD(찾을 문자열, 문자열1, 문자열2, ...): 찾을 문자열 반환
-- FIND_IN_SET(찾을 문자열, 문자열 리스트): 찾을 문자열의 위치 반환
-- INSTR(기준 문자열, 부분 문자열): 기준 문자열에서 부분 문자열의 시작 위치 반환
-- LOCATE(부분 문자열, 기준 문자열): INSTR와 순서만 반대
SELECT ELT(2,'사과','딸기','바나나') AS ELT,                   -- 딸기
       FIELD('딸기','사과','딸기','바나나') AS FIELD,           -- 2
       FIND_IN_SET('바나나', '사과,딸기,바나나') AS FINDINSET,  -- 3
       INSTR('사과딸기바나나', '딸기') AS INSTR,                -- 3
       LOCATE('딸기', '사과딸기바나나') AS LOCATE;              -- 3

-- INSERT(기준 문자열, 위치, 길이, 삽입할 문자열): 기준 문자열의 위치부터 길이만큼 지우고 문자열을 끼워넣음
SELECT INSERT('내 이름은 아무개입니다.', 7, 3, '홍길동');    -- 내 이름은 홍길동입니다.

-- LEFT(문자열, 길이): 왼쪽에서 문자열의 길이만큼 반환
-- RIGHT(문자열, 길이): 오른쪽에서 문자열의 길이만큼 반환
SELECT LEFT('hello world!', 3),     -- hel
       RIGHT('hello world!', 3);    -- ld!

-- UPPER(): 소문자를 대문자로 바꿈
-- LOWER(): 대문자를 소문자로 바꿈
SELECT LOWER('Hello World!'),   -- hello world!
       UPPER('Hello World!');   -- HELLO WORLD!

-- LPAD(문자열, 길이, 채울 문자열): 문자열을 길이만큼 왼쪽으로 늘린 후, 빈 곳을 채울 문자열로 채운다.
-- RPAD(문자열, 길이, 채울 문자열): 문자열을 길이만큼 오른쪽으로 늘린 후, 빈 곳을 채울 문자열로 채운다.
SELECT LPAD('왼쪽',6,'@'),    -- @@@@왼쪽
       RPAD('오른쪽',6,'@');  -- 오른쪽@@@

-- LTRIM(문자열): 왼쪽 공백 제거
-- RTRIM(문자열): 오른쪽 공백 제거
-- TRIM(문자열):  양쪽 공백 제거
-- TRIM(BOTH, LEADING(앞), TRAILING(뒤)): 해당 방향에 지정한 문자열 제거
SELECT LTRIM('      왼쪽'),
       RTRIM('오른쪽    '),
       TRIM('   양쪽    '),
       TRIM(BOTH '@' FROM '@@@@@mysql@@@@@');   -- mysql

-- REPEAT(문자열, 횟수): 문자열을 횟수만큼 반복
SELECT REPEAT('mysql',3);   -- mysqlmysqlmysql

-- REPLACE(문자열, 찾을 문자열, 바꿀 문자열): 문자열에서 문자열을 찾아 바꿈
SELECT REPLACE('마이SQL','마이','My');  -- MySQL

-- REVERSE(문자열): 문자열의 순서를 거꾸로 뒤집음
SELECT REVERSE('stressed');     -- desserts

-- SPACE(길이): 길이만큼의 공백 반환
SELECT CONCAT('안녕', SPACE(5), '하세요', SPACE(3), '반갑습니다.');   -- 안녕     하세요   반갑습니다.

-- SUBSTRING(문자열, 시작위치, 길이): 시작 위치부터 길이 만큼의 문자 반환(길이를 생략하면 시작부터 끝까지 반환)
SELECT SUBSTRING('안녕하세요 반갑습니다.',7,2),   -- 반갑
       SUBSTRING('안녕하세요 반갑습니다.',7);     -- 반갑습니다.

-- SUBSTRING_INDEX(문자열, delimiter, 횟수): delimiter가 왼쪽부터 횟수번째 나오면 그 이후의 오른쪽은 버린다.
-- 횟수가 음수일 경우, 오른쪽부터 세고 왼쪽을 버린다.
SELECT SUBSTRING_INDEX('hong.test.gmail.com', '.', 2);  -- hong.test
SELECT SUBSTRING_INDEX('hong.test.gmail.com', '.', -2); -- gmail.com


/*
숫자 관련 함수
*/
-- FORMAT(숫자, 소수점 자리수): 1000단위마다 , 표시해주며, 소수점 아래 자리수(반올림)까지 표현
SELECT FORMAT(123123123123.45678, 3);   -- 123,123,123,123.457

-- BIN(n): 2진수
-- OCT(n): 8진수
-- HEX(n): 16진수
SELECT BIN(65), OCT(65), HEX(65);   -- 100001, 101, 45

-- ABS(n): 절대값 반환
SELECT ABS(-123);   -- 123

-- CEILING(n): 올림값 반환
-- FLOOR(n):   내림값 반환
-- ROUND(n):   반올림값 반환
SELECT CEILING(1234.56), FLOOR(1234.56), ROUND(1234.56);    -- 1235, 1234, 1235

-- MOD(n1, n2), n1 % n2, n1 MOD n2 : n1을 n2로 나눈 나머지 추출
SELECT MOD(75,10), 75 % 10, 75 MOD 10;      -- 5

-- POW(n1, n2): 거듭제곱값 반환
-- SQRT(n): 제곱근 추출
SELECT POW(2,4), SQRT(16);  -- 16, 4

-- RAND(): 0이상 1미만의 실수 반환
-- 'm <= random # < n'
-- FLOOR((RAND() * (n-m)) + m)
-- 1부터 10까지의 random number
SELECT RAND(),
       FLOOR(RAND() * (11 - 1) + 1);

-- SIGN(n): 양수면 1, 0이면 0, 음수면 -1 반환
SELECT SIGN(10.1), SIGN(0.0), SIGN(-10.1);  -- 1, 0, -1

-- TRUNCATE(숫자, 정수): 소수점을 기준으로 정수 위치까지 구하고 나머지는 버림
SELECT TRUNCATE(12345.12745, 2),    -- 12345.12
       TRUNCATE(12395.12345, -2);   -- 12300

/*
날짜 및 시간 관련 함수
*/
-- ADDDATE(날짜, 차이): 날짜를 기준으로 차이를 더함
-- SUBDATE(날짜, 차이): 날짜를 기준으로 차이를 뺌
SELECT ADDDATE('2024-06-13', INTERVAL 30 DAY),  -- 2024-07-13
       ADDDATE('2024-06-13', INTERVAL 6 MONTH), -- 2024-12-13
       SUBDATE('2024-06-13', INTERVAL 30 DAY),  -- 2024-05-14
       SUBDATE('2024-06-13', INTERVAL 6 MONTH); -- 2023-12-13

-- ADDTIME(날짜/시간, 시간): 날짜/시간을 기준으로 시간을 더함
-- SUBTIME(날짜/시간, 시간): 날짜/시간을 기준으로 시간을 뺌
SELECT ADDTIME('2024-06-13 12:00:00', '1:0:1'), -- 2024-06-13 13:00:01
       SUBTIME('2024-06-13 12:00:00', '1:0:1'); -- 2024-06-13 10:59:59

-- 현재 연-월-일 시간-분-초 반환해주는 함수들
-- CURDATE(), CURTIME(), NOW(), SYSDATE()
SELECT CURDATE(),   -- 2024-06-13
       CURTIME(),   -- 12:03:42
       NOW(),       -- 2024-06-13 12:03:42
       SYSDATE();   -- 2024-06-13 12:03:42

-- YEAR(), MONTH(), DAY(), HOUR(), MINUTE(), SECOND(), MICROSECOND()
-- 날짜 또는 시간에서 연,월,일,시,초,밀리초 추출
SELECT YEAR(CURDATE()), -- 2024
       HOUR(CURTIME()); -- 12

-- DATE(): 연,월,일
-- TIME(): 시,분,초
SELECT DATE(NOW()), -- 2024-06-13
       TIME(NOW()); -- 12:07:45

-- LAST_DAY(날짜): 해당 날짜의 달에서 마지막 날짜를 구한다.
SELECT LAST_DAY('20240201');    -- 2024-02-29

-- MAKETIME(시, 분, 초): '시:분:초' TIME 형식을 만든다.
-- MAKEDATE(연도,정수): 해당 연도의 정수만큼 지난 날짜를 구한다.
SELECT MAKETIME(17,03,02),      -- 17:03:02
       MAKEDATE(2024,200);      -- 2024-07-18

-- QUARTER(날짜): 해당 날짜의 분기를 구한다.
SELECT QUARTER(NOW());          -- 2

-- TIME_TO_SEC(시간): 시간을 초단위로 반환
SELECT TIME_TO_SEC('1:1:1');    -- 3661
