-- 3. �������� 25�� �̻��� å ��ȣ�� ������
DECLARE
    BKNO TB_BOOK.BOOK_NO%TYPE;
    BKNM TB_BOOK.BOOK_NM%TYPE;
BEGIN
    SELECT BOOK_NO, BOOK_NM
    INTO BKNO, BKNM
    FROM TB_BOOK
    WHERE LENGTH( BOOK_NM ) >= 25;
    
    DBMS_OUTPUT.PUT_LINE('å ��ȣ : ' || BKNO );
    DBMS_OUTPUT.PUT_LINE('������ : ' || BKNM );
    
END;
/

    SELECT BOOK_NO, BOOK_NM
    --INTO BKNO, BKNM
    FROM TB_BOOK
    WHERE LENGTH( BOOK_NM ) >= 25;
    
    
-- 4. �޴��� ��ȣ�� '019'�ν����ϴ� �达 ���� ���� �۰� -> �̸��� ���� ������� ǥ�õǴ� 
-- �۰� �̸��� �繫����ȭ��ȣ, ����ȭ��ȣ, �޴��� ��ȭ��ȣ ǥ��
SELECT *
FROM (
    SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
    FROM TB_WRITER
    WHERE WRITER_NM LIKE '��%' AND MOBILE_NO LIKE '019%'
    ORDER BY WRITER_NM)
WHERE ROWNUM <= 1;


-- 5. 
