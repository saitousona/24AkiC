<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>新規チケット作成</title>
    <style>
        /* フォーム全体のスタイル */
        .form-container {
            width: 500px;
            margin: 0 auto;
            padding: 1em;
            background-color: #f9f9f9;
            border-radius: 8px;
        }

        /* ラベルとフィールドを左右に揃える */
        .form-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1em;
        }

        .form-label {
            font-weight: bold;
            width: 100px;
        }

        .form-input {
            flex-grow: 1;
            text-align: left;
        }

        /* 送信ボタン、戻るボタンのスタイル */
        .button-container {
            display: flex;
            justify-content: flex-end;
            margin-top: 1em;
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 0.5em 1em;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

        .back-button {
            background-color: #f44336;
            margin-left: 1em;
        }

        .back-button:hover {
            background-color: #da190b;
        }
    </style>
</head>
<body>
    <h2>新規チケット作成</h2>

    <div class="form-container">
        <form action="FixOrCreateTicketServlet" method="post">
            <input type="hidden" name="ticketId" value="">

            <div class="form-row">
                <label for="title" class="form-label">タイトル:</label>
                <input type="text" id="title" name="title" class="form-input" required>
            </div>

            <div class="form-row">
                <label for="deadline" class="form-label">締め切り:</label>
                <input type="date" id="deadline" name="deadline" class="form-input" required>
            </div>

            <div class="form-row">
                <label for="assignedPerson" class="form-label">担当者:</label>
                <input type="text" id="assignedPerson" name="assignedPerson" class="form-input" required>
            </div>

            <div class="form-row">
                <label for="importance" class="form-label">重要度:</label>
                <select id="importance" name="importance" class="form-input" required>
                    <option value="低">低</option>
                    <option value="中">中</option>
                    <option value="高">高</option>
                </select>
            </div>

            <div class="form-row">
                <label for="category" class="form-label">カテゴリー:</label>
                <input type="text" id="category" name="category" class="form-input" required>
            </div>

            <div class="form-row">
                <label for="progress" class="form-label">進捗:</label>
                <input type="number" id="progress" name="progress" class="form-input" value="0" required>
            </div>

            <div class="button-container">
                <button type="submit" name="action" value="create">送信</button>
                <button type="button" class="back-button" onclick="location.href='MainToDoPage.jsp'">戻る</button>
            </div>
        </form>
    </div>

</body>
</html>
