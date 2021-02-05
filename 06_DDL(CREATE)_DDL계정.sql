/*

    ��, ������ü�� �����ϴ� ���� �ַ� DB������, �����ڰ� �����
    
    ����Ŭ������ ��ü(����) : 
                            

*/
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_DATE DATE
);

SELECT * FROM MEMBER;

DROP TABLE MEMBER;
/*
    * �÷��� �ּ��ޱ� (�÷��� ���� ��������)
    
    COMMENT ON COLUMN �÷��� IS '�ּ�����';
*/
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵�';
-- ȸ����й�ȣ, ȸ���̸�, ȸ��������
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN MEMBER.MEMBER_DATE IS 'ȸ��������';

-- ������ ��ųʸ�: �پ��� ��ü���� ������ �����ϰ� �ִ� �ý��� ���̺�
SELECT * FROM USER_TABLES;
-- USER_TABLES : ���� �� ������ �������ִ� ���̺���� �������� ������ Ȯ���� ���ִ� ������ ��ųʸ�
SELECT * FROM USER_TAB_COLUMNS;
-- USER_TAB_COLUMNS : ���� �� ������ �������ִ� ���̺���� ��� �÷��� ������ ��ȸ�� �� �ִ� ������ ��ųʸ�
SELECT * FROM MEMBER;

-- ������ �߰��� �� �ִ� ���� (INSERT == �� ������ �߰�)
-- INSERT INTO ���̺�� VALUES(��,��,��,��, ..._);
INSERT INTO MEMBER VALUES('user01', 'pass01', 'ȫ�浿', '2021-02-01');
INSERT INTO MEMBER VALUES('user02', 'pass02', '�踻��', '21/02/02');
insert into member values('user03', 'pass03', '������', sysdate);
----------------------------------------------------------------------
/*
    < ���� ���� constraints >
    - ���ϴ� �����Ͱ��� �����ϱ� ���ؼ� (�����ϱ� ���ؼ�) Ư�� �÷����� �����ϴ� ���� (������ ���Ἲ ������ ��������)
    - ���������� �ο��� �÷��� ���� �����Ϳ� ������ ������ �ڵ����� �˻��� ����
    
    * ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
*/
/*
    * NOT NULL ���� ����
      �ش� �÷��� �ݵ�� ���� �����ؾ߸� �� ��� ��� (NULL���� ���� ���ͼ��� �ȵǴ� �÷��� �ο�)
      ���� / ������ NULL���� ������� �ʵ��� ����
      
*/
--  NOT NULL ���� ���Ǹ� ������ ���̺� �����
-- �÷����� ���: �÷��� �ڷ��� ���� ���� => ���������� �ο��ϰ��� �÷��ڿ� ��ٷ� ���
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEN_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30) 
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL
VALUES(1, 'user01', 'pass01', '�踻��', '��', '010-5511-9220', 'aaa@naver.com');

INSERT INTO MEM_NOTNULL
VALUES(2, NULL, NULL, NULL, NULL, NULL, NULL);
--> NOT NULL �������ǿ� ����Ǿ� �����߻�

INSERT INTO MEM_NOTNULL
VALUES(3, 'user01', 'pass10', '������', '��', null, null);


