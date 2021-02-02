/*
    < GROUP BY�� >
    �׷��� ������ ������ ������ �� �ִ� ����
    => �ش� ���õ� ���غ��� �׷��� ���� �� ����!
    
    �������� ������ �ϳ��� �׷����� ��� ó���� �������� ���
*/
-- ��ü����� �� �޿���
SELECT SUM(SALARY)
FROM EMPLOYEE;  --> ���� ��ȸ�� ��ü ������� �ϳ��� �׷����� ��� �� ���� ���� ��� 

-- �� �μ��� �� �޿���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- ��ü �����
SELECT COUNT(*)
FROM EMPLOYEE;

-- �� �μ��� ��� ��
SELECT COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �� �μ��� �� �޿����� �μ��� �������� �����ؼ� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)   -- 3. SELECT ��
FROM EMPLOYEE                   -- 1. FROM ��
GROUP BY DEPT_CODE              -- 2. GROUP ��
ORDER BY DEPT_CODE;             -- 4. ORDER BY ��

-- �� ���޺� �����ڵ�, �� �޿���, �����, ���ʽ��� �޴� �����
SELECT JOB_CODE "����", SUM(SALARY) "�޿���", COUNT(*) "�����", COUNT(BONUS) "���ʽ����޴»����",
       ROUND(AVG(SALARY)) "��ձ޿�", MAX(SALARY) "�ְ�޿�", MIN(SALARY) "�ּұ޿�"
FROM EMPLOYEE
GROUP BY JOB_CODE;





















