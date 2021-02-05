/*

*/
-- 사원테이블에서 사원명, 직급코드, 보너스를 받는 사원수를 조회한 후 직급코드별 오름차순 정렬

SELECT
       EMP_NAME
     , JOB_CODE
     , COUNT(*) AS "사원수"
FROM EMPLOYEE
WHERE BONUS != NULL
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

--> 문제점1. BONUS가 NULL이 아닌 이라는 조건이 제대로 수행되지 않음
--> 문제점2. SELECT 절에서 그룹함수를 제외한 모든 컬럼을 GROUP BY에 기술되어있지않다.

--> 조치1. BONUS IS NOT NULL 로 조건을 수정
--> 조치2. GROUP BY 절을 EMP_NAME, JOB_CODE로 수정해야된다
SELECT
       EMP_NAME
     , JOB_CODE
     , COUNT(*) AS "사원수"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY JOB_CODE, EMP_NAME
ORDER BY JOB_CODE;