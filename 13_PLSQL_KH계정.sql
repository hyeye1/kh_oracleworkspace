/*

    ����Ŭ ��ü�� ����Ǿ��ִ� ������ ���
    ��������, ����ó��(IF), �ݺ�ó��(LOOP, FOR, WHILE)���� �����Ͽ� SQL�� ������ ����
    �ټ��� SQL���� �ѹ��� ���డ�� (BLOCK����)
    
    * PL/SQL ����
    - [����� (DECLARE SECTION)] : DECLARE�� ����, ������ ����� ���� �� �ʱ�ȭ�ϴ� �κ�
    - ����� (EXECUTABLE SECTION) : BEGIN�� ����, ������ SQL�� �Ǵ� ���(���ǹ�, �ݺ���)
    - [����ó���� (EXCEPTION SECTION)] : EXCEPTION�� ����,

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
    1_2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ (���������ϰ��ִ� Ư�� �÷��� ������Ÿ������ ����)
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
    
    -- ����� 200�� ����� ���, �̸�, �޿� ��ȸ�� �� ���� EID, ENAME, SAL�� ���
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM EMPLOYEE
    --WHERE EMP_ID = 200;
    --WHERE EMP_ID = &���;
    WHERE EMP_NAME = '&�̸�';
    --WHERE DEPT_CODE = '&�μ��ڵ�'; --> ����: SELECT INTO�� �̿��ؼ� ��ȸ����� ������ ����� �Ѵٸ� �ݵ�� �� ������ ��ȸ�Ǿ�ߵ� 
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID );
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/

----------------------------------�ǽ�����------------------------------------------
/*
    ���۷���Ÿ�Ժ����� EID, ENAME, JCODE, SAL, DTITLE�� �����ϰ�
    �� �ڷ������� EMPLOYEE�� EMP_ID, EMP_NAME, JOB_CODE, SALARY/DEPARTMENT�� DEPT_TITLE�÷����� ������Ÿ���� �����ϰԲ�
    
    ��ü������ �Է��� ������ ��ġ�ϴ� ����� ��ȸ�ؼ� �� ������ ���� �� ���

*/
-- �����
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;

-- �����
BEGIN 
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_NAME = '&�����';
    
    DBMS_OUTPUT.PUT_LINE(EID || ', ' || ENAME || ', ' || JCODE || ', ' || SAL || ', ' || DTITLE);
END;
/
-------------------------------------------------------------------------------------

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
    
    -- DBMS_OUTPUT.PUT_LINE(E);
    DBMS_OUTPUT.PUT_LINE('��� : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('����� : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('���� : ' || E.SALARY *12);
    DBMS_OUTPUT.PUT_LINE('���ʽ� ���� ���� : ' || (E.SALARY + E.SALARY * E.BONUS) *12 );
    
END;
/










