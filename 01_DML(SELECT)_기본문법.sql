/*

    <select>
    데이터를 조회하거나 검색할 때 사용되는 명령어
    
    * Result Set : Select 구문을 통해 조회된 데이터의 결과물을 뜻함
                    즉, 조회된 행들의 집합을 의미
    * 표현법
    SELECT조회하고자 하는 컬럼, 컬럼, 컬럼, ...
    FROM 테이블명;

*/

-- EMPLOYEE 테이블의 전체 사원들의 모든 컬럼(*) 조회  -> *은 모든것을 의미함.
SELECT * FROM EMPLOYEE;

-- EMPLOYEE 테이블의 전체 사원들의 사번, 이름, 급여 컬럼만을 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;



-----------------------실습문제-----------------------
--1. JOB테이블의 모든 컬럼 조회
SELECT * FROM JOB;

--2. JOB테이블의 직급명 컬럼만 조회
SELECT JOB_NAME FROM JOB;

--3. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT * FROM DEPARTMENT;

--4. EMPLOYEE 테이블의 직원명, 이메일, 전화번호, 입사일 컬럼만 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE FROM EMPLOYEE;

--5. EMPLOYEE 테이블의 입사일 직원명 급여 컬럼만 조회
SELECT HIRE_DATE, EMP_NAME, SALARY FROM EMPLOYEE;

/*
    <컬럼값을 통한 산술연산>
    - 조회하고자 하는 컬럼들을 나열하는 SELECT절에 산술연산(+-/*)을 기술해서 결과를 조회할 수 있다.
    
*/

-- EMPLOYEE 테이블로부터 직원명, 월급, 연봉(월급*12)
SELECT EMP_NAME, SALARY, SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE 테이블로부터 직원명, 월급, 보너스, 보너스가포함된연봉(월급+보너스*월급)*12
SELECT EMP_NAME, SALARY, BONUS, (SALARY+BONUS*SALARY)*12
FROM EMPLOYEE;
--> 산술연산하는 과정에 NULL값이 존재할 경우 산술연산 결과마저도 NULL값으로 조회된다.

-- EMPLOYEE 테이블로부터 직원명, 입사일, 근무일수(오늘날짜 -입사일) 조회
-- DATE타입끼리도 연산 가능 (DATE -> 년, 월, 일, 시, 분, 초)
-- 오늘날짜 : SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE
FROM EMPLOYEE;
-- 값이 지저분한 이유는 DATE타입안에 포함되어있는 시/분/초에 대한 연산까지 수행하기 때문이다.

/*
    <컬럼명에 별칭 지정하기>
    
    [표현법]
    1. 컬럼명 AS별칭, 2. 컬럼명 AS "별칭", 3. 컬럼명 별칭, 4. 컬럼명 "별칭"
    
    AS를 붙이든 안붙이든
    별칭에 특수문자나 띄어쓰기가 포함될 경우 반드시 "" 로 묶어서 표기해야됨
    
*/

SELECT EMP_NAME AS 이름, SALARY AS "급여 (원)", BONUS 보너스, (SALARY+BONUS*SALARY)*12 "총 소득"
FROM EMPLOYEE;
