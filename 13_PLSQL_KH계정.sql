/*

    오라클 자체에 내장되어있는 절차적 언어
    변수정의, 조건처리(IF), 반복처리(LOOP, FOR, WHILE)등을 지원하여 SQL의 단점을 보완
    다수의 SQL문을 한번에 실행가능 (BLOCK구조)
    
    * PL/SQL 구조
    - [선언부 (DECLARE SECTION)] : DECLARE로 시작, 변수나 상수를 선언 및 초기화하는 부분
    - 실행부 (EXECUTABLE SECTION) : BEGIN로 시작, 실행할 SQL문 또는 제어문(조건문, 반복문)
    - [예외처리부 (EXCEPTION SECTION)] : EXCEPTION로 시작,

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
    1_2) 레퍼런스 타입 변수 선언 및 초기화 (현재존재하고있는 특정 컬럼의 데이터타입으로 지정)
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
    
    -- 사번이 200인 사원의 사번, 이름, 급여 조회한 후 각각 EID, ENAME, SAL에 담기
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM EMPLOYEE
    --WHERE EMP_ID = 200;
    --WHERE EMP_ID = &사번;
    WHERE EMP_NAME = '&이름';
    --WHERE DEPT_CODE = '&부서코드'; --> 오류: SELECT INTO를 이용해서 조회결과를 변수에 담고자 한다면 반드시 한 행으로 조회되어야됨 
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID );
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/

----------------------------------실습문제------------------------------------------
/*
    레퍼런스타입변수로 EID, ENAME, JCODE, SAL, DTITLE을 선언하고
    각 자료형으로 EMPLOYEE의 EMP_ID, EMP_NAME, JOB_CODE, SALARY/DEPARTMENT의 DEPT_TITLE컬럼들의 데이터타임을 참조하게끔
    
    대체변수로 입력한 사원명과 일치하는 사원을 조회해서 각 변수에 대입 후 출력

*/
-- 선언부
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;

-- 실행부
BEGIN 
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_NAME = '&사원명';
    
    DBMS_OUTPUT.PUT_LINE(EID || ', ' || ENAME || ', ' || JCODE || ', ' || SAL || ', ' || DTITLE);
END;
/
-------------------------------------------------------------------------------------

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
    
    -- DBMS_OUTPUT.PUT_LINE(E);
    DBMS_OUTPUT.PUT_LINE('사번 : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('연봉 : ' || E.SALARY *12);
    DBMS_OUTPUT.PUT_LINE('보너스 포함 연봉 : ' || (E.SALARY + E.SALARY * E.BONUS) *12 );
    
END;
/










