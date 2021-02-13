/*
    < �Լ� FUNCTION >
    - �ڹٷ� ������ �޼ҵ� ���� ����
    - ���޵� ������ �о ����� ����� ��ȯ��
    
    > ������ �Լ� : N���� ���� �о N���� ����� ���� (�� �ึ�� �Լ� ������ ��� ��ȯ)
    > �׷�   �Լ� : N���� ���� �о 1���� ����� ���� (�ϳ��� �׷캰�� �Լ� ������ ��� ��ȯ)
    
    * �������Լ��� �׷��Լ��� �Բ� ����� �� ���� : ��� ���� ������ �ٸ��� ����
    
*/
------------------------------ < ������ �Լ� > ------------------------------------------
/*
    < ���ڿ��� ���õ� �Լ� >
    
    * LENGTH / LENGTHB
    
    LENGTH(STR)   : �ش� ���޵� ���ڿ��� ���� �� ��ȯ
    LENGTHB(STR)  : �ش� ���޵� ���ڿ��� ����Ʈ �� ��ȯ
    
    => ����� NUMBER Ÿ������ ��ȯ
    
    > STR : '���ڿ�'|���ڿ����ش��ϴ��÷�
    
    �ѱ� : '��', '��', '��', '��', '�K'     => �� ���ڴ� 3BYTE�� ���
    ����,����,Ư������ : '!', '~', '1', 'A' => �� ���ڴ� 1BYTE�� ���
    
*/

SELECT LENGTH('����Ŭ!'), LENGTHB('����Ŭ!')
FROM DUAL; --> �������̺� (DUMMY TABLE)

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL), EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;

----------------------------------------------------------------------------------

/*
    * INSTR
    ���ڿ��κ��� Ư�� ������ ��ġ�� ��ȯ
    
    INSTR(STR, '����'[, ã����ġ�ǽ��۰�, [����]])
    => ����� NUMBERŸ��
    
    > ã����ġ�ǽ��۰�
     1 : �տ������� ã�ڴ�. (������ �⺻��)
    -1 : �ڿ������� ã�ڴ�. 
    
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- ã����ġ,���� ������ �⺻������ �տ������� ù��°������ ��ġ �˻�
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '@') AS "@��ġ"
FROM EMPLOYEE;

--------------------------------------------------------------------------------------

/*
    * SUBSTR
    ���ڿ��κ��� Ư�� ���ڿ��� �����ؼ� ��ȯ
    (�ڹٷ� ġ�� ���ڿ�.substring(~~) �޼ҵ�� ����)
    
    SUBSTR(STR, POSITION, [LENGTH])
    => ����� CHARACTER Ÿ��
    
    > STR : '���ڿ�' �Ǵ� ����Ÿ�� �÷�
    > POSITION : ���ڿ��� ������ ������ġ�� (������ ���ð���)
    > LENGTH : ������ ���� ���� (������ ������ �ǹ�)
*/
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) ����
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

-- ��ø�ؼ� �Լ� ��������
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) "���̵�"
FROM EMPLOYEE;


SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) "���̵�"
FROM EMPLOYEE;
---------------------------------------------------------------------------------

/*
    * LPAD / RPAD
    ���ڿ� ���� ���ϰ��ְ� �����ְ��� �� �� ���
    
    LPAD/RPAD(STR, ���������� ��ȯ�� �����Ǳ���(����Ʈ), [�����̰����ϴ¹���])
    => ����� CHARACTERŸ��
    
    ������ ���ڿ��� ������ ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� ���� N���̸�ŭ�� ���ڿ��� ��ȯ
    
*/
SELECT LPAD(EMAIL, 20) "EMAIL" -- �����̰����ϴ� ���� ������ �⺻���� ����
FROM EMPLOYEE;

SELECT '������' || 'ABC' || 'DEF' FROM DUAL;

SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 850918-2****** �ֹι�ȣ ��ȸ   => �� ���ڼ� : 14����
SELECT RPAD('850918-2', 14, '*') FROM DUAL;

SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8)
FROM EMPLOYEE;

