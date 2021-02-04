/*
    * SUBQUERY (서브쿼리)
    - 하나의 주된 SQL문(SELECT, INSERT, UPDATE, CREATE, ...) 안에 포함된 또 하나의 SELECT문
    - 메인 SQL문을 위해 보조역할을 하는 쿼리문
    
*/

-- 간단 서브쿼리 예시1
-- 노옹철 사원과 같은 부서인 사원들에 대해 조회(사원명)

-- 1) 먼저 노옹철 사원의 부서코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철'; -->  D9인걸 알아냄!

-- 2) 부서코드가 D9인 사원들 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 위의 두 단계를 하나의 쿼리문으로!!
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '노옹철');


-- 간단 서브쿼리예시 2
-- 전체사원의 평균급여보다 더 많은 급여를 받고있는 사원들의 사번, 이름, 직급코드 조회
-- 1) 전 직원의 평균 급여 조회
SELECT AVG(SALARY)
FROM EMPLOYEE; -- 대략3047663원

-- 2) 급여가 3047663원 이상인 사원들 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3047663;

-- 위의 두 단계를 하나로 합치기
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                 FROM EMPLOYEE);
                 
-------------------------------------------------------------------------------
/*
    * 서브쿼리 구분
      서브쿼리를 수행한 결과값이 몇행 몇열이냐에 따라서 분류됨
      
      - 단일행 [단일열] 서브쿼리 : 서브쿼리를 수행한 결과값이 오로지 1개일때
      - 다중행 [단일열] 서브쿼리 : 서브쿼리를 수행한 결과값이 여러행일 때
      - [단일행] 다중열 서브쿼리 : 서브쿼리를 수행한 결과값이 여러열일 때
      - 다중행 다중열 서브쿼리   : 서브쿼리를 수행한 결과값이 여러행 여러컬럼일 때
      
      >> 서브쿼리를 수행한 결과가 몇행 몇열이냐에 따라 사용가능한 연산자도 달라짐
*/
/*
    1. 단일행 서브쿼리 (SINGLE ROW SUBQUERY)
       서브쿼리의 조회 결과값이 오로지 1개일 때
       
       일반 연산자 사용 가능 ( =, !=, <=, > ...)
       
*/
-- 전 직원의 평균 급여보다 더 적게받는 사원들의 사원명, 직급코드, 급여 조회
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)  --> 결과값 1행 1열 오로지 1개값
                FROM EMPLOYEE);
                
-- 최저급여를 받는 사원의 사번, 사원명, 직급코드, 급여, 입사일 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE);
                
-- 노옹철 사원의 급여보다 더 많이 받는 사원들의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY 
                FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철');

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE SALARY> (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철')
AND DEPT_CODE = DEPT_ID;

-- 전지연과 같은 부서인 사원들의 사번, 사원명, 전화번호, 직급명
SELECT * FROM EMPLOYEE;
SELECT * FROM JOB;

SELECT EMP_ID, EMP_NAME, PHONE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE DEPT_CODE = ( SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '전지연')
AND E.JOB_CODE = J.JOB_CODE;

SELECT EMP_ID, EMP_NAME, PHONE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE DEPT_CODE = ( SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '전지연')
  AND EMP_NAME != '전지연';
  
-- 부서별 급여합이 가장 큰 부서 하나만을 조회 부서코드 , 급여합 조회

/*
    2. 다중행 서브쿼리 (MULTI ROW SUBQUERY)
    서브쿼리의 조회 결과값이 여러행일 때
    
    -[NOT] IN 서브쿼리 : 여러개의 결과값 중에서 한개라도 일치하는 값이 있으면 / 없다면 이라는 의미
    
    ANY :                   OR
    - > ANY 서브쿼리 : 여러개의 결과값 중에서 "하나라도" 클 경우
                     여러개의 결과값 중에서 가장 작은값보다 클 경우
    - < ANY 서브쿼리 : 여러개의 결과값 중에서 "하나라도" 작을 경우
                     여러개의 결과값 중에서 가장 큰값 보다 작을 경우
    
    ALL : 모든               AND       
    - > ALL 서브쿼리 : 여러개의 결과값의 "모든"값보다 클 경우
                     여러개의 결과값 중에서 가장 큰 값보다 클 경우
    - < ALL 서브쿼리 : 여러개의 결과값의 "모든"값보다 작을 경우
                     여러개의 결과값 중에서 가장 작은 값보다 작을 경우
*/

-- 각 부서별 최고급여를 받는 사원의 이름, 직급코드, 급여 조회

-- 1) 각 부서별 최고 급여 조회
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- 2890000, 3660000, 8000000, 3760000, 3900000, 2550000

-- 2) 위의 급여를 받는 사원들 조회
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (2890000, 3660000, 8000000, 3760000, 3900000, 2550000);

--> 위의 두개의 단계를 합치자!
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY)
                FROM EMPLOYEE
                GROUP BY DEPT_CODE);

-- 선동일 또는 유재식 사원과 같은 부서인 사원들을 조회하시오 (사원명, 부서코드, 급여)
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ( SELECT DEPT_CODE
                     FROM EMPLOYEE
                     WHERE EMP_NAME IN ('선동일', '유재식'));

-- 사원 < 대리 < 과장 < 차장 < 부장
-- 대리직급임에도 불구하고 과장직급의 급여보다 많이 받는 직원 조회 (사번, 이름, 직급명, 급여)

-->> 과장 직급의 급여들 조회
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장'; -- 2200000, 2500000, 3760000

-->> 직급이 대리이면서 급여값이 위의 목록들 값 중에 하나라도 큰 사원
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
  AND SALARY > ANY (2200000, 2500000, 3760000);
   -- SALARY > 2200000 OR SALARY > 2500000 OR SALARY > 3760000
   
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
  AND SALARY > ANY (SELECT SALARY
                    FROM EMPLOYEE
                    JOIN JOB USING(JOB_CODE)
                    WHERE JOB_NAME = '과장');
                    
-- 사원 < 대리 < 과장 < 차장 < 부장
-- 과장직급임에도 불구하고 모든 차장직급의 급여보다도 더 많이 받는 사원 (사번, 사원명, 직급명, 급여)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장'
  AND SALARY > ALL (SELECT SALARY
                    FROM EMPLOYEE
                    JOIN JOB USING(JOB_CODE)
                    WHERE JOB_NAME = '차장');

-----------------------------------------------------------------------------------
/*
    3. [단일행] 다중열 서브쿼리
        조회결과값은 한 행이지만 나열된 컬럼수가 여러개일 때

*/
-- 하이유 사원과 같은 부서코드, 같은 직급코드에 해당하는 사원들 조회

-->> 하이유 사원의 부서코드와 직급코드 먼저 조회
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '하이유';     -- D5 / J5

-- >> 부서코드가 D5이면서 직급코드가 J5인 사원 조회
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
  AND JOB_CODE = 'J5';
  
-->> 위의 내용들을 하나의 쿼리문으로! (단일행 서브쿼리)
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '하이유')
  AND JOB_CODE = (SELECT JOB_CODE
                  FROM EMPLOYEE
                  WHERE EMP_NAME = '하이유');
                  
-->> 다중열 서브쿼리
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE  --> 결과값이 1행 여러 컬럼
                                 FROM EMPLOYEE
                                WHERE EMP_NAME = '하이유');

-- 박나라 사원과 같은 직급코드, 같은 사수사번을 가진 사원들의 사번, 이름, 직급코드, 사수사번 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                  FROM EMPLOYEE
                                 WHERE EMP_NAME = '박나라');








