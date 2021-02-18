/*
    < PL/SQL >
    PROCUDURE LANGUAGE EXTENSION TO SQL
    
    오라클 자체에 내장되어있는 절차적 언어
    변수 정의, 조건처리(IF), 반복처리(LOOP,FOR,WHILE) 등을 지원하여 SQL의 단점을 보완
    다수의 SQL문을 한번에 실행 가능 (BLOCK구조)
    
    * PL/SQL 구조
    - [선언부 (DECLARE SECTION)] : DECLARE로 시작, 변수나 상수를 선언 및 초기화하는 부분
    - 실행부 (EXECUTABLE SECTION) : BEGIN로 시작, 실행할 SQL문 또는 제어문(조건문, 반복문) 등의 로직을 기술하는 부분
    - [예외처리부 (EXCEPTION SECTION)] : EXCEPTION로 시작, 예외 발생시 실행할 구문을 기술해두는 부분
*/

-- * 간단하게 화면에 HELLO ORACLE 출력
SET SERVEROUTPUT ON;
BEGIN
    -- System.out.println("Hello Oracle");
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/

---------------------------------------------------------------------------------

/*
    1. DECLARE 선언부
       변수 및 상수 선언해놓는 공간 (선언과 동시에 초기화도 가능)
       일반타입변수, 레퍼런스타입변수, ROW타입변수
    
    1_1) 일반타입변수 선언 및 초기화
         [표현법] 변수명 [CONSTANT] 자료형 [:= 값];
*/

DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    --EID := 800;
    --ENAME := '배장남';
    EID := &사번;
    ENAME := '&이름';
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/

---------------------------------------------------------------------------------

/*
    1_2) 레퍼런스 타입 변수 선언 및 초기화 (현재 존재하고있는 특정 컬럼의 데이터타입으로 지정)
         [표현법] 변수명 테이블명.컬럼명%TYPE;
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    /*
    EID := '200';
    ENAME := '선동일';
    SAL := 8000000;
    */
    
    -- 사번이 200인 사원의 사번, 이름, 급여 조회한 후 각각 EID, ENAME, SAL 담기
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM EMPLOYEE
    --WHERE EMP_ID = 202;
    --WHERE EMP_ID = &사번;
    WHERE EMP_NAME = '&이름';
    --WHERE DEPT_CODE = '&부서코드';  => 오류남!! (왜? : SELECT INTO를 이용해서 조회결과를 변수에 담고자 한다면 반드시 한행으로 조회되어야됨!)
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/

---------------------------- 실습문제 -------------------------------------
/*
    레퍼런스타입변수로 EID, ENAME, JCODE, SAL, DTITLE을 선언하고
    각 자료형으로 EMPLOYEE의 EMP_ID, EMP_NAME, JOB_CODE, SALARY / DEPARTMENT의 DEPT_TITLE 컬럼들의 데이터타입을 참조하게끔
    
    대체변수로 입력한 사원명과 일치하는 사원을 조회해서 각 변수에 대입 후 출력
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_NAME = '&사원명';
    
    DBMS_OUTPUT.PUT_LINE(EID || ', ' || ENAME || ', ' || JCODE || ', ' || SAL || ', ' || DTITLE);
END;
/

------------------------------------------------------------------------------------

/*
    1_3) ROW타입 변수
         어떤 테이블의 한 행에 대한 모든 컬럼값을 다 담을 수 있는 변수
         
         [표현법] 변수명 테이블명%ROWTYPE;
*/

DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    --WHERE EMP_ID = 201;
    WHERE EMP_NAME = '&사원명';
    
    --DBMS_OUTPUT.PUT_LINE(E);
    DBMS_OUTPUT.PUT_LINE('사번 : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('연봉 : ' || E.SALARY * 12);
    DBMS_OUTPUT.PUT_LINE('보너스 포함 연봉 : ' || (E.SALARY + E.SALARY * NVL(E.BONUS, 0)) * 12);
    -- 출력문 안에 산술연산식, 함수식 기술 가능
END;
/

--------------------------------------------------------------------------------

-- 2. BEGIN

-- < 조건문 >

-- 1) IF 조건식 THEN 실행내용 END IF;  

-- 사번 입력받은 후 해당 사원의 사번, 이름, 급여, 보너스율(%) 출력
-- 단, 보너스를 받지 않는 사원은 보너스율 출력 전 '보너스를 지급받지 않는 사원입니다' 출력
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';

    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY);
    
    IF (BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다');    
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('보너스율 : ' || BONUS * 100 || '%');
END;
/
SET SERVEROUTPUT ON;

-- 2) IF 조건식 THEN 실행내용 ELSE 실행내용 END IF; (IF-ELSE문)
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';

    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY);
    
    IF (BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다');    
    ELSE
        DBMS_OUTPUT.PUT_LINE('보너스율 : ' || BONUS * 100 || '%');
    END IF;
    
END;
/

-- 3) IF 조건식1 THEN 실행내용1 ELSIF 조건식2 THEN 실행내용2 .. [ELSE 실행내용N] END IF;

