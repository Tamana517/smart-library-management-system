-- SEQUENCES
CREATE SEQUENCE ISSUE_SEQ START WITH 1;
CREATE SEQUENCE FINE_SEQ START WITH 1;
CREATE SEQUENCE AUDIT_SEQ START WITH 1;
CREATE SEQUENCE BOOK_SEQ START WITH 1;
CREATE SEQUENCE MEMBER_SEQ START WITH 1;

-- USERS
CREATE TABLE USERS (
    user_id NUMBER PRIMARY KEY,
    username VARCHAR2(50),
    role VARCHAR2(20),
    is_active NUMBER(1) DEFAULT 1
);

-- MEMBERS
CREATE TABLE MEMBERS (
    member_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100),
    phone VARCHAR2(15),
    is_active NUMBER(1) DEFAULT 1
);

-- BOOKS
CREATE TABLE BOOKS (
    book_id NUMBER PRIMARY KEY,
    title VARCHAR2(150),
    author VARCHAR2(100),
    available NUMBER(1) DEFAULT 1,
    is_active NUMBER(1) DEFAULT 1
);

-- ISSUE
CREATE TABLE ISSUE (
    issue_id NUMBER PRIMARY KEY,
    member_id NUMBER,
    book_id NUMBER,
    issue_date DATE DEFAULT SYSDATE,
    return_date DATE,
    status VARCHAR2(20),
    FOREIGN KEY (member_id) REFERENCES MEMBERS(member_id),
    FOREIGN KEY (book_id) REFERENCES BOOKS(book_id)
);

-- FINE
CREATE TABLE FINE (
    fine_id NUMBER PRIMARY KEY,
    issue_id NUMBER,
    amount NUMBER,
    paid_status VARCHAR2(10) DEFAULT 'UNPAID',
    FOREIGN KEY (issue_id) REFERENCES ISSUE(issue_id)
);

-- AUDIT LOG
CREATE TABLE AUDIT_LOG (
    log_id NUMBER PRIMARY KEY,
    action VARCHAR2(20),
    table_name VARCHAR2(50),
    action_date DATE DEFAULT SYSDATE
);