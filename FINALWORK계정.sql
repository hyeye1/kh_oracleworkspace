-- 3. 도서명이 25자 이상인 책 번호와 도서명
DECLARE
    BKNO TB_BOOK.BOOK_NO%TYPE;
    BKNM TB_BOOK.BOOK_NM%TYPE;
BEGIN
    SELECT BOOK_NO, BOOK_NM
    INTO BKNO, BKNM
    FROM TB_BOOK
    WHERE LENGTH( BOOK_NM ) >= 25;
    
    DBMS_OUTPUT.PUT_LINE('책 번호 : ' || BKNO );
    DBMS_OUTPUT.PUT_LINE('도서명 : ' || BKNM );
    
END;
/

    SELECT BOOK_NO, BOOK_NM
    --INTO BKNO, BKNM
    FROM TB_BOOK
    WHERE LENGTH( BOOK_NM ) >= 25;
    
    
-- 4. 휴대폰 번호가 '019'로시작하는 김씨 성을 가진 작가 -> 이름순 정렬 가장먼저 표시되는 
-- 작가 이름과 사무실전화번호, 집전화번호, 휴대폰 전화번호 표시
SELECT *
FROM (
    SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
    FROM TB_WRITER
    WHERE WRITER_NM LIKE '김%' AND MOBILE_NO LIKE '019%'
    ORDER BY WRITER_NM)
WHERE ROWNUM <= 1;


-- 5. 
