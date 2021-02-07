
-- 사원테이블에서 사원명, 직급코드, 보너스를받는사원수를 조회한 후 직급코드별 오름차순 정렬 하려고함...
SELECT 
       EMP_NAME
     , JOB_CODE
     , COUNT(*) AS "사원수"
FROM EMPLOYEE
WHERE BONUS != NULL
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

--> 문제점1. BONUS가 NULL이 아닌 이라는 조건이 제대로 수행되지 않을꺼임..
--> 문제점2. SELECT 절에서 그룹함수를 제외한 모든 컬럼을 GROUP BY에 기술해야되는데 안되어잇음

--> 조치1. BONUS IS NOT NULL로 조건을 수정해야됨
--> 조치2. GROUP BY 절을 EMP_NAME, JOB_CODE로 수정해야됨
SELECT 
       EMP_NAME
     , JOB_CODE
     , COUNT(*) AS "사원수"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY JOB_CODE, EMP_NAME
ORDER BY JOB_CODE;

---------------------------------------------------------------------------------

-- 각 부서별 그룹을 지어서
-- 부서코드, 부서별급여합, 부서별평균급여(정수처리), 부서별사원수 조회 후 부서코드별 오름차순 정렬
-- 단, 부서별 평균급여가 2800000초과인 부서만을 조회
SELECT 
       DEPT_CODE
     , SUM(SALARY) "합계"
     , ROUND(AVG(SALARY)) "평균"
     , COUNT(*) "사원수"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

--> 조건 누락 HAVING 절을 추가해야됨
SELECT 
       DEPT_CODE
     , SUM(SALARY) "합계"
     , ROUND(AVG(SALARY)) "평균"
     , COUNT(*) "사원수"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 2800000
ORDER BY DEPT_CODE;

---------------------------------------------------------------------------------

-- 부서별 급여합이 1000만원 이상인 부서만을 조회 (부서코드, 부서별 급여합)
SELECT 
       DEPT "부서명"
     , SUM(SALARY) "급여합"
FROM EMP
GROUP BY DEPT
HAVING SUM(SALARY) > 9000000;

-- '800918-2******' 주민번호 조회 => SUBSTR, RPAD
SELECT
       ENAME "사원명"
     , RPAD ( SUBSTR(ENO, 1, 8), 14, '*' ) "주민번호"
FROM EMP;



-- 직원들의 급여를 인상시켜서 조회
-- 직급코드가 'J7'인 사원은 급여를 10%로 인상해서 조회    SALARY * 1.1
--          'J6'인 사원은 급여를 15%로 인상해서 조회     SALARY * 1.15
--          'J5'인 사원은 급여를 20%로 인상해서 조회     SALARY * 1.2
--     그외의 직급인 사원들은 급여를 5%로만 인상해서 조회  SALARY * 1.05

SELECT 
       EMPNAME "직원명"
     , JOBCODE "직급코드"
     , SALARY "급여"
     , DECODE ( JOBCODE, 'J7', SALARY * 1.08
                       , 'J6', SALARY * 1.07
                       , 'J5', SALARY * 1.05
                             , SALARY * 1.03) "인상급여"
FROM EMP;