-- �Լ� ��ø���� ����ϴ� ����
SELECT EMP_NAME, RPAD( SUBSTR(EMP_NO, 1, 8) , 14, '*')
FROM EMPLOYEE;

------------------------------------------------------------------------------

/*
    * LTRIM / RTRIM
    
    LTRIM/RTRIM(STR, [���Ž�Ű�����ϴ¹���])
    => ����� CHARACTERŸ��
    
    ���ڿ��� ���� �Ǵ� �����ʿ��� ���Ž�Ű�����ϴ� ���ڵ��� ã�Ƽ� ������ ������ ���ڿ��� ��ȯ   
    
*/
SELECT LTRIM('   K H') FROM DUAL;
SELECT RTRIM('0001230456000', '0') FROM DUAL;
SELECT LTRIM('123123KH123', '123') FROM DUAL;
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;

/*
    * TRIM
    ���ڿ��� ��/��/���ʿ� �ִ� Ư�� ���ڸ� ������ ������ ���ڿ� ��ȯ
    
    TRIM([[BOTH|LEADING|TRAILING] '���Ž�Ű�����ϴ¹���' FROM] STR)
*/
-- �⺻������ ���ʿ� �ִ� ���� ����
SELECT TRIM('  K H  ') FROM DUAL;

SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;

SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- BOTH : ���� (������ �⺻��)
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- LEADING : ��
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- TRAILING : ��

----------------------------------------------------------------------------------

/*
    * LOWER / UPPER / INITCAP
    
    LOWER : �� �ҹ��ڷ�
    UPPER : �� �빮�ڷ�
    INITCAP : �� �ܾ� �ձ��ڸ� �빮�ڷ�
    
    LOWER/UPPER/INITCAP(STR)
    => ����� CHARACTER Ÿ��
    
*/
SELECT LOWER('Welcome To My World!') FROM DUAL;
SELECT UPPER('Welcome To My World!') FROM DUAL;
SELECT INITCAP('welcome to myworld!') FROM DUAL;

-------------------------------------------------------------------------------

/*
    * CONCAT
    ���޵� �ΰ��� ���ڿ� �ϳ��� ��ģ ��� ��ȯ
    
    CONCAT(STR, STR)
    => ����� CHARACTERŸ��
*/
SELECT CONCAT('������', 'ABC') FROM DUAL;
SELECT '������' || 'ABC' FROM DUAL;

SELECT CONCAT('������', 'ABC', 'DEF') FROM DUAL; -- ���� (�ΰ��ۿ� �ȵ�)

--------------------------------------------------------------------------------

/*
    * REPLACE
    
    REPLACE(STRING, STR1, STR2)
    => ����� CHARACTERŸ��
    
    STRING���κ��� STR1�� ã�Ƽ� STR2�� �ٲ� ���ڿ��� ��ȯ
    
*/
SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��') FROM DUAL;

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'iei.com')
FROM EMPLOYEE;

-- =============================================================================

/*
    < ���ڿ� ���õ� �Լ� >
    
    * ABS
    ���� �����ִ� �Լ�
    
    ABS(NUMBER)
    
*/
SELECT ABS(-10) FROM DUAL;
SELECT ABS(-10.9) FROM DUAL;

----------------------------------------------------------------------------

