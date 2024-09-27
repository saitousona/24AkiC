<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>新規チケット作成</title>
</head>
<body>
    <h2>新規チケット作成</h2>
    <form action="FixOrCreateTicketServlet" method="post">
        <input type="hidden" name="ticketId" value="">
        
        <label for="title">タイトル:</label>
        <input type="text" id="title" name="title" required>
        
        <label for="deadline">締め切り:</label>
        <input type="date" id="deadline" name="deadline" required>
        
        <label for="assignedPerson">担当者:</label>
        <input type="text" id="assignedPerson" name="assignedPerson" required>
        
        <label for="importance">重要度:</label>
        <select id="importance" name="importance" required>
            <option value="低">低</option>
            <option value="中">中</option>
            <option value="高">高</option>
        </select>

        <label for="category">カテゴリー:</label>
        <input type="text" id="category" name="category" required>
        
        <label for="progress">進捗:</label>
        <input type="number" id="progress" name="progress" value="0" required>
        
        <!-- 送信ボタン -->
        <button type="submit" name="action" value="create">送信</button>
    </form>
    <button onclick="location.href='MainToDoPage.jsp'">戻る</button> <!-- 戻るボタン -->
</body>
</html>
