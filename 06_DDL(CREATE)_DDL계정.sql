/*
    
    * DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
    
      ����Ŭ���� �����ϴ� ��ü(OBJECT)��
      ������ �����(CREATE), ������ ����(ALTER)�ϰ�, ���� ��ü�� ����(DROP)�ϴ� ��ɹ�
      ��, ���� ��ü�� �����ϴ� ���� �ַ� DB������, �����ڰ� �����
      
      ����Ŭ������ ��ü(����) : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE),
                             �ε���(INDEX), ��Ű��(PACKAGE), Ʈ����(TRIGGER),
                             ���ν���(PROCEDURE), �Լ�(FUNCTION),
                             ���Ǿ�(SYNONYM), �����(USER)
*/
/*
    < CREATE TABLE >
   
    * ���̺��̶�? : ��(ROW)�� ��(COLUMN)�� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
                   ��� �����ʹ� ���̺��� ���ؼ� ����� (== �����͸� �����ϰ��� �Ѵٸ� ���̺��� �����ߵ�)
    
    * ǥ����
    CREATE TABLE ���̺��(
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        ...
    );
    
    * �ڷ���
    - ���� (CHAR(ũ��) / VARCHAR2(ũ��))
      > CHAR(����Ʈ��) : �ִ� 2000BYTE���� ���� ���� / �������� (�ƹ��� ���� ���� ���͵� ó�� �Ҵ��� ũ�� ����(��������ä����))
      > VARCHAR2(����Ʈ��) : �ִ� 4000BYTE���� ���� ���� / �������� (���� ���� ������ �� ��� ���� ���� ũ�Ⱑ �پ��)
    - ���� (NUMBER)
    - ��¥ (DATE)
*/

-->> ȸ������ ������(���̵�,��й�ȣ,�̸�,ȸ��������)�� ������� ���̺� MEMBER ���̺� �����ϱ�
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_DATE DATE
);

SELECT * FROM MEMBER;

/*
    * �÷��� �ּ��ޱ� (�÷��� ���� ��������)
    
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
*/
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵�';
-- ȸ����й�ȣ, ȸ���̸�, ȸ��������
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ����';
COMMENT ON COLUMN MEMBER.MEMBER_DATE IS 'ȸ��������';


-- ������ ��ųʸ� : �پ��� ��ü���� ������ �����ϰ� �ִ� �ý��� ���̺�
SELECT * FROM USER_TABLES;
-- USER_TABLES : ���� �� ������ ������ �ִ� ���̺���� �������� ������ Ȯ���� �� �ִ� ������ ��ųʸ�
SELECT * FROM USER_TAB_COLUMNS;
-- USER_TAB_COLUMNS : ���� �� ������ �������ִ� ���̺���� ��� �÷��� ������ ��ȸ�� �� �ִ� ������ ��ųʸ�

SELECT * FROM MEMBER;

-- ������ �߰��� �� �ִ� ���� (INSERT == �� ������ �߰�)
-- INSERT INTO ���̺�� VALUES(��, ��, ��, ��, ...);
INSERT INTO MEMBER VALUES('user01', 'pass01', 'ȫ�浿', '2021-02-01');
INSERT INTO MEMBER VALUES('user02', 'pass02', '�踻��', '21/02/02');
insert into member values('user03', 'pass03', '������', sysdate);
INSERT INTO MEMBER VALUES(NULL, NULL, NULL, SYSDATE);           --> ���̵�,���,�̸��� NULL�� �����ؼ��� �ȵ�
insert into member values('user03', 'pass03', '�谳��', sysdate);--> �ߺ��� ���̵� �����ؼ��� �ȵ�

----------------------------------------------------------------------------------

/*
    < �������� CONSTRAINTS > 
    - ���ϴ� �����Ͱ��� �����ϱ� ���ؼ� (�����ϱ� ���ؼ�) Ư�� �÷����� �����ϴ� ���� (������ ���Ἲ ������ ��������)
    - ���������� �ο��� �÷��� ���� �����Ϳ� ������ ������ �ڵ����� �˻��� ����
    
    * ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
    
    * �÷��� ���������� �ο��ϴ� ��� : �÷����� / ���̺���
    
*/

/*
    * NOT NULL ��������
      �ش� �÷��� �ݵ�� ���� �����ؾ߸� �� ��� ��� (NULL���� ���� ���ͼ��� �ȵǴ� �÷��� �ο�)
      ���� / ������ NULL���� ������� �ʵ��� ����
      
      ��, NOT NULL ���������� �÷����� ��� �ۿ� �ȵ�!
*/

-- NOT NULL �������Ǹ� ������ ���̺� �����
-- �÷����� ��� : �÷��� �ڷ��� ��������  => ���������� �ο��ϰ����ϴ� �÷� �ڿ� ��ٷ� ���
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL 
VALUES(1, 'user01', 'pass01', '�踻��', '��', '010-5511-9220', 'aaa@naver.com');

INSERT INTO MEM_NOTNULL
VALUES(2, NULL, NULL, NULL, NULL, NULL, NULL);
--> NOT NULL �������ǿ� ����Ǿ� ���� �߻�

INSERT INTO MEM_NOTNULL
VALUES(2, 'user02', 'pass02', 'ȫ�浿', NULL, NULL, NULL);
--> NOT NULL ���������� �ο��Ǿ��ִ� �÷����� �ݵ�� ���� �����ؾߵ�

INSERT INTO MEM_NOTNULL
VALUES(3, 'user01', 'pass10', '������', '��', null, null);





