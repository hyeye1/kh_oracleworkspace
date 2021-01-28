/*

    <select>
    �����͸� ��ȸ�ϰų� �˻��� �� ���Ǵ� ��ɾ�
    
    * Result Set : Select ������ ���� ��ȸ�� �������� ������� ����
                    ��, ��ȸ�� ����� ������ �ǹ�
    * ǥ����
    SELECT��ȸ�ϰ��� �ϴ� �÷�, �÷�, �÷�, ...
    FROM ���̺��;

*/

-- EMPLOYEE ���̺��� ��ü ������� ��� �÷�(*) ��ȸ  -> *�� ������ �ǹ���.
SELECT * FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ��ü ������� ���, �̸�, �޿� �÷����� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

--> ��ɾ�, Ű���� ���� ��ҹ��ڸ� ������ ������ ����ִ� �����ʹ� ������.


-----------------------�ǽ�����-----------------------
--1. JOB���̺��� ��� �÷� ��ȸ
SELECT * FROM JOB;

--2. JOB���̺��� ���޸� �÷��� ��ȸ
SELECT JOB_NAME FROM JOB;

--3. DEPARTMENT ���̺��� ��� �÷� ��ȸ
SELECT * FROM DEPARTMENT;

--4. EMPLOYEE ���̺��� ������, �̸���, ��ȭ��ȣ, �Ի��� �÷��� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE FROM EMPLOYEE;

--5. EMPLOYEE ���̺��� �Ի��� ������ �޿� �÷��� ��ȸ
SELECT HIRE_DATE, EMP_NAME, SALARY FROM EMPLOYEE;

/*
    <�÷����� ���� �������>
    - ��ȸ�ϰ��� �ϴ� �÷����� �����ϴ� SELECT���� �������(+-/*)�� ����ؼ� ����� ��ȸ�� �� �ִ�.
    
*/

-- EMPLOYEE ���̺�κ��� ������, ����, ����(����*12)
SELECT EMP_NAME, SALARY, SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE ���̺�κ��� ������, ����, ���ʽ�, ���ʽ������Եȿ���(����+���ʽ�*����)*12
SELECT EMP_NAME, SALARY, BONUS, (SALARY+BONUS*SALARY)*12
FROM EMPLOYEE;
--> ��������ϴ� ������ NULL���� ������ ��� ������� ��������� NULL������ ��ȸ�ȴ�.

-- EMPLOYEE ���̺�κ��� ������, �Ի���, �ٹ��ϼ�(���ó�¥ -�Ի���) ��ȸ
-- DATEŸ�Գ����� ���� ���� (DATE -> ��, ��, ��, ��, ��, ��)
-- ���ó�¥ : SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE
FROM EMPLOYEE;
-- ���� �������� ������ DATEŸ�Ծȿ� ���ԵǾ��ִ� ��/��/�ʿ� ���� ������� �����ϱ� �����̴�.

/*
    <�÷��� ��Ī �����ϱ�>
    
    [ǥ����]
    1. �÷��� AS��Ī, 2. �÷��� AS "��Ī", 3. �÷��� ��Ī, 4. �÷��� "��Ī"
    
    AS�� ���̵� �Ⱥ��̵�
    ��Ī�� Ư�����ڳ� ���Ⱑ ���Ե� ��� �ݵ�� "" �� ��� ǥ���ؾߵ�
    
*/

SELECT EMP_NAME AS �̸�, SALARY AS "�޿� (��)", BONUS ���ʽ�, (SALARY+BONUS*SALARY)*12 "�� �ҵ�"
FROM EMPLOYEE;

-----------------------------------------------------------------------------------
--���ͷ�
int a = 20; --> ������ ���� ����ü�� ���ͷ��̶�� �θ�

/*
    <���ͷ�>
    ���Ƿ� ������ ���ڿ�('')�� SELECT���� ����ϸ�                                ( �ڹٿ����� ���ڿ��� ���ڸ� "" '' �� ǥ�������� ���⼱ ���ڿ� ���ڿ� ���о��� '')
    ���� �� ���̺� �����ϴ� ������ó�� ��ȸ����
*/
-- EMPLOYEE ���̺�κ��� ���, �����, �޿�, ����('��') ��ȸ�ϱ�
SELECT EMP_ID, EMP_NAME, SALARY, '��' ����
FROM EMPLOYEE;

--------------------------------------------------------------------------------------

/*
    < DISTINCT >
    ��ȸ�ϰ����ϴ� �÷��� �ߺ��� ���� �� �ѹ����� ��ȸ�ϰ��� �� �� ���
    �ش� �÷��� �տ� ����Ѵ�.
    
    [ǥ����] DISTINCT �÷���
    
    (��, SELECT���� �� �� ���� ��� ����)
*/
-- EMPLOYEE ���̺�κ��� �μ��ڵ� ��ȸ
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

-- EMPLOYEE ���̺�κ��� �����ڵ� ��ȸ
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- DEPT_CODE�� JOB_CODE ��� ��ȸ
SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

