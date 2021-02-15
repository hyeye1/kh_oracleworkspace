
/*
    < VIEW 뷰 >
    SELECT문(쿼리문)을 저장해둘 수 있는 객체
    (자주 쓰는 긴 SELECT문을 저장해두면 긴 SELECT문을 매번 다시 기술 할 필요없음)
    임시테이블같은 존재(실제 데이터가 담겨있는건 아님)
*/

-- '한국'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명, 직급명을 조회하시오
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
JOIN JOB USING(JOB_CODE)
WHERE NATIONAL_NAME = '한국';

-- '러시아'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명, 직급명을 조회하시오
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
JOIN JOB USING(JOB_CODE)
WHERE NATIONAL_NAME = '러시아';

----------------------------------------------------------------------------------

/*
    1. VIEW 생성 방법
    
    [표현법]
    CREATE [OR REPLACE] VIEW 뷰명
    AS 서브쿼리;
    
    [OR REPLACE] : 뷰 생성시 기존에 중복된 이름의 뷰가 없다면 새로이 뷰를 생성하고,
                            기존에 중복된 이름의 뷰가 있다면 해당 뷰를 변경(갱신)하는 옵션
*/

CREATE OR REPLACE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME, BONUS
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE)
    JOIN JOB USING(JOB_CODE);
--> 현재 KH계정에 뷰 생성 권한이 없어서 발생하는 문제 => 관리자에서 CREATE VIEW 권한 부여받으면됨

SELECT * 
FROM VW_EMPLOYEE;

-- '한국'에서 근무하는 사원
SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '한국';

-- '러시아'에서 근무하는 사원
SELECT EMP_ID, EMP_NAME, JOB_NAME, BONUS
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '러시아';

-- 뷰는 논리적인 가상테이블 => 실질적으로 데이터를 저장하고 있진 않음 (단순히 쿼리문이 TEXT문구로 저장되어있음)

-- [참고] 해당 계정이 가지고 있는 VIEW들에 대한 내용 조회하고자 한다면 USER_VIEWS 데이터딕셔너리
SELECT * FROM USER_VIEWS;

---------------------------------------------------------------------------------

/*
    * 뷰 컬럼에 별칭 부여
      서브쿼리의 SELECT절에 함수나 산술연산식이 기술되어있는 경우 반드시 별칭 지정!
*/

-- 사원의 사번, 이름, 직급명, 성별, 근무년수를 조회할 수 있는 SELECT문 뷰로 정의
CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
          DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여'),
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
   FROM EMPLOYEE       
   JOIN JOB USING(JOB_CODE);

CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
          DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') "성별",
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "근무년수"
   FROM EMPLOYEE       
   JOIN JOB USING(JOB_CODE);

SELECT *
FROM VW_EMP_JOB;

--> 또다른 방법으로 별칭 부여가능 (단, 모든 컬럼에 대한 별칭 다 기술해야됨)
CREATE OR REPLACE VIEW VW_EMP_JOB(사번, 사원명, 직급명, 성별, 근무년수)
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
          DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여'),
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
   FROM EMPLOYEE       
   JOIN JOB USING(JOB_CODE);

SELECT 사원명, 근무년수
FROM VW_EMP_JOB;

SELECT 사원명, 직급명
FROM VW_EMP_JOB
WHERE 성별 = '여';

-- 근무년수가 20년이상인 사원들의 모든 컬럼
SELECT *
FROM VW_EMP_JOB
WHERE 근무년수 >= 20;

-- 뷰 삭제 하고자 한다면
DROP VIEW VW_EMP_JOB;

---------------------------------------------------------------------------------

/*
    * 생성된 뷰를 이용해서 DML(INSERT, UPDATE, DELETE) 사용가능
      단, 뷰를 통해서 변경하게 되면 실제 데이터가 담겨있는 실질적인 테이블(베이스테이블)에 적용 됨
*/
CREATE OR REPLACE VIEW VW_JOB
AS SELECT * FROM JOB;

SELECT * FROM VW_JOB;
SELECT * FROM JOB;

-- 뷰에 INSERT
INSERT INTO VW_JOB
VALUES('J8', '인턴');  --> 베이스테이블(JOB)에 값 INSERT

-- 뷰로 UPDATE
UPDATE VW_JOB
SET JOB_NAME = '알바'
WHERE JOB_CODE = 'J8'; --> 베이스테이블(JOB)에 값 UPDATE

-- 뷰에 DELETE
DELETE FROM VW_JOB
WHERE JOB_CODE = 'J8'; --> 베이스테이블(JOB)에 값 DELETE

SELECT * FROM JOB;

----------------------------------------------------------------------------------

