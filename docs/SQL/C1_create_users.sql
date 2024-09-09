CREATE SEQUENCE USERS_Sequence
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE TABLE USERS (
    user_id NUMBER(4,0) PRIMARY KEY,
    user_name VARCHAR2(30) NOT NULL,
    password VARCHAR2(64) NOT NULL CONSTRAINT CK_USER_PASSWORD CHECK (
        LENGTH(password) BETWEEN 8 AND 64
        AND REGEXP_LIKE(password, '[A-Z]')
        AND REGEXP_LIKE(password, '[a-z]')
        AND REGEXP_LIKE(password, '[0-9]')
        AND NOT REGEXP_LIKE(password, '(.)\1{2,}')
    ),
    old_password VARCHAR2(64),
    secret_word VARCHAR2(10) NOT NULL
);

exit;