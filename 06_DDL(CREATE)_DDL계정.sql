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

---------------------------------------------------------------------------------

/*
    * UNIQUE ��������
      �÷��� �ߺ����� �����ϴ� ��������
      ���� / ������ ������ �ش� �÷��� �߿� �ߺ����� ���� ��� �߰� �Ǵ� ������ �ȵǰԲ�
    
      �÷����� / ���̺��� ��� �� �� ����
*/

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- �÷����� ���
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);
DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    UNIQUE (MEM_ID) -- ���̺��� ���
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'aaa@naver.com');
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '�踻��', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(3, 'user02', 'pass03', '������', null, null, null);
--> UNIQUE �������ǿ� ����Ǿ����Ƿ� INSERT ����!!
--> ���� �������� �������Ǹ����� �˷��� (� �÷��� ������ �ִ��� �÷������� �˷����� ����) => ���� �ľ��ϱ� �����
--> �������� �ο��� ���� �������Ǹ��� ���������� ������ �ý��ۿ��� �˾Ƽ� ������ �������Ǹ� �ο����� SYS_C~~~~

SELECT * FROM MEM_UNIQUE;

/*
    * �������� �ο��� �������Ǹ� �����ϴ� ǥ����
    
    > �÷����� ���
    CREATE TABLE ���̺�� (
        �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] ��������,
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        ...
    );
    
    > ���̺��� ���
    CREATE TABLE ���̺��(
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        ... ,
        [CONSTRAINT �������Ǹ�] �������� (�÷���)
    );
    
*/

CREATE TABLE MEM_CON_NM(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    CONSTRAINT MEM_ID_UQ UNIQUE (MEM_ID) -- ���̺��� ���
);

INSERT INTO MEM_CON_NM VALUES(1, 'user01', 'pass01', 'ȫ�浿', null, null, null);
INSERT INTO MEM_CON_NM VALUES(2, 'user02', 'pass02', '�踻��', '��', null, null);
--> ������ �ش��ϴ� �÷��� '��' �Ǵ� '��'���� ���߸� �ϴµ� �� ���� ������ ������!! �Ф�

SELECT * FROM MEM_CON_NM;

---------------------------------------------------------------------------------

/*
    * CHECK ��������
      �÷��� ��ϵ� �� �ִ� ���� ���� ������ ������ �� �� �� ����! 
      
      CHECK (���ǽ�)
*/
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE NOT NULL
);

INSERT INTO MEM_CHECK 
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', null, sysdate);

INSERT INTO MEM_CHECK 
VALUES(2, 'user02', 'pass02', '�踻��', NULL, NULL, null, sysdate);
--> NULL���� INSERT������!! (���� NULL���� �������� �ϰ�ʹٸ� NOT NULL�� ���� �ο��ϸ��)

INSERT INTO MEM_CHECK 
VALUES(3, 'user03', 'pass03', '������', '��', NULL, null, sysdate);

SELECT * FROM MEM_CHECK;

-------------------------------------------------------------------------------

/*
    >> Ư�� �÷��� ���� ���� ���� �⺻�� ���� ����  => �������� �ƴ�!!
       �÷��� �ڷ��� DEFAULT �⺻��
*/
DROP TABLE MEM_CHECK;
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL
);

INSERT INTO MEM_CHECK(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME)
VALUES(1, 'user01', 'pass01', '������');
--> �����ȵ� �÷����� �⺻������ null���� ������ ���� default���� �ο��Ǿ��ִٸ� null���� �ƴ� default������ ��!

SELECT * FROM MEM_CHECK;

------------------------------------------------------------------------------------

/*
    * PRIMARY KEY (�⺻Ű) ��������
      ���̺��� �� ����� ������ �����ϰ� �ĺ��� �� �ִ� �÷��� �ο��ϴ� ��������
      -> ������� ������ �� �ִ� �ĺ����� ����(EX. ȸ����ȣ, �ֹ���ȣ, ���, �й�, �����ȣ, ...)
      -> �ߺ����� �ʰ� ���� �����ؾ߸� �ϴ� �÷��� PRIMARY KEY �ο� (NOT NULL+UNIQUE)
      
      ��, �� ���̺�� �� ���� ���� ����
*/

CREATE TABLE MEM_PRIMARYKEY1(
    MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY, -- �÷��������
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
    --CONSTRAINT MEM_PK PRIMARY KEY(MEM_NO) -- ���̺������
);

INSERT INTO MEM_PRIMARYKEY1
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', null, null);

INSERT INTO MEM_PRIMARYKEY1
VALUES(1, 'user02', 'pass02', '�̼���', NULL, null, null);
--> �⺻Ű �÷��� �ߺ����� ���� ����

INSERT INTO MEM_PRIMARYKEY1
VALUES(NULL, 'user02', 'pass02', '�̼���', NULL, null, null);
--> �⺻Ű �÷��� NULL������ ���� ����

INSERT INTO MEM_PRIMARYKEY1
VALUES(2, 'user02', 'pass02', '�̼���', NULL, null, null);

SELECT * FROM MEM_PRIMARYKEY1;


CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    PRIMARY KEY (MEM_NO, MEM_ID) -- �÷��� ��� PRIMARY KEY �ϳ��� �����ϴ°� ���� --> ����Ű
);

INSERT INTO MEM_PRIMARYKEY2 
VALUES (1, 'user01', 'pass01', 'ȫ�浿', null, null, null);

INSERT INTO MEM_PRIMARYKEY2 
VALUES (1, 'user02', 'pass02', '�踻��', null, null, null);