/*
    * 하지만 뷰를 가지고 DML이 불가능한 경우가 더 많음
    
    1) 뷰에 정의되어있지 않은 컬럼을 조작하는 경우
    2) 뷰에 정의되어있지 않은 컬럼 중에 베이스테이블 상에 NOT NULL제약조건이 지정된 경우
    3) 산술연산식 또는 함수를 통해서 정의되어있는 경우
    4) 그룹함수나 GROUP BY절이 포함된 경우
    5) DISTINCT 구문이 포함된 경우
    6) JOIN을 이용해서 여러 테이블을 매칭시켜놓은 경우
    
*/

-- 1) 뷰에 정의되어있지 않은 컬럼을 가지고 조작하는 경우
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE FROM JOB;

SELECT * FROM VW_JOB;

-- INSERT => 불가
INSERT INTO VW_JOB(JOB_CODE, JOB_NAME) VALUES('J8', '인턴');

-- UPDATE => 불가
UPDATE VW_JOB
SET JOB_NAME = '인턴'
WHERE JOB_CODE = 'J7';

-- DELETE => 불가
DELETE FROM VW_JOB
WHERE JOB_NAME = '사원';

--------------------------------------------------------------------------------

-- 2) 뷰에 정의되어있지 않은 컬럼중에서 베이스테이블상에 NOT NULL제약조건이 지정되어있는 경우
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

SELECT * FROM VW_JOB;

-- INSERT => 불가
INSERT INTO VW_JOB VALUES('인턴'); --> JOB테이블에 (NULL, '인턴')이 삽입되려고 했다!! 

-- UPDATE 
-- 사원직급을 알바로 변경
UPDATE VW_JOB
SET JOB_NAME = '알바'
WHERE JOB_NAME = '사원'; --> 뷰에 정의된 컬럼만을 가지고 조작, NOT NULL제약조건에 별도로 위배되지 않을 경우 가능

SELECT * FROM JOB;
ROLLBACK;

UPDATE VW_JOB
SET JOB_CODE = NULL
WHERE JOB_NAME = '사원'; --> 불가

-- DELETE
DELETE FROM VW_JOB
WHERE JOB_NAME = '사원'; --> J7 이라는 데이터를 가져다 쓰고 있는 자식데이터가 있기 때문에 삭제 불가

--------------------------------------------------------------------------------

-- 3) 함수 또는 산술연산식으로 정의된 경우

-- 사원의 사번, 사원명, 급여, 연봉에 대해서 조회하는 뷰
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 "연봉"
   FROM EMPLOYEE;
   
SELECT * FROM VW_EMP_SAL;  --> 이 뷰를 가지고 DML하게 되면 EMPLOYEE에 반영

-- INSERT => 불가
INSERT INTO VW_EMP_SAL VALUES(400, '정진훈', 3000000, 36000000);

-- UPDATE
-- 200번 사원의 연봉을 8000만원
UPDATE VW_EMP_SAL
SET 연봉 = 80000000
WHERE EMP_ID = 200; --> 산술연산식으로 정의되어있는 컬럼을 변경하려고 하면 불가

-- 200번 사원의 급여를 700만원
UPDATE VW_EMP_SAL
SET SALARY = 7000000
WHERE EMP_ID = 200;

SELECT * FROM EMPLOYEE;
SELECT * FROM VW_EMP_SAL;

-- DELETE 
-- 연봉이 7200만원인 사원 삭제
DELETE FROM VW_EMP_SAL
WHERE 연봉 = 72000000;

ROLLBACK;

----------------------------------------------------------------------------------

-- 4) 그룹함수 또는 GROUP BY절을 포함된 경우

-- 부서별 급여합, 평균급여 조회하는 뷰
CREATE OR REPLACE VIEW VW_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) "급여합", FLOOR(AVG(SALARY)) "평균급여"
   FROM EMPLOYEE
   GROUP BY DEPT_CODE;

SELECT * FROM VW_GROUPDEPT;

-- INSERT => 불가
INSERT INTO VW_GROUPDEPT VALUES('D0', 8000000, 4000000);

-- UPDATE => 불가
UPDATE VW_GROUPDEPT
SET 급여합 = 8000000
WHERE DEPT_CODE = 'D1';

UPDATE VW_GROUPDEPT
SET DEPT_CODE = 'D0'
WHERE DEPT_CODE = 'D1';

-- DELETE => 불가
DELETE FROM VW_GROUPDEPT
WHERE DEPT_CODE = 'D1';

--------------------------------------------------------------------------------

-- 5) DISTINCT가 포함된 경우
CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT JOB_CODE
   FROM EMPLOYEE;

SELECT * FROM VW_DT_JOB;

-- INSERT => 불가
INSERT INTO VW_DT_JOB VALUES('J8');

-- UPDATE => 불가
UPDATE VW_DT_JOB
SET JOB_CODE = 'J8'
WHERE JOB_CODE = 'J7';

-- DELETE => 불가
DELETE FROM VW_DT_JOB
WHERE JOB_CODE = 'J7';