-- 사용자에게 점수값 입력받은 후 SCORE변수에 기록한 후 
-- 80점 이상은 '상', 60점 이상은 '중', 60점 미만은 '하' 처리한 후 GRADE변수에 기록
-- '당신의 점수는 XX점이고, 실력은 X입니다.'

DECLARE 
    SCORE NUMBER;
    GRADE CHAR(3);
BEGIN
    SCORE := &점수;
    
    IF SCORE >= 80 THEN GRADE := '상';
    ELSIF SCORE >= 60 THEN GRADE := '중';
    ELSE GRADE := '하';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('당신의 점수는 ' || SCORE || '점이고, 실력은 ' || GRADE || '입니다.');
END;
/

------------------------------- 실습문제 -------------------------------


DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(10);
BEGIN
    
    -- 사번입력받아 해당사번과 일치하는 사원의 사번, 사원명, 부서명, 근무국가코드 조회한 후 => EID,ENAME,DTITLE,NCODE 담기
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = '&사번';
    
    -- NCODE가 'KO' 일경우 TEAM변수에 '국내팀' 담기
    --        그에 아닐경우 TEAM 변수에 '해외팀' 담기
    IF NCODE = 'KO' THEN TEAM := '국내팀';
    ELSE TEAM := '해외팀';
    END IF;
    
    -- 사번,이름,부서명,소속에 대해 출력
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('소속 : ' || TEAM);
END;
/

--------------------------------------------------------------------------------

-- < 반복문 >

/*
    1) BASIC LOOP문
    
    [표현식]
    LOOP
        반복적으로실행할구문
        
        반복문을 빠져나갈수있는 구문
    END LOOP;
    
    => 반복문을 빠져나갈수있는 구문 (2가지)
       1) IF 조건식 THEN EXIT; END IF;
       2) EXIT WHEN 조건식;
*/

-- 1 ~ 5 까지 순차적으로 1씩 증가하는 값 출력
DECLARE
    I NUMBER := 1;
BEGIN
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 1;
        
        --IF I = 6 THEN EXIT; END IF;
        EXIT WHEN I=6;
    END LOOP;
END;
/

/*
    2) FOR LOOP문
    
    [표현식]
    FOR 변수 IN [REVERSE] 초기값..최종값
    LOOP
        반복적으로실행할구문
    END LOOP;
*/
BEGIN
    FOR I IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

BEGIN
    FOR I IN REVERSE 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

-- 반복문을 이용한 데이터 삽입
CREATE TABLE TEST2(
    TEST_NO NUMBER PRIMARY KEY,
    TEST_DATE DATE 
);

CREATE SEQUENCE SEQ_TEST2
START WITH 100;

BEGIN
    FOR I IN 1..50
    LOOP
        INSERT INTO TEST2 VALUES(SEQ_TEST2.NEXTVAL, SYSDATE);
    END LOOP;
END;
/
SELECT * FROM TEST2;

---------------------------------------------------------------------------------

/*
    3) WHILE LOOP문
    
    [표현식]
    WHILE 반복이수행될조건
    LOOP
        반복적으로실행할구문
    END LOOP;
*/

DECLARE
    I NUMBER := 1;
BEGIN
    
    WHILE I < 6
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 1;
    END LOOP;
END;
/
    
-----------------------------------------------------------------------------------

/*
    3. EXCEPTION (예외처리부)
    
    예외 (EXCEPTION) : 실행 중 발생하는 오류
    
    [표현법]
    EXCEPTION
        WHEN 예외명1 THEN 예외처리구문1;
        WHEN 예외명2 THEN 예외처리구문2;
        ...
        WHEN OTHERS THEN 예외처리구문N;
    
    * 시스템예외 (오라클에서 미리정의 되어있는 예외)
    - NO_DATA_FOUND : SELECT한 결과가 한 행도 없을 경우
    - TOO_MANY_ROWS : SELECT한 결과가 여러행일 경우
    - ZERO_DIVIDE : 0으로 나눌 때 
    - DUP_VAL_ON_INDEX : UNIQUE 제약조건에 위배되었을 경우
    ... 
*/

-- 사용자가 입력한 수로 나눗셈 연산한 결과 출력
DECLARE
    RESULT NUMBER;
BEGIN
    RESULT := 10 / &숫자;
    DBMS_OUTPUT.PUT_LINE('결과 : ' || RESULT);
EXCEPTION
    --WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('나누기 연산시 0으로 나눌순 없습니다.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('나누기 연산시 0으로 나눌순 없습니다.');
END;
/

-- UNIQUE 제약조건 위배시
BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = '&변경할사번'
    WHERE EMP_NAME = '노옹철';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번입니다.');
END;
/


DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO EID, ENAME
    FROM EMPLOYEE
    WHERE MANAGER_ID = &사수사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
EXCEPTION
    --WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('조회결과가 없습니다');
    --WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('너무 많은 행이 조회되었습니다.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('조회결과가 없거나 너무 많습니다.');
END;
/






