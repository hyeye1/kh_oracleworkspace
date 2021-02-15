
/*
    < VIEW �� >
    SELECT��(������)�� �����ص� �� �ִ� ��ü
    (���� ���� �� SELECT���� �����صθ� �� SELECT���� �Ź� �ٽ� ��� �� �ʿ����)
    �ӽ����̺��� ����(���� �����Ͱ� ����ִ°� �ƴ�)
*/

-- '�ѱ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ�������, ���޸��� ��ȸ�Ͻÿ�
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
JOIN JOB USING(JOB_CODE)
WHERE NATIONAL_NAME = '�ѱ�';

-- '���þ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ�������, ���޸��� ��ȸ�Ͻÿ�
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
JOIN JOB USING(JOB_CODE)
WHERE NATIONAL_NAME = '���þ�';

----------------------------------------------------------------------------------

/*
    1. VIEW ���� ���
    
    [ǥ����]
    CREATE [OR REPLACE] VIEW ���
    AS ��������;
    
    [OR REPLACE] : �� ������ ������ �ߺ��� �̸��� �䰡 ���ٸ� ������ �並 �����ϰ�,
                            ������ �ߺ��� �̸��� �䰡 �ִٸ� �ش� �並 ����(����)�ϴ� �ɼ�
*/

CREATE OR REPLACE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME, BONUS
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE)
    JOIN JOB USING(JOB_CODE);
--> ���� KH������ �� ���� ������ ��� �߻��ϴ� ���� => �����ڿ��� CREATE VIEW ���� �ο��������

SELECT * 
FROM VW_EMPLOYEE;

-- '�ѱ�'���� �ٹ��ϴ� ���
SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�ѱ�';

-- '���þ�'���� �ٹ��ϴ� ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, BONUS
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '���þ�';

-- ��� ������ �������̺� => ���������� �����͸� �����ϰ� ���� ���� (�ܼ��� �������� TEXT������ ����Ǿ�����)

-- [����] �ش� ������ ������ �ִ� VIEW�鿡 ���� ���� ��ȸ�ϰ��� �Ѵٸ� USER_VIEWS �����͵�ųʸ�
SELECT * FROM USER_VIEWS;

---------------------------------------------------------------------------------

/*
    * �� �÷��� ��Ī �ο�
      ���������� SELECT���� �Լ��� ���������� ����Ǿ��ִ� ��� �ݵ�� ��Ī ����!
*/

-- ����� ���, �̸�, ���޸�, ����, �ٹ������ ��ȸ�� �� �ִ� SELECT�� ��� ����
CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
          DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��'),
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
   FROM EMPLOYEE       
   JOIN JOB USING(JOB_CODE);

CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
          DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') "����",
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "�ٹ����"
   FROM EMPLOYEE       
   JOIN JOB USING(JOB_CODE);

SELECT *
FROM VW_EMP_JOB;

--> �Ǵٸ� ������� ��Ī �ο����� (��, ��� �÷��� ���� ��Ī �� ����ؾߵ�)
CREATE OR REPLACE VIEW VW_EMP_JOB(���, �����, ���޸�, ����, �ٹ����)
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
          DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��'),
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
   FROM EMPLOYEE       
   JOIN JOB USING(JOB_CODE);

SELECT �����, �ٹ����
FROM VW_EMP_JOB;

SELECT �����, ���޸�
FROM VW_EMP_JOB
WHERE ���� = '��';

-- �ٹ������ 20���̻��� ������� ��� �÷�
SELECT *
FROM VW_EMP_JOB
WHERE �ٹ���� >= 20;

-- �� ���� �ϰ��� �Ѵٸ�
DROP VIEW VW_EMP_JOB;

---------------------------------------------------------------------------------

/*
    * ������ �並 �̿��ؼ� DML(INSERT, UPDATE, DELETE) ��밡��
      ��, �並 ���ؼ� �����ϰ� �Ǹ� ���� �����Ͱ� ����ִ� �������� ���̺�(���̽����̺�)�� ���� ��
*/
CREATE OR REPLACE VIEW VW_JOB
AS SELECT * FROM JOB;

SELECT * FROM VW_JOB;
SELECT * FROM JOB;

-- �信 INSERT
INSERT INTO VW_JOB
VALUES('J8', '����');  --> ���̽����̺�(JOB)�� �� INSERT

-- ��� UPDATE
UPDATE VW_JOB
SET JOB_NAME = '�˹�'
WHERE JOB_CODE = 'J8'; --> ���̽����̺�(JOB)�� �� UPDATE

-- �信 DELETE
DELETE FROM VW_JOB
WHERE JOB_CODE = 'J8'; --> ���̽����̺�(JOB)�� �� DELETE

SELECT * FROM JOB;

----------------------------------------------------------------------------------

