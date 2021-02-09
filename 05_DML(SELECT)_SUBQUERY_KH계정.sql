/*
    * SUBQUERY (��������)
    - �ϳ��� �ֵ� SQL��(SELECT, INSERT, UPDATE, CREATE, ...) �ȿ� ���Ե� ���ϳ��� SELECT��
    - ���� SQL���� ���� ���� ������ �ϴ� ������
    
*/

-- ���� �������� ����1
-- ���ö ����� ���� �μ��� ����鿡 ���� ��ȸ (�����)

-- 1) ���� ���ö ����� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';  --> D9 �ΰ� �˾Ƴ�!

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


-- ���ܼ�����������2
-- ��ü ����� ��ձ޿����� �� ���� �޿��� �ް��ִ� ������� ���, �̸�, �����ڵ� ��ȸ
-- 1) �� ������ ��� �޿� ��ȸ
SELECT AVG(SALARY)
FROM EMPLOYEE; -- �뷫 3047663��

-- 2) �޿��� 3047663�� �̻��� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3047663;

--> ���� �δܰ踦 �ϳ��� ���ļ�!
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                 FROM EMPLOYEE);

---------------------------------------------------------------------------------

/*
    * �������� ����
      ���������� ������ ������� ���� ��̳Ŀ� ���� �з���
      
      - ������ [���Ͽ�] �������� : ���������� ������ ������� ������ 1���϶� 
      - ������ [���Ͽ�] �������� : ���������� ������ ������� �������� �� 
      - [������] ���߿� �������� : ���������� ������ ������� �������� �� 
      - ������ ���߿� �������� : ���������� ������ ������� ������ �����÷��� �� 
      
      >> ���������� ������ ����� ���� ��̳Ŀ� ���� ��밡���� �����ڵ� �޶���
*/

/*
    1. ������ �������� (SINGLE ROW SUBQUERY)
       ���������� ��ȸ ������� ������ 1���� �� 
       
       �Ϲ� ������ ��밡�� (=, !=, <=, > ,....)
*/

-- �� ������ ��� �޿����� �� ���� �޴� ������� �����, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)   --> ����� 1�� 1��  ������ 1����
                FROM EMPLOYEE);

-- �����޿��� �޴� ����� ���, �����, �����ڵ�, �޿�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)      --> ����� 1�� 1�� ������ 1����
                FROM EMPLOYEE);

-- ���ö ����� �޿����� �� ���� �޴� ������� ���, �̸�, �μ���, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME='���ö')
  AND DEPT_CODE = DEPT_ID;
  
  
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME='���ö');
                

-- �������� ���� �μ��� ������� ���, �����, ��ȭ��ȣ, ���޸� ��ȸ (��, �������� ����)
SELECT EMP_ID, EMP_NAME, PHONE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE DEPT_CODE = (SELECT DEPT_CODE     
                   FROM EMPLOYEE
                   WHERE EMP_NAME='������')
  AND EMP_NAME != '������';
  
  
-- �μ��� �޿����� ���� ū �μ� �ϳ����� ��ȸ �μ��ڵ�, �μ���, �޿��� ��ȸ
SELECT DEPT_CODE, DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_CODE, DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY)) --����� 1�� 1�� ������ 1��
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE);


---------------------------------------------------------------------------------

/*
    
    2. ������ �������� (MULTI ROW SUBQUERY)
       ���������� ��ȸ ������� �������� ��
       
       - [NOT] IN �������� : �������� ����� �߿��� �Ѱ��� ��ġ�ϴ� ���� ������ / ���ٸ� �̶�� �ǹ�
       
       ANY : �ϳ���           OR
       - > ANY �������� : �������� ����� �߿��� "�ϳ���" Ŭ ��� 
                         �������� ����� �߿��� ���� ������ ���� Ŭ��� 
       - < ANY �������� : �������� ����� �߿��� "�ϳ���" ���� ���
                         �������� ����� �߿��� ���� ū�� ���� �������
                         
       ALL : ���             AND
       - > ALL �������� : �������� ������� "���" ������ Ŭ ���       
                         �������� ����� �߿��� ���� ū ������ Ŭ ���
       - < ALL �������� : �������� ������� "���" ������ ���� ���
                         �������� ����� �߿��� ���� ���� ������ ���� ���
    
*/

