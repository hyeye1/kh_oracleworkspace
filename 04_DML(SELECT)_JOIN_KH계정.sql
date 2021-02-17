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
-- ��ġ�ϴ°� ������ ��ȸ�����ʴ´�, ������ ã�Ƽ� �����ϴ°� ����ΰ� ���������� Ư¡
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


-----------------------------------------------------------------------------
/*
    5. ��ü ���� ( SELF JOIN)
    ���� ���̺��� �ٽ� �ѹ� �����ϴ� ���
    ��, �ڱ� �ڽ��� ���̺�� �ٽ� ������ �δ� ���

*/

SELECT EMP_ID "������", EMP_NAME "�����", SALARY "����޿�", MANAGER_ID "������"
FROM EMPLOYEE;

SELECT * FROM EMPLOYEE E; -- ����� ���� ���� ����� ���̺�    MANAGER_ID
SELECT * FROM EMPLOYEE M; -- ����� ���� ���� ����� ���̺�    EMP_ID          --> �����, ����޿�

-- ������, �����, ����μ��ڵ�, ����޿�
-- ������, �����, ����μ��ڵ�, ����޿�
-->> ����Ŭ ����
SELECT E.EMP_ID "������", E.EMP_NAME "�����", E.DEPT_CODE "����μ�", E.SALARY "����޿�"
     , M.EMP_ID "������", M.EMP_NAME "�����", M.DEPT_CODE "����μ�", M.SALARY "����޿�"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID(+);

-->> ANSI ����
SELECT E.EMP_ID "������", E.EMP_NAME "�����", E.DEPT_CODE "����μ�", E.SALARY "����޿�"
     , M.EMP_ID "������", M.EMP_NAME "�����", M.DEPT_CODE "����μ�", M.SALARY "����޿�"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);


SELECT E.EMP_ID "������", E.EMP_NAME "�����", E.DEPT_CODE "����μ�", ED.DEPT_TITLE "����μ���", E.SALARY "����޿�"
     , M.EMP_ID "������", M.EMP_NAME "�����", M.DEPT_CODE "����μ�", MD.DEPT_TITLE "����μ���", M.SALARY "����޿�"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID)
JOIN DEPARTMENT ED ON (E.DEPT_CODE = ED.DEPT_ID)
JOIN DEPARTMENT MD ON (M.DEPT_CODE = MD.DEPT_ID);

----------------------------------------------------------------------------------
/*
    < ���� JOIN >
    
*/
-- ���, �����, �μ���, ���޸�, ������(LOCAL_NAME)
SELECT * FROM EMPLOYEE;     -- DEPT_CODE                    JOB_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID      LOCATION_ID
SELECT * FROM LOCATION;     --              LOCAL_CODE
SELECT * FROM JOB;          --                              JOB_CODE

-->> ����Ŭ ����
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, J.JOB_NAME, L.LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
  AND D.LOCATION_ID = L.LOCAL_CODE
  AND E.JOB_CODE = J.JOB_CODE

-->> ANSI ����
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, J.JOB_NAME, L.LOCAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);
--> ���� JOIN�Ҷ� ���� �߿� 

-- �����, �μ���, ���޸�, �ٹ�������, �ٹ�������, �޿����
SELECT * FROM EMPLOYEE;     -- DEPT_CODE                    JOB_CODE                    SALARY
SELECT * FROM DEPARTMENT;   -- DEPT_ID      LOCATION_ID
SELECT * FROM LOCATION;     --              LOCAL_CODE                  NATIONAL_CODE
SELECT * FROM JOB;          --                              JOB_CODE
SELECT * FROM NATIONAL;     --                                          NATIONAL_CODE
SELECT * FROM SAL_GRADE;    --                                                          MIN_SAL, MAX_SAL(�������������)

SELECT 
       E.EMP_NAME "�����"
     , D.DEPT_TITLE "�μ���"
     , J.JOB_NAME "���޸�"
     , L.LOCAL_NAME "�ٹ�������"
     , N.NATIONAL_NAME "�ٹ�������"
     , S.SAL_LEVEL "�޿����"
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
  JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
  JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
  JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);