INSERT INTO MEM_PRIMARYKEY2 
VALUES (2, 'user02', 'pass03', '�̼���', null, null, null);

INSERT INTO MEM_PRIMARYKEY2 
VALUES (3, NULL, 'pass04', '�Ż��Ӵ�', null, null, null);
--> �⺻Ű�� �����Ǿ��ִ� �÷��鿡�� NULL���� �� �� ����.

SELECT * FROM MEM_PRIMARYKEY2;

--------------------------------------------------------------------------------

-- ȸ�� ��޿� ���� ������(����ڵ�, ��޸�) �����ϴ� ���̺�
CREATE TABLE MEM_GRADE(
    GRADE_CODE CHAR(2) PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

INSERT INTO MEM_GRADE VALUES('G1', '�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES('G2', '���ȸ��');
INSERT INTO MEM_GRADE VALUES('G3', 'Ư��ȸ��');

SELECT * FROM MEM_GRADE;


/*
    * FOREIGN KEY (�ܷ�Ű) ��������
      �ش� �÷��� �ٸ� ���̺� �����ϴ� ���� ���;ߵǴ� �÷��� �ο��ϴ� ��������
      --> �ٸ� ���̺�(�θ����̺�)�� �����Ѵٰ� ǥ��
          ��, ������ �ٸ� ���̺�(�θ����̺�)�� �����ϰ� �ִ� ���� ���� �� �ִ�. 
      --> FOREIGN KEY ������������ �ٸ� ���̺� ���� ���踦 ������ �� ����
      
      > �÷��������
        �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] REFERENCES ���������̺��[(�������÷���)]
      
      > ���̺������
        [CONSTRAINT �������Ǹ�] FOREIGN KEY(�÷���) REFERENCES ���������̺��[(�������÷���)]
        
        (�������÷���) ������ �⺻������ ���������̺���� �⺻Ű �÷����� ����
*/
-- �ڽ� ���̺�
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE), -- �÷����� ���
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
    -- FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) -- ���̺��� ���
);


INSERT INTO MEM
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'G1', NULL, NULL, NULL);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '�踻��', 'G2', NULL, NULL, NULL);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '������', 'G1', NULL, NULL, NULL);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '������', NULL, NULL, NULL, NULL);
--> �ܷ�Ű ���������� �ɷ��ִ� �÷����� �⺻������ NULL���� �� ����

INSERT INTO MEM
VALUES(5, 'user05', 'pass05', '�̼���', 'G4', NULL, NULL, NULL);
--> parent key not found ���� �߻�
--  G4 ����� MEM_GRADE ���̺��� GRADE_CODE �÷����� �����ϴ� ���� �ƴϱ� ������


--> ����! �θ����̺�(MEM_GRADE)���� �����Ͱ��� �����ȴٸ�?

-- MEM_GRADE ���̺�κ��� GRDAE_CODE�� G1�� ������ �����
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';
--> �ڽ����̺�(MEM) �߿� G1�� ����ϰ� �ֱ� ������ ������ �� ����!
--> ���� �ܷ�Ű �������� �ο��� �����ɼ��� �ο� ������!! 
--> �ڽ����̺��� ����ϰ� �ִ� ���� ���� ��� ������ �ȵǴ� "�������ѿɼ�" �ɷ�����
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G3'; --> �ڽ����̺� ���ǰ� �ִ� ���� �ƴϱ� ������ ���� ���� 

ROLLBACK;

DROP TABLE MEM;
--------------------------------------------------------------------

/*
    * �ڽ����̺� ������ (�ܷ�Ű �������� �ο���)
      �θ����̺��� �����Ͱ� �������� �� �ڽ����̺��� ��� ó���� ���� �ɼ����� ���س��� �� ����
    
    * FOREIGN KEY ���� �ɼ�  
      ���� �ɼ��� ������ �������� ������ ON DELETE RESTRICTED(���� ����)���� �⺻������ ����
*/ 
-- 1) ON DELETE SET NULL : �θ����� ������ �ش� �����͸� ����ϰ� �ִ� �ڽĵ����͸� NULL�� �����Ű��
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2),
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
);

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'G1', NULL, NULL, NULL);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '�踻��', 'G2', NULL, NULL, NULL);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '������', 'G1', NULL, NULL, NULL);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '������', NULL, NULL, NULL, NULL);

-- �θ����̺�(MEM_GRADE)�� GRADE_CODE�� G1�� ������ ����
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';
--> �������� �� ������! (�� G1�� ���� �ִ� �ڽĵ����� ������ ��� NULL�� ����)

ROLLBACK;

DROP TABLE MEM;

-- 2) ON DELETE CASCADE : �θ����� ������ �ش� �����͸� ���� �ִ� �ڽĵ����͵� ���� �����ع�����
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2),
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
);

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'G1', NULL, NULL, NULL);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '�踻��', 'G2', NULL, NULL, NULL);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '������', 'G1', NULL, NULL, NULL);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '������', NULL, NULL, NULL, NULL);

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';
-- �������� �� ������
-- ��, �ش� �θ����͸� ����ϰ� �ִ� �ڽĵ����Ͱ� ���� DELETE�� ��)


-- ��ü ȸ���� ȸ����ȣ, ���̵�, ��й�ȣ, �̸�, ��޸� ��ȸ
SELECT MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GRADE_NAME
FROM MEM, MEM_GRADE
WHERE GRADE_ID = GRADE_CODE(+);

SELECT MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GRADE_NAME
FROM MEM
LEFT JOIN MEM_GRADE ON(GRADE_ID = GRADE_CODE);














