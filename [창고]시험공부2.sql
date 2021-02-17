
-- �� �μ��� �ְ�޿��� �޴� ����� ���, �����, �μ��ڵ�, �޿�

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                             FROM EMPLOYEE
                             GROUP BY DEPT_CODE)
ORDER BY DEPT_CODE;
                             -- DEPT_CODE = '����' AND SALARY = 2890000
--> �μ��� ���� ����� ��ȸ���� ����
SELECT EMPID, EMPNAME, DEPTCODE, SAL
FROM EMP
WHERE (NVL(DEPTCODE, '����'), SAL) IN (SELECT NVL(DEPTCODE, '����'), MAX(SAL)
                                        FROM EMP
                                    GROUP BY DEPTCODE)
ORDER BY DEPTCODE;

--> NVL �Լ��� �̿��ؼ� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE, '����'), SALARY) IN (SELECT NVL(DEPT_CODE, '����'), MAX(SALARY)
                                          FROM EMPLOYEE
                                          GROUP BY DEPT_CODE);
                                          -- DEPT_CODE = NULL AND SALARY = 2890000
--> �μ��� ���� ����� ��ȸ���� ����!

--> NVL �Լ��� �̿��ؼ� ����
SELECT EMPID, EMPNAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE, '����'), SALARY) IN (SELECT NVL(DEPT_CODE, '����'), MAX(SALARY)
                                          FROM EMPLOYEE
                                          GROUP BY DEPT_CODE);
                                          
-- ������ BOARD ���̺� �����ϴ� ����
CREATE TABLE BOARD (
    BOARDNO NUMBER PRIMARY KEY,
    BOARDTITLE VARCHAR2(50) NOT NULL,
    BOARDDATE DATE DEFAULT SYSDATE NOT NULL,
    BOARDWRITER VARCHAR2(15) NOT NULL,
    BOARDCONTENT VARCHAR2(2000),
    ORIGINAL_FILEPATH VARCHAR2(100),
    RENAME_FILEPATH VARCHAR2(100)
);

COMMENT ON COLUMN BOARD.BOARDNO IS '�Խñ۹�ȣ';
COMMENT ON COLUMN BOARD.BOARDTITLE IS '�Խñ�����';
COMMENT ON COLUMN BOARD.BOARDDATE IS '�Խñ۵�ϳ�¥';
COMMENT ON COLUMN BOARD.BOARDWRITER IS '�Խñ��ۼ��ھ��̵�';
COMMENT ON COLUMN BOARD.BOARDCONTENT IS '�Խñ۳���';
COMMENT ON COLUMN BOARD.ORIGINAL_FILEPATH IS '÷�����Ͽ�����';
COMMENT ON COLUMN BOARD.RENAME_FILEPATH IS '÷�����ϼ�����';

-- INSERT�� ���� �����غ��ð�
INSERT INTO BOARD VALUES(1, '�Խñ������̴�', SYSDATE, 'USER01', '�ȳ��ϼ���', '����', '����');
INSERT INTO BOARD VALUES(2, '�Խñ������̴�', SYSDATE, 'USER02', '�ȳ��ϼ���', '����', '����');
INSERT INTO BOARD VALUES(3, '�Խñ������̴�', SYSDATE, 'USER03', '�ȳ��ϼ���', '����', '����');
INSERT INTO BOARD VALUES(4, '�Խñ������̴�', SYSDATE, 'USER04', '�ȳ��ϼ���', '����', '����');
INSERT INTO BOARD VALUES(5, '�Խñ������̴�', SYSDATE, 'USER05', '�ȳ��ϼ���', '����', '����');

SELECT * FROM BOARD;

-- BOARD���̺� �ֱٿ� ��ϵ� �Խñ� 5���� ��ȸ�ϴ� TOP-N �м� ������ �ۼ��غ��ÿ�
-->> 1. ROWNUM �̿��� ���
SELECT *
FROM (SELECT *
      FROM BOARD
      ORDER BY BOARDDATE DESC)
WHERE ROWNUM <= 5;

SELECT *
FROM (SELECT *
      FROM NOTICE
      ORDER BY NOTICEDATE)
WHERE ROWNUM <= 5;

-->> 2. RANK() �Լ��� �̿��� ���
SELECT *
FROM (SELECT BOARDNO, BOARDTITLE, BOARDDATE, BOARDWRITER, BOARDCONTENT,
             ORIGINAL_FILEPATH, RENAME_FILEPATH, RANK() OVER(ORDER BY BOARDNO DESC) "����"
      FROM BOARD)
WHERE ���� <= 5;

SELECT *
FROM (SELECT NOTICENO, NOTICETITLE, NOTICEDATE, NOTICEWRITER, NOTICECONTENT, ORIGINAL_FILEPATH, RENAME_FILEPATH, RANK() OVER(ORDER BY NOTICEDATE) "�ֱ� ������"
        FROM NOTICE)
WHERE ���� <= 5;

-->> RANK() OVER() / DENSE_RANK() OVER() Ư¡ ������

-->> JOIN ����

-->> ���̺� ���� => DDL �ǽ����� (�����������α׷�) �ٽú���

-->> INSERT
