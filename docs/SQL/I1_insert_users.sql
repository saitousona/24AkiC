INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (users_sequence.NEXTVAL, '�V�� �n��', 'Abc12345&!', 'NewAbc123!', '�v���o');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (users_sequence.NEXTVAL, '�c�v�� ���', 'Xy7890&@', 'Xy8901@&', '�����̖�');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (users_sequence.NEXTVAL, '�c�� ��Y', 'StrongP@ssw0rd1', 'WeakP@ssw0rd1', '�Ƒ�');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (users_sequence.NEXTVAL, 'Test User', 'TestUser123!', NULL, '�e�X�g');
--�ȉ��G���[������
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (5, 'Error User1', 'password123', NULL, '�e�X�g');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (6, 'Error User2', 'AAAAaaaa1111!', NULL, '�e�X�g');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (7, 'Error User3', 'Short1!', NULL, '�e�X�g');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (8, 'Error User4', '12345678', NULL, '�e�X�g');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (, 'Error User5', 'ErrorUser123!', NULL, '�e�X�g');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (9, '', 'ErrorUser123!', NULL, '�e�X�g');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (10, 'Error User6', 'ErrorUser123!', NULL, '');
INSERT INTO users (user_id, user_name, password, old_password, secret_word) VALUES (1, 'Error User6', 'ErrorUser123!', NULL, '');


commit;
exit;