-----------------------------------------<�ǽ�����>--------------------------------------
-- 1. ������ �븮�̸鼭 ASIA������ �ٹ��ϴ� ��������
--    ���, �����, ���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�Ͻÿ�
SELECT * FROM EMPLOYEE;     -- JOB_CODE     DEPT_CODE
SELECT * FROM JOB;          -- JOB_CODE
SELECT * FROM DEPARTMENT;   --              DEPT_ID     LOCATION_ID 
SELECT * FROM LOCATION;     --                          LOCAL_CODE

SELECT E.EMP_ID "���"
     , E.EMP_NAME "�����"
     , J.JOB_NAME "���޸�"
     , D.DEPT_TITLE "�μ���"
     , N.NATIONAL_NAME "�ٹ�������"
     , E.SALARY "�޿�"
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE J.JOB_NAME = '�븮' 
  AND L.LOCAL_NAME LIKE 'ASIA%';


-- 2. 70�����̸鼭 �����̰�, ���� ������ ��������
--    �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�
SELECT * FROM EMPLOYEE;     -- ����� EMP_NAME, �ֹι�ȣ EMP_NO   -- DEPT_CODE     JOB_CODE
SELECT * FROM DEPARTMENT;   -- �μ��� DEPT_TITLE                --  DEPT_ID   
SELECT * FROM JOB;          -- ���޸� JOB_NAME                                   JOB_CODE

SELECT E.EMP_NAME "�����"
     , E.EMP_NO "�ֹι�ȣ"
     , D.DEPT_TITLE "�μ���"
     , J.JOB_NAME "���޸�"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE SUBSTR(E.EMP_NO, 1, 1) = 7
  AND SUBSTR(E.EMP_NO, 8, 1) = 2
  AND EMP_NAME LIKE '��%';

-- 3. �̸��� '��'�ڰ� ����ִ� ��������
--    ���, �����, ���޸��� ��ȸ�Ͻÿ�
SELECT * FROM EMPLOYEE; -- JOB_CODE
SELECT * FROM JOB;      -- JOB_CODE

SELECT E.EMP_ID "���"
     , E.EMP_NAME "�����"
     , J.JOB_NAME "���޸�"
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE EMP_NAME LIKE '%��%';

-- 4. �ؿܿ������� �ٹ��ϴ� ��������
--    �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�
SELECT * FROM EMPLOYEE;     -- JOB_CODE     DEPT_CODE
SELECT * FROM JOB;          -- JOB_CODE
SELECT * FROM DEPARTMENT;   --              DEPT_ID

SELECT E.EMP_NAME "�����"
     , J.JOB_NAME "���޸�"
     , D.DEPT_ID "�μ��ڵ�"
     , D.DEPT_TITLE "�μ���"
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE D.DEPT_TITLE LIKE '�ؿܿ���%';


-- 5. ���ʽ��� �޴� ��������
--    �����, ���ʽ�, ����, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
SELECT * FROM EMPLOYEE;     -- DEPT_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID      LOCATION_ID
SELECT * FROM LOCATION;     --              LOCAL_CODE      NATIONAL_CODE
SELECT * FROM NATIONAL;     --                              NATIONAL_CODE

SELECT E.EMP_NAME "�����"
     , E.BONUS "���ʽ�"
     , E.SALARY*12 "����"
     , D.DEPT_TITLE "�μ���"
     , N.NATIONAL_NAME "�ٹ�������"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE E.BONUS IS NOT NULL;


-- 6. �μ��� �ִ� ��������
--    �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
SELECT * FROM EMPLOYEE;     -- JOB_CODE     DEPT_CODE
SELECT * FROM JOB;          -- JOB_CODE
SELECT * FROM DEPARTMENT;   --              DEPT_ID         LOCATION_ID
SELECT * FROM LOCATION;     --                              LOCAL_CODE      NATIONAL_CODE
SELECT * FROM NATIONAL;     --                                              NATIONAL_CODE

