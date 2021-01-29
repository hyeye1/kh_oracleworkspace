/* 
    < 함수 FUNCTION >
    - 자바로 따지면 메소드 같은 존재
    - 전달된 값들을 읽어서 계산한 결과를 반환함
    
    > 단일행 함수 : N개의 값을 읽어서 N개의 결과를 리턴 ( 매 행마다 함수 실행후 결과 반환)
    > 그룹   함수 : N개의 값을 읽어서 1개의 결과를 리턴 (하나의 그룹별로 함수실행후 결과 반환)
    
    * 단일행함수와 그룹함수를 함께 상요할 수 없음 : 결과 행의 갯수가 다르기 때문에

*/
---------------------------------< 단일행 함수 >---------------------------------

/*
    < 문자열과 관련된 함수 >
    
    * LENGTH / LENGTHB
    
    LENGTH(STR) : 해당 전달된 문자열의 바이트수 반환
    LENGTHB (STR) : 해당 전달된 문자열의 바이트수 반환
    
    => 결과값 NUMBER타입으로 잔환
    
    > STR : '문자열' | 문자열에해당하는컬럼
    
    한글 : 'ㄱ' 'ㅏ' '강' '나' '핳' => 한 글자당 3 BYTE로 취급
    숫자, 영문, 특수문자 : '!' '~' '1' 'A' =>한 글자당 1BYTE로 취급

*/
SELECT LENGTH ('오라클!'), LENGTHB('오라클')
FROM DUAL; -- 가상테이블 (DUMMY TABLE)

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL), EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;

----------------------------------------------------------------------------------

/*
    * INSTR 
    문자열로부터 특정 문자의 위치값 반환
    
    INSTR(STR, '문자'[, 찾을위치의시작값, [순번]])
    => 결과값 NUMBER타입
    
    > 찾을위치의시작값
    1   : 앞에서부터 찾겠다 (생략시 기본값)
    -1  : 뒤에서부터 찾겠다
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- 찾을위치, 순번 생략시 기본적으로 앞에서부터 첫번째글자의 위치 검색
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; 
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1,2) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '@') AS "@위치"
FROM EMPLOYEE;

-------------------------------------------------------------------------------------------

/*
    * SUBSTR
    문자열로부터 특정 문자열을 추출해서 반환
    (자바로 치면 문자열.    SUBSTRING(~~) 메소드와 유사)
    
    SUBSTR(STR, POSITION, [LENGTH])
    => 결과값 CHARACTER 타입
    
    > STR : '문자열' 또는 문자타입컬럼
    > POSITION : 문자열을 추출할 시작위치값 (음수도 제시가능)
    > LENGTH : 추출할 문자갯수(생략시 끝까지 의미)
    
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE;

-- 남자사원들만 조회 (사원명, 급여)
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8, 1) = '1' OR SUBSTR(EMP_NO, 8, 1) = '3';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3'); 

-- 여자사원들만 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');


SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1)
FROM EMPLOYEE;

-------------------------------------------------------------------------------------

/*
    LPAD/RPAD(STR, 최종적으로 반환할 문자의 길이(바이트), [덧붙이고자하는문자])
    => 결과값 CHARACTER 타입
    
    제시한 문자열에 임의의 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N길이만큼의 문자열을 반환

*/
SELECT LPAD(EMAIL,20) -- 덧붙이고자하는 문자 생략시 기본값이 공백
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 주민번호조회 => 총글자수 14글자
SELECT RPAD('850918-2', 14, '*') FROM DUAL;

SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8)
FROM EMPLOYEE;

