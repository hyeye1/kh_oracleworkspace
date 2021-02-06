/*
    
    * DDL (DATA DEFINITION LANGUAGE) : 데이터 정의 언어
    
      오라클에서 제공하는 객체(OBJECT)를
      새로이 만들고(CREATE), 구조를 변경(ALTER)하고, 구조 자체를 삭제(DROP)하는 명령문
      즉, 구조 자체를 정의하는 언어로 주로 DB관리자, 설계자가 사용함
      
      오라클에서의 객체(구조) : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE),
                             인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER),
                             프로시져(PROCEDURE), 함수(FUNCTION),
                             동의어(SYNONYM), 사용자(USER)
*/
/*
    < CREATE TABLE >
   
    * 테이블이란? : 행(ROW)과 열(COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체
                   모든 데이터는 테이블을 통해서 저장됨 (== 데이터를 보관하고자 한다면 테이블을 만들어야됨)
    
    * 표현식
    CREATE TABLE 테이블명(
        컬럼명 자료형,
        컬럼명 자료형,
        컬럼명 자료형,
        ...
    );
    
    * 자료형
    - 문자 (CHAR(크기) / VARCHAR2(크기))
      > CHAR(바이트수) : 최대 2000BYTE까지 지정 가능 / 고정길이 (아무리 적은 값이 들어와도 처음 할당한 크기 유지(공백으로채워서))
      > VARCHAR2(바이트수) : 최대 4000BYTE까지 지정 가능 / 가변길이 (적은 값이 들어오면 그 담긴 값에 맞춰 크기가 줄어듬)
    - 숫자 (NUMBER)
    - 날짜 (DATE)
*/

-->> 회원들의 데이터(아이디,비밀번호,이름,회원가입일)를 담기위한 테이블 MEMBER 테이블 생성하기
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_DATE DATE
);

SELECT * FROM MEMBER;

/*
    * 컬럼에 주석달기 (컬럼에 대한 설명같은거)
    
    COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
*/
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
-- 회원비밀번호, 회원이름, 회원가입일
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원명';
COMMENT ON COLUMN MEMBER.MEMBER_DATE IS '회원가입일';


-- 데이터 딕셔너리 : 다양한 객체들의 정보를 저장하고 있는 시스템 테이블
SELECT * FROM USER_TABLES;
-- USER_TABLES : 현재 이 계정이 가지고 있는 테이블들의 전반적인 구조를 확인할 수 있는 데이터 딕셔너리
SELECT * FROM USER_TAB_COLUMNS;
-- USER_TAB_COLUMNS : 현재 이 계정이 가지고있는 테이블들의 모든 컬럼의 정보를 조회할 수 있는 데이터 딕셔너리

SELECT * FROM MEMBER;

-- 데이터 추가할 수 있는 구문 (INSERT == 한 행으로 추가)
-- INSERT INTO 테이블명 VALUES(값, 값, 값, 값, ...);
INSERT INTO MEMBER VALUES('user01', 'pass01', '홍길동', '2021-02-01');
INSERT INTO MEMBER VALUES('user02', 'pass02', '김말똥', '21/02/02');
insert into member values('user03', 'pass03', '강개순', sysdate);
INSERT INTO MEMBER VALUES(NULL, NULL, NULL, SYSDATE);           --> 아이디,비번,이름에 NULL이 존재해서는 안됨
insert into member values('user03', 'pass03', '김개똥', sysdate);--> 중복된 아이디 존재해서는 안됨

----------------------------------------------------------------------------------

/*
    < 제약조건 CONSTRAINTS > 
    - 원하는 데이터값만 유지하기 위해서 (보관하기 위해서) 특정 컬럼마다 설정하는 제약 (데이터 무결성 보장을 목적으로)
    - 제약조건이 부여된 컬럼에 들어올 데이터에 문제가 없는지 자동으로 검사할 목적
    
    * 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
    
    * 컬럼에 제약조건을 부여하는 방식 : 컬럼레벨 / 테이블레벨
    
*/

/*
    * NOT NULL 제약조건
      해당 컬럼에 반드시 값이 존재해야만 할 경우 사용 (NULL값이 절대 들어와서는 안되는 컬럼에 부여)
      삽입 / 수정시 NULL값을 허용하지 않도록 제한
      
      단, NOT NULL 제약조건은 컬럼레벨 방식 밖에 안됨!
*/

-- NOT NULL 제약조건만 설정한 테이블 만들기
-- 컬럼레벨 방식 : 컬럼명 자료형 제약조건  => 제약조건을 부여하고자하는 컬럼 뒤에 곧바로 기술
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL 
VALUES(1, 'user01', 'pass01', '김말똥', '남', '010-5511-9220', 'aaa@naver.com');

INSERT INTO MEM_NOTNULL
VALUES(2, NULL, NULL, NULL, NULL, NULL, NULL);
--> NOT NULL 제약조건에 위배되어 오류 발생

INSERT INTO MEM_NOTNULL
VALUES(2, 'user02', 'pass02', '홍길동', NULL, NULL, NULL);
--> NOT NULL 제약조건이 부여되어있는 컬럼에는 반드시 값이 존재해야됨

INSERT INTO MEM_NOTNULL
VALUES(3, 'user01', 'pass10', '강개순', '여', null, null);





