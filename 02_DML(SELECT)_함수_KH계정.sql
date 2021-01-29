/* 
    < �Լ� FUNCTION >
    - �ڹٷ� ������ �޼ҵ� ���� ����
    - ���޵� ������ �о ����� ����� ��ȯ��
    
    > ������ �Լ� : N���� ���� �о N���� ����� ���� ( �� �ึ�� �Լ� ������ ��� ��ȯ)
    > �׷�   �Լ� : N���� ���� �о 1���� ����� ���� (�ϳ��� �׷캰�� �Լ������� ��� ��ȯ)
    
    * �������Լ��� �׷��Լ��� �Բ� ����� �� ���� : ��� ���� ������ �ٸ��� ������

*/
---------------------------------< ������ �Լ� >---------------------------------

/*
    < ���ڿ��� ���õ� �Լ� >
    
    * LENGTH / LENGTHB
    
    LENGTH(STR) : �ش� ���޵� ���ڿ��� ����Ʈ�� ��ȯ
    LENGTHB (STR) : �ش� ���޵� ���ڿ��� ����Ʈ�� ��ȯ
    
    => ����� NUMBERŸ������ ��ȯ
    
    > STR : '���ڿ�' | ���ڿ����ش��ϴ��÷�
    
    �ѱ� : '��' '��' '��' '��' '�K' => �� ���ڴ� 3 BYTE�� ���
    ����, ����, Ư������ : '!' '~' '1' 'A' =>�� ���ڴ� 1BYTE�� ���

*/
SELECT LENGTH ('����Ŭ!'), LENGTHB('����Ŭ')
FROM DUAL; -- �������̺� (DUMMY TABLE)

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL), EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;

----------------------------------------------------------------------------------

/*
    * INSTR 
    ���ڿ��κ��� Ư�� ������ ��ġ�� ��ȯ
    
    INSTR(STR, '����'[, ã����ġ�ǽ��۰�, [����]])
    => ����� NUMBERŸ��
    
    > ã����ġ�ǽ��۰�
    1   : �տ������� ã�ڴ� (������ �⺻��)
    -1  : �ڿ������� ã�ڴ�
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- ã����ġ, ���� ������ �⺻������ �տ������� ù��°������ ��ġ �˻�
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; 
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1,2) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '@') AS "@��ġ"
FROM EMPLOYEE;

-------------------------------------------------------------------------------------------

/*
    * SUBSTR
    ���ڿ��κ��� Ư�� ���ڿ��� �����ؼ� ��ȯ
    (�ڹٷ� ġ�� ���ڿ�.    SUBSTRING(~~) �޼ҵ�� ����)
    
    SUBSTR(STR, POSITION, [LENGTH])
    => ����� CHARACTER Ÿ��
    
    > STR : '���ڿ�' �Ǵ� ����Ÿ���÷�
    > POSITION : ���ڿ��� ������ ������ġ�� (������ ���ð���)
    > LENGTH : ������ ���ڰ���(������ ������ �ǹ�)
    
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE;

-- ���ڻ���鸸 ��ȸ (�����, �޿�)
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8, 1) = '1' OR SUBSTR(EMP_NO, 8, 1) = '3';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3'); 

-- ���ڻ���鸸 ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');


SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1)
FROM EMPLOYEE;

-------------------------------------------------------------------------------------

/*
    LPAD/RPAD(STR, ���������� ��ȯ�� ������ ����(����Ʈ), [�����̰����ϴ¹���])
    => ����� CHARACTER Ÿ��
    
    ������ ���ڿ��� ������ ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� ���� N���̸�ŭ�� ���ڿ��� ��ȯ

*/
SELECT LPAD(EMAIL,20) -- �����̰����ϴ� ���� ������ �⺻���� ����
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- �ֹι�ȣ��ȸ => �ѱ��ڼ� 14����
SELECT RPAD('850918-2', 14, '*') FROM DUAL;

SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8)
FROM EMPLOYEE;

