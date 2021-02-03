/*
    < GROUP BY�� >
    �׷��� ������ ������ ������ �� �ִ� ���� 
    => �ش� ���õ� ���غ��� �׷��� ���� �� ����!!
    
    �������� ������ �ϳ��� �׷����� ��� ó���� �������� ���
*/
-- ��ü����� �� �޿���
SELECT SUM(SALARY)
FROM EMPLOYEE;  --> ���� ��ȸ�� ��ü������� �ϳ��� �׷����� ��� ������ ���� ���

-- �� �μ��� �� �޿���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- ��ü��� ��
SELECT COUNT(*)
FROM EMPLOYEE;

-- �� �μ��� ��� ��
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �� �μ��� �� �޿����� �μ��� �������� �����ؼ� ��ȸ
SELECT DEPT_CODE, SUM(SALARY) -- 3. SELECT ��
FROM EMPLOYEE       -- 1. FROM ��
GROUP BY DEPT_CODE  -- 2. GROUP BY ��
ORDER BY DEPT_CODE; -- 4. ORDER BY ��

-- �� ���޺� �����ڵ�, �ѱ޿���, �����, ���ʽ��� �޴� �����
SELECT JOB_CODE "����", SUM(SALARY) "�޿���", COUNT(1) "�����", COUNT(BONUS) "���ʽ����޴»����",
       ROUND(AVG(SALARY)) "��ձ޿�", MAX(SALARY) "�ְ�޿�", MIN(SALARY) "�ּұ޿�"
FROM EMPLOYEE
GROUP BY JOB_CODE;


-- �� �μ��� �μ��ڵ�, �ѻ����, ���ʽ��� �޴� �����, ����� �ִ� �����, ��ձ޿�
SELECT DEPT_CODE "�μ�", COUNT(*) "�����", COUNT(BONUS) "���ʽ����޴»����"
     , COUNT(MANAGER_ID) "����������ϴ»����", ROUND(AVG(SALARY)) "��ձ޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- ������ �����
SELECT SUBSTR(EMP_NO, 8, 1), COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '��') "����", COUNT(*) "�����"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

--------------------------------------------------------------------------------

/*
    < HAVING �� >
    �׷쿡 ���� ������ �����ϰ��� �� �� ���Ǵ� ����
    (�ַ� �׷��Լ��� ������ ���� ����)
*/
-- �� �μ��� ��� �޿��� 300���� �̻��� �μ��鸸 ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
WHERE AVG(SALARY) >= 3000000
GROUP BY DEPT_CODE; -- ���� ��

SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

-- �� ���޺� �� �޿����� 1000���� �̻��� �����ڵ�, �޿����� ��ȸ
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- �� �μ��� ���ʽ��� �޴� ����� ���� �μ����� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

---------------------------------------------------------------------------------

/*
    < ������� >
    
    5: SELECT *|��ȸ�ϰ����ϴ��÷���|��������|�Լ���  [AS] "�� Ī!"|��Ī
    1: FROM ��ȸ�ϰ����ϴ� ���̺��
    2: WHERE ���ǽ�
    3: GROUP BY �׷���ؿ��ش��ϴ��÷���|�Լ���
    4: HAVING �׷��Լ��Ŀ� ���� ���ǽ�
    6: ORDER BY ���ı��ؿ��ش��ϴ��÷���|��Ī|�÷�����  [ASC|DESC] [NULLS FIRST|NULLS LAST]
    
*/


---------------------------------------------------------------------------------------
/*
    < ���� ������ == SET OPERATOR >
    
    �������� �������� ������ �ϳ��� ���������� ����� ������
    
    - UNION : ������ ( �� ������ ������ ������� ���� �� �ߺ��Ǵ� �κ��� �� �� ) OR
    - INTERSECT : ������ ( �� �������� �ߺ��� �����)
    - UNION ALL : ������ ����� �������� ������ ���� ( �� ������ ������ ������� ������ ����) => �ߺ��� ����� �ι� ��ȸ�� �� ����
    - MINUS : ������ ( ���������� ����� ���� ���� ������ ������� ��� )
*/
-- 1. UNION (������- �� ������ ������ ������� �������� ��, �ߺ��� ����� �ѹ��� ��ȸ)
-- �μ��ڵ尡 D5�̰ų� �Ǵ� �޿��� 300���� �ʰ��� ����� ��ȸ(���, �����, �μ��ڵ�, �޿�)

-- �μ��ڵ尡 D5�� ����鸸 ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';  --> 6�� ��ȸ (�ڳ���, ������, ���ؼ�, �ɺ���, ������, ���ȥ)

-- �޿��� 300���� �ʰ��� ����鸸 ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; --> 8�� ��ȸ (������, ������, ���ö, �����, ������, �ɺ���, ���ȥ, ������)

-- UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY --> ���� �÷����� �����ϰ� �ۼ�
FROM EMPLOYEE
WHERE SALARY > 3000000; --> 12�� ��ȸ (6�� + 8�� - �ߺ� 2��)

-- ���� UNION ���� ��� �ϳ��� SELECT������ ��ȸ�غ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D2';

SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- GROUP BY ���� �̿��ؼ� ���� �ذ�
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-----------------------------------------------------------------------------
-- 2. UNION ALL : �������� ���� ����� ������ ���ϴ� ������ (�ߺ����� ������ �� �� ����)

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; --> 14��

-------------------------------------------------------------------------------
-- 3. INTERSECT (������ - ���� ���� ����� �ߺ��� ������� ��ȸ)
-- �μ��ڵ尡 D5�̸鼭 �Ӹ��ƴ϶� �޿������� 300���� �ʰ��� ���

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- AND������ �̿밡��
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

-- �μ��ڵ尡 D5�� ����� �� �޿��� 300���� �ʰ��� ����� �����ؼ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- �Ʒ�ó�� ����
-- �μ��ڵ尡 D5�̸鼭 �Ӹ��ƴ϶� �޿��� 300���� ������ ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <= 3000000;




