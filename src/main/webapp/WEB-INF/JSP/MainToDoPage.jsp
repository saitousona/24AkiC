<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>ToDo管理</title>
    <link rel="stylesheet" type="text/css" href="styles.css"> <!-- CSSの読み込み -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQueryの読み込み -->
    <script>
        // チケット詳細を取得する関数
        function loadTicketDetail(ticketId) {
            if (ticketId === 'new') {
                // 新規作成用のフォームを表示
                $('#ticketDetailForm').html(`
                    <h2>新規チケット作成</h2>
                    <button onclick="closeTicketDetail()">閉じる</button> <!-- 閉じるボタン追加 -->
                    <form action="FixOrCreateTicketServlet" method="post">
                        <input type="hidden" name="ticketId" value="">
                        <input type="hidden" name="email" value="${sessionScope.email}"> <!-- Emailを渡す -->
                        <label for="title">タイトル:</label>
                        <input type="text" id="title" name="title" value="">
                        <label for="deadline">締め切り:</label>
                        <input type="date" id="deadline" name="deadline" value="">
                        <label for="assignedPerson">担当者:</label>
                        <input type="text" id="assignedPerson" name="assignedPerson" value="">
                        <label for="importance">重要度:</label>
                        <select id="importance" name="importance">
                            <option value="低">低</option>
                            <option value="中">中</option>
                            <option value="高">高</option>
                        </select>
                        <label for="category">カテゴリー:</label>
                        <input type="text" id="category" name="category" value="">
                        <label for="progress">進捗:</label>
                        <input type="number" id="progress" name="progress" value="">
                        <button type="submit" name="action" value="create">作成</button>
                    </form>
                `);
                $('#ticketDetailForm').show(); // 詳細エリアを表示
            } else {
                $.ajax({
                    url: 'GetTicketDetailServlet', // チケット詳細を取得するServletのURL
                    type: 'GET',
                    data: { id: ticketId },
                    success: function(data) {
                        $('#ticketDetailForm').html(data);
                        $('#ticketDetailForm').show(); // 詳細エリアを表示
                    },
                    error: function() {
                        alert('チケットの詳細を取得できませんでした。');
                    }
                });
            }
        }

        // 詳細を閉じる関数
        function closeTicketDetail() {
            $('#ticketDetailForm').hide(); // 詳細エリアを非表示
        }
    </script>
    <style>
        .ticket-detail {
            display: none; /* 最初は非表示 */
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="left-pane">
            <h2>検索</h2>
            <form action="searchTickets.jsp" method="get">
                <label for="searchCriteria">条件:</label>
                <input type="text" id="searchCriteria" name="searchCriteria">
                <input type="submit" value="検索">
            </form>
            <br>
            <a href="displayOtherPage.jsp">表示切替</a>
            <br>
            <button onclick="loadTicketDetail('new')">起票</button> <!-- 新規作成ボタン -->
        </div>

        <div class="right-pane">
            <h2>チケット一覧</h2>

            <h3>未進行 (0%)</h3>
            <c:forEach var="ticket" items="${notStartedTickets}">
                <div>
                    <a href="javascript:void(0);" onclick="loadTicketDetail(${ticket.ticketId})">${ticket.title}</a> - ${ticket.deadline}
                </div>
            </c:forEach>
            <c:if test="${empty notStartedTickets}">
                <div>未進行のチケットはありません。</div>
            </c:if>

            <h3>進行中 (1% - 99%)</h3>
            <c:forEach var="ticket" items="${inProgressTickets}">
                <div>
                    <a href="javascript:void(0);" onclick="loadTicketDetail(${ticket.ticketId})">${ticket.title}</a> - ${ticket.deadline}
                </div>
            </c:forEach>
            <c:if test="${empty inProgressTickets}">
                <div>進行中のチケットはありません。</div>
            </c:if>

            <h3>完了 (100%)</h3>
            <c:forEach var="ticket" items="${completedTickets}">
                <div>
                    <a href="javascript:void(0);" onclick="loadTicketDetail(${ticket.ticketId})">${ticket.title}</a> - ${ticket.deadline}
                </div>
            </c:forEach>
            <c:if test="${empty completedTickets}">
                <div>完了したチケットはありません。</div>
            </c:if>
        </div>
    </div>

    <div class="ticket-detail" id="ticketDetailForm">
        <!-- チケット詳細がここに表示される -->
        <button onclick="closeTicketDetail()">閉じる</button> <!-- 閉じるボタン -->
    </div>
</body>
</html>