-- �� �μ��� �ְ�޿��� �޴� ����� �̸�, �����ڵ�, �޿� ��ȸ

-- 1) �� �μ��� �ְ� �޿� ��ȸ
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- 2890000, 3660000, 8000000, 3760000, 3900000, 2490000, 2550000

-- 2) ���� �޿��� �޴� ����� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (2890000, 3660000, 8000000, 3760000, 3900000, 2490000, 2550000);

--> ���� �ΰ��� �ܰ踦 ��ġ��!
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY)
                 FROM EMPLOYEE
                 GROUP BY DEPT_CODE);
                 

-- ������ �Ǵ� ����� ����� ���� �μ��� ������� ��ȸ�Ͻÿ� (�����, �μ��ڵ�, �޿�)
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_CODE
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

--> �ϳ��� ����������!
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮' 
  AND SALARY > ANY (SELECT SALARY
                    FROM EMPLOYEE
                    JOIN JOB USING(JOB_CODE)
                    WHERE JOB_NAME = '����');


-- ��� < �븮 < ���� < ���� < ����
-- ���������ӿ��� �ұ��ϰ� ��� ���������� �޿����ٵ� �� ���̹޴� ��� (���, �����, ���޸�, �޿�)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����'
  AND SALARY > ALL (SELECT SALARY   -- 280����, 155����, 249����, 248����
                    FROM EMPLOYEE
                    JOIN JOB USING(JOB_CODE)
                    WHERE JOB_NAME='����');
        -- SALARY > 2800000 AND SALARY > 1550000 AND SALARY > 2490000 AND SALARY > 2480000

---------------------------------------------------------------------------------------

/*
    3. [������] ���߿� ��������
       ��ȸ������� �� �������� ������ �÷����� �������� ��
*/

-- ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ����� ��ȸ

-- >> ������ ����� �μ��ڵ�� �����ڵ� ���� ��ȸ
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������';     -- D5 / J5

-- >> �μ��ڵ尡 D5�̸鼭 �����ڵ尡 J5�� ��� ��ȸ
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
  AND JOB_CODE = 'J5';


-->> ���� ������� �ϳ��� ����������! (�����༭������)
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
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE   --> ������� 1�� �����÷�
                                 FROM EMPLOYEE
                                WHERE EMP_NAME = '������');


-- �ڳ��� ����� ���� �����ڵ�, ���� �������� ���� ������� ���, �̸�, �����ڵ�, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '�ڳ���');

-------------------------------------------------------------------------------------

/*
    4. ������ ���߿� �������� 
       �������� ��ȸ ������� ������ �����÷��� ���
*/
-- �� ���޺� �ּ� �޿��� �޴� ����� ��ȸ (���, �̸�, �����ڵ�, �޿�)

-->> �� ���޺� �ּ� �޿� ��ȸ
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-->> ���� ��ϵ� �߿� ��ġ�ϴ� ���
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) = ('J2', 3700000)
   OR (JOB_CODE, SALARY) = ('J7', 1380000)
   OR (JOB_CODE, SALARY) = ('J3', 3400000)
   ...;
/*
    (JOB_CODE, SALARY) IN (('J2', 3700000), ('J7', 1380000), ('J3', 3400000), ...)
*/

-->> ���� �ܰ踦 �ϳ��� ��ġ��
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY) -- ������ ������
                             FROM EMPLOYEE
                             GROUP BY JOB_CODE);

-- �� �μ��� �ְ�޿��� �޴� ����� ���, �����, �μ��ڵ�, �޿�
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY "�޿�"
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE, '����'), SALARY) IN (SELECT NVL(DEPT_CODE, '����'), MAX(SALARY)
                                           FROM EMPLOYEE
                                           GROUP BY DEPT_CODE)
ORDER BY �޿�;
        --   DEPT_CODE = 'D9' AND SALARY = 8000000
        --OR DEPT_CODE = 'D6' AND SALARY = 3900000
        --OR DEPT_CODE = '����' AND SALARY = 2890000
        
