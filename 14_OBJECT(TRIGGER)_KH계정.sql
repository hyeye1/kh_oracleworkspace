
/*
    < 트리거 TRIGGER >
    
    내가 지정한 테이블에 INSERT, UPDATE, DELETE 와 같은 DML문에 의해 변경되었을 경우 (테이블에 이벤트 발생했을 경우)
    자동(묵시적)으로 매번 실행될 내용을 정의해둘 수 있는 객체
    데이터 무결성 보장의 목적
    
    EX)
    입출고에 대한 데이터가 기록(INSERT)될 때 마다 해당 상품에 대한 재고수량 매번 수정(UPDATE)해야될 경우
    회원탈퇴시 기존의 회원테이블에 데이터 DELETE 후 탈퇴된회원들만 따로 보관하는 테이블에 자동으로 INSERT시켜야될 경우
    
    * 트리거 종류
    > SQL문의 실행 시기에 따른 분류
    - BEFORE TRIGGER : 내가 지정한 테이블에 이벤트가 발생되기 전 트리거 실행
    - AFTER TRIGGER : 내가 지정한 테이블에 이벤트가 발생된 후 트리거 실행
    
    > SQL문에 의해 영향을 받는 각 행에 따른 분류
    - STATEMENT TRIGGER(문장 트리거) : 이벤트가 발생한 SQL문에 대해 딱 한번만 트리거 실행 
    - ROW TRIGGER(행 트리거) : 해당 SQL문 실행될 때 마다 매번 트리거 실행 
                              트리거 생성 구문 작성시 FOR EACH ROW 옵션 기술해야됨
            => :OLD     : BEFORE UPDATE(수정전 자료), BEFORE DELETE(삭제전 자료)
            => :NEW     : AFTER INSERT(입력후 자료), AFTER UPDATE(수정된 자료) 
    
    * 트리거 생성구문
    [표현식]
                                TRG_
    CREATE [OR REPLACE] TRIGGER 트리거명
    BEFORE|AFTER  INSERT|UPDATE|DELETE  ON 테이블명
    [FOR EACH ROW]
    [DECLARE 
        변수선언;]
    BEGIN
        해당위에 지정된 이벤트 발생시 묵시적으로(자동으로) 실행할 구문;
    [EXCEPTION
        예외처리구문;]
    END;
    /
    
    
*/

-- EMPLOYEE테이블에 새로운 행이 INSERT 될때 마다 자동으로 메세지 출력하는 트리거 정의
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원님 환영합니다');
END;
/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
VALUES('300', '김개똥', '444444-5555555', 'J7', SYSDATE);

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
VALUES('301', '강개순', '444444-5555555', 'J7', SYSDATE);

-----------------------------------------------------------------------

-- 상품 입고 및 출고 관련 예시

-->> 필요한 테이블, 시퀀스 생성

-- 1. 상품에 대한 데이터 보관할 테이블 (TB_PRODUCT) 생성 구문
--    PCODE (자료형 : NUMBER, 제약조건 : PRIMARY KEY) => 상품코드
--    PNAME (자료형 : VARCHAR2(30), 제약조건 : NOT NULL) => 상품명
--    BRAND (자료형 : VARCHAR2(30), 제약조건 : NOT NULL) => 브랜드명
--    PRICE (자료형 : NUMBER)                           => 가격
--    STOCK (자료형 : NUMBER, 제약조건 : NOT NULL, 기본값 : 0) => 재고수량
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,
    PNAME VARCHAR2(30) NOT NULL,
    BRAND VARCHAR2(30) NOT NULL,
    PRICE NUMBER,
    STOCK NUMBER DEFAULT 0 NOT NULL
);


-- 상품코드번호로써 적용시킬 시퀀스 (SEQ_PCODE) 생성 구문
-- 시작값 : 1001
-- 캐시메모리 사용 안함
CREATE SEQUENCE SEQ_PCODE
START WITH 1001
NOCACHE;

-- 샘플 데이터 추가
INSERT INTO TB_PRODUCT
VALUES(SEQ_PCODE.NEXTVAL, '갤럭시20', '샘송', 1400000, DEFAULT);

INSERT INTO TB_PRODUCT
VALUES(SEQ_PCODE.NEXTVAL, '아이폰12pro', '사과', 1300000, DEFAULT);

INSERT INTO TB_PRODUCT
VALUES(SEQ_PCODE.NEXTVAL, '대륙폰', '샤우미', NULL, 20);

COMMIT;

-- 2. 상품 입출고 상세 이력 테이블 (TB_PRODETAIL)
--    어떤 상품이 어떤날 몇개가 입고/출고가 되었는지 기록하는 테이블
CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,               -- 입출고이력번호
    PCODE NUMBER REFERENCES TB_PRODUCT,     -- 상품코드
    DDATE DATE NOT NULL,                    -- 상품입출고일
    AMOUNT NUMBER NOT NULL,                 -- 수량(입출고개수)
    STATUS CHAR(6) CHECK(STATUS IN ('입고', '출고'))
);

-- 입출고 이력번호로 적용시킬 시퀀스(SEQ_DCODE) 생성
CREATE SEQUENCE SEQ_DCODE
NOCACHE;

-- 1001번 상품이 오늘날짜로 10개가 입고 될 경우
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 1001, SYSDATE, 10, '입고');

UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PCODE = 1001;

COMMIT;

-- 1002번 상품이 오늘날짜로 20개가 입고될 경우
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 1002, SYSDATE, 20, '입고');

UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 1002;

COMMIT;

-- 1003번 상품이 오늘날짜로 3개 출고될 경우
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 1003, SYSDATE, 3, '출고');

UPDATE TB_PRODUCT
SET STOCK = STOCK - 3
WHERE PCODE = 1002;

ROLLBACK;

-- TB_PRODETAIL 테이블에 INSERT 후 
-- 자동으로 TB_PRODUCT테이블에 UPDATE 되게끔 트리거 정의
CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    -- 상품이 입고된 경우 => 재고수량 증가 UPDATE
    IF (:NEW.STATUS = '입고')
        THEN
            UPDATE TB_PRODUCT
            SET STOCK = STOCK + :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
    -- 상품이 출고된 경우 => 재고수량 감소 UPDATE
    IF (:NEW.STATUS = '출고')
        THEN
            UPDATE TB_PRODUCT
            SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/

-- 1001번 상품이 오늘날짜로 100개가 입고
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 1001, SYSDATE, 100, '입고');

-- 1003번 상품이 오늘날짜로 10개가 출고
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 1003, SYSDATE, 10, '출고');









