<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>チケット詳細</title>
</head>
<body>
    <h2>チケット詳細</h2>
    
    <!-- チケット修正フォーム -->
    <form action="FixOrCreateTicketServlet" method="post">
        <!-- チケットIDをhiddenフィールドとして設定 -->
        <input type="hidden" name="ticketId" value="${ticket.ticketId}">

        <!-- セッションから前ページのURLを取得し、hiddenフィールドに設定 -->
        <input type="hidden" name="previousPage" value="${sessionScope.currentPage}">
        
        <!-- Emailをhiddenフィールドとして設定 -->
        <input type="hidden" name="email" value="${sessionScope.email}">
        
        <!-- フォームフィールド -->
        <label for="title">タイトル:</label>
        <input type="text" id="title" name="title" value="${ticket.title}" required>
        
        <label for="deadline">締め切り:</label>
        <input type="date" id="deadline" name="deadline" value="${ticket.deadline}" required>
        
        <label for="assignedPerson">担当者:</label>
        <input type="text" id="assignedPerson" name="assignedPerson" value="${ticket.assignedPerson}" required>
        
        <label for="importance">重要度:</label>
        <select id="importance" name="importance" required>
            <option value="低" <c:if test="${ticket.importance == '低'}">selected</c:if>>低</option>
            <option value="中" <c:if test="${ticket.importance == '中'}">selected</c:if>>中</option>
            <option value="高" <c:if test="${ticket.importance == '高'}">selected</c:if>>高</option>
        </select>

        <label for="category">カテゴリー:</label>
        <input type="text" id="category" name="category" value="${ticket.category}" required>
        
        <label for="progress">進捗:</label>
        <input type="number" id="progress" name="progress" value="${ticket.progress}" min="0" max="100" required>
        
        <!-- 修正ボタン -->
        <button type="submit" name="action" value="update">修正</button>
    </form>
    
    <!-- 閉じるボタンを追加 -->
    <button onclick="closeTicketDetail()">閉じる</button>
    
    <script>
        function closeTicketDetail() {
            // セッションからcurrentPageを取得
            var previousPage = '${sessionScope.currentPage}';
            
            // currentPageにリダイレクト
            window.location.href = previousPage;  
        }
    </script>
</body>
</html>
