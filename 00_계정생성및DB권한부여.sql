-- MySQL 계정 만들기
-- 1) 새로운 계정 만들기
create user 'ohgiraffers'@'%' identified by 'ohgiraffers';

-- 2) 계정이 추가된 것을 확인하기
use mysql
select * from user;


-- DB 생성하기
--1) 데이터베이스 생성
create database menudb;
-- create schema menudb; -- 이것도 같은 역할을 한다.

-- MYSQL은 개념적으로 database와 스키마를 구분하지 않는다.
SHOW databases;

--2) 권한 부여하기
-- menudb 데이터베이스에 대한. * (와일드카드로 모든 권한을 의미)
-- 모든 권한을 준다. to (~에게) 어느 ip로 접속한 ohgiraffers 계정에게
grant all privileges on menudb.* to 'ohgiraffers'@'%';

-- 권한 확인하기
show grants for 'ohgiraffers'@'%';

-- menu db에서 뭔가 쿼리를 써서 데이터를 넣거나 조회하고 싶다면 이제
use menudb -- 를 사용하면 된다.