----------------------------------------------------------------------------------

/*
    5. �ζ��� �� (INLINE-VIEW)
       FROM ���� ���������� �����ϴ°�
       
       ���������� ������ ���(RESULT SET)�� ���̺� ��ſ� �����!!
*/

-- ���ʽ����Կ����� 3000���� �̻��� ������� ���, �̸�, ���ʽ����Կ���, �μ��ڵ带 ��ȸ
SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0)) * 12 "���ʽ����Կ���", DEPT_CODE
FROM EMPLOYEE
--WHERE ���ʽ����Կ��� >= 30000000;
WHERE (SALARY + SALARY * NVL(BONUS, 0)) * 12 >= 30000000;

-->> �ζ��κ� �Ẹ��!
SELECT EMP_NAME, ���ʽ����Կ���--, JOB_CODE
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0)) * 12 "���ʽ����Կ���", DEPT_CODE
      FROM EMPLOYEE)
WHERE ���ʽ����Կ��� >= 30000000;

-->> �ζ��� �並 �ַ� ����ϴ� ��
--   * TOP-N�м�

-- �� ���� �� �޿��� ���� ���� ���� 5��

-- * ROWNUM : ����Ŭ���� �������ִ� �÷�, ��ȸ�� ������� 1���� ������ �ο����ִ� �÷�
SELECT ROWNUM, EMP_NAME, SALARY -- 3
FROM EMPLOYEE               -- 1
WHERE ROWNUM <= 5           -- 2
ORDER BY SALARY DESC;           -- 4

-- => FROM => WHERE => SELECT => ORDER BY

--> ORDER BY�� ������ ���̺��� ������ ROWNUM ���� �ο� �Ŀ� ROWNUM <= 5
SELECT ROWNUM "����", E.*
FROM (SELECT * 
       FROM EMPLOYEE
      ORDER BY SALARY DESC) E
WHERE ROWNUM <= 10;

-- ���μ��� ��ձ޿��� ���� 3���� �μ��� �μ��ڵ�, ��� �޿� ��ȸ
SELECT DEPT_CODE, ROUND(��ձ޿�) "��ձ޿�"
FROM (SELECT DEPT_CODE, AVG(SALARY) "��ձ޿�"
      FROM EMPLOYEE
      GROUP BY DEPT_CODE
      ORDER BY ��ձ޿� DESC)
WHERE ROWNUM <= 3;

-- ���� �ֱٿ� �Ի��� ��� 5�� ��ȸ �����, �޿�, �Ի���
SELECT *
FROM (SELECT EMP_NAME, SALARY, HIRE_DATE
      FROM EMPLOYEE
      ORDER BY HIRE_DATE DESC)
WHERE ROWNUM <= 5;

--------------------------------------------------------------------------------

/*
    6. ���� �ű�� �Լ�
             RANK() OVER(���ı���)
       DENSE_RANK() OVER(���ı���)
       
       ��, ���� �Լ����� ������ SELECT�������� �ۼ� ����
       
       - RANK() OVER(���ı���) : ���� 1���� 3���̶�� �Ѵٸ� �� ���� ������ 4���� �ϰڴ�
       - DENSE_RANK() OVER(���ı���) : ���� 1���� 3���̶�� �ص� �� ���� ������ ������ 2�� 
    
*/

-- ������� �޿��� ���� ����� ������ �Űܼ� �����, �޿�, ���� ��ȸ
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE;
--> ���� 19�� 2�� �׵��� ���� 21��

SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE;
--> ���� 19�� 2�� �׵��� ���� 20��

-- 5�������� ��ȸ�ϰڴ�.
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE
--WHERE ���� <= 5;
WHERE RANK() OVER(ORDER BY SALARY DESC) <= 5; --> ������ �Լ� WHERE ���� ��� �Ұ�


-->> �ᱹ �ζ��κ�� �ؾߵ�!
SELECT *
FROM (SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY ASC) "����"
        FROM EMPLOYEE)
WHERE ���� <= 5;

















