@echo off
chcp 65001

set NLS_LANG=JAPANESE_JAPAN.UTF8
set /p DB_USER=ユーザー名を入力してください: 
set /p DB_PASSWORD=パスワードを入力してください: 

set DB_CONNECT=localhost:1521/orcl

set /p selectOracleSQL=Create or Drop or Insert(Enter:c/d/i): 

if "%selectOracleSQL%"=="c" (
    rem Create Table
    sqlplus "%DB_USER%"/"%DB_PASSWORD%"@%DB_CONNECT% @C1_create_users.sql  >>sql.log
    sqlplus "%DB_USER%"/"%DB_PASSWORD%"@%DB_CONNECT% @C2_create_ticket.sql  >>sql.log
) else (
    if "%selectOracleSQL%"=="d" (
        rem Drop Table
        sqlplus "%DB_USER%"/"%DB_PASSWORD%"@%DB_CONNECT% @D1_drop_ticket.sql  >>sql.log
        sqlplus "%DB_USER%"/"%DB_PASSWORD%"@%DB_CONNECT% @D2_drop_users.sql  >>sql.log
    ) else (
        if "%selectOracleSQL%"=="i" (
            rem Insert Table
            sqlplus "%DB_USER%"/"%DB_PASSWORD%"@%DB_CONNECT% @I1_insert_users.sql  >>sql.log
            sqlplus "%DB_USER%"/"%DB_PASSWORD%"@%DB_CONNECT% @I2_insert_ticket.sql  >>sql.log
        ) else (
            rem error process
            echo mistake
            pause
        )
    )
)
