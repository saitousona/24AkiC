INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (users_sequence.NEXTVAL, '齋藤 創己', 'Abc12345&!', 'NewAbc123!', '思い出');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (users_sequence.NEXTVAL, '田久保 雅也', 'Xy7890&@', 'Xy8901@&', '未来の夢');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (users_sequence.NEXTVAL, '田中 一郎', 'StrongP@ssw0rd1', 'WeakP@ssw0rd1', '家族');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (users_sequence.NEXTVAL, 'Test User', 'TestUser123!', NULL, 'テスト');
--以下エラーが発生
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (5, 'Error User1', 'password123', NULL, 'テスト');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (6, 'Error User2', 'AAAAaaaa1111!', NULL, 'テスト');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (7, 'Error User3', 'Short1!', NULL, 'テスト');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (8, 'Error User4', '12345678', NULL, 'テスト');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (, 'Error User5', 'ErrorUser123!', NULL, 'テスト');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (9, '', 'ErrorUser123!', NULL, 'テスト');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (10, 'Error User6', 'ErrorUser123!', NULL, '');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (1, 'Error User6', 'ErrorUser123!', NULL, '');


commit;
exit;