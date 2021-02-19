
/*
    < Ʈ���� TRIGGER >
    
    ���� ������ ���̺� INSERT, UPDATE, DELETE �� ���� DML���� ���� ����Ǿ��� ��� (���̺� �̺�Ʈ �߻����� ���)
    �ڵ�(������)���� �Ź� ����� ������ �����ص� �� �ִ� ��ü
    ������ ���Ἲ ������ ����
    
    EX)
    ����� ���� �����Ͱ� ���(INSERT)�� �� ���� �ش� ��ǰ�� ���� ������ �Ź� ����(UPDATE)�ؾߵ� ���
    ȸ��Ż��� ������ ȸ�����̺� ������ DELETE �� Ż���ȸ���鸸 ���� �����ϴ� ���̺� �ڵ����� INSERT���Ѿߵ� ���
    
    * Ʈ���� ����
    > SQL���� ���� �ñ⿡ ���� �з�
    - BEFORE TRIGGER : ���� ������ ���̺� �̺�Ʈ�� �߻��Ǳ� �� Ʈ���� ����
    - AFTER TRIGGER : ���� ������ ���̺� �̺�Ʈ�� �߻��� �� Ʈ���� ����
    
    > SQL���� ���� ������ �޴� �� �࿡ ���� �з�
    - STATEMENT TRIGGER(���� Ʈ����) : �̺�Ʈ�� �߻��� SQL���� ���� �� �ѹ��� Ʈ���� ���� 
    - ROW TRIGGER(�� Ʈ����) : �ش� SQL�� ����� �� ���� �Ź� Ʈ���� ���� 
                              Ʈ���� ���� ���� �ۼ��� FOR EACH ROW �ɼ� ����ؾߵ�
            => :OLD     : BEFORE UPDATE(������ �ڷ�), BEFORE DELETE(������ �ڷ�)
            => :NEW     : AFTER INSERT(�Է��� �ڷ�), AFTER UPDATE(������ �ڷ�) 
    
    * Ʈ���� ��������
    [ǥ����]
                                TRG_
    CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    BEFORE|AFTER  INSERT|UPDATE|DELETE  ON ���̺��
    [FOR EACH ROW]
    [DECLARE 
        ��������;]
    BEGIN
        �ش����� ������ �̺�Ʈ �߻��� ����������(�ڵ�����) ������ ����;
    [EXCEPTION
        ����ó������;]
    END;
    /
    
    
*/

-- EMPLOYEE���̺� ���ο� ���� INSERT �ɶ� ���� �ڵ����� �޼��� ����ϴ� Ʈ���� ����
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի���� ȯ���մϴ�');
END;
/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
VALUES('300', '�谳��', '444444-5555555', 'J7', SYSDATE);

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
VALUES('301', '������', '444444-5555555', 'J7', SYSDATE);

-----------------------------------------------------------------------

-- ��ǰ �԰� �� ��� ���� ����

-->> �ʿ��� ���̺�, ������ ����

-- 1. ��ǰ�� ���� ������ ������ ���̺� (TB_PRODUCT) ���� ����
--    PCODE (�ڷ��� : NUMBER, �������� : PRIMARY KEY) => ��ǰ�ڵ�
--    PNAME (�ڷ��� : VARCHAR2(30), �������� : NOT NULL) => ��ǰ��
--    BRAND (�ڷ��� : VARCHAR2(30), �������� : NOT NULL) => �귣���
--    PRICE (�ڷ��� : NUMBER)                           => ����
--    STOCK (�ڷ��� : NUMBER, �������� : NOT NULL, �⺻�� : 0) => ������
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,
    PNAME VARCHAR2(30) NOT NULL,
    BRAND VARCHAR2(30) NOT NULL,
    PRICE NUMBER,
    STOCK NUMBER DEFAULT 0 NOT NULL
);


-- ��ǰ�ڵ��ȣ�ν� �����ų ������ (SEQ_PCODE) ���� ����
-- ���۰� : 1001
-- ĳ�ø޸� ��� ����
CREATE SEQUENCE SEQ_PCODE
START WITH 1001
NOCACHE;

-- ���� ������ �߰�
INSERT INTO TB_PRODUCT
VALUES(SEQ_PCODE.NEXTVAL, '������20', '����', 1400000, DEFAULT);

INSERT INTO TB_PRODUCT
VALUES(SEQ_PCODE.NEXTVAL, '������12pro', '���', 1300000, DEFAULT);

INSERT INTO TB_PRODUCT
VALUES(SEQ_PCODE.NEXTVAL, '�����', '�����', NULL, 20);

COMMIT;

-- 2. ��ǰ ����� �� �̷� ���̺� (TB_PRODETAIL)
--    � ��ǰ�� ��� ��� �԰�/��� �Ǿ����� ����ϴ� ���̺�
CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,               -- ������̷¹�ȣ
    PCODE NUMBER REFERENCES TB_PRODUCT,     -- ��ǰ�ڵ�
    DDATE DATE NOT NULL,                    -- ��ǰ�������
    AMOUNT NUMBER NOT NULL,                 -- ����(�������)
    STATUS CHAR(6) CHECK(STATUS IN ('�԰�', '���'))
);

-- ����� �̷¹�ȣ�� �����ų ������(SEQ_DCODE) ����
CREATE SEQUENCE SEQ_DCODE
NOCACHE;

-- 1001�� ��ǰ�� ���ó�¥�� 10���� �԰� �� ���
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 1001, SYSDATE, 10, '�԰�');

UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PCODE = 1001;

COMMIT;

-- 1002�� ��ǰ�� ���ó�¥�� 20���� �԰�� ���
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 1002, SYSDATE, 20, '�԰�');

UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 1002;

COMMIT;

-- 1003�� ��ǰ�� ���ó�¥�� 3�� ���� ���
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 1003, SYSDATE, 3, '���');

UPDATE TB_PRODUCT
SET STOCK = STOCK - 3
WHERE PCODE = 1002;

ROLLBACK;

-- TB_PRODETAIL ���̺� INSERT �� 
-- �ڵ����� TB_PRODUCT���̺� UPDATE �ǰԲ� Ʈ���� ����
CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    -- ��ǰ�� �԰�� ��� => ������ ���� UPDATE
    IF (:NEW.STATUS = '�԰�')
        THEN
            UPDATE TB_PRODUCT
            SET STOCK = STOCK + :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
    -- ��ǰ�� ���� ��� => ������ ���� UPDATE
    IF (:NEW.STATUS = '���')
        THEN
            UPDATE TB_PRODUCT
            SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/

-- 1001�� ��ǰ�� ���ó�¥�� 100���� �԰�
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 1001, SYSDATE, 100, '�԰�');

-- 1003�� ��ǰ�� ���ó�¥�� 10���� ���
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 1003, SYSDATE, 10, '���');









