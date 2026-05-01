CREATE OR REPLACE TRIGGER trg_fine
AFTER UPDATE ON ISSUE
FOR EACH ROW
DECLARE
    v_amount NUMBER;
BEGIN
    IF :NEW.STATUS = 'RETURNED' THEN

        v_amount := calculate_fine(:OLD.issue_date, :NEW.return_date);

        IF v_amount > 0 THEN
            INSERT INTO FINE(fine_id, issue_id, amount)
            VALUES (FINE_SEQ.NEXTVAL, :NEW.issue_id, v_amount);
        END IF;

    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_audit
AFTER INSERT OR UPDATE OR DELETE ON ISSUE
FOR EACH ROW
DECLARE
    v_action VARCHAR2(10);
BEGIN
    IF INSERTING THEN
        v_action := 'INSERT';
    ELSIF UPDATING THEN
        v_action := 'UPDATE';
    ELSIF DELETING THEN
        v_action := 'DELETE';
    END IF;

    INSERT INTO AUDIT_LOG(log_id, action, table_name)
    VALUES (
        AUDIT_SEQ.NEXTVAL,
        v_action,
        'ISSUE'
    );
END;
/