INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('ss23304007@ga.ttc.ac.jp', '齋藤 創己', 'Abc12345&!', 'NewAbc123!', '思い出');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('mt23304012@ga.ttc.ac.jp', '田久保 雅也', 'Xy7890&@', 'Xy8901@&', '未来の夢');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('ichiroutanaka@hoge.jp', '田中 一郎', 'StrongP@ssw0rd1', 'WeakP@ssw0rd1', '家族');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('testuser1@hoge.jp', 'Test User', 'TestUser123!', NULL, 'テスト');
--以下エラーが発生
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('testuser2@hoge.jp', 'Error User1', 'password123', NULL, 'テスト');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('testuser3@hoge.jp', 'Error User2', 'AAAAaaaa1111!', NULL, 'テスト');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('testuser4@hoge.jp', 'Error User3', 'Short1!', NULL, 'テスト');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('testuer5@hoge.jp', 'Error User4', '12345678', NULL, 'テスト');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('', 'Error User5', 'ErrorUser123!', NULL, 'テスト');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('testuer6@hoge.jp', '', 'ErrorUser123!', NULL, 'テスト');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('testuser7@hoge.jp', 'Error User6', 'ErrorUser123!', NULL, '');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('testuser1@hoge.jp', 'Error User6', 'ErrorUser123!', NULL, '');


commit;
exit;