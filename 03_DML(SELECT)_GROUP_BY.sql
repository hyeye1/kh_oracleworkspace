/*
    < GROUP BY절 >
    그룹을 묶어줄 기준을 제시할 수 있는 구문 
    => 해당 제시된 기준별로 그룹을 묶을 수 있음!!
    
    여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용
*/
-- 전체사원의 총 급여합
SELECT SUM(SALARY)
FROM EMPLOYEE;  --> 현재 조회된 전체사원들을 하나의 그룹으로 묶어서 총합을 구한 결과

-- 각 부서별 총 급여합
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 전체사원 수
SELECT COUNT(*)
FROM EMPLOYEE;

-- 각 부서별 사원 수
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 총 급여합을 부서별 오름차순 정렬해서 조회
SELECT DEPT_CODE, SUM(SALARY) -- 3. SELECT 절
FROM EMPLOYEE       -- 1. FROM 절
GROUP BY DEPT_CODE  -- 2. GROUP BY 절
ORDER BY DEPT_CODE; -- 4. ORDER BY 절

-- 각 직급별 직급코드, 총급여합, 사원수, 보너스를 받는 사원수
SELECT JOB_CODE "직급", SUM(SALARY) "급여합", COUNT(1) "사원수", COUNT(BONUS) "보너스를받는사원수",
       ROUND(AVG(SALARY)) "평균급여", MAX(SALARY) "최고급여", MIN(SALARY) "최소급여"
FROM EMPLOYEE
GROUP BY JOB_CODE;


-- 각 부서별 부서코드, 총사원수, 보너스를 받는 사원수, 사수가 있는 사원수, 평균급여
SELECT DEPT_CODE "부서", COUNT(*) "사원수", COUNT(BONUS) "보너스를받는사원수"
     , COUNT(MANAGER_ID) "사수가존재하는사원수", ROUND(AVG(SALARY)) "평균급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 성별별 사원수
SELECT SUBSTR(EMP_NO, 8, 1), COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '여') "성별", COUNT(*) "사원수"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

--------------------------------------------------------------------------------

/*
    < HAVING 절 >
    그룹에 대한 조건을 제시하고자 할 때 사용되는 구문
    (주로 그룹함수를 가지고 조건 제시)
*/
-- 각 부서별 평균 급여가 300만원 이상인 부서들만 조회
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
WHERE AVG(SALARY) >= 3000000
GROUP BY DEPT_CODE; -- 오류 남

SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

-- 각 직급별 총 급여합이 1000만원 이상인 직급코드, 급여합을 조회
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- 각 부서별 보너스를 받는 사원이 없는 부서만을 조회
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

---------------------------------------------------------------------------------

/*
    < 실행순서 >
    
    5: SELECT *|조회하고자하는컬럼명|산술연산식|함수식  [AS] "별 칭!"|별칭
    1: FROM 조회하고자하는 테이블명
    2: WHERE 조건식
    3: GROUP BY 그룹기준에해당하는컬럼명|함수식
    4: HAVING 그룹함수식에 대한 조건식
    6: ORDER BY 정렬기준에해당하는컬럼명|별칭|컬럼순번  [ASC|DESC] [NULLS FIRST|NULLS LAST]
    
*/


---------------------------------------------------------------------------------------
/*
    < 집합 연산자 == SET OPERATOR >
    
    여러개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자
    
    - UNION : 합집합 ( 두 쿼리문 수행한 결과값을 더한 후 중복되는 부분은 뺀 것 ) OR
    - INTERSECT : 교집합 ( 두 쿼리문의 중복된 결과값)
    - UNION ALL : 합집합 결과에 교집합이 더해진 개념 ( 두 쿼리문 수행한 결과값을 무조건 더함) => 중복된 결과가 두번 조회될 수 있음
    - MINUS : 차집합 ( 선행쿼리문 결과값 빼기 후행 쿼리문 결과값의 결과 )
*/
-- 1. UNION (합집합- 두 쿼리문 수행한 결과값을 더하지만 단, 중복된 결과는 한번만 조회)
-- 부서코드가 D5이거나 또는 급여가 300만원 초과인 사원들 조회(사원, 사원명, 부서코드, 급여)

-- 부서코드가 D5인 사원들만 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';  --> 6명 조회 (박나라, 하이유, 김해술, 심봉선, 윤은해, 대북혼)

-- 급여가 300만원 초과인 사원들만 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; --> 8명 조회 (선동일, 송종기, 노옹철, 유재식, 정중하, 심봉선, 대북혼, 전지연)

-- UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY --> 위의 컬럼갯수 동일하게 작성
FROM EMPLOYEE
WHERE SALARY > 3000000; --> 12명 조회 (6명 + 8명 - 중복 2명)

-- 위의 UNION 구문 대신 하나의 SELECT문으로 조회해보기
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D2';

SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- GROUP BY 절을 이용해서 쉽게 해결
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-----------------------------------------------------------------------------
-- 2. UNION ALL : 여러개의 쿼리 결과를 무조건 더하는 연산자 (중복값이 여러개 들어갈 수 있음)

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; --> 14명

-------------------------------------------------------------------------------
-- 3. INTERSECT (교집합 - 여러 쿼리 결과의 중복된 결과만을 조회)
-- 부서코드가 D5이면서 뿐만아니라 급여까지도 300만원 초과인 사원

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- AND연산자 이용가능
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

-- 부서코드가 D5인 사원들 중 급여가 300만원 초과인 사원들 제외해서 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 아래처럼 가능
-- 부서코드가 D5이면서 뿐만아니라 급여가 300만원 이하인 사원들 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <= 3000000;




