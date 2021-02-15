
/*
    < TCL : TRANSACTION CONTROL LANGUAGE >
    트랜잭션을 제어하는 언어
    
    * 트랜잭션 (TRANSACTION)
    - 데이터베이스의 논리적 연산단위
    - 데이터의 변경사항(DML)들을 하나의 트랜잭션에 묶어서 처리 
      COMMIT(확정) 하기 전까지의 변경사항들을 하나의 트랜잭션에 담게 됨
    - 트랜잭션의 대상이 되는 SQL : INSERT, UPDATE, DELETE (DML)
    
    COMMIT(트랜잭션 종료처리 후 확정), ROLLBACK(트랜잭션 취소), SAVEPOINT(임시저장점 잡기)
    
    COMMIT; 진행 : 하나의 트랜잭션에 담겨있는 변경사항들을 실제 DB에 반영하겠다는걸 의미 (실제 DB에 반영시킨 후 트랜잭션은 비워짐)
    ROLLBACK; 진행 : 하나의 트랜잭션에 담겨있는 변경사항들을 삭제한 후 마지막 COMMIT 시점으로 돌아감
    
    SAVEPOINT 포인트명; 진행 : 현재 이시점에 임시저장점을 정의해두는 거
    ROLLBACK 포인트명;  진행 : 전체 변경사항들을 삭제하는게 아니라 해당 포인트 지점까지의 트랜잭션만 롤백함
        
*/
SELECT * FROM EMP_01;

-- 사번이 901인 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID = 901;
-- 사번이 900인 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID = 900;

ROLLBACK;

------------------------------------

-- 200번 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID = 200;

-- 800, 홍길동, 총무부 사원 추가
INSERT INTO EMP_01
VALUES(800, '홍길동', '총무부');

COMMIT;

SELECT * FROM EMP_01;
ROLLBACK;

--------------------------------------

-- 217, 216, 214 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID IN (217, 216, 214);

-- 3개의 행이 삭제된 시점에 SAVEPOINT 지정
SAVEPOINT SP1;

-- 801, '김말똥', '인사부'
INSERT INTO EMP_01
VALUES(801, '김말똥', '인사부');

-- 218 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID=218;

ROLLBACK TO SP1;

COMMIT;

SELECT * FROM EMP_01;

-----------------------------------------

-- 900, 901 사원지움
DELETE FROM EMP_01
WHERE EMP_ID IN (900, 901);

-- 218 사원지움
DELETE FROM EMP_01
WHERE EMP_ID = 218;

-- 테이블 생성 (DDL)
CREATE TABLE TEST(
    TID NUMBER
);

/*
    DDL 구문(CREATE, ALTER, DROP)을 실행하는 순간 
    기존에 트랜잭션에 있던 모든 변경사항들을 무조건 실제 DB에 반영(COMMIT)시킨 후에 DDL이 수행됨
    => 즉, DDL 수행전 변경사항들이 있었다면 정확히 픽스(COMMIT, ROLLBACK) 하고 해라
*/

ROLLBACK;

SELECT * FROM EMP_01;

/*
    사용자가 게시글(첨부파일이 존재하는) 추가하는 요청시 (한가지 요청에 두개 이상의 DML을 수행할 경우)
    
    => INSERT INTO 첨부파일테이블
    => INSERT INTO 게시글테이블 
    
    둘 다 잘 INSERT가 될 시 성공 => COMMIT (확정)
    둘 중 하나라도 잘 못 INSERT 시 실패 => ROLLBACK(기존에 잘 INSERT됐던 것도 돌려놓기)
    
*/















