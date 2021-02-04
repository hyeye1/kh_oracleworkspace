/*
    * SUBQUERY (��������)
    - �ϳ��� �ֵ� SQL��(SELECT, INSERT, UPDATE, CREATE, ...) �ȿ� ���Ե� �� �ϳ��� SELECT��
    - ���� SQL���� ���� ���������� �ϴ� ������
    
*/

-- ���� �������� ����1
-- ���ö ����� ���� �μ��� ����鿡 ���� ��ȸ(�����)

-- 1) ���� ���ö ����� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö'; -->  D9�ΰ� �˾Ƴ�!

-- 2) �μ��ڵ尡 D9�� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- ���� �� �ܰ踦 �ϳ��� ����������!!
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö');


-- ���� ������������ 2
-- ��ü����� ��ձ޿����� �� ���� �޿��� �ް��ִ� ������� ���, �̸�, �����ڵ� ��ȸ
-- 1) �� ������ ��� �޿� ��ȸ
SELECT AVG(SALARY)
FROM EMPLOYEE; -- �뷫3047663��

-- 2) �޿��� 3047663�� �̻��� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3047663;

-- ���� �� �ܰ踦 �ϳ��� ��ġ��
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                 FROM EMPLOYEE);
                 
-------------------------------------------------------------------------------
/*
    * �������� ����
      ���������� ������ ������� ���� ��̳Ŀ� ���� �з���
      
      - ������ [���Ͽ�] �������� : ���������� ������ ������� ������ 1���϶�
      - ������ [���Ͽ�] �������� : ���������� ������ ������� �������� ��
      - [������] ���߿� �������� : ���������� ������ ������� �������� ��
      - ������ ���߿� ��������   : ���������� ������ ������� ������ �����÷��� ��
      
      >> ���������� ������ ����� ���� ��̳Ŀ� ���� ��밡���� �����ڵ� �޶���
*/
/*
    1. ������ �������� (SINGLE ROW SUBQUERY)
       ���������� ��ȸ ������� ������ 1���� ��
       
       �Ϲ� ������ ��� ���� ( =, !=, <=, > ...)
       
*/
-- �� ������ ��� �޿����� �� ���Թ޴� ������� �����, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)  --> ����� 1�� 1�� ������ 1����
                FROM EMPLOYEE);
                
-- �����޿��� �޴� ����� ���, �����, �����ڵ�, �޿�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE);
                
-- ���ö ����� �޿����� �� ���� �޴� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY 
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE SALARY> (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö')
AND DEPT_CODE = DEPT_ID;

-- �������� ���� �μ��� ������� ���, �����, ��ȭ��ȣ, ���޸�
SELECT * FROM EMPLOYEE;
SELECT * FROM JOB;

SELECT EMP_ID, EMP_NAME, PHONE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE DEPT_CODE = ( SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������')
AND E.JOB_CODE = J.JOB_CODE;

SELECT EMP_ID, EMP_NAME, PHONE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE DEPT_CODE = ( SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������')
  AND EMP_NAME != '������';
  
-- �μ��� �޿����� ���� ū �μ� �ϳ����� ��ȸ �μ��ڵ� , �޿��� ��ȸ

/*
    2. ������ �������� (MULTI ROW SUBQUERY)
    ���������� ��ȸ ������� �������� ��
    
    -[NOT] IN �������� : �������� ����� �߿��� �Ѱ��� ��ġ�ϴ� ���� ������ / ���ٸ� �̶�� �ǹ�
    
    ANY :                   OR
    - > ANY �������� : �������� ����� �߿��� "�ϳ���" Ŭ ���
                     �������� ����� �߿��� ���� ���������� Ŭ ���
    - < ANY �������� : �������� ����� �߿��� "�ϳ���" ���� ���
                     �������� ����� �߿��� ���� ū�� ���� ���� ���
    
    ALL : ���               AND       
    - > ALL �������� : �������� ������� "���"������ Ŭ ���
                     �������� ����� �߿��� ���� ū ������ Ŭ ���
    - < ALL �������� : �������� ������� "���"������ ���� ���
                     �������� ����� �߿��� ���� ���� ������ ���� ���
*/

-- �� �μ��� �ְ�޿��� �޴� ����� �̸�, �����ڵ�, �޿� ��ȸ

-- 1) �� �μ��� �ְ� �޿� ��ȸ
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- 2890000, 3660000, 8000000, 3760000, 3900000, 2550000

-- 2) ���� �޿��� �޴� ����� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (2890000, 3660000, 8000000, 3760000, 3900000, 2550000);

--> ���� �ΰ��� �ܰ踦 ��ġ��!
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY)
                FROM EMPLOYEE
                GROUP BY DEPT_CODE);

-- ������ �Ǵ� ����� ����� ���� �μ��� ������� ��ȸ�Ͻÿ� (�����, �μ��ڵ�, �޿�)
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ( SELECT DEPT_CODE
                     FROM EMPLOYEE
                     WHERE EMP_NAME IN ('������', '�����'));

-- ��� < �븮 < ���� < ���� < ����
-- �븮�����ӿ��� �ұ��ϰ� ���������� �޿����� ���� �޴� ���� ��ȸ (���, �̸�, ���޸�, �޿�)

-->> ���� ������ �޿��� ��ȸ
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����'; -- 2200000, 2500000, 3760000

-->> ������ �븮�̸鼭 �޿����� ���� ��ϵ� �� �߿� �ϳ��� ū ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
  AND SALARY > ANY (2200000, 2500000, 3760000);
   -- SALARY > 2200000 OR SALARY > 2500000 OR SALARY > 3760000
   
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
  AND SALARY > ANY (SELECT SALARY
                    FROM EMPLOYEE
                    JOIN JOB USING(JOB_CODE)
                    WHERE JOB_NAME = '����');
                    
-- ��� < �븮 < ���� < ���� < ����
-- ���������ӿ��� �ұ��ϰ� ��� ���������� �޿����ٵ� �� ���� �޴� ��� (���, �����, ���޸�, �޿�)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����'
  AND SALARY > ALL (SELECT SALARY
                    FROM EMPLOYEE
                    JOIN JOB USING(JOB_CODE)
                    WHERE JOB_NAME = '����');

-----------------------------------------------------------------------------------
/*
    3. [������] ���߿� ��������
        ��ȸ������� �� �������� ������ �÷����� �������� ��

*/
-- ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ����� ��ȸ

-->> ������ ����� �μ��ڵ�� �����ڵ� ���� ��ȸ
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������';     -- D5 / J5

-- >> �μ��ڵ尡 D5�̸鼭 �����ڵ尡 J5�� ��� ��ȸ
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
  AND JOB_CODE = 'J5';
  
-->> ���� ������� �ϳ��� ����������! (������ ��������)
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '������')
  AND JOB_CODE = (SELECT JOB_CODE
                  FROM EMPLOYEE
                  WHERE EMP_NAME = '������');
                  
-->> ���߿� ��������
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE  --> ������� 1�� ���� �÷�
                                 FROM EMPLOYEE
                                WHERE EMP_NAME = '������');

-- �ڳ��� ����� ���� �����ڵ�, ���� �������� ���� ������� ���, �̸�, �����ڵ�, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                  FROM EMPLOYEE
                                 WHERE EMP_NAME = '�ڳ���');








