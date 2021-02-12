/*
    < DDL : DATA DEFINITION LANGUAGE >
    ������ ���� ���
    
    ��ü���� ���� ����(CREATE), ����(ALTER), ����(DROP)�ϴ� ����
    
    1. ALTER
       ��ü ������ �����ϴ� ����
       
       <���̺� ����>
       ALTER TABLE ���̺�� �����ҳ���;
       
       - ������ ���� -
       1) �÷� �߰�/����/����
       2) �������� �߰�/����   --> ������ �Ұ�(�����ϰ��� �Ѵٸ� ������ �� ���� �߰�)
       3) ���̺��/�÷���/�������Ǹ� ����
*/

-- 1) �÷� �߰�/����/����
-- 1-1) �÷� �߰� (ADD) : ADD �߰����÷��� ������Ÿ�� [DEFAULT �⺻��]
SELECT * FROM DEPT_COPY;
 
-- CNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
--> ���ο� �÷��� ��������� �⺻������ NULL������ ä����

-- LNAME �÷� �߰� DEFAULT �����ؼ�
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(40) DEFAULT '�ѱ�';
--> ���ο� �÷��� ��������� NULL�� �ƴ� DEFAULT������ ä����

-- 1-2) �÷� ���� (MODIFY)
--      ������Ÿ�� ���� : MODIFY �������÷��� �ٲٰ����ϴµ�����Ÿ��
--      DEFAULT�� ���� : MODIFY �������÷��� DEFAULT �ٲٰ����ϴ±⺻��

-- DEPT_ID �÷��� ������Ÿ���� CHAR(3)�� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

--ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
--ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);

-- DEPT_TITLE �÷��� ������Ÿ���� VARCHAR2(40)��
-- LOCATION_ID �÷��� ������Ÿ���� VARCHAR2(2)��
-- LNAME �÷��� �⺻���� '�̱�'
ALTER TABLE DEPT_COPY 
    MODIFY DEPT_TITLE VARCHAR2(40)
    MODIFY LOCATION_ID VARCHAR2(2)
    MODIFY LNAME DEFAULT '�̱�';

CREATE TABLE DEPT_COPY2
AS SELECT *
   FROM DEPT_COPY;

-- 1-3) �÷� ���� (DROP COLUMN) : DROP COLUMN �����ϰ����ϴ��÷���
SELECT * FROM DEPT_COPY2;

-- DEPT_COPY2�κ��� DEPT_ID �÷� �����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ROLLBACK; --> DDL������ ���� �Ұ���

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME; --> ���̺� �ּ� �Ѱ��� �÷��� �����ؾ���




