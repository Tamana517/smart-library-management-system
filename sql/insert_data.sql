-- MEMBERS
INSERT INTO MEMBERS VALUES (1, 'Rahul', 'rahul@gmail.com', '9999999999', 1);
INSERT INTO MEMBERS VALUES (2, 'Simran', 'simran@gmail.com', '8888888888', 1);
INSERT INTO MEMBERS VALUES (3, 'Aman', 'aman@gmail.com', '7777777777', 1);

-- BOOKS
INSERT INTO BOOKS VALUES (1, 'DBMS Concepts', 'Korth', 1, 1);
INSERT INTO BOOKS VALUES (2, 'Operating Systems', 'Galvin', 1, 1);
INSERT INTO BOOKS VALUES (3, 'Computer Networks', 'Tanenbaum', 1, 1);
INSERT INTO BOOKS VALUES (4, 'Data Structures', 'Sahni', 1, 1);
INSERT INTO BOOKS VALUES (5, 'Artificial Intelligence', 'Russell', 1, 1);


-- ISSUE DATA
INSERT INTO ISSUE VALUES (ISSUE_SEQ.NEXTVAL, 1, 1, SYSDATE - 12, NULL, 'ISSUED');  -- overdue
INSERT INTO ISSUE VALUES (ISSUE_SEQ.NEXTVAL, 2, 2, SYSDATE - 3, NULL, 'ISSUED');   -- not overdue
INSERT INTO ISSUE VALUES (ISSUE_SEQ.NEXTVAL, 3, 3, SYSDATE - 10, SYSDATE - 2, 'RETURNED'); -- returned late

UPDATE ISSUE
SET return_date = SYSDATE,
    status = 'RETURNED'
WHERE issue_id = (SELECT MAX(issue_id) FROM ISSUE);

COMMIT;