/*
    * MOD
    �� ���� ���� ������ ���� ��ȯ���ִ� �Լ�
    
    MOD(NUMBER, NUMBER)
*/
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(-10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;

----------------------------------------------------------------------------

/*
    * ROUND
    �ݿø� ó�����ִ� �Լ�
    
    ROUND(NUMBER, [��ġ])
*/
SELECT ROUND(123.456) FROM DUAL; -- ��ġ�� ������ �⺻���� 0
SELECT ROUND(123.456, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 4) FROM DUAL;
SELECT ROUND(123.456, -1) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;

-------------------------------------------------------------------------

/*
    * CEIL
    ������ �ø�ó�����ִ� �Լ�
    
    CEIL(NUMBER)
    
*/
SELECT CEIL(123.156) FROM DUAL;

-------------------------------------------------------------------------

/*
    * FLOOR
    �Ҽ��� �Ʒ� ������ ���������� �Լ�
    
    FLOOR(NUMBER)
*/
SELECT FLOOR(123.956) FROM DUAL;
SELECT FLOOR(207.68) FROM DUAL;

SELECT EMP_NAME, FLOOR(SYSDATE-HIRE_DATE) || '��' "�ٹ��ϼ�"
FROM EMPLOYEE;

-----------------------------------------------------------------------------

/*
    * TRUNC
    ��ġ ���������� ����ó�����ִ� �Լ�
    
    TRUNC(NUMBER, [��ġ])
*/
SELECT TRUNC(123.756) FROM DUAL;
SELECT TRUNC(123.756, 1) FROM DUAL;

-- ===============================================================================

/*
    < ��¥ ���� �Լ� >  
    
    >> DATE Ÿ�� : ��,��,��,��,��,�� �� �� ������ �ڷ���
*/
-- * SYSDATE : ����ý��۳�¥ ��ȯ
SELECT SYSDATE FROM DUAL;

-- * MONTHS_BETWEEN(DATE1, DATE2) : �� ��¥ ������ ������ ��ȯ 
--   => ����� NUMBERŸ��
SELECT EMP_NAME
     , FLOOR(SYSDATE-HIRE_DATE) �ٹ��ϼ�
     , FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) �ٹ�������
FROM EMPLOYEE;

-- * ADD_MONTHS(DATE, NUMBER) : Ư�� ��¥�� �ش� ���ڸ�ŭ�� �������� ���� ��¥ ��ȯ
--   => ����� DATE Ÿ��
-- ���ó�¥�κ��� 5���� ��
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- ��ü ������� ������, �Ի���, �Ի��� 6������ �귶������ ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)
FROM EMPLOYEE;

-- * NEXT_DAY(DATE, ����(����|����)) : Ư����¥���� ���� ����� �ش� ������ ã�� �׳�¥ ��ȯ
--   => ����� DATEŸ��
SELECT NEXT_DAY(SYSDATE, '�Ͽ���') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 1) FROM DUAL; -- 1:�Ͽ���, 2:������, ... 6:�ݿ���, 7:�����

SELECT NEXT_DAY(SYSDATE, 'SUNDAY') FROM DUAL; -- ���� (����� KOREAN�̱⶧����)

-- ����
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT NEXT_DAY(SYSDATE, 'SUNDAY') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '�Ͽ���') FROM DUAL; -- ����

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- * LAST_DAY(DATE): �ش� Ư�� ��¥ ���� ������ ��¥�� ���ؼ� ��ȯ
--   => ����� DATE Ÿ��
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- �̸�, �Ի���, �Ի��� ���� ������ ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;


/*
    * EXTRACT
    �⵵ �Ǵ� �� �Ǵ� �� ������ �����ؼ� ��ȯ
    => ����� NUMBER Ÿ��
    
    EXTRACT(YEAR FROM DATE) : Ư�� ��¥�κ��� �⵵�� ����
    EXTRACT(MONTH FROM DATE) : Ư�� ��¥�κ��� ���� ����
    EXTRACT(DAY FROM DATE) : Ư�� ��¥�κ��� �ϸ� ����
    
*/
-- �����, �Ի�⵵, �Ի��, �Ի��� ��ȸ
SELECT EMP_NAME
     , EXTRACT(YEAR FROM HIRE_DATE) "�Ի�⵵"
     , EXTRACT(MONTH FROM HIRE_DATE) "�Ի��"
     , EXTRACT(DAY FROM HIRE_DATE) "�Ի���"
  FROM EMPLOYEE
 ORDER 
    BY �Ի�⵵
     , �Ի��
     , �Ի���;

--===============================================================================

