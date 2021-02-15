
/*
    < DCL : DATA CONTROL LANGUAGE >
    데이터 제어 언어
    
    계정에게 시스템권한 또는 객체접근권한을 부여(GRANT)하거나 회수(REVOKE)하는 언어
    
    > 시스템권한     : 특정DB에 접근하는 권한, 객체들을 생성할 수 있는 권한
    > 객체접근권한    : 특정 객체들에 접근해서 조작할 수 있는 권한
    
    * 시스템권한 종류
    - CREATE SESSION : 계정에 접속할 수 있는 권한
    - CREATE TABLE : 테이블을 생성할 수 있는 권한
    - CREATE VIEW : 뷰 생성할 수 있는 권한
    - CREATE SEQUENCE : 시퀀스 생성할 수 있는 권한
    - CREATE USER : 계정 생성할 수 있는 권한 
    - .....
    
    [표현법]
    GRANT 권한1, 권한2, .. TO 계정명;
*/

-- 1. SAMPLE 계정 생성
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;

-- 2. SAMPLE계정에 접속하기 위한 CREATE SESSION 권한 부여
GRANT CREATE SESSION TO SAMPLE;

-- 3_1. SAMPLE계정에 테이블을 생성할 수 있는 CREATE TABLE 권한 부여
GRANT CREATE TABLE TO SAMPLE;
-- 3_2. SAMPLE계정에 테이블스페이스할당해주기 (SAMPLE 계정변경)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;

-- 4. SAMPLE계정에 뷰를 생성할 수 있는 CREATE VIEW 권한 부여
GRANT CREATE VIEW TO SAMPLE;

-------------------------------------------------------------

/*
    * 객체권한종류
      특정 객체들을 조작(SELECT,INSERT,UPDATE,DELETE,..)할 수 있는 권한
      
      권한종류  |  특정객체
     ===============================
      SELECT   | TABLE, VIEW, SEQUENCE
      INSERT   | TABLE, VIEW
      UPDATE   | TABLE, VIEW
      DELETE   | TABLE, VIEW
      ....
      
      [표현법]
      GRANT 권한종류 ON 특정객체 TO 계정명;
*/
-- 5. SAMPLE계정에 KH.EMPLOYEE테이블을 조회할 수 있는 권한 부여
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

-- 6. SAMPLE계정에 KH.DEPARTMENT테이블에 삽입할 수 있는 권한 부여
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

--------------------------------------------------------------------------------

-- 최소한의 권한을 부여하고자 할때 CONNECT, RESOURCE만 부여
GRANT CONNECT, RESOURCE TO 계정명;

/*
    < 롤 ROLE >
    특정 권한들을 하나의 집합으로 모아놓은 것
    
    CONNECT : CREATE SESSION (데이터베이스에 접속할 수 있는 권한)
    RESOURCE : CREATE TABLE, CREATE SEQUENCE, ... (특정 객체들을 생성 및 관리할 수 있는 권한)
*/
SELECT *
FROM ROLE_SYS_PRIVS -- 롤들이 담겨있는 테이블! 
WHERE ROLE IN ('CONNECT', 'RESOURCE');

-- 사용자에게 부여할 권한 : CONNECT, RESOURCE
-- 권한을 부여받을 사용자 : MYMY
CREATE USER MYMY IDENTIFIED BY MYMY;
GRANT CONNECT, RESOURCE TO MYMY;












