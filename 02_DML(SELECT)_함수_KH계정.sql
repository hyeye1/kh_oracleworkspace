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
    
    LENGTH(STR) 
    > STR : '문자열' | 문자열에해당하는컬럼
    

*/
SELECT LENGTH ('오라클!'), LENGTHB('오라클')
FROM DUAL; -- 가상테이블 (DUMMY TABLE)

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL), EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;