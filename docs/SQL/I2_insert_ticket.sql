INSERT INTO ticket (ticket_id, user_id, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 1, '�c��̃`�F�b�N���X�g�쐬', TO_DATE('2024-09-10', 'YYYY-MM-DD'), '�V��', '��', 100, '���͍쐬');
INSERT INTO ticket (ticket_id, user_id, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 1, '�~�[�e�B���O�̋c�萮��', TO_DATE('2024-11-02', 'YYYY-MM-DD'), '�c�v��', '��', 50, '��c����');
INSERT INTO ticket (ticket_id, user_id, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 1, '�v���W�F�N�g�̒�ď��̍쐬�i�S���ҍăA�T�C���̉\������B�j', TO_DATE('2025-02-02', 'YYYY-MM-DD'), '�c��', '��', 0, '�ڋq����');
INSERT INTO ticket (ticket_id, user_id, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 1, '�T���Ɩ�', TO_DATE('2024-11-08', 'YYYY-MM-DD'), '�c�v��', '��', 0, '���Ɩ�');
INSERT INTO ticket (ticket_id, user_id, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 1, '�T������c', TO_DATE('2024-11-08', 'YYYY-MM-DD'), '�����o', '��', 0, '��c');
INSERT INTO ticket (ticket_id, user_id, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 2, '�T������c', TO_DATE('2024-11-08', 'YYYY-MM-DD'), '�����o', '��', 0, '��c');
INSERT INTO ticket (ticket_id, user_id, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 2, 'Unit Test', TO_DATE('2024-11-09', 'YYYY-MM-DD'), '�V��', '��', 0, '�e�X�g');
INSERT INTO ticket (ticket_id, user_id, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 2, '�V�X�e������', TO_DATE('2026-10-02', 'YYYY-MM-DD'), NULL, '��', 0, NULL);
INSERT INTO ticket (ticket_id, user_id, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 3, '�[�т̂�����', TO_DATE('2024-10-02', 'YYYY-MM-DD'), '�p�p', '��', 50, NULL);
INSERT INTO ticket (ticket_id, user_id, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 3, '�S�~�o��', TO_DATE('2024-10-03', 'YYYY-MM-DD'), '�}�}', '��', 0, '�Ǝ�');
-- �ȉ��G���[������
INSERT INTO ticket (ticket_id, user_id, title, deadline, assigned_person, importance, progress, category) VALUES (null, 3, '�S�~�o��', TO_DATE('2024-10-03', 'YYYY-MM-DD'), '�}�}', '��', 0, '�Ǝ�');
INSERT INTO ticket (ticket_id, user_id, title, deadline, assigned_person, importance, progress, category) VALUES (11, NULL, '�S�~�o��', TO_DATE('2024-10-03', 'YYYY-MM-DD'), '�}�}', '��', 0, '�Ǝ�');
INSERT INTO ticket (ticket_id, user_id, title, deadline, assigned_person, importance, progress, category) VALUES (12, 1, '�v���W�F�N�g�̒�ď��̍쐬�i�S���ҍăA�T�C���̉\������܂��j', TO_DATE('2025-02-02', 'YYYY-MM-DD'), '�c��', '��', 0, '�ڋq����');
INSERT INTO ticket (ticket_id, user_id, title, deadline, assigned_person, importance, progress, category) VALUES (13, 1, '�S�~�o��', TO_DATE('2024-10-03', 'YYYY-MM-DD'), '�}�}', 'LOW', 0, '�Ǝ�');
INSERT INTO ticket (ticket_id, user_id, title, deadline, assigned_person, importance, progress, category) VALUES (14, 1, '�S�~�o��', TO_DATE('2024-10-03', 'YYYY-MM-DD'), '�}�}', '��', NULL, '�Ǝ�');
INSERT INTO ticket (ticket_id, user_id, title, deadline, assigned_person, importance, progress, category) VALUES (1, 1, '�S�~�o��', TO_DATE('2024-10-03', 'YYYY-MM-DD'), '�}�}', '��', 0, '�Ǝ�');


commit;
exit;