/*
    < ����ȯ �Լ� >
    
    NUMBER => ����
    CHARACTER => ����
    DATE => ��¥
    
    TO_CHAR()   : NUMBER|DATE => CHARACTER
    TO_DATE()   : NUMBER|CHARACTER => DATE
    TO_NUMBER() : CHARACTER => NUMBER       -> DATE =>NUMBER�� �ȵ�
    
    
    * NUMBER|DATE => CHARACTER
    
    TO_CHAR(NUMBER|DATE, [����]) : ������ �Ǵ� ��¥�� �����͸� ������Ÿ������ ��ȯ
    => ������� CHARACTER Ÿ��
    
*/
-- NUMBER => CHARACTER
SELECT TO_CHAR(1234) FROM DUAL;                 -- 1234 => '1234'
SELECT TO_CHAR(1234, '00000') FROM DUAL;        -- 1234 => '01234'   : ��ĭ�� 0���� ä��(������ ���������� �����ؾ��Ѵ�.)
SELECT TO_CHAR(1234, '99999') FROM DUAL;        -- 1234 => ' 1234'   : ��ĭ�� �������� ä��
SELECT TO_CHAR(1234, 'L00000') FROM DUAL;       -- 1234 => '��01234' : ���� ������ ����(LOCAL)�� ȭ�����
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;       -- 1234 => '�� 1234' 
SELECT TO_CHAR(1234, '$99999') FROM DUAL;      -- 1234 => '$ 1234'  : �޷��� ����

SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999') "�޿�����"
  FROM EMPLOYEE;


-- DATE(����Ͻú���) => CHARACTER
SELECT SYSDATE FROM DUAL; 

SELECT TO_CHAR(SYSDATE) FROM DUAL;                    -- '21/02/02'
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;      -- '2021-02-02'
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;     -- '���� 10:07:49'
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;      -- 24�ð� �������� �������Բ� �Ҷ� HH24
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;    -- '2�� ȭ, 2021' '�� ����, �⵵'

-- �⵵�ν� �����ִ� ����
SELECT TO_CHAR(SYSDATE, 'YYYY')
     , TO_CHAR(SYSDATE, 'RRRR')             -- 2021
     , TO_CHAR(SYSDATE, 'YY')
     , TO_CHAR(SYSDATE, 'RR')               -- 21
     , TO_CHAR(SYSDATE, 'YEAR')             -- TWENTY TWENTY-ONE
  FROM DUAL;

-- ���ν� �����ִ� ����
SELECT TO_CHAR(SYSDATE, 'MM')               -- 02
     , TO_CHAR(SYSDATE, 'MON')              -- 2��
     , TO_CHAR(SYSDATE, 'MONTH')            -- 2��
     , TO_CHAR(SYSDATE, 'RM')               -- II (�θ�����)
  FROM DUAL;

-- �Ϸν� �����ִ� ����
SELECT TO_CHAR(SYSDATE, 'D')                -- 1�ֱ��� ��ĥ° (������ ȭ�����̱⶧���� �Ͽ��Ϸκ��� 3��°)
     , TO_CHAR(SYSDATE, 'DD')               -- �Ѵޱ��� ��ĥ° (������ 2���� 2��°)
     , TO_CHAR(SYSDATE, 'DDD')              -- 1����� ��ĥ° (������ 2021�⵵ 33��°) 
  FROM DUAL;
  
-- ���Ϸν� �����ִ� ����
SELECT TO_CHAR(SYSDATE, 'DY')
     , TO_CHAR(SYSDATE, 'DAY')
  FROM DUAL;
  
-- '2021�� 02�� 02�� (ȭ)' �������� ����
SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��" (DY)') FROM DUAL;

-- �����, �Ի���(���� ��������)
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��" (DY)')
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2000;

-------------------------------------------------------------------------------

/*
    * NUMBER|CHARACTER => DATE�� ��ȯ��Ű�� �Լ�
    
    TO_DATE(NUMBER|CHARACTER, [����])  : ������ �Ǵ� ������ �����͸� ��¥������ ��ȯ
    -> ����� DATEŸ��
    
*/
SELECT TO_DATE(20210101) FROM DUAL;
SELECT TO_DATE('20210101') FROM DUAL;
SELECT TO_DATE(000101) FROM DUAL; -- ����
SELECT TO_DATE('000101') FROM DUAL; 

SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE('041030 143021', 'YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL; --2014�⵵
SELECT TO_DATE('980630', 'YYYYMMDD') FROM DUAL; --2098�⵵
-- TO_DATE �Լ��� �̿��ؼ� DATE �������� ��ȯ��
-- ���ڸ��⵵�� ���� YY������ ���������� -> ���缼��� ����

SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL; -- 2014�⵵
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL; -- 1998�⵵
-- ���ڸ��⵵�� ���� RR������ ���������� -> 50 �̻��̸� ��������, 50�̸��̸� ���缼��

----------------------------------------------------------------------------------
/*
    * CHARACTER => NUMBER
    
    TO_NUMBER(CHARACTER, [����]) : ������ �����͸� ���������� ��ȯ
    => ����� NUMBERŸ��
*/

SELECT '123' + '123' FROM DUAL;   --> �˾Ƽ� �ڵ����� ���� ���ڷ� ����ȯ �� �� ���������� ����

SELECT '10,000,000' + '550,000' FROM DUAL;   --> ���ڰ� ���ԵǾ��ֱ� ������ �ڵ�����ȯ �ȵ�

SELECT TO_NUMBER('10,000,000', '99,999,999') + TO_NUMBER('550,000', '999,999')
  FROM DUAL;
  
SELECT TO_NUMBER('0123')
  FROM DUAL;
  
  
-------------------------------------------------------------------------------------------
/*
    < NULL ó�� �Լ� >
*/
-- * NVL(�÷���, �ش��÷�����NULL�� ��� ��ȯ�� �����)
-- �ش� �÷����� ������ ��� ������ �÷��� ��ȯ, 
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
  FROM EMPLOYEE;

-- ���ʽ� ���� ���� ��ȸ
SELECT EMP_NAME, (SALARY + SALARY * NVL(BONUS,0) ) * 12
  FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '����')
  FROM EMPLOYEE;

-- * NVL2(�÷���, �����1, �����2)
-- �ش� �÷����� ������ ��� �����1 ��ȯ
-- �ش� �÷����� NULL�� ��� �����2 ��ȯ
SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0)
  FROM EMPLOYEE;

SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE, '�μ���ġ�Ϸ�', '�μ���ġ����')  --> �μ������� ��ġ�Ϸ�, ������ ����
  FROM EMPLOYEE;

-- * NULLIF(�񱳴��1, �񱳴��2)
-- �ΰ��� ���� ������ ��� NULL ��ȯ
-- �ΰ��� ���� �������� ������� �񱳴�� 1 ��ȯ
SELECT NULLIF('123', '123') FROM DUAL;
SELECT NULLIF('123', '456') FROM DUAL;

