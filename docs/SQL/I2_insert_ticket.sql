INSERT INTO ticket (ticket_id, email, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 'ss23304007@ga.ttc.ac.jp', '議題のチェックリスト作成', TO_DATE('2024-09-10', 'YYYY-MM-DD'), '齋藤', '低', 100, '文章作成');
INSERT INTO ticket (ticket_id, email, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 'ss23304007@ga.ttc.ac.jp', 'ミーティングの議題整理', TO_DATE('2024-11-02', 'YYYY-MM-DD'), '田久保', '中', 50, '会議準備');
INSERT INTO ticket (ticket_id, email, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 'ss23304007@ga.ttc.ac.jp', 'プロジェクトの提案書の作成（担当者再アサインの可能性あり。）', TO_DATE('2025-02-02', 'YYYY-MM-DD'), '田中', '高', 0, '顧客調査');
INSERT INTO ticket (ticket_id, email, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 'ss23304007@ga.ttc.ac.jp', '週次業務', TO_DATE('2024-11-08', 'YYYY-MM-DD'), '田久保', '中', 0, '定例業務');
INSERT INTO ticket (ticket_id, email, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 'ss23304007@ga.ttc.ac.jp', '週次定例会議', TO_DATE('2024-11-08', 'YYYY-MM-DD'), 'メンバ', '中', 0, '会議');
INSERT INTO ticket (ticket_id, email, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 'mt23304012@ga.ttc.ac.jp', '週次定例会議', TO_DATE('2024-11-08', 'YYYY-MM-DD'), 'メンバ', '中', 0, '会議');
INSERT INTO ticket (ticket_id, email, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 'mt23304012@ga.ttc.ac.jp', 'Unit Test', TO_DATE('2024-11-09', 'YYYY-MM-DD'), '齋藤', '高', 0, 'テスト');
INSERT INTO ticket (ticket_id, email, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 'mt23304012@ga.ttc.ac.jp', 'システム調査', TO_DATE('2026-10-02', 'YYYY-MM-DD'), NULL, '低', 0, NULL);
INSERT INTO ticket (ticket_id, email, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 'ichiroutanaka@hoge.jp', '夕飯のおつかい', TO_DATE('2024-10-02', 'YYYY-MM-DD'), 'パパ', '低', 50, NULL);
INSERT INTO ticket (ticket_id, email, title, deadline, assigned_person, importance, progress, category) VALUES (ticket_sequence.NEXTVAL, 'ichiroutanaka@hoge.jp', 'ゴミ出し', TO_DATE('2024-10-03', 'YYYY-MM-DD'), 'ママ', '低', 0, '家事');
--以下エラーが発生
INSERT INTO ticket (ticket_id, email, title, deadline, assigned_person, importance, progress, category) VALUES (null, 'ichiroutanaka@hoge.jp', 'ゴミ出し', TO_DATE('2024-10-03', 'YYYY-MM-DD'), 'ママ', '低', 0, '家事');
INSERT INTO ticket (ticket_id, email, title, deadline, assigned_person, importance, progress, category) VALUES (11, 'NULL', 'ゴミ出し', TO_DATE('2024-10-03', 'YYYY-MM-DD'), 'ママ', '低', 0, '家事');
INSERT INTO ticket (ticket_id, email, title, deadline, assigned_person, importance, progress, category) VALUES (12, 'ss23304007@ga.ttc.ac.jp', 'プロジェクトの提案書の作成（担当者再アサインの可能性あります）', TO_DATE('2025-02-02', 'YYYY-MM-DD'), '田中', '高', 0, '顧客調査');
INSERT INTO ticket (ticket_id, email, title, deadline, assigned_person, importance, progress, category) VALUES (13, 'ss23304007@ga.ttc.ac.jp', 'ゴミ出し', TO_DATE('2024-10-03', 'YYYY-MM-DD'), 'ママ', 'LOW', 0, '家事');
INSERT INTO ticket (ticket_id, email, title, deadline, assigned_person, importance, progress, category) VALUES (14, 'ss23304007@ga.ttc.ac.jp', 'ゴミ出し', TO_DATE('2024-10-03', 'YYYY-MM-DD'), 'ママ', '低', NULL, '家事');
INSERT INTO ticket (ticket_id, email, title, deadline, assigned_person, importance, progress, category) VALUES (1, 'ss23304007@ga.ttc.ac.jp', 'ゴミ出し', TO_DATE('2024-10-03', 'YYYY-MM-DD'), 'ママ', '低', 0, '家事');



commit;
exit;