/*
    * ������ �並 ������ DML�� �Ұ����� ��찡 �� ����
    
    1) �信 ���ǵǾ����� ���� �÷��� �����ϴ� ���
    2) �信 ���ǵǾ����� ���� �÷� �߿� ���̽����̺� �� NOT NULL���������� ������ ���
    3) �������� �Ǵ� �Լ��� ���ؼ� ���ǵǾ��ִ� ���
    4) �׷��Լ��� GROUP BY���� ���Ե� ���
    5) DISTINCT ������ ���Ե� ���
    6) JOIN�� �̿��ؼ� ���� ���̺��� ��Ī���ѳ��� ���
    
*/

-- 1) �信 ���ǵǾ����� ���� �÷��� ������ �����ϴ� ���
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE FROM JOB;

SELECT * FROM VW_JOB;

-- INSERT => �Ұ�
INSERT INTO VW_JOB(JOB_CODE, JOB_NAME) VALUES('J8', '����');

-- UPDATE => �Ұ�
UPDATE VW_JOB
SET JOB_NAME = '����'
WHERE JOB_CODE = 'J7';

-- DELETE => �Ұ�
DELETE FROM VW_JOB
WHERE JOB_NAME = '���';

--------------------------------------------------------------------------------

-- 2) �信 ���ǵǾ����� ���� �÷��߿��� ���̽����̺�� NOT NULL���������� �����Ǿ��ִ� ���
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

SELECT * FROM VW_JOB;

-- INSERT => �Ұ�
INSERT INTO VW_JOB VALUES('����'); --> JOB���̺� (NULL, '����')�� ���ԵǷ��� �ߴ�!! 

-- UPDATE 
-- ��������� �˹ٷ� ����
UPDATE VW_JOB
SET JOB_NAME = '�˹�'
WHERE JOB_NAME = '���'; --> �信 ���ǵ� �÷����� ������ ����, NOT NULL�������ǿ� ������ ������� ���� ��� ����

SELECT * FROM JOB;
ROLLBACK;

UPDATE VW_JOB
SET JOB_CODE = NULL
WHERE JOB_NAME = '���'; --> �Ұ�

-- DELETE
DELETE FROM VW_JOB
WHERE JOB_NAME = '���'; --> J7 �̶�� �����͸� ������ ���� �ִ� �ڽĵ����Ͱ� �ֱ� ������ ���� �Ұ�

--------------------------------------------------------------------------------

-- 3) �Լ� �Ǵ� ������������ ���ǵ� ���

-- ����� ���, �����, �޿�, ������ ���ؼ� ��ȸ�ϴ� ��
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 "����"
   FROM EMPLOYEE;
   
SELECT * FROM VW_EMP_SAL;  --> �� �並 ������ DML�ϰ� �Ǹ� EMPLOYEE�� �ݿ�

-- INSERT => �Ұ�
INSERT INTO VW_EMP_SAL VALUES(400, '������', 3000000, 36000000);

-- UPDATE
-- 200�� ����� ������ 8000����
UPDATE VW_EMP_SAL
SET ���� = 80000000
WHERE EMP_ID = 200; --> ������������ ���ǵǾ��ִ� �÷��� �����Ϸ��� �ϸ� �Ұ�

-- 200�� ����� �޿��� 700����
UPDATE VW_EMP_SAL
SET SALARY = 7000000
WHERE EMP_ID = 200;

SELECT * FROM EMPLOYEE;
SELECT * FROM VW_EMP_SAL;

-- DELETE 
-- ������ 7200������ ��� ����
DELETE FROM VW_EMP_SAL
WHERE ���� = 72000000;

ROLLBACK;

----------------------------------------------------------------------------------

-- 4) �׷��Լ� �Ǵ� GROUP BY���� ���Ե� ���

-- �μ��� �޿���, ��ձ޿� ��ȸ�ϴ� ��
CREATE OR REPLACE VIEW VW_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) "�޿���", FLOOR(AVG(SALARY)) "��ձ޿�"
   FROM EMPLOYEE
   GROUP BY DEPT_CODE;

SELECT * FROM VW_GROUPDEPT;

-- INSERT => �Ұ�
INSERT INTO VW_GROUPDEPT VALUES('D0', 8000000, 4000000);

-- UPDATE => �Ұ�
UPDATE VW_GROUPDEPT
SET �޿��� = 8000000
WHERE DEPT_CODE = 'D1';

UPDATE VW_GROUPDEPT
SET DEPT_CODE = 'D0'
WHERE DEPT_CODE = 'D1';

-- DELETE => �Ұ�
DELETE FROM VW_GROUPDEPT
WHERE DEPT_CODE = 'D1';

--------------------------------------------------------------------------------

-- 5) DISTINCT�� ���Ե� ���
CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT JOB_CODE
   FROM EMPLOYEE;

SELECT * FROM VW_DT_JOB;

-- INSERT => �Ұ�
INSERT INTO VW_DT_JOB VALUES('J8');

-- UPDATE => �Ұ�
UPDATE VW_DT_JOB
SET JOB_CODE = 'J8'
WHERE JOB_CODE = 'J7';

-- DELETE => �Ұ�
DELETE FROM VW_DT_JOB
WHERE JOB_CODE = 'J7';

