/*

    즉, 구조자체를 정의하는 언어로 주로 DB관리자, 설계자가 사용함
    
    오라클에서의 객체(구조) : 
                            

*/
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_DATE DATE
);

SELECT * FROM MEMBER;

DROP TABLE MEMBER;
/*
    * 컬럼에 주석달기 (컬럼에 대한 설명같은거)
    
    COMMENT ON COLUMN 컬럼명 IS '주석내용';
*/
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
-- 회원비밀번호, 회원이름, 회원가입일
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.MEMBER_DATE IS '회원가입일';

-- 데이터 딕셔너리: 다양한 객체들의 정보를 저장하고 있는 시스템 테이블
SELECT * FROM USER_TABLES;
-- USER_TABLES : 현재 이 계정이 가지고있는 테이블들의 전반적인 구조를 확인할 수있는 데이터 딕셔너리
SELECT * FROM USER_TAB_COLUMNS;
-- USER_TAB_COLUMNS : 현재 이 계정이 가지고있는 테이블들의 모든 컬럼의 정보를 조회할 수 있는 데이터 딕셔너리
SELECT * FROM MEMBER;

-- 데이터 추가할 수 있는 구문 (INSERT == 한 행으로 추가)
-- INSERT INTO 테이블명 VALUES(값,값,값,값, ..._);
INSERT INTO MEMBER VALUES('user01', 'pass01', '홍길동', '2021-02-01');
INSERT INTO MEMBER VALUES('user02', 'pass02', '김말똥', '21/02/02');
insert into member values('user03', 'pass03', '강개순', sysdate);
----------------------------------------------------------------------
/*
    < 제약 조건 constraints >
    - 원하는 데이터값만 유지하기 위해서 (보관하기 위해서) 특정 컬럼마다 설정하는 제약 (데이터 무결성 보장을 목적으로)
    - 제약조건이 부여된 컬럼에 들어올 데이터에 문제가 없는지 자동으로 검사할 목적
    
    * 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
*/
/*
    * NOT NULL 제약 조건
      해당 컬럼에 반드시 값이 존재해야만 할 경우 사용 (NULL값이 절대 들어와서는 안되는 컬럼에 부여)
      삽입 / 수정시 NULL값을 허용하지 않도록 제한
      
*/
--  NOT NULL 제약 조건만 설정한 테이블 만들기
-- 컬럼레벨 방식: 컬럼명 자료형 제약 조건 => 제약조건을 부여하고자 컬럼뒤에 곧바로 기술
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEN_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30) 
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL
VALUES(1, 'user01', 'pass01', '김말똥', '남', '010-5511-9220', 'aaa@naver.com');

INSERT INTO MEM_NOTNULL
VALUES(2, NULL, NULL, NULL, NULL, NULL, NULL);
--> NOT NULL 제약조건에 위배되어 오류발생

INSERT INTO MEM_NOTNULL
VALUES(3, 'user01', 'pass10', '강개순', '여', null, null);