-- �Լ� ��ø���
SELECT EMP_NAME, RPAD(  SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;


-----------------------------------------------------------------

/*
    * LTRIM/ RTRIM
    
    LTRIM/RTRIM(STR, [���Ž�Ű�����ϴ¹���])
    => ����� CHARACTER Ÿ��
    
    ���ڿ��� ���� �Ǵ� �����ʿ��� ���Ž�Ű�����ϴ� ���ڵ��� ã�Ƽ� ������ ������ ���ڿ��� ��ȯ
*/
SELECT LTRIM('      K   H') FROM DUAL;

/*
    * TRIM
    ���ڿ��� ��/��/���ʿ� �ִ� Ư�����ڸ� ������ ������ ���ڿ� ��ȯ
    
    TRIM(STR)
*/
--�⺻������ ���ʿ��ִ� ���� ����
SELECT TRIM('   K H   ') FROM DUAL;

SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;

SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL;  --- BOTH : ���� (������ �⺻��)
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- LEADING : ����  == LTRIM
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- TRAILING : ����

---------------------------------------------------------------------------
/*
    * LOWER/ UPPER / INITCAP
    
    LOWER : �� �ҹ��ڷ�
    UPPER : �� �빮�ڷ�
    INITCAP : �� �ܾ��� �ձ��ڸ� �빮�ڷ�
    
    LOWER / UPPER / INITCAP(STR)
    -> ����� CHARACTERŸ��
*/
SELECT LOWER('Welcome to My World') FROM DUAL;
SELECT UPPER('Welcome to My World') FROM DUAL;
SELECT INITCAP('welcome to myworld') FROM DUAL;

/*
*/
SELECT CONCAT('������', 'ABC', 'DEF') FROM DUAL; -- ���� (�ΰ��ۿ��ȵ�)

--------------------------------------------------------------------------

/*
    * REPLACE
    
    REPLACE(sTRING, STR1, STR2)
    -> ����� CHARACTER Ÿ��
    
    STRING ���κ��� STR1�� ã�Ƽ� STR2 �� �ٲ� ���ڿ��� ��ȯ
*/
SELECT REPLACE ('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��') FROM DUAL;

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'iei.com') 
FROM EMPLOYEE;

-----------------------------------
/*
    ABS
*/

-------------------------------------------
/*
    *MOD
    �� ���� ���� ������ ���� ��ȯ���ִ� �Լ�
    
    MOD(NUMBER, NUMBER)
*/
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(-10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;

-----------------------------------------------------------
/*

    *ROUND
    �ݿø� ó�����ִ� �Լ�
    
    ROUND(NUMBER. [��ġ])
*/
SELECT ROUND ( 123.456) FROM DUAL; -- ��ġ�� ������ �⺻���� 0
SELECT ROUND(123.456, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 4) FROM DUAL;
SELECT ROUND(123.456, -1) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;

---------------------------------------------------------------
/*

     *CEIL
     ������ �ø�ó�����ִ� �Լ�
     
     CEIL(NUMBER)
     
*/
SELECT CEIL(123.456) FROM DUAL;
--------------------------------------------------------------------
/*
    * FLOOR
    �Ҽ��� �Ʒ� ������ ������ �Լ�
    
    FLOOR(NUMBER)

*/
SELECT FLOOR(123.987) FROM DUAL;
SELECT FLOOR(207.68) FROM DUAL;

SELECT EMP_NAME, FLOOR(SYSDATE-HIRE_DATE) || '��' "�ٹ��ϼ�"
FROM EMPLOYEE;
--------------------------------------------------------------------
/*
    * TRUNC
    ��ġ ���������� ����ó�����ִ� �Լ�
    
    TRUNC(NUMBER, [��ġ])
*/
SELECT TRUNC(123.765) FROM DUAL;
SELECT TRUNC(123.756,1) FROM DUAL;

--------------------------------------------------------------------

/*
    < ��¥ ���� �Լ� >
    
    >> DATE Ÿ�� : ��, ��, ��, ��, ��, �� �� �� ������ �ڷ���

  -- �ܼ��� ��¥-��¥= �� ��
*/
-- * SYSDATE : ����ý��۳�¥ ��ȯ
SELECT SYSDATE FROM DUAL;

-- * MONTHS_BETWEEN(DATE1, DATE2) : �� ��¥ ������ ������ ��ȯ
-- -> ����� NUMBERŸ��
SELECT EMP_NAME
     , FLOOR(SYSDATE-HIRE_DATE) �ٹ��ϼ�
     , FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)) �ٹ������� 
FROM EMPLOYEE;

-- * ADD_MONTHS(DATE, NUMBER) : Ư�� ��¥�� �ش� ���ڸ�ŭ�� �������� ���� ��¥ ��ȯ
--  => ����� DATE Ÿ��
-- ���ó�¥�� ���� 5���� ��
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- ��ü ������� ������, �Ի���, �Ի��� 6������ �귶������ ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)
FROM EMPLOYEE;

-- * NEXT_DAY(DATE, ����(����|����)) : Ư�� ��¥���� ���� ����� �ش� ������ ã�� �� ��¥ ��ȯ
-- => ����� DATE Ÿ��
-- ���� ��¥�κ��� �����
SELECT NEXT_DAY(SYSDATE, '�Ͽ���') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 1) FROM DUAL; -- 1. �Ͽ��� 2: ������ . . . 6:�ݿ���, 7:�����

SELECT NEXT_DAY(SYSDATE, 'SUNDAY') FROM DUAL; -- ���� (���� �� KOREAN�̱⶧����)

-- ����
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT NEXT_DAY(SYSDATE, 'SUNDAY') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '�Ͽ���') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- * LAST_DAY(DATE): �ش� Ư�� ��¥ ���� ������ ��¥�� ���ؼ� ��ȯ
-- -> ����� DATEŸ��
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- �̸�, �Ի���, �Ի��� ���� ������ ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;
