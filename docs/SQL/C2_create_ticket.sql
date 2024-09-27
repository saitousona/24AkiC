CREATE SEQUENCE TICKET_Sequence
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;


CREATE TABLE TICKET (
    ticket_id NUMBER(9,0) PRIMARY KEY,
    email VARCHAR2(100) NOT NULL,
    title VARCHAR2(60) CONSTRAINT NN_TICKET_TITLE NOT NULL,
    deadline DATE CONSTRAINT NN_TICKET_DEADLINE NOT NULL,
    assigned_person VARCHAR2(50),
    importance VARCHAR2(10) NOT NULL CONSTRAINT CK_TICKET_IMPORTANCE CHECK (importance IN ('低', '中', '高')),
    progress NUMBER(3,0) DEFAULT 0 NOT NULL CONSTRAINT CK_TICKET_PROGRESS CHECK (progress BETWEEN 0 AND 100),
    category VARCHAR2(20),
    CONSTRAINT FK_TICKET_USER FOREIGN KEY (email) REFERENCES USERS(email) ON DELETE CASCADE
);
commit;
exit;