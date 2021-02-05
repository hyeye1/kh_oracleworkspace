/*

*/
-- ������̺��� �����, �����ڵ�, ���ʽ��� �޴� ������� ��ȸ�� �� �����ڵ庰 �������� ����

SELECT
       EMP_NAME
     , JOB_CODE
     , COUNT(*) AS "�����"
FROM EMPLOYEE
WHERE BONUS != NULL
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

--> ������1. BONUS�� NULL�� �ƴ� �̶�� ������ ����� ������� ����
--> ������2. SELECT ������ �׷��Լ��� ������ ��� �÷��� GROUP BY�� ����Ǿ������ʴ�.

--> ��ġ1. BONUS IS NOT NULL �� ������ ����
--> ��ġ2. GROUP BY ���� EMP_NAME, JOB_CODE�� �����ؾߵȴ�
SELECT
       EMP_NAME
     , JOB_CODE
     , COUNT(*) AS "�����"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY JOB_CODE, EMP_NAME
ORDER BY JOB_CODE;