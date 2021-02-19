/*
    < PL/SQL >
    PROCUDURE LANGUAGE EXTENSION TO SQL
    
    ����Ŭ ��ü�� ����Ǿ��ִ� ������ ���
    ���� ����, ����ó��(IF), �ݺ�ó��(LOOP,FOR,WHILE) ���� �����Ͽ� SQL�� ������ ����
    �ټ��� SQL���� �ѹ��� ���� ���� (BLOCK����)
    
    * PL/SQL ����
    - [����� (DECLARE SECTION)] : DECLARE�� ����, ������ ����� ���� �� �ʱ�ȭ�ϴ� �κ�
    - ����� (EXECUTABLE SECTION) : BEGIN�� ����, ������ SQL�� �Ǵ� ���(���ǹ�, �ݺ���) ���� ������ ����ϴ� �κ�
    - [����ó���� (EXCEPTION SECTION)] : EXCEPTION�� ����, ���� �߻��� ������ ������ ����صδ� �κ�
*/

-- * �����ϰ� ȭ�鿡 HELLO ORACLE ���
SET SERVEROUTPUT ON;
BEGIN
    -- System.out.println("Hello Oracle");
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/

---------------------------------------------------------------------------------

/*
    1. DECLARE �����
       ���� �� ��� �����س��� ���� (����� ���ÿ� �ʱ�ȭ�� ����)
       �Ϲ�Ÿ�Ժ���, ���۷���Ÿ�Ժ���, ROWŸ�Ժ���
    
    1_1) �Ϲ�Ÿ�Ժ��� ���� �� �ʱ�ȭ
         [ǥ����] ������ [CONSTANT] �ڷ��� [:= ��];
*/

DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    --EID := 800;
    --ENAME := '���峲';
    EID := &���;
    ENAME := '&�̸�';
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/

---------------------------------------------------------------------------------

/*
    1_2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ (���� �����ϰ��ִ� Ư�� �÷��� ������Ÿ������ ����)
         [ǥ����] ������ ���̺��.�÷���%TYPE;
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    /*
    EID := '200';
    ENAME := '������';
    SAL := 8000000;
    */
    
    -- ����� 200�� ����� ���, �̸�, �޿� ��ȸ�� �� ���� EID, ENAME, SAL ���
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM EMPLOYEE
    --WHERE EMP_ID = 202;
    --WHERE EMP_ID = &���;
    WHERE EMP_NAME = '&�̸�';
    --WHERE DEPT_CODE = '&�μ��ڵ�';  => ������!! (��? : SELECT INTO�� �̿��ؼ� ��ȸ����� ������ ����� �Ѵٸ� �ݵ�� �������� ��ȸ�Ǿ�ߵ�!)
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/

---------------------------- �ǽ����� -------------------------------------
/*
    ���۷���Ÿ�Ժ����� EID, ENAME, JCODE, SAL, DTITLE�� �����ϰ�
    �� �ڷ������� EMPLOYEE�� EMP_ID, EMP_NAME, JOB_CODE, SALARY / DEPARTMENT�� DEPT_TITLE �÷����� ������Ÿ���� �����ϰԲ�
    
    ��ü������ �Է��� ������ ��ġ�ϴ� ����� ��ȸ�ؼ� �� ������ ���� �� ���
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_NAME = '&�����';
    
    DBMS_OUTPUT.PUT_LINE(EID || ', ' || ENAME || ', ' || JCODE || ', ' || SAL || ', ' || DTITLE);
END;
/

------------------------------------------------------------------------------------

/*
    1_3) ROWŸ�� ����
         � ���̺��� �� �࿡ ���� ��� �÷����� �� ���� �� �ִ� ����
         
         [ǥ����] ������ ���̺��%ROWTYPE;
*/

DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    --WHERE EMP_ID = 201;
    WHERE EMP_NAME = '&�����';
    
    --DBMS_OUTPUT.PUT_LINE(E);
    DBMS_OUTPUT.PUT_LINE('��� : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('����� : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('���� : ' || E.SALARY * 12);
    DBMS_OUTPUT.PUT_LINE('���ʽ� ���� ���� : ' || (E.SALARY + E.SALARY * NVL(E.BONUS, 0)) * 12);
    -- ��¹� �ȿ� ��������, �Լ��� ��� ����
END;
/

--------------------------------------------------------------------------------

-- 2. BEGIN

-- < ���ǹ� >

-- 1) IF ���ǽ� THEN ���೻�� END IF;  

-- ��� �Է¹��� �� �ش� ����� ���, �̸�, �޿�, ���ʽ���(%) ���
-- ��, ���ʽ��� ���� �ʴ� ����� ���ʽ��� ��� �� '���ʽ��� ���޹��� �ʴ� ����Դϴ�' ���
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';

    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);
    
    IF (BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�');    
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || BONUS * 100 || '%');
END;
/
SET SERVEROUTPUT ON;

-- 2) IF ���ǽ� THEN ���೻�� ELSE ���೻�� END IF; (IF-ELSE��)
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';

    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);
    
    IF (BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�');    
    ELSE
        DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || BONUS * 100 || '%');
    END IF;
    
END;
/

