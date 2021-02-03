/*
    < JOIN >
    
    두 개이상의 테이블에서 데이터를 같이 조회하고자 할 때 사용되는 구문
    조회 결과는 하나의 결과물(result set)로 나옴
    
    관계형 데이터베이스에서는 최소한의 데이터로 각각의 테이블에 데이터를 보관하고 있음 (중복을 최소화하기 위해서)
    => 즉, JOIN 구문을 이용해서 여러개의 테이블간 "관계"를 맺어서 같이 조회해야함
    => 단, 무작정 JOIN을 해서 조회하는게 아니라
        테이블간 "연결고리"에 해당하는 컬럼을 "매칭"시켜서 조회해야한다.
            
                                           [ JOIN 용어 정리 ]
                        
                          JOIN은 크게 "오라클 전용구문"과 "ANSI(미국국립표준협회) 구문"
                        
                    오라클 전용구문(오라클)            |           ANSI구문(오라클+다른DBMS)
   --==========================================================================================================
                           등가 조인                 |            내부 조인 (INNER JOIN)   -> JOIN USING/ON
                         (EQUAL JOIN)              |            자연 조인 (NATUAL JOIN)  -> JOIN USING
   --------------------------------------------------------------------------------------------------------------
                           포괄 조인                 |           왼쪽 외부조인 (LEFT OUTER JOIN)
                        ( LEFT OUTER )             |           오른쪽 외부조인 (RIGHT OUTER JOIN)
                        (RIGHT OUTER )             |            전체 외부조인 (FULL OUTER JOIN) -> 오라클에서는 불가
    --------------------------------------------------------------------------------------------------------------
                    카테시안 곱 (CARTESIAN PRODUCT)  |          교차 조인(CROSS JOIN)
    -------------------------------------------------------------------------------------------------------------
    자체 조인(SELF JOIN) 비등가 조인(NON EQUAL JOIN)   |              JOIN ON



*/

-- 전체 사원들의 사번, 사원명, 부서코드, 부서명까지 알아내고자 한다면?
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 전체 사원들의 사번, 사원명, 직급코드, 직급명까지 알아내고자 한다면?
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, JOB_NAME
FROM JOB;
--------> 조인을 통해서 연결고리에 해당하는 컬럼만 제대로 매칭시키면 마치 하나의 결과물로 조회가능

/*
    1. 등가조인(EQUAL JOIN)/ 내부조인(INNER JOIN)
       연결시키는 컬럼의 값이 일치하는 행들만 조인해서 조회(== 일치하지않는 값들은 조회에서 제외)
*/
-- >> 오라클 전용 구문
--    FROM 절에 조회하고자하는 테이블들을 나열 (, 로)
--

--   전체사원의 사번, 사원명, 부서코드, 부서명 같이조회
-- 1) 연결할 두 컬럼명이 다른경우 (EMPLOYEE-"DEPT_CODE" / DEPARTMENT-"DEPT_ID")
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> 일치하지 않는 값은 조회에서 제외된거 확인가능
-- (DEPT_CODE가 NULL이었던 2명의 사원데이터 조회안됨, DEPT_ID가 D3,D4,D7인 부서데이터 조회안됨)

-- 사번, 사원명, 직급코드, 직급명
-- 2)연결할 두 컬럼명이 같을 경우 (EMPLOYEE - "JOB_CODE" / JOB- "JOB_CODE")

/*
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE JOB_CODE = JOB_CODE; 
-> 에러 : ambiguously : 애매하다, 모호하다 => 확실히 어떤테이블의 컬럼인지를 다 명시해줘야됨
*/

-- 방법1) 테이블명을 이용하는 방법
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- 방법2) 테이블의 별칭 사용 ( 각 테이블마다 별칭 부여가능)
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-->> ANSI 구문
-- FROM 절에 기준 테이블을 하나 기술 한 뒤
-- 그 뒤에 JOIN절에서 같이 조회하고자 하는 테이블 기술 ( 또한 매칭시킬 컬럼에 대한 조건도 같이 기술)
-- USING구문/ ON구문

