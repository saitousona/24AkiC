INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('ss23304007@ga.ttc.ac.jp', '�V�� �n��', 'Abc12345&!', 'NewAbc123!', '�v���o');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('mt23304012@ga.ttc.ac.jp', '�c�v�� ���', 'Xy7890&@', 'Xy8901@&', '�����̖�');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('ichiroutanaka@hoge.jp', '�c�� ��Y', 'StrongP@ssw0rd1', 'WeakP@ssw0rd1', '�Ƒ�');
--�G���[������
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('testuser1@hoge.jp', 'Test User', 'TestUser123!', NULL, '�e�X�g');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('testuser2@hoge.jp', 'Error User1', 'password123', NULL, '�e�X�g');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('testuser3@hoge.jp', 'Error User2', 'AAAAaaaa1111!', NULL, '�e�X�g');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('testuser4@hoge.jp', 'Error User3', 'Short1!', NULL, '�e�X�g');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('testuer5@hoge.jp', 'Error User4', '12345678', NULL, '�e�X�g');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('', 'Error User5', 'ErrorUser123!', NULL, '�e�X�g');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('testuer6@hoge.jp', '', 'ErrorUser123!', NULL, '�e�X�g');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('testuser7@hoge.jp', 'Error User6', 'ErrorUser123!', NULL, '');
INSERT INTO users (email, user_name, password, old_password, secret_word) VALUES ('testuser1@hoge.jp', 'Error User6', 'ErrorUser123!', NULL, '');


commit;
exit;