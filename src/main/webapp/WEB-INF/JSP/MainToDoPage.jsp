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
                $('#ticketDetailForm').html(`
                    <h2>新規チケット作成</h2>
                    <button onclick="closeTicketDetail()">閉じる</button>
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
                    url: 'GetTicketDetailServlet',
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

        // 検索フォームの表示・非表示を切り替える関数
        function toggleSearchOptions() {
            var searchOptions = $('#searchOptions');
            var toggleButton = $('#toggleSearchButton');
            
            if (searchOptions.is(':visible')) {
                searchOptions.hide(); // 非表示にする
                toggleButton.text('検索オプションを表示');
            } else {
                searchOptions.show(); // 表示する
                toggleButton.text('検索オプションを閉じる');
            }
        }

        // 検索を実行する関数
        function performSearch() {
            var searchCriteria = $('input[name="criteria"]:checked').val();
            var searchText = $('#searchText').val();
            var email = $('input[name="email"]').val(); // email フィールドを取得
        
            $.ajax({
                url: 'SearchTicketServlet',
                type: 'POST',
                data: {
                    criteria: searchCriteria,
                    searchText: searchText,
                    email: email
                },
                success: function(data) {
                    $('#searchResults').html(data); // 検索結果を表示
                    $('#ticketList').hide(); // 全件表示エリアを非表示にする
                },
                error: function() {
                    alert('検索に失敗しました。');
                }
            });
            return false; // フォームの送信を防ぐ
        }

        // 検索解除関数
        function resetSearch() {
            $('#searchResults').empty(); // 検索結果をクリア
            $('#ticketList').show(); // 全件表示エリアを再表示
        }

    </script>
    <style>
        .ticket-detail {
            display: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="left-pane">
            <h2>検索</h2>
            <button id="toggleSearchButton" onclick="toggleSearchOptions()">検索オプションを表示</button>
            <div id="searchOptions" style="display:none;">
                <form onsubmit="return performSearch();">
                    <label>検索条件:</label><br>
                    <input type="hidden" name="email" value="${sessionScope.email}">
                    <input type="radio" name="criteria" value="title"> タイトル
                    <input type="radio" name="criteria" value="assigned_Person"> 担当者
                    <input type="radio" name="criteria" value="category"> カテゴリー
                    <br><br>
                    <label for="searchText">検索文字列:</label>
                    <input type="text" id="searchText" name="searchText">
                    <input type="submit" value="検索">
                </form>
                <button onclick="resetSearch()">検索解除</button>
            </div>
            <br>
            <a href="displayOtherPage.jsp">表示切替</a>
            <br>
            <button onclick="loadTicketDetail('new')">起票</button>
        </div>

        <div class="right-pane">
            <h2>チケット一覧</h2>
            <div id="ticketList">
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
    </div>

    <div class="ticket-detail" id="ticketDetailForm">
        <button onclick="closeTicketDetail()">閉じる</button>
    </div>

    <div id="searchResults">
        <!-- 検索結果がここに表示される -->
    </div>
</body>
</html>
