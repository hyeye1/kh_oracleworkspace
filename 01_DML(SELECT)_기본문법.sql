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

--> 명령어, 키워드 등은 대소문자를 가리지 않지만 담겨있는 데이터는 가린다.


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

-----------------------------------------------------------------------------------
--리터럴
int a = 20; --> 변수에 담기는 값자체를 리터럴이라고 부름

/*
    <리터럴>
    임의로 지정한 문자열('')을 SELECT절에 기술하면                                ( 자바에서는 문자열과 문자를 "" '' 로 표기했지만 여기선 문자와 문자열 구분없이 '')
    실제 그 테이블에 존재하는 데이터처럼 조회가능
*/
-- EMPLOYEE 테이블로부터 사번, 사원명, 급여, 단위('원') 조회하기
SELECT EMP_ID, EMP_NAME, SALARY, '원' 단위
FROM EMPLOYEE;

--------------------------------------------------------------------------------------

/*
    < DISTINCT >
    조회하고자하는 컬럼에 중복된 값을 딱 한번씩만 조회하고자 할 때 사용
    해당 컬럼명 앞에 기술한다.
    
    [표현법] DISTINCT 컬럼명
    
    (단, SELECT절에 단 한 개만 기술 가능)
*/
-- EMPLOYEE 테이블로부터 부서코드 조회
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

-- EMPLOYEE 테이블로부터 직급코드 조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- DEPT_CODE와 JOB_CODE 묶어서 조회
SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

--------------------------------------------------------------------------------

/*
    < WHERE 절 >
    
    조회하고자 하는 테이블에 특정 조건을 제시해서
    그 조건에 만족하는 데이터만을 조회하고자 할 때 기술하는 구문
    
    [표현법]
    SELECT 조회하고자하는 컬럼, 컬럼, . . . 
    FROM 테이블명
    WHERE 조건식;
    
    => 조건식에 다양한 연산자들 사용 가능
    
    < 비교 연산자 >
    >  <  >=  <=
         =
     !=  ^=  <>
*/
-- EMPLOYEE 테이블로부터 급여가 400만원 이상인 사원들만 조회(모든컬럼)
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE 테이블로부터 부서코드가 D9인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 부서코드 D9가 아닌 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';         --> 세가지 모두 일치하지 않음을 의미

-------------------------- 실습문제 --------------------------------------
-- 1. EMPLOYEE 테이블에서 급여가 300만원 이상인 사원들의 이름, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. EMPLOYEE 테이블에서 직급코드가 J2인 사원들의 이름, 급여, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J2';

-- 3. EMPLOYEE 테이블에서 현재 재직중인 사원들의 사번, 이름, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN != 'N';

-- 4. EMPLOYEE 테이블에서 연봉(급여*12)이 5000만원 이상인 사원들의 이름, 급여, 연봉, 입사일 조회
SELECT EMP_NAME, SALARY, (SALARY*12) "연봉" , HIRE_DATE    --3
FROM EMPLOYEE                                             --1
WHERE (SALARY*12) >= 50000000;                            --2
           --> SELECT에서 부여한 별칭("연봉")을  WHERE절에서 사용할 수 없다.
           --> 실행순서는 FROM-> WHERE -> SELECT이기때문
           
-----------------------------------------------------------------------------------


/*
    < 논리연산자 >
    여러개의 조건을 엮을 때 사용
    
    AND(~이면서, 그리고) , OR(~이거나, 또는)
*/
-- 부서코드가 'D9'이면서 급여가 500만원 이상인 사원들의 이름, 부서코드, 급여
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- 부서코드가 'D9'이거나 급여가 500만원 이상인 사원들의 이름, 부서코드, 급여
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

/*
    < BETWEEN AND>
    
    [표현법] 
    비교대상컬럼명 BETWEEN 하한값 AND 상한값
*/

-- 급여가 350만원 이상이고 600만원 이하인 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
--WHERE SALARY >= 3500000 AND SALARY <= 6000000;
WHERE SALARY BEWEEN 3500000 AND 6000000;

-- 급여가 350만원 이상 600만원 이하가 아닌 사원들
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
--WHERE NOT SALARY BETWEEN 3500000 AND 6000000;  -- 1번방법. 
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;  -- 2번방법. 
-- 오라클에서의 NOT은 자바로 따졌을 때 논리부정연산자인 !와 동일한 의미


-- ** BETWEEN AND 연산자 DATE형식간에서도 사용 가능
-- 입사일이 '90/01/01' ~ '01/01/01'인 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '01/01/01';


SELECT *
FROM EMPLOYEE
WHERE NOT HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

----------------------------------------
/*
    <LIKE 특정패턴>
    [표현법]
    비교대상컬럼명 LIKE '특정패턴'
    
    - 특정패턴에 와일드카드인 '%' '_' 을 가지고 제시할 수 있음
    > '%' : 0글자이상
    EX) 비교대상컬럼명 LIKE '문자%'    :   컬럼값중에 '문자'로 시작되는 걸 조회
        비교대상컬럼명 LIKE '%문자'    :   컬럼값중에 '문자'로 끝나는 걸 조회
        비교대상컬럼명 LIKE '%문자%'   :   컬럼값중에 '문자'가 포함되는 걸 조회
        
    > '_' : 1글자의미
    EX) 비교대상컬럼명 LIKE '_문자'    :   컬럼
*/
-- 성이 전씨인 사원들의 이름, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 이름중에 '하'가 포함된 사원들의 이름, 주민번호, 부서코드 조회
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%'; 

