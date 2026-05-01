CREATE OR REPLACE PROCEDURE issue_book(
    p_member_id NUMBER,
    p_book_id NUMBER
)
AS
    v_available NUMBER;
BEGIN
    SELECT available INTO v_available FROM BOOKS WHERE book_id = p_book_id;

    IF v_available = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Book not available');
    END IF;

    INSERT INTO ISSUE(issue_id, member_id, book_id, status)
    VALUES (ISSUE_SEQ.NEXTVAL, p_member_id, p_book_id, 'ISSUED');

    UPDATE BOOKS SET available = 0 WHERE book_id = p_book_id;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

CREATE OR REPLACE PROCEDURE return_book(
    p_issue_id NUMBER
)
AS
    v_book_id NUMBER;
BEGIN
    SELECT book_id INTO v_book_id FROM ISSUE WHERE issue_id = p_issue_id;

    UPDATE ISSUE
    SET return_date = SYSDATE,
        status = 'RETURNED'
    WHERE issue_id = p_issue_id;

    UPDATE BOOKS SET available = 1 WHERE book_id = v_book_id;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/