-- 함수 중첩사용
SELECT EMP_NAME, RPAD(  SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;


-----------------------------------------------------------------

/*
    * LTRIM/ RTRIM
    
    LTRIM/RTRIM(STR, [제거시키고자하는문자])
    => 결과값 CHARACTER 타입
    
    문자열의 왼쪽 또는 오른쪽에서 제거시키고자하는 문자들을 찾아서 제거한 나머지 문자열을 반환
*/
SELECT LTRIM('      K   H') FROM DUAL;

/*
    * TRIM
    문자열의 앞/뒤/양쪽에 있는 특정문자를 제거한 나머지 문자열 반환
    
    TRIM(STR)
*/
--기본적으로 양쪽에있는 문자 제거
SELECT TRIM('   K H   ') FROM DUAL;

SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;

SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL;  --- BOTH : 양쪽 (생략시 기본값)
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- LEADING : 앞쪽  == LTRIM
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- TRAILING : 뒤쪽

---------------------------------------------------------------------------
/*
    * LOWER/ UPPER / INITCAP
    
    LOWER : 다 소문자로
    UPPER : 다 대문자로
    INITCAP : 각 단어의 앞글자만 대문자로
    
    LOWER / UPPER / INITCAP(STR)
    -> 결과값 CHARACTER타입
*/
SELECT LOWER('Welcome to My World') FROM DUAL;
SELECT UPPER('Welcome to My World') FROM DUAL;
SELECT INITCAP('welcome to myworld') FROM DUAL;

/*
*/
SELECT CONCAT('가나다', 'ABC', 'DEF') FROM DUAL; -- 오류 (두개밖에안됨)

--------------------------------------------------------------------------

/*
    * REPLACE
    
    REPLACE(sTRING, STR1, STR2)
    -> 결과값 CHARACTER 타입
    
    STRING 으로부터 STR1을 찾아서 STR2 로 바꾼 문자열을 반환
*/
SELECT REPLACE ('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL;

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'iei.com') 
FROM EMPLOYEE;

-----------------------------------
/*
    ABS
*/

-------------------------------------------
/*
    *MOD
    두 수를 나눈 나머지 값을 반환해주는 함수
    
    MOD(NUMBER, NUMBER)
*/
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(-10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;

-----------------------------------------------------------
/*

    *ROUND
    반올림 처리해주는 함수
    
    ROUND(NUMBER. [위치])
*/
SELECT ROUND ( 123.456) FROM DUAL; -- 위치값 생략시 기본값은 0
SELECT ROUND(123.456, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 4) FROM DUAL;
SELECT ROUND(123.456, -1) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;

---------------------------------------------------------------
/*

     *CEIL
     무조건 올림처리해주는 함수
     
     CEIL(NUMBER)
     
*/
SELECT CEIL(123.456) FROM DUAL;
--------------------------------------------------------------------
/*
    * FLOOR
    소수점 아래 무조건 버리는 함수
    
    FLOOR(NUMBER)

*/
SELECT FLOOR(123.987) FROM DUAL;
SELECT FLOOR(207.68) FROM DUAL;

SELECT EMP_NAME, FLOOR(SYSDATE-HIRE_DATE) || '일' "근무일수"
FROM EMPLOYEE;
--------------------------------------------------------------------
/*
    * TRUNC
    위치 지정가능한 버림처리해주는 함수
    
    TRUNC(NUMBER, [위치])
*/
SELECT TRUNC(123.765) FROM DUAL;
SELECT TRUNC(123.756,1) FROM DUAL;

--------------------------------------------------------------------

/*
    < 날짜 관련 함수 >
    
    >> DATE 타입 : 년, 월, 일, 시, 분, 초 를 다 포함한 자료형

  -- 단순히 날짜-날짜= 일 수
*/
-- * SYSDATE : 현재시스템날짜 반환
SELECT SYSDATE FROM DUAL;

-- * MONTHS_BETWEEN(DATE1, DATE2) : 두 날짜 사이의 개월수 반환
-- -> 결과값 NUMBER타입
SELECT EMP_NAME
     , FLOOR(SYSDATE-HIRE_DATE) 근무일수
     , FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)) 근무개월수 
FROM EMPLOYEE;

-- * ADD_MONTHS(DATE, NUMBER) : 특정 날짜에 해당 숫자만큼의 개월수를 더한 날짜 반환
--  => 결과값 DATE 타입
-- 오늘날짜로 부터 5개월 후
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- 전체 사원들의 직원명, 입사일, 입사후 6개월이 흘렀을때의 날짜 조회
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)
FROM EMPLOYEE;

-- * NEXT_DAY(DATE, 요일(문자|숫자)) : 특절 날짜에서 가장 가까운 해당 요일을 찾아 그 날짜 반환
-- => 결과값 DATE 타입
-- 오늘 날짜로부터 토요일
SELECT NEXT_DAY(SYSDATE, '일요일') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '일') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 1) FROM DUAL; -- 1. 일요일 2: 월요일 . . . 6:금요일, 7:토요일

SELECT NEXT_DAY(SYSDATE, 'SUNDAY') FROM DUAL; -- 에러 (현재 언어가 KOREAN이기때문에)

-- 언어변경
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT NEXT_DAY(SYSDATE, 'SUNDAY') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '일요일') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- * LAST_DAY(DATE): 해당 특정 날짜 달의 마지막 날짜를 구해서 반환
-- -> 결과값 DATE타입
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- 이름, 입사일, 입사한 달의 마지막 날짜 조회
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;
