/*
    < DDL : DATA DEFINITION LANGUAGE >
    데이터 정의 언어
    
    객체들을 새로 생성(CREATE), 수정(ALTER), 삭제(DROP)하는 구문
    
    1. ALTER
       객체 구조를 수정하는 구문
       
       <테이블 수정>
       ALTER TABLE 테이블명 수정할내용;
       
       - 수정할 내용 -
       1) 컬럼 추가/수정/삭제
       2) 제약조건 추가/삭제   --> 수정은 불가(수정하고자 한다면 삭제한 후 새로 추가)
       3) 테이블명/컬럼명/제약조건명 변경
*/

-- 1) 컬럼 추가/수정/삭제
-- 1-1) 컬럼 추가 (ADD) : ADD 추가할컬럼명 데이터타입 [DEFAULT 기본값]
SELECT * FROM DEPT_COPY;
 
-- CNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
--> 새로운 컬럼이 만들어지고 기본적으로 NULL값으로 채워짐

-- LNAME 컬럼 추가 DEFAULT 지정해서
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(40) DEFAULT '한국';
--> 새로운 컬럼이 만들어지고 NULL이 아닌 DEFAULT값으로 채워짐

-- 1-2) 컬럼 수정 (MODIFY)
--      데이터타입 수정 : MODIFY 수정할컬럼명 바꾸고자하는데이터타입
--      DEFAULT값 수정 : MODIFY 수정할컬럼명 DEFAULT 바꾸고자하는기본값

-- DEPT_ID 컬럼의 데이터타입을 CHAR(3)로 변경
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

--ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
--ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);

-- DEPT_TITLE 컬럼의 데이터타입을 VARCHAR2(40)로
-- LOCATION_ID 컬럼의 데이터타입을 VARCHAR2(2)로
-- LNAME 컬럼의 기본값을 '미국'
ALTER TABLE DEPT_COPY 
    MODIFY DEPT_TITLE VARCHAR2(40)
    MODIFY LOCATION_ID VARCHAR2(2)
    MODIFY LNAME DEFAULT '미국';

CREATE TABLE DEPT_COPY2
AS SELECT *
   FROM DEPT_COPY;

-- 1-3) 컬럼 삭제 (DROP COLUMN) : DROP COLUMN 삭제하고자하는컬럼명
SELECT * FROM DEPT_COPY2;

-- DEPT_COPY2로부터 DEPT_ID 컬럼 지우기
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ROLLBACK; --> DDL구문은 복구 불가능

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME; --> 테이블에 최소 한개의 컬럼은 존재해야함




