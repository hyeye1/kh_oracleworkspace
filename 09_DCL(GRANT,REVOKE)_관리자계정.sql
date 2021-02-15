
/*
    < DCL : DATA CONTROL LANGUAGE >
    ������ ���� ���
    
    �������� �ý��۱��� �Ǵ� ��ü���ٱ����� �ο�(GRANT)�ϰų� ȸ��(REVOKE)�ϴ� ���
    
    > �ý��۱���     : Ư��DB�� �����ϴ� ����, ��ü���� ������ �� �ִ� ����
    > ��ü���ٱ���    : Ư�� ��ü�鿡 �����ؼ� ������ �� �ִ� ����
    
    * �ý��۱��� ����
    - CREATE SESSION : ������ ������ �� �ִ� ����
    - CREATE TABLE : ���̺��� ������ �� �ִ� ����
    - CREATE VIEW : �� ������ �� �ִ� ����
    - CREATE SEQUENCE : ������ ������ �� �ִ� ����
    - CREATE USER : ���� ������ �� �ִ� ���� 
    - .....
    
    [ǥ����]
    GRANT ����1, ����2, .. TO ������;
*/

-- 1. SAMPLE ���� ����
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;

-- 2. SAMPLE������ �����ϱ� ���� CREATE SESSION ���� �ο�
GRANT CREATE SESSION TO SAMPLE;

-- 3_1. SAMPLE������ ���̺��� ������ �� �ִ� CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO SAMPLE;
-- 3_2. SAMPLE������ ���̺����̽��Ҵ����ֱ� (SAMPLE ��������)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;

-- 4. SAMPLE������ �並 ������ �� �ִ� CREATE VIEW ���� �ο�
GRANT CREATE VIEW TO SAMPLE;

-------------------------------------------------------------

/*
    * ��ü��������
      Ư�� ��ü���� ����(SELECT,INSERT,UPDATE,DELETE,..)�� �� �ִ� ����
      
      ��������  |  Ư����ü
     ===============================
      SELECT   | TABLE, VIEW, SEQUENCE
      INSERT   | TABLE, VIEW
      UPDATE   | TABLE, VIEW
      DELETE   | TABLE, VIEW
      ....
      
      [ǥ����]
      GRANT �������� ON Ư����ü TO ������;
*/
-- 5. SAMPLE������ KH.EMPLOYEE���̺��� ��ȸ�� �� �ִ� ���� �ο�
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

-- 6. SAMPLE������ KH.DEPARTMENT���̺� ������ �� �ִ� ���� �ο�
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

--------------------------------------------------------------------------------

-- �ּ����� ������ �ο��ϰ��� �Ҷ� CONNECT, RESOURCE�� �ο�
GRANT CONNECT, RESOURCE TO ������;

/*
    < �� ROLE >
    Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ��� ��
    
    CONNECT : CREATE SESSION (�����ͺ��̽��� ������ �� �ִ� ����)
    RESOURCE : CREATE TABLE, CREATE SEQUENCE, ... (Ư�� ��ü���� ���� �� ������ �� �ִ� ����)
*/
SELECT *
FROM ROLE_SYS_PRIVS -- �ѵ��� ����ִ� ���̺�! 
WHERE ROLE IN ('CONNECT', 'RESOURCE');

-- ����ڿ��� �ο��� ���� : CONNECT, RESOURCE
-- ������ �ο����� ����� : MYMY
CREATE USER MYMY IDENTIFIED BY MYMY;
GRANT CONNECT, RESOURCE TO MYMY;












