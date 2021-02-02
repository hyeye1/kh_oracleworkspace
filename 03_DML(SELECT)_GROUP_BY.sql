/*
    < GROUP BY절 >
    그룹을 묶어줄 기준을 제시할 수 있는 구문
    => 해당 제시된 기준별로 그룹을 묶을 수 있음!
    
    여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용
*/
-- 전체사원의 총 급여합
SELECT SUM(SALARY)
FROM EMPLOYEE;  --> 현재 조회된 전체 사원들을 하나의 그룹으로 묶어서 총 합을 구한 결과 

-- 각 부서별 총 급여합
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 전체 사원수
SELECT COUNT(*)
FROM EMPLOYEE;

-- 각 부서별 사원 수
SELECT COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 총 급여합을 부서별 오름차순 정렬해서 조회
SELECT DEPT_CODE, SUM(SALARY)   -- 3. SELECT 절
FROM EMPLOYEE                   -- 1. FROM 절
GROUP BY DEPT_CODE              -- 2. GROUP 절
ORDER BY DEPT_CODE;             -- 4. ORDER BY 절

-- 각 직급별 직급코드, 총 급여합, 사원수, 보너스를 받는 사원수
SELECT JOB_CODE "직급", SUM(SALARY) "급여합", COUNT(*) "사원수", COUNT(BONUS) "보너스를받는사원수",
       ROUND(AVG(SALARY)) "평균급여", MAX(SALARY) "최고급여", MIN(SALARY) "최소급여"
FROM EMPLOYEE
GROUP BY JOB_CODE;





















