/*
    < DDL : DATA DEFINITION LANGUAGE >
    데이터 정의 언어
    
    객체들을 새로이 생성(CREATE), 수정(ALTER), 삭제(DROP)하는 구문
    
    1. ALTER
       객체 구조를 수정하는 구문
       
       <테이블 수정>
       ALTER TABLE 테이블명 수정할내용;
       
       - 수정할 내용 -
       1) 컬럼 추가/수정/삭제
       2) 제약조건 추가/삭제   --> 수정은 불가(수정하고자 한다면 삭제한 후 새로이 추가)
       3) 테이블명/컬럼명/제약조건명 변경
    
*/

-- 1) 컬럼 추가/수정/삭제
-- 1_1) 컬럼 추가 (ADD) : ADD 추가할컬럼명 데이터타입 [DEFAULT 기본값]
SELECT * FROM DEPT_COPY;

-- CNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
--> 새로운 컬럼이 만들어지고 기본적으로 NULL값으로 채워짐

-- LNAME 컬럼 추가 DEFAULT 지정해서
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(40) DEFAULT '한국';
--> 새로운 컬럼이 만들어지고 NULL이 아닌 DEFAULT값으로 채워짐


-- 1_2) 컬럼 수정 (MODIFY)
--      데이터타입 수정 : MODIFY 수정할컬럼명 바꾸고자하는데이터타입
--      DEFAULT값 수정 : MODIFY 수정할컬럼명 DEFAULT 바꾸고자하는기본값

-- DEPT_ID 컬럼의 데이터타입을 CHAR(3)로 변경
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

--ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
--ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);

-- 다중 수정 가능
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

-- 1_3) 컬럼 삭제 (DROP COLUMN) : DROP COLUMN 삭제하고자하는컬럼명

SELECT * FROM DEPT_COPY2;

-- DEPT_COPY2로부터 DEPT_ID 컬럼 지우기
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ROLLBACK; --> DDL구문은 복구 불가능

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME; --> 테이블에 최소 한개의 컬럼은 존재해야됨

------------------------------------------------------------------------------------

-- 2) 제약조건 추가/삭제

/*
    2_1) 제약조건 추가 
    - PRIMARY KEY : ADD PRIMARY KEY(컬럼명);
    - FOREIGN KEY : ADD FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명[(참조할컬럼명)];
    - UNIQUE      : ADD UNIQUE(컬럼명);
    - CHECK       : ADD CHECK(컬럼에대한조건);
    - NOT NULL    : MODIFY 컬럼명 NOT NULL;
    
    나만의 제약조건명을 부여하고자 한다면 : [CONSTRAINT 제약조건명] 제약조건
    
    주의사항 : 제약조건명은 현재 계정 내에 고유한 값으로 부여해야됨
*/

-- DEPT_COPY 테이블에
-- DEPT_ID컬럼에 PRIMARY KEY 제약조건 추가
-- DEPT_TITLE컬럼에 UNIQUE제약조건 추가
-- LNAME 컬럼에 NOT NULL 제약조건 추가
ALTER TABLE DEPT_COPY
ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;

/*
    2_2) 제약조건 삭제
    
    PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK : DROP CONSTRAINT 제약조건명
    NOT NULL : MODIFY 컬럼명 NULL 
*/

-- DCOPY_PK 제약조건 지우기
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

-- DCOPY_UQ 제약조건 지우기
-- LNAME 제약조건 지우기 NOT NULL => NULL
ALTER TABLE DEPT_COPY
DROP CONSTRAINT DCOPY_UQ
MODIFY LNAME NULL;

-----------------------------------------------------------------------

-- 3) 컬럼명/제약조건명/테이블명 변경 (RENAME)

-- 3_1) 컬럼명 변경 : RENAME COLUMN 기존컬럼명 TO 바꿀컬럼명
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 3_2) 제약조건명 변경 : RENAME CONSTRAINT 기존제약조건명 TO 바꿀제약조건명
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007242 TO DCOPY_LID_NN;

-- 3_3) 테이블명 변경 : RENAME [기존테이블명] TO 바꿀테이블명
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;

--------------------------------------------------------------------------------

/*
    2. DROP
       객체를 삭제하는 구문
*/
DROP TABLE DEPT_TEST;

-- 단, 어딘가에서 참조되고 있는 부모테이블들은 함부러 삭제안됨!!
-- 만약에 삭제하고 싶다면..
 
-- 1. 자식테이블 먼저 삭제한 후 부모테이블 삭제하는 방법
DROP TABLE 자식테이블;
DROP TABLE 부모테이블;

-- 2. 부모테이블만 삭제하는데 아싸리 맞물려있는 제약조건도 함께 삭제하는 방법
DROP TABLE 부모테이블 CASCADE CONSTRAINT;