-- 3) IF ���ǽ�1 THEN ���೻��1 ELSIF ���ǽ�2 THEN ���೻��2 .. [ELSE ���೻��N] END IF;

-- ����ڿ��� ������ �Է¹��� �� SCORE������ ����� �� 
-- 80�� �̻��� '��', 60�� �̻��� '��', 60�� �̸��� '��' ó���� �� GRADE������ ���
-- '����� ������ XX���̰�, �Ƿ��� X�Դϴ�.'

DECLARE 
    SCORE NUMBER;
    GRADE CHAR(3);
BEGIN
    SCORE := &����;
    
    IF SCORE >= 80 THEN GRADE := '��';
    ELSIF SCORE >= 60 THEN GRADE := '��';
    ELSE GRADE := '��';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('����� ������ ' || SCORE || '���̰�, �Ƿ��� ' || GRADE || '�Դϴ�.');
END;
/

------------------------------- �ǽ����� -------------------------------


DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(10);
BEGIN
    
    -- ����Է¹޾� �ش����� ��ġ�ϴ� ����� ���, �����, �μ���, �ٹ������ڵ� ��ȸ�� �� => EID,ENAME,DTITLE,NCODE ���
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = '&���';
    
    -- NCODE�� 'KO' �ϰ�� TEAM������ '������' ���
    --        �׿� �ƴҰ�� TEAM ������ '�ؿ���' ���
    IF NCODE = 'KO' THEN TEAM := '������';
    ELSE TEAM := '�ؿ���';
    END IF;
    
    -- ���,�̸�,�μ���,�Ҽӿ� ���� ���
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || TEAM);
END;
/

--------------------------------------------------------------------------------

-- < �ݺ��� >

/*
    1) BASIC LOOP��
    
    [ǥ����]
    LOOP
        �ݺ������ν����ұ���
        
        �ݺ����� �����������ִ� ����
    END LOOP;
    
    => �ݺ����� �����������ִ� ���� (2����)
       1) IF ���ǽ� THEN EXIT; END IF;
       2) EXIT WHEN ���ǽ�;
*/

-- 1 ~ 5 ���� ���������� 1�� �����ϴ� �� ���
DECLARE
    I NUMBER := 1;
BEGIN
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 1;
        
        --IF I = 6 THEN EXIT; END IF;
        EXIT WHEN I=6;
    END LOOP;
END;
/

/*
    2) FOR LOOP��
    
    [ǥ����]
    FOR ���� IN [REVERSE] �ʱⰪ..������
    LOOP
        �ݺ������ν����ұ���
    END LOOP;
*/
BEGIN
    FOR I IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

BEGIN
    FOR I IN REVERSE 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

-- �ݺ����� �̿��� ������ ����
CREATE TABLE TEST2(
    TEST_NO NUMBER PRIMARY KEY,
    TEST_DATE DATE 
);

CREATE SEQUENCE SEQ_TEST2
START WITH 100;

BEGIN
    FOR I IN 1..50
    LOOP
        INSERT INTO TEST2 VALUES(SEQ_TEST2.NEXTVAL, SYSDATE);
    END LOOP;
END;
/
SELECT * FROM TEST2;

---------------------------------------------------------------------------------

/*
    3) WHILE LOOP��
    
    [ǥ����]
    WHILE �ݺ��̼��������
    LOOP
        �ݺ������ν����ұ���
    END LOOP;
*/

DECLARE
    I NUMBER := 1;
BEGIN
    
    WHILE I < 6
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 1;
    END LOOP;
END;
/
    
-----------------------------------------------------------------------------------

/*
    3. EXCEPTION (����ó����)
    
    ���� (EXCEPTION) : ���� �� �߻��ϴ� ����
    
    [ǥ����]
    EXCEPTION
        WHEN ���ܸ�1 THEN ����ó������1;
        WHEN ���ܸ�2 THEN ����ó������2;
        ...
        WHEN OTHERS THEN ����ó������N;
    
    * �ý��ۿ��� (����Ŭ���� �̸����� �Ǿ��ִ� ����)
    - NO_DATA_FOUND : SELECT�� ����� �� �൵ ���� ���
    - TOO_MANY_ROWS : SELECT�� ����� �������� ���
    - ZERO_DIVIDE : 0���� ���� �� 
    - DUP_VAL_ON_INDEX : UNIQUE �������ǿ� ����Ǿ��� ���
    ... 
*/

-- ����ڰ� �Է��� ���� ������ ������ ��� ���
DECLARE
    RESULT NUMBER;
BEGIN
    RESULT := 10 / &����;
    DBMS_OUTPUT.PUT_LINE('��� : ' || RESULT);
EXCEPTION
    --WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('������ ����� 0���� ������ �����ϴ�.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('������ ����� 0���� ������ �����ϴ�.');
END;
/

-- UNIQUE �������� �����
BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = '&�����һ��'
    WHERE EMP_NAME = '���ö';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�.');
END;
/


DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO EID, ENAME
    FROM EMPLOYEE
    WHERE MANAGER_ID = &������;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
EXCEPTION
    --WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('��ȸ����� �����ϴ�');
    --WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('�ʹ� ���� ���� ��ȸ�Ǿ����ϴ�.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('��ȸ����� ���ų� �ʹ� �����ϴ�.');
END;
/






