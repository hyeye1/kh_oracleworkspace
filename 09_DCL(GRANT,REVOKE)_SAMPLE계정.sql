
-- CREATE TABLE 할 수 있는 권한이 없어서 문제 발생
-- 3_1. CREATE TABLE 권한 부여받기
-- 3_2. TABLESPACE 할당 받기
CREATE TABLE TEST(
    TEST_ID NUMBER
);

-- 위의 테이블생성권한을 부여받게 되면
-- 계정이 소유하고 있는 테이블들을 조작하는것도 가능해짐
SELECT * FROM TEST;
INSERT INTO TEST VALUES(1);

-- 뷰 객체를 생성할 수 있는 CREATE VIEW 권한이 없기때문에 문제 발생
-- 4. CREATE VIEW 권한 부여받기
CREATE VIEW V_TEST
AS SELECT * FROM TEST;

---------------------------------------------------------------

-- KH계정의 테이블에 접근해서 조회할 수 있는 권한이 없기때문에 문제 발생
-- 5. KH.EMPLOYEE에 SELECT할 수 있는 권한 부여받기
SELECT *
FROM KH.EMPLOYEE;

SELECT *
FROM KH.DEPARTMENT;

-- KH계정의 테이블에 접근해서 삽입할 수 있는 권한이 없기때문에 문제 발생
-- 6. KH.DEPARTMENT에 INSERT할 수 있는 권한 부여받기
INSERT INTO KH.DEPARTMENT VALUES('D0', '회계부', 'L2');

ROLLBACK;








