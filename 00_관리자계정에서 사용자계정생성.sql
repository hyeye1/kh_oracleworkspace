
-- 일반 사용자 계정을 만들 수 있는 권한은 관리자 계정에 있다.
-- 사용자계정생성 방법
-- CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER KH IDENTIFIED BY KH;

-- 생성된 사용자계정에게 최소한의 권한(접속, 데이터관리)부여
-- [표현법] GRANT 권한1, 권한2, .. TO 계정명;
GRANT CONNECT, RESOURCE TO KH; 