-- 전화번호 4번째 자리가 9로 시작하는 사원들의 사번, 사원명, 전화번호, 이메일조회
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
--WHERE PHONE LIKE '0109%' OR PHONE LIKE '0119%' OR PHONE LIKE '0179%';
WHERE PHONE LIKE '___9%';

-- 이름 가운데 글자가 '지'인 사원들의 모든칼럼
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_지_';

-------------------- 실습문제 ---------------------
-- 1. 이름이 '연'으로 끝나는 사람들의 이름, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 2. 전화번호 처음 3글자가 010이 아닌 사원들의 이름, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- 3. DEPARTMENT 테이블에서 해외영업과 관련된 부서들의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외영업%';

-- 어떤게 와일드 카드고 어떤게 데이터값인지 구분이 안됨!!
-- 데이터값으로 인식시킬 값 앞에 나만의 와일드 카드로 제시하고 나만의 와일드카드를 EXCAPE로 등록
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE'$';

-------------------- 실습문제 =------------------------
-- 1, 이름이 '연'으로 끝나는 사원들의 이름, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';


----------------------------------------------------------------
/*
    < IS NULL / IS NOT NULL >
    [표현법]
    비교대상컬럼 IS NULL : 컬럼값이 NULL일 경우
    비교대상컬럼 IN NOT NULL : 컬럼값이 NULL이 아닌 경우
*/
SELECT * FROM EMPLOYEE;

-- 보너스를 받지 않는 사원들 (BONUS 컬럼값이 NULL인)의 사번, 이름, 급여, 보너스
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
-- WHERE BONUS = NULL; => 제대로 안됨
WHERE BONUS IS NULL;

-- 보너스를 받는 사원들 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL ;

-- 사수가 없는 사원들의 사원명, 사수사번, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- 사수도 없고 부서배치도 받지않은사원들의 모든컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- 부서배치를 받진 않았지만 보너스는 받는 사원 조회 (사원명, 보너스, 부서코드)
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-----------------------------------------------------------
/*
    < IN >
     비교대상 컬럼값에 내가 제시한 목록들 중에 일치하는 값이 하나라도 존재하면 조회
     
    [표현법]
    비교대상칼럼 IN (값, 값, 값, . .)
*/
-- 부서코드가 D6이거나 또는 D8이거나 또는 D5인 사원들의 이름, 부서코드, 급여
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_COD = 'D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');

-- 그외의 사원들
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN ('D6', 'D8', 'D5');

------------------------------------------------------------------------------
/*
    < 연결 연산자 || >
    여러 컬럼값들을 마치 하나의 컬럼인 것 처럼 연결시켜주는 연산자
    컬럼과 리터럴(임의의 문자열)을 연결할 수 있음
    */
    
SELECT EMP_ID || EMP_NAME || SALARAY AS "연결됨"
FROM EMPLOYEE;

-- XXX번 XXX의 월급은 XXXXXX원 입니다.
SELECT EMP_ID || '번 ' || EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.' 급여정보
FROM EMPLOYEE;
    
    
/*
    0. ()
    1. 산술연산자
    2. 
    3. 비교연산자
    4. IS NULL          LIKE        IN
    5. BETWEEN AND
    6. NOT
    7. AND (논리연산자)
    8. OR (논리연산자)
*/

------------------------------------------------------------------

/*
    < ORDER BY 절 >
    SELECT문 가장 마지막에 기입하는 구문 뿐만 아니라 실행 순서 또한 가장 마지막
    
    [표현법]
    SELECT 조회할칼럼, 컬럼, ...
    FROM 조회할 테이블명
    WHERE 조건식
    ORDER BY 정렬기준으로세우고자하는컬럼명|별칭|컬럼순번[ASC|DESC]
    
    - ASC : 오름차순 정렬 ( 생략시 기본값)
    - DESC : 내림차순 정렬
    
    - NULLS FIRST : 정렬하고자 하는 컬럼값에 NULL이 있을 경우 해당 NULL값들을 앞으로 배치 (내림차순 정렬일 경우 기본값)
    - NULLS LAST : 정렬하고자 하는 컬럼값에 NULL이 있을 경우 해당 NULL값들을 뒤로 배치 (오름차순 정렬일 경우 기본값)
    


*/

SELECT *
FROM EMPLOYEE
--ORDER BY BONUS; -- ASC 또는 DESC 생략시 기본값이 ASC (오름차순정렬)
--ORDER BY BONUS ASC; -- ASC 는 NULLS LAST 구나
--ORDER BY BONUS ASC NULLS FIRST;
--ORDER BY BONUS DESC; -- DESC는 기본적으로 NULLS FIRST구나


ORDER BY BONUS DESC, SALARY ASC;
-- 첫번째로 제시한 정렬기준의 컬럼값이 일치할 경우 두번째 정렬기준을 가지고 다시정렬

-- 연봉별 내림차순 정렬
SELECT EMP_NAME, SALARY*12 "연봉"
FROM EMPLOYEE
-- ORDER BY SALARY*12 DESC;
-- ORDER BY 연봉 DESC;              --별칭 사용가능
ORDER BY 2 DESC;                   --컬럼 순번 사용가능