--------------------------------------------------------------------------------------------
/*
    < ���� �Լ� >
    * DECODE( �񱳴��(�÷���|�������|�Լ�), ���ǰ�1, �����1, ���ǰ�2, �����2, ..., �����)
    
    > �ڹٿ����� SWITCH���� ����
    switch(�񱳴��) {
    case ���ǰ�1 : �����1;
    case ���ǰ�2 : �����2;
    . . .
    default : �����;
    }
*/
-- ���, �����, �ֹι�ȣ�κ��ͼ����ڸ� ����
SELECT EMP_ID, EMP_NAME "�̸�", DECODE( SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��' ) "����"
  FROM EMPLOYEE;

-- �������� �޿��� �λ���Ѽ� ��ȸ
-- ���� �ڵ尡 'J7' �� ����� �޿��� 10% �λ��ؼ� ��ȸ -> SALARY *1.1
--           'J6' �� ����� �޿��� 15% �λ��ؼ� ��ȸ -> SALARY *1.15
--           'J5' �� ����� �޿��� 20% �λ��ؼ� ��ȸ -> SALARY *1.2
-- �׿��� ������ ������� �޿��� 5%�θ� �λ��ؼ� ��ȸ   -> SALARY *1.05
SELECT EMP_NAME, JOB_CODE, SALARY "�����޿�"
     , DECODE( JOB_CODE, 'J7', SALARY*1.1
                       , 'J6', SALARY*1.15
                       , 'J5', SALARY*1.2
                             , SALARY*1.05) "�λ�޿�"
  FROM EMPLOYEE;

---------------------------------------------------------------------------------------
/*
    * CASE WHEN THEN ����
    
    DECODE �����Լ��� ���ϸ� DECODE�� �ش� ���ǰ˻�� ����񱳸��� �����Ѵٸ� 
    CASE WHEN THEN �������δ� Ư�� ���� ���ý� �� ������� ���ǽ� �������
    
    >> �ڹٷ� IF-ELSE IF�� ���� ����
    
    CASE WHEN ���ǽ�1 THEN �����1
         WHEN ���ǽ�2 THEN �����2
         ...
         ELSE �����
    END
*/

SELECT EMP_ID, EMP_NAME
     , CASE WHEN SUBSTR(EMP_NO, 8, 1) = '2' THEN '��'
            ELSE '��'
        END "����"
  FROM EMPLOYEE;
  
-- �����, �޿�, �޿����(���,�߱�,�ʱ�)
-- SALARY���� 500���� �ʰ��� ��� '���'
--           500���� ���� 350���� �ʰ��� ��� '�߱�'
--           350���� ������ ��� '�ʱ�'
SELECT EMP_NAME, SALARY
     , CASE WHEN SALARY > 5000000 THEN '���'
            WHEN SALARY > 3500000 THEN '�߱�'
            ELSE '�ʱ�'
        END "�޿����"
  FROM EMPLOYEE;

--====================================================================================
--====================================================================================

/*
    < �׷� �Լ� >
    N���� ���� �о 1���� ����� ��ȯ(�ϳ��� �׷캰�� �Լ� ���� ��� ��ȯ)

*/
-- 1. SUM(����Ÿ���÷�) : �ش� �÷������� �� �հ踦 ��ȯ���ִ� �Լ�

-- ��ü ����� �� �޿� ��
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- �μ��ڵ尡 D5�� ������� �� �޿� ��
SELECT SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- ���� ����� �� �޿���
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1';

-- 2. AVG(����Ÿ���÷�) : �ش� �÷������� ��հ��� ���ؼ� ��ȯ
-- ��ü����� ��� �޿�
SELECT AVG(SALARY)
FROM EMPLOYEE;

SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

-- 3. MIN(ANY Ÿ��Į��) : �ش� �÷����� �� ���� ������ ��ȯ
SELECT MIN(SALARY) "�����޿�", MIN(EMP_NAME), MIN(EMAIL), MIN(HIRE_DATE) 
FROM EMPLOYEE;

-- 4. MAX(ANY Ÿ���÷�) : �ش� �÷����� �� ���� ū �� ��ȯ
SELECT MAX(SALARY) "�ִ�޿�", MAX(EMP_NAME), MAX(MAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- 5. COUNT(*|�÷���|DISTRINCT �÷���) : �� ������ ���� ��ȯ 
--    COUNT(*) : ��ȸ����� �ش��ϴ� ��� �� ���� �� ���� ��ȯ
--    COUNT(�÷���) : ������ �ش� �÷����� NULL�� �ƴѰ͸� �� ���� ���� ��ȯ
--    COUNT(DISTINCT �÷���) : ������ �ش� �÷����� �ߺ����� ���� ��� �ϳ��θ� ���� ���� ��ȯ

-- ��ü �����
SELECT COUNT(*)
FROM EMPLOYEE;

-- ���� ��� ��
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2';

-- �μ���ġ�� �� ���(DEPT_CODE ���� �����ϴ�) ��
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- �μ���ġ�� �� ���� ��� �� 
SELECT COUNT (DEPT_CODE)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2';

-- ����� �ִ� ��� ��
SELECT COUNT(MANAGER_ID)
FROM EMPLOYEE;

-- ���� ������� �����ִ� �μ��� ����
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;



