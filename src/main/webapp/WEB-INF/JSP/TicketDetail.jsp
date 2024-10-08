<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>チケット詳細</title>
    <style>
        /* フォーム全体のスタイル */
		/* TicketDetail専用のスタイル */
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
		
		.ticket-detail-container .right-pane {
		    width: 100%;
		    max-height: 100%;
		    overflow-y: auto;
		}


    </style>
</head>
<body>
<div class="ticket-detail-container">
    <h2>チケット詳細</h2>

    <!-- チケット修正フォーム -->
    <form action="FixOrCreateTicketServlet" method="post">
        <input type="hidden" name="ticketId" value="${ticket.ticketId}">
        <input type="hidden" name="previousPage" value="${sessionScope.currentPage}">
        <input type="hidden" name="email" value="${sessionScope.email}">

        <!-- 各フィールドを行ごとに配置 -->
        <div class="form-row">
            <label for="title">タイトル:</label>
            <input type="text" id="title" name="title" value="${ticket.title}" required>
        </div>

        <div class="form-row">
            <label for="deadline">締め切り:</label>
            <input type="date" id="deadline" name="deadline" value="${ticket.deadline}" required>
        </div>

        <div class="form-row">
            <label for="assignedPerson">担当者:</label>
            <input type="text" id="assignedPerson" name="assignedPerson" value="${ticket.assignedPerson}" required>
        </div>

        <div class="form-row">
            <label for="importance">重要度:</label>
            <select id="importance" name="importance" required>
                <option value="低" <c:if test="${ticket.importance == '低'}">selected</c:if>>低</option>
                <option value="中" <c:if test="${ticket.importance == '中'}">selected</c:if>>中</option>
                <option value="高" <c:if test="${ticket.importance == '高'}">selected</c:if>>高</option>
            </select>
        </div>

        <div class="form-row">
            <label for="category">カテゴリ:</label>
            <input type="text" id="category" name="category" value="${ticket.category}" required>
        </div>

        <div class="form-row">
            <label for="progress">進捗:</label>
            <input type="number" id="progress" name="progress" value="${ticket.progress}" min="0" max="100" required>
        </div>

        <!-- ボタン -->
        <div class="button-container">
            <button type="submit" name="action" value="update">修正</button>
            <button type="button" onclick="closeTicketDetail()">閉じる</button>
        </div>
        
    </form>
</div>
    
	<form action="DeleteTicketServlet" method="post" onsubmit="return confirmDelete();">
	    <input type="hidden" name="ticketId" value="${ticket.ticketId}">
	    <div class="button-container">
	        <button type="submit" name="action" value="delete">削除</button>
	    </div>
	</form>

	<script>
	    function confirmDelete() {
	        return confirm("本当にこのチケットを削除しますか？"); // 確認ダイアログを表示
	    }
	</script>

    

    <script>
        function closeTicketDetail() {
            var previousPage = '${sessionScope.currentPage}';
            window.location.href = previousPage;
        }
    </script>
</body>
</html>
