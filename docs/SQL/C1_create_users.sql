CREATE TABLE USERS (
    email VARCHAR2(100) PRIMARY KEY,
    user_name VARCHAR2(30) NOT NULL ,
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

commit;
exit;