--------------------------------------------------------------------------------

/*
    < WHERE �� >
    
    ��ȸ�ϰ��� �ϴ� ���̺� Ư�� ������ �����ؼ�
    �� ���ǿ� �����ϴ� �����͸��� ��ȸ�ϰ��� �� �� ����ϴ� ����
    
    [ǥ����]
    SELECT ��ȸ�ϰ����ϴ� �÷�, �÷�, . . . 
    FROM ���̺��
    WHERE ���ǽ�;
    
    => ���ǽĿ� �پ��� �����ڵ� ��� ����
    
    < �� ������ >
    >  <  >=  <=
         =
     !=  ^=  <>
*/
-- EMPLOYEE ���̺�κ��� �޿��� 400���� �̻��� ����鸸 ��ȸ(����÷�)
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE ���̺�κ��� �μ��ڵ尡 D9�� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- �μ��ڵ� D9�� �ƴ� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';         --> ������ ��� ��ġ���� ������ �ǹ�

-------------------------- �ǽ����� --------------------------------------
-- 1. EMPLOYEE ���̺��� �޿��� 300���� �̻��� ������� �̸�, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. EMPLOYEE ���̺��� �����ڵ尡 J2�� ������� �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J2';

-- 3. EMPLOYEE ���̺��� ���� �������� ������� ���, �̸�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN != 'N';

-- 4. EMPLOYEE ���̺��� ����(�޿�*12)�� 5000���� �̻��� ������� �̸�, �޿�, ����, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, (SALARY*12) "����" , HIRE_DATE    --3
FROM EMPLOYEE                                             --1
WHERE (SALARY*12) >= 50000000;                            --2
           --> SELECT���� �ο��� ��Ī("����")��  WHERE������ ����� �� ����.
           --> ��������� FROM-> WHERE -> SELECT�̱⶧��
           
-----------------------------------------------------------------------------------


/*
    < �������� >
    �������� ������ ���� �� ���
    
    AND(~�̸鼭, �׸���) , OR(~�̰ų�, �Ǵ�)
*/
-- �μ��ڵ尡 'D9'�̸鼭 �޿��� 500���� �̻��� ������� �̸�, �μ��ڵ�, �޿�
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- �μ��ڵ尡 'D9'�̰ų� �޿��� 500���� �̻��� ������� �̸�, �μ��ڵ�, �޿�
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

/*
    < BETWEEN AND>
    
    [ǥ����] 
    �񱳴���÷��� BETWEEN ���Ѱ� AND ���Ѱ�
*/

-- �޿��� 350���� �̻��̰� 600���� ������ ������� �̸�, ���, �޿�, �����ڵ� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
--WHERE SALARY >= 3500000 AND SALARY <= 6000000;
WHERE SALARY BEWEEN 3500000 AND 6000000;

-- �޿��� 350���� �̻� 600���� ���ϰ� �ƴ� �����
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
--WHERE NOT SALARY BETWEEN 3500000 AND 6000000;  -- 1�����. 
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;  -- 2�����. 
-- ����Ŭ������ NOT�� �ڹٷ� ������ �� �������������� !�� ������ �ǹ�


-- ** BETWEEN AND ������ DATE���İ������� ��� ����
-- �Ի����� '90/01/01' ~ '01/01/01'�� ������� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '01/01/01';


SELECT *
FROM EMPLOYEE
WHERE NOT HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

----------------------------------------
/*
    <LIKE Ư������>
    [ǥ����]
    �񱳴���÷��� LIKE 'Ư������'
    
    - Ư�����Ͽ� ���ϵ�ī���� '%' '_' �� ������ ������ �� ����
    > '%' : 0�����̻�
    EX) �񱳴���÷��� LIKE '����%'    :   �÷����߿� '����'�� ���۵Ǵ� �� ��ȸ
        �񱳴���÷��� LIKE '%����'    :   �÷����߿� '����'�� ������ �� ��ȸ
        �񱳴���÷��� LIKE '%����%'   :   �÷����߿� '����'�� ���ԵǴ� �� ��ȸ
        
    > '_' : 1�����ǹ�
    EX) �񱳴���÷��� LIKE '_����'    :   �÷�
*/
-- ���� ������ ������� �̸�, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- �̸��߿� '��'�� ���Ե� ������� �̸�, �ֹι�ȣ, �μ��ڵ� ��ȸ
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%'; 

-- ��ȭ��ȣ 4��° �ڸ��� 9�� �����ϴ� ������� ���, �����, ��ȭ��ȣ, �̸�����ȸ
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
--WHERE PHONE LIKE '0109%' OR PHONE LIKE '0119%' OR PHONE LIKE '0179%';
WHERE PHONE LIKE '___9%';

-- �̸� ��� ���ڰ� '��'�� ������� ���Į��
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';

-------------------- �ǽ����� ---------------------
-- 1. �̸��� '��'���� ������ ������� �̸�, �Ի��� ��ȸ
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