-- 사번, 사원명, 부서코드, 부서명
-- 1) 연결할 두 컬럼명이 다른 경우 (EMPLOYEE- "DEPT_CODE"/ DEPARTMENT-"DEPT_ID")
-- => 무조건 ON 구문만 가능! (USING구문 불가능)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
/*INNER(생략가능)*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- 어떤테이블에 같이 조회할건지 JOIN -> 매칭시킬 구문 -ON

-- 사번 사원명 직급코드 직급명
-- 2) 연결할 두 컬럼명이 같을 경우(EMPLOYEE - "JOB_CODE" / JOB- "JOB_CODE")
-- ON 구문 , USING 구문 둘다 사용가능하나 ON을 더 선호한다

--  2_1) ON 구문 이용 : AMBIGUOSLY가 발생활 수 있기 때문에 확실히 명시해야함
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);
-- JOB테입블이랑 조인해서 EMPLOYEE를 조회할래!

--  2_2) USING구문 이용 : 일치하는 컬럼명만을 알아서 찾기때문에 AMBIGUOSLY발생 X
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- [참고] 위의 USING 구문의 예시는 NATURAL JOIN(자연조인)으로도 가능
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;
-- 두개의 테이블만 제시한 상태, 운좋게도 두개의 테이블에 일치하는 컬럼이 유일하게 한개 존재(JOB_CODE) => 알아서 매칭하여 조회한다.

-- 추가적인 조건도 제시가능!
-- 직급이 대리인 사원들의 정보를 조회

-->> 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME = '대리';

-->> ANSI 구문
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
FROM EMPLOYEE  E
-- JOIN JOB USING(JOB_CODE)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE JOB_NAME = '대리';

---------------------< 실습문제 >---------------------------------

-- 1. 부서가 '인사관리부'인 사원들의 사번, 사원명, 보너스를 조회
-->> 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE, DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE = '인사관리부';


-->> ANSI구문
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';

-- 2. 부서가 '총무부'가 아닌 사원들의 사원명, 급여, 입사일 조회
-->> 오라클 전용구문
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_ID = DEPT_CODE
AND DEPT_TITLE != '총무부';

-->> ANSI 구문
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE AND DEPT_TITLE != '총무부');
--WHERE DEPT_TITLE != '총무부';

-- 3. 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
-->> 오라클 전용구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND BONUS IS NOT null;

-->> ANSI 구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;

-- 4. 아래의 두 테이블 참고해서 부서코드, 부서명, 지역코드, 지역명(LOCAL_NAME) 조회
SELECT * FROM DEPARTMENT; -- LOCATION_ID
SELECT * FROM LOCATION;   -- LOCAL_CODE
-->> 오라클 전용 구문
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT;

-->> ANSI구문
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- 추가) 사번, 사원명, 부서명, 직급명
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;

-->> 오라클 전용구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID -- 매칭을 시키고~
AND E.JOB_CODE = J.JOB_CODE;

-->> ANSI 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);

------------------------------------------------------------------------여기까지가 등가조인,내부조인
-- 일치하는게 없으면 조회되지않는다, 무조건 찾아서 조인하는게 분가조인과 내부조인의 특징
-----------------------------------------------------------------------------------------------
/*
    2. 포괄조인 / 외부조인 (OUTER JOIN)
    
    테이블간의 JOIN시 일치하지 않은 행도 포함시켜서 조회가능
    단, 반드시 LEFT/RIGHT를 지정해야함! (기준이 되는 테이블 지정해야됨!)
    
*/
-- "전체" 사원들의 사원명, 급여, 부서명 조회
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- DEPT_CODE가 NULL인 두명의 사원 조회 X
-- 부서에 배정된 사원이 없는 부서(D3, D4, D7)같은 경우 조회 X

-- 1) LEFT[OUTER] JOIN : 두 테이블 중 왼편에 기술된 테이블 기준으로 JOIN
--                       즉, 뭐가 됐든 왼편에 기술된 테이블의 데이터는 무조건 조회되게 (일치하는 것을 찾지 못했어도)
-->> ANSI구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
LEFT /*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--> EMPLOYEE 테이블 기준으로 조회했기 때문에 EMPLOYEE에 존재하는 데이터는 뭐가 됐든 조회되게끔!

-->> 오라클 전용구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE =DEPT_ID(+); --> 내가 기준으로 삼을 테이블의 컬럼명이아닌 반대 테이블의 컬럼명에(+)

-- 2) RIGHT [OUTER] JOIN : 두 테이블 중 오른편에 기술된 테이블을 기준으로 JOIN
--                         즉, 오른쪽테이블에 있는 건 무조건 조회하겠다! (일치하는 걸 찾지 못하더라도)
-->> ANSI구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
RIGHT/*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-->> 오라클 전용 구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- 3) FULL [ORDER] JOIN : 두 테이블이 가진 모든 행을 조회할 수 있도록 (단, 오라클 전용구문에서는 불가)
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
FULL /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-->> 오라클 전용구문(에러난다)
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);

-------------------------------------------------------------------------------
/*
    3. 카테시안곱(CARTESIAN PRODUCT) / 교차조인 (CROSS JOIN)
    모든 테이블의 각 행들이 서로서로 매핑된 데이터가 조회됨(곱집합)
    
    두테이블의 행들이 모두 곱해진 행들의 조합 출력 -> 방대한 데이터 출력 => 과부하의 위험
*/
-- 사원명, 부서명
--> 오라클 전용 구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT; --> 23 * 9 => 207개 행 조회

-->> ANSI 구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;

------------------------------------------------------------------------------
/*
    4. 비등가 조인(NON EQUAL JOIN)
    '='(등호)를 사용하지 않는 조인문
    
    지정한 컬럼값ㄱ이 일치하는 경우가 아닌, "범위"에 포함되는 경우 매칭
    
    
*/
-- 사원명, 급여
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;

SELECT *
FROM SAL_GRADE;

-- 사원명, 급여, 급여등급(SAL_LEVEL)
-->> 오라클 전용구문
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
--WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-->> ANSI 구문 ( ON 구문만! )
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);







