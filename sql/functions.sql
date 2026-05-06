CREATE OR REPLACE FUNCTION calculate_fine(
p_issue_date DATE,
p_return_date DATE -- Pass SYSDATE for still-issued books
)
RETURN NUMBER
IS
v_days_held NUMBER;
v_grace CONSTANT NUMBER := 7; -- free days
v_rate CONSTANT NUMBER := 1; -- Rs. per overdue day
v_fine NUMBER := 0;
BEGIN
v_days_held := TRUNC(NVL(p_return_date, SYSDATE)) - TRUNC(p_issue_date);
IF v_days_held > v_grace THEN
v_fine := (v_days_held - v_grace) * v_rate;
END IF;
RETURN v_fine;
END calculate_fine;
/
