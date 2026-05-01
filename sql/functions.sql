SELECT i.issue_id, m.name, b.title,
       i.issue_date, i.return_date, i.status
FROM ISSUE i
JOIN MEMBERS m ON i.member_id = m.member_id
JOIN BOOKS b ON i.book_id = b.book_id
WHERE 
    (i.status = 'ISSUED' AND SYSDATE - i.issue_date > 7)
    OR
    (i.status = 'RETURNED' AND i.return_date - i.issue_date > 7);