SELECT E.EMP_NAME "�����"
     , J.JOB_NAME "���޸�"
     , D.DEPT_TITLE "�μ���"
     , N.NATIONAL_NAME "�ٹ�������"
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE E.DEPT_CODE IS NOT NULL;


-- 7. '�ѱ�'�� '�Ϻ�'�� �ٹ��ϴ� �������� 
--    �����, �μ���, �ٹ�������, �ٹ��������� ��ȸ�Ͻÿ�
SELECT * FROM EMPLOYEE;     --              DEPT_CODE
SELECT * FROM DEPARTMENT;   --              DEPT_ID         LOCATION_ID
SELECT * FROM LOCATION;     --                              LOCAL_CODE      NATIONAL_CODE
SELECT * FROM NATIONAL;     --                                              NATIONAL_CODE

SELECT E.EMP_NAME "�����"
     , D.DEPT_TITLE "�μ���"
     , L.LOCAL_NAME "�ٹ�������"
     , N.NATIONAL_NAME "�ٹ�������"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE N.NATIONAL_NAME IN ('�ѱ�', '�Ϻ�');



-- 8. ���ʽ��� ���� �ʴ� ������ �� �����ڵ尡 J4 �Ǵ� J7�� ��������
--    �����, ���޸�, �޿��� ��ȸ�Ͻÿ�

SELECT * FROM EMPLOYEE;     -- JOB_CODE     DEPT_CODE
SELECT * FROM JOB;          -- JOB_CODE
SELECT * FROM DEPARTMENT;   --              DEPT_ID         LOCATION_ID
SELECT * FROM LOCATION;     --                              LOCAL_CODE      NATIONAL_CODE
SELECT * FROM NATIONAL;     --                                              NATIONAL_CODE

SELECT E.EMP_NAME
     , J.JOB_NAME
     , E.SALARY
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE E.BONUS IS NULL
AND J.JOB_CODE IN ('J4', 'J7');

-- 9. ���, �����, ���޸�, �޿����, ������ ��ȸ�ϴµ�
--    �̶� ���п� �ش��ϴ� ����
--    �޿������ S1, S2�� ��� '���'
--    �޿������ S3, S4�� ��� '�߱�'
--    �޿������ S5, S6�� ��� '�ʱ�' ���� ��ȸ�ǰ� �Ͻÿ�.

SELECT * FROM EMPLOYEE;     -- JOB_CODE     DEPT_CODE                                       SALARY
SELECT * FROM JOB;          -- JOB_CODE
SELECT * FROM DEPARTMENT;   --              DEPT_ID         LOCATION_ID
SELECT * FROM LOCATION;     --                              LOCAL_CODE      NATIONAL_CODE
SELECT * FROM NATIONAL;     --                                              NATIONAL_CODE
SELECT * FROM SAL_GRADE;    --                                                              MIN_MAX_SAL

SELECT E.EMP_ID
     , E.EMP_NAME
     , J.JOB_NAME
     , S.SAL_LEVEL
     CASE WHEN SAL_LEVEL IN ('S1', 'S2') THEN '���'
     
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);


-- 10. �� �μ��� �� �޿����� ��ȸ�ϵ�
--     �̶�, �� �޿����� 1000���� �̻��� �μ���, �޿����� ��ȸ�Ͻÿ�
SELECT * FROM EMPLOYEE;     -- JOB_CODE     DEPT_CODE                                       SALARY
SELECT * FROM JOB;          -- JOB_CODE
SELECT * FROM DEPARTMENT;   --              DEPT_ID         LOCATION_ID
SELECT * FROM LOCATION;     --                              LOCAL_CODE      NATIONAL_CODE
SELECT * FROM NATIONAL;     --                                              NATIONAL_CODE
SELECT * FROM SAL_GRADE;    --                                                              MIN_MAX_SAL

SELECT 


-- 11. �� �μ��� ��ձ޿��� ��ȸ�Ͽ� �μ���, ��ձ޿� (����ó��)�� ��ȸ�Ͻÿ�.
--      ��, �μ���ġ�� �ȵ� ������� ��յ� ���� �����Բ� �Ͻÿ�.



















