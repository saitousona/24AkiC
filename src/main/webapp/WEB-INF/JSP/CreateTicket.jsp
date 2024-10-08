<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>新規チケット作成</title>
    <style>
        /* フォーム全体のスタイル */
        .ticket-detail-container form {
            width: 100%;
            padding: 1em;
            box-sizing: border-box;
        }
        
        .ticket-detail-container label {
            display: inline-block;
            width: 100px;
            text-align: left;
            margin-bottom: 0.5em;
        }
        
        .ticket-detail-container input[type="text"],
        .ticket-detail-container input[type="date"],
        .ticket-detail-container input[type="number"],
        .ticket-detail-container select {
            width: 100%;
            padding: 0.5em;
            margin-bottom: 1em;
            box-sizing: border-box;
        }
        
        .ticket-detail-container .button-container {
            text-align: right;
        }
        
        .ticket-detail-container .form-row {
            display: flex;
            align-items: center;
            margin-bottom: 1em;
        }
    </style>
</head>
<body>
<div class="ticket-detail-container">
    <h2>新規チケット作成</h2>

    <form action="FixOrCreateTicketServlet" method="post">
        <input type="hidden" name="ticketId" value="">
        <input type="hidden" name="previousPage" value="${sessionScope.currentPage}">
        <input type="hidden" name="email" value="${sessionScope.email}">

        <div class="form-row">
            <label for="title">タイトル:</label>
            <input type="text" id="title" name="title" required>
        </div>
        <br>

        <div class="form-row">
            <label for="deadline">締め切り:</label>
            <input type="date" id="deadline" name="deadline" required>
        </div>
        <br>

        <div class="form-row">
            <label for="assignedPerson">担当者:</label>
            <input type="text" id="assignedPerson" name="assignedPerson" required>
        </div>
		<br>
		<br>
        <div class="form-row">
            <label for="importance">重要度:</label>
            <select id="importance" name="importance" required>
                <option value="低">低</option>
                <option value="中">中</option>
                <option value="高">高</option>
            </select>
        </div>
        <br>

        <div class="form-row">
            <label for="category">カテゴリ:</label>
            <input type="text" id="category" name="category" required>
        </div>

        <div class="form-row">
            <label for="progress">進捗:</label>
            <input type="number" id="progress" name="progress" min="0" max="100" required>
        </div>

        <div class="button-container">
            <button type="submit" name="action" value="create">送信</button>
            <button type="button" onclick="closeCreateTicket()">閉じる</button>
        </div>
    </form>
</div>

<script>
    function closeCreateTicket() {
        var previousPage = '${sessionScope.currentPage}';
        window.location.href = previousPage;
    }
</script>
</body>
</html>
