/*
    < JOIN >
    
    �� ���̻��� ���̺��� �����͸� ���� ��ȸ�ϰ��� �� �� ���Ǵ� ����
    ��ȸ ����� �ϳ��� �����(result set)�� ����
    
    ������ �����ͺ��̽������� �ּ����� �����ͷ� ������ ���̺� �����͸� �����ϰ� ���� (�ߺ��� �ּ�ȭ�ϱ� ���ؼ�)
    => ��, JOIN ������ �̿��ؼ� �������� ���̺� "����"�� �ξ ���� ��ȸ�ؾ���
    => ��, ������ JOIN�� �ؼ� ��ȸ�ϴ°� �ƴ϶�
        ���̺� "�����"�� �ش��ϴ� �÷��� "��Ī"���Ѽ� ��ȸ�ؾ��Ѵ�.
            
                                           [ JOIN ��� ���� ]
                        
                          JOIN�� ũ�� "����Ŭ ���뱸��"�� "ANSI(�̱�����ǥ����ȸ) ����"
                        
                    ����Ŭ ���뱸��(����Ŭ)            |           ANSI����(����Ŭ+�ٸ�DBMS)
   --==========================================================================================================
                           � ����                 |            ���� ���� (INNER JOIN)   -> JOIN USING/ON
                         (EQUAL JOIN)              |            �ڿ� ���� (NATUAL JOIN)  -> JOIN USING
   --------------------------------------------------------------------------------------------------------------
                           ���� ����                 |           ���� �ܺ����� (LEFT OUTER JOIN)
                        ( LEFT OUTER )             |           ������ �ܺ����� (RIGHT OUTER JOIN)
                        (RIGHT OUTER )             |            ��ü �ܺ����� (FULL OUTER JOIN) -> ����Ŭ������ �Ұ�
    --------------------------------------------------------------------------------------------------------------
                    ī�׽þ� �� (CARTESIAN PRODUCT)  |          ���� ����(CROSS JOIN)
    -------------------------------------------------------------------------------------------------------------
    ��ü ����(SELF JOIN) �� ����(NON EQUAL JOIN)   |              JOIN ON



*/

-- ��ü ������� ���, �����, �μ��ڵ�, �μ������ �˾Ƴ����� �Ѵٸ�?
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- ��ü ������� ���, �����, �����ڵ�, ���޸���� �˾Ƴ����� �Ѵٸ�?
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, JOB_NAME
FROM JOB;
--------> ������ ���ؼ� ������� �ش��ϴ� �÷��� ����� ��Ī��Ű�� ��ġ �ϳ��� ������� ��ȸ����

/*
    1. �����(EQUAL JOIN)/ ��������(INNER JOIN)
       �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 �����ؼ� ��ȸ(== ��ġ�����ʴ� ������ ��ȸ���� ����)
*/
-- >> ����Ŭ ���� ����
--    FROM ���� ��ȸ�ϰ����ϴ� ���̺���� ���� (, ��)
--

--   ��ü����� ���, �����, �μ��ڵ�, �μ��� ������ȸ
-- 1) ������ �� �÷����� �ٸ���� (EMPLOYEE-"DEPT_CODE" / DEPARTMENT-"DEPT_ID")
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> ��ġ���� �ʴ� ���� ��ȸ���� ���ܵȰ� Ȯ�ΰ���
-- (DEPT_CODE�� NULL�̾��� 2���� ��������� ��ȸ�ȵ�, DEPT_ID�� D3,D4,D7�� �μ������� ��ȸ�ȵ�)

-- ���, �����, �����ڵ�, ���޸�
-- 2)������ �� �÷����� ���� ��� (EMPLOYEE - "JOB_CODE" / JOB- "JOB_CODE")

/*
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE JOB_CODE = JOB_CODE; 
-> ���� : ambiguously : �ָ��ϴ�, ��ȣ�ϴ� => Ȯ���� ����̺��� �÷������� �� �������ߵ�
*/

-- ���1) ���̺���� �̿��ϴ� ���
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- ���2) ���̺��� ��Ī ��� ( �� ���̺��� ��Ī �ο�����)
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-->> ANSI ����
-- FROM ���� ���� ���̺��� �ϳ� ��� �� ��
-- �� �ڿ� JOIN������ ���� ��ȸ�ϰ��� �ϴ� ���̺� ��� ( ���� ��Ī��ų �÷��� ���� ���ǵ� ���� ���)
-- USING����/ ON����

-- ���, �����, �μ��ڵ�, �μ���
-- 1) ������ �� �÷����� �ٸ� ��� (EMPLOYEE- "DEPT_CODE"/ DEPARTMENT-"DEPT_ID")
-- => ������ ON ������ ����! (USING���� �Ұ���)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
/*INNER(��������)*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- ����̺� ���� ��ȸ�Ұ��� JOIN -> ��Ī��ų ���� -ON

-- ��� ����� �����ڵ� ���޸�
-- 2) ������ �� �÷����� ���� ���(EMPLOYEE - "JOB_CODE" / JOB- "JOB_CODE")
-- ON ���� , USING ���� �Ѵ� ��밡���ϳ� ON�� �� ��ȣ�Ѵ�

--  2_1) ON ���� �̿� : AMBIGUOSLY�� �߻�Ȱ �� �ֱ� ������ Ȯ���� ����ؾ���
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);
-- JOB���Ժ��̶� �����ؼ� EMPLOYEE�� ��ȸ�ҷ�!

--  2_2) USING���� �̿� : ��ġ�ϴ� �÷����� �˾Ƽ� ã�⶧���� AMBIGUOSLY�߻� X
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- [����] ���� USING ������ ���ô� NATURAL JOIN(�ڿ�����)���ε� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;
-- �ΰ��� ���̺� ������ ����, �����Ե� �ΰ��� ���̺� ��ġ�ϴ� �÷��� �����ϰ� �Ѱ� ����(JOB_CODE) => �˾Ƽ� ��Ī�Ͽ� ��ȸ�Ѵ�.

-- �߰����� ���ǵ� ���ð���!
-- ������ �븮�� ������� ������ ��ȸ

-->> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME = '�븮';

-->> ANSI ����
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
FROM EMPLOYEE  E
-- JOIN JOB USING(JOB_CODE)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE JOB_NAME = '�븮';

---------------------< �ǽ����� >---------------------------------

-- 1. �μ��� '�λ������'�� ������� ���, �����, ���ʽ��� ��ȸ
-->> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE, DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE = '�λ������';


-->> ANSI����
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '�λ������';

-- 2. �μ��� '�ѹ���'�� �ƴ� ������� �����, �޿�, �Ի��� ��ȸ
-->> ����Ŭ ���뱸��
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_ID = DEPT_CODE
AND DEPT_TITLE != '�ѹ���';

-->> ANSI ����
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE AND DEPT_TITLE != '�ѹ���');
--WHERE DEPT_TITLE != '�ѹ���';

-- 3. ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
-->> ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND BONUS IS NOT null;

-->> ANSI ����
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;

-- 4. �Ʒ��� �� ���̺� �����ؼ� �μ��ڵ�, �μ���, �����ڵ�, ������(LOCAL_NAME) ��ȸ
SELECT * FROM DEPARTMENT; -- LOCATION_ID
SELECT * FROM LOCATION;   -- LOCAL_CODE
-->> ����Ŭ ���� ����
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT;

-->> ANSI����
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- �߰�) ���, �����, �μ���, ���޸�
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;

-->> ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID -- ��Ī�� ��Ű��~
AND E.JOB_CODE = J.JOB_CODE;

-->> ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);

------------------------------------------------------------------------��������� �����,��������
-- ��ġ�ϴ°� ������ ��ȸ�����ʴ´�, ������ ã�Ƽ� �����ϴ°� �а����ΰ� ���������� Ư¡
-----------------------------------------------------------------------------------------------
/*
    2. �������� / �ܺ����� (OUTER JOIN)
    
    ���̺��� JOIN�� ��ġ���� ���� �൵ ���Խ��Ѽ� ��ȸ����
    ��, �ݵ�� LEFT/RIGHT�� �����ؾ���! (������ �Ǵ� ���̺� �����ؾߵ�!)
    
*/
-- "��ü" ������� �����, �޿�, �μ��� ��ȸ
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- DEPT_CODE�� NULL�� �θ��� ��� ��ȸ X
-- �μ��� ������ ����� ���� �μ�(D3, D4, D7)���� ��� ��ȸ X

-- 1) LEFT[OUTER] JOIN : �� ���̺� �� ���� ����� ���̺� �������� JOIN
--                       ��, ���� �Ƶ� ���� ����� ���̺��� �����ʹ� ������ ��ȸ�ǰ� (��ġ�ϴ� ���� ã�� ���߾)
-->> ANSI����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
LEFT /*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--> EMPLOYEE ���̺� �������� ��ȸ�߱� ������ EMPLOYEE�� �����ϴ� �����ʹ� ���� �Ƶ� ��ȸ�ǰԲ�!

-->> ����Ŭ ���뱸��
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE =DEPT_ID(+); --> ���� �������� ���� ���̺��� �÷����̾ƴ� �ݴ� ���̺��� �÷���(+)

-- 2) RIGHT [OUTER] JOIN : �� ���̺� �� ������ ����� ���̺��� �������� JOIN
--                         ��, ���������̺� �ִ� �� ������ ��ȸ�ϰڴ�! (��ġ�ϴ� �� ã�� ���ϴ���)
-->> ANSI����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
RIGHT/*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-->> ����Ŭ ���� ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- 3) FULL [ORDER] JOIN : �� ���̺��� ���� ��� ���� ��ȸ�� �� �ֵ��� (��, ����Ŭ ���뱸�������� �Ұ�)
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
FULL /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-->> ����Ŭ ���뱸��(��������)
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);

-------------------------------------------------------------------------------
/*
    3. ī�׽þȰ�(CARTESIAN PRODUCT) / �������� (CROSS JOIN)
    ��� ���̺��� �� ����� ���μ��� ���ε� �����Ͱ� ��ȸ��(������)
    
    �����̺��� ����� ��� ������ ����� ���� ��� -> ����� ������ ��� => �������� ����
*/
-- �����, �μ���
--> ����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT; --> 23 * 9 => 207�� �� ��ȸ

-->> ANSI ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;

------------------------------------------------------------------------------
/*
    4. �� ����(NON EQUAL JOIN)
    '='(��ȣ)�� ������� �ʴ� ���ι�
    
    ������ �÷������� ��ġ�ϴ� ��찡 �ƴ�, "����"�� ���ԵǴ� ��� ��Ī
    
    
*/
-- �����, �޿�
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;

SELECT *
FROM SAL_GRADE;

-- �����, �޿�, �޿����(SAL_LEVEL)
-->> ����Ŭ ���뱸��
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
--WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-->> ANSI ���� ( ON ������! )
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);