-- 2. ��ȭ��ȣ ó�� 3���ڰ� 010�� �ƴ� ������� �̸�, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- 3. DEPARTMENT ���̺��� �ؿܿ����� ���õ� �μ����� ��� �÷� ��ȸ
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '�ؿܿ���%';

-- ��� ���ϵ� ī��� ��� �����Ͱ����� ������ �ȵ�!!
-- �����Ͱ����� �νĽ�ų �� �տ� ������ ���ϵ� ī��� �����ϰ� ������ ���ϵ�ī�带 EXCAPE�� ���
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE'$';

-------------------- �ǽ����� =------------------------
-- 1, �̸��� '��'���� ������ ������� �̸�, �Ի��� ��ȸ
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';


----------------------------------------------------------------
/*
    < IS NULL / IS NOT NULL >
    [ǥ����]
    �񱳴���÷� IS NULL : �÷����� NULL�� ���
    �񱳴���÷� IN NOT NULL : �÷����� NULL�� �ƴ� ���
*/
SELECT * FROM EMPLOYEE;

-- ���ʽ��� ���� �ʴ� ����� (BONUS �÷����� NULL��)�� ���, �̸�, �޿�, ���ʽ�
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
-- WHERE BONUS = NULL; => ����� �ȵ�
WHERE BONUS IS NULL;

-- ���ʽ��� �޴� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL ;

-- ����� ���� ������� �����, ������, �μ��ڵ� ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- ����� ���� �μ���ġ�� ��������������� ����÷� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- �μ���ġ�� ���� �ʾ����� ���ʽ��� �޴� ��� ��ȸ (�����, ���ʽ�, �μ��ڵ�)
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-----------------------------------------------------------
/*
    < IN >
     �񱳴�� �÷����� ���� ������ ��ϵ� �߿� ��ġ�ϴ� ���� �ϳ��� �����ϸ� ��ȸ
     
    [ǥ����]
    �񱳴��Į�� IN (��, ��, ��, . .)
*/
-- �μ��ڵ尡 D6�̰ų� �Ǵ� D8�̰ų� �Ǵ� D5�� ������� �̸�, �μ��ڵ�, �޿�
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_COD = 'D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');

-- �׿��� �����
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN ('D6', 'D8', 'D5');

------------------------------------------------------------------------------
/*
    < ���� ������ || >
    ���� �÷������� ��ġ �ϳ��� �÷��� �� ó�� ��������ִ� ������
    �÷��� ���ͷ�(������ ���ڿ�)�� ������ �� ����
    */
    
SELECT EMP_ID || EMP_NAME || SALARAY AS "�����"
FROM EMPLOYEE;

-- XXX�� XXX�� ������ XXXXXX�� �Դϴ�.
SELECT EMP_ID || '�� ' || EMP_NAME || '�� ������ ' || SALARY || '�� �Դϴ�.' �޿�����
FROM EMPLOYEE;
    
    
/*
    0. ()
    1. ���������
    2. 
    3. �񱳿�����
    4. IS NULL          LIKE        IN
    5. BETWEEN AND
    6. NOT
    7. AND (��������)
    8. OR (��������)
*/

------------------------------------------------------------------

/*
    < ORDER BY �� >
    SELECT�� ���� �������� �����ϴ� ���� �Ӹ� �ƴ϶� ���� ���� ���� ���� ������
    
    [ǥ����]
    SELECT ��ȸ��Į��, �÷�, ...
    FROM ��ȸ�� ���̺��
    WHERE ���ǽ�
    ORDER BY ���ı������μ�������ϴ��÷���|��Ī|�÷�����[ASC|DESC]
    
    - ASC : �������� ���� ( ������ �⺻��)
    - DESC : �������� ����
    
    - NULLS FIRST : �����ϰ��� �ϴ� �÷����� NULL�� ���� ��� �ش� NULL������ ������ ��ġ (�������� ������ ��� �⺻��)
    - NULLS LAST : �����ϰ��� �ϴ� �÷����� NULL�� ���� ��� �ش� NULL������ �ڷ� ��ġ (�������� ������ ��� �⺻��)
    


*/

SELECT *
FROM EMPLOYEE
--ORDER BY BONUS; -- ASC �Ǵ� DESC ������ �⺻���� ASC (������������)
--ORDER BY BONUS ASC; -- ASC �� NULLS LAST ����
--ORDER BY BONUS ASC NULLS FIRST;
--ORDER BY BONUS DESC; -- DESC�� �⺻������ NULLS FIRST����


ORDER BY BONUS DESC, SALARY ASC;
-- ù��°�� ������ ���ı����� �÷����� ��ġ�� ��� �ι�° ���ı����� ������ �ٽ�����

-- ������ �������� ����
SELECT EMP_NAME, SALARY*12 "����"
FROM EMPLOYEE
-- ORDER BY SALARY*12 DESC;
-- ORDER BY ���� DESC;              --��Ī ��밡��
ORDER BY 2 DESC;                   --�÷� ���� ��밡��

