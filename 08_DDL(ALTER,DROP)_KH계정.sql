/*
    < DDL : DATA DEFINITION LANGUAGE >
    ������ ���� ���
    
    ��ü���� ������ ����(CREATE), ����(ALTER), ����(DROP)�ϴ� ����
    
    1. ALTER
       ��ü ������ �����ϴ� ����
       
       <���̺� ����>
       ALTER TABLE ���̺�� �����ҳ���;
       
       - ������ ���� -
       1) �÷� �߰�/����/����
       2) �������� �߰�/����   --> ������ �Ұ�(�����ϰ��� �Ѵٸ� ������ �� ������ �߰�)
       3) ���̺��/�÷���/�������Ǹ� ����
    
*/

-- 1) �÷� �߰�/����/����
-- 1_1) �÷� �߰� (ADD) : ADD �߰����÷��� ������Ÿ�� [DEFAULT �⺻��]
SELECT * FROM DEPT_COPY;

-- CNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
--> ���ο� �÷��� ��������� �⺻������ NULL������ ä����

-- LNAME �÷� �߰� DEFAULT �����ؼ�
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(40) DEFAULT '�ѱ�';
--> ���ο� �÷��� ��������� NULL�� �ƴ� DEFAULT������ ä����


-- 1_2) �÷� ���� (MODIFY)
--      ������Ÿ�� ���� : MODIFY �������÷��� �ٲٰ����ϴµ�����Ÿ��
--      DEFAULT�� ���� : MODIFY �������÷��� DEFAULT �ٲٰ����ϴ±⺻��

-- DEPT_ID �÷��� ������Ÿ���� CHAR(3)�� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

--ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
--ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);

-- ���� ���� ����
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

-- 1_3) �÷� ���� (DROP COLUMN) : DROP COLUMN �����ϰ����ϴ��÷���

SELECT * FROM DEPT_COPY2;

-- DEPT_COPY2�κ��� DEPT_ID �÷� �����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ROLLBACK; --> DDL������ ���� �Ұ���

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME; --> ���̺� �ּ� �Ѱ��� �÷��� �����ؾߵ�

------------------------------------------------------------------------------------

-- 2) �������� �߰�/����

/*
    2_1) �������� �߰� 
    - PRIMARY KEY : ADD PRIMARY KEY(�÷���);
    - FOREIGN KEY : ADD FOREIGN KEY(�÷���) REFERENCES ���������̺��[(�������÷���)];
    - UNIQUE      : ADD UNIQUE(�÷���);
    - CHECK       : ADD CHECK(�÷�����������);
    - NOT NULL    : MODIFY �÷��� NOT NULL;
    
    ������ �������Ǹ��� �ο��ϰ��� �Ѵٸ� : [CONSTRAINT �������Ǹ�] ��������
    
    ���ǻ��� : �������Ǹ��� ���� ���� ���� ������ ������ �ο��ؾߵ�
*/

-- DEPT_COPY ���̺�
-- DEPT_ID�÷��� PRIMARY KEY �������� �߰�
-- DEPT_TITLE�÷��� UNIQUE�������� �߰�
-- LNAME �÷��� NOT NULL �������� �߰�
ALTER TABLE DEPT_COPY
ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;

/*
    2_2) �������� ����
    
    PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK : DROP CONSTRAINT �������Ǹ�
    NOT NULL : MODIFY �÷��� NULL 
*/

-- DCOPY_PK �������� �����
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

-- DCOPY_UQ �������� �����
-- LNAME �������� ����� NOT NULL => NULL
ALTER TABLE DEPT_COPY
DROP CONSTRAINT DCOPY_UQ
MODIFY LNAME NULL;

-----------------------------------------------------------------------

-- 3) �÷���/�������Ǹ�/���̺�� ���� (RENAME)

-- 3_1) �÷��� ���� : RENAME COLUMN �����÷��� TO �ٲ��÷���
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 3_2) �������Ǹ� ���� : RENAME CONSTRAINT �����������Ǹ� TO �ٲ��������Ǹ�
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007242 TO DCOPY_LID_NN;

-- 3_3) ���̺�� ���� : RENAME [�������̺��] TO �ٲ����̺��
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;

--------------------------------------------------------------------------------

/*
    2. DROP
       ��ü�� �����ϴ� ����
*/
DROP TABLE DEPT_TEST;

-- ��, ��򰡿��� �����ǰ� �ִ� �θ����̺���� �Ժη� �����ȵ�!!
-- ���࿡ �����ϰ� �ʹٸ�..
 
-- 1. �ڽ����̺� ���� ������ �� �θ����̺� �����ϴ� ���
DROP TABLE �ڽ����̺�;
DROP TABLE �θ����̺�;

-- 2. �θ����̺� �����ϴµ� �ƽθ� �¹����ִ� �������ǵ� �Բ� �����ϴ� ���
DROP TABLE �θ����̺� CASCADE CONSTRAINT;










