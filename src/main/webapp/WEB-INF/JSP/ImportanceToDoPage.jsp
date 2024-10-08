<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>ToDo管理</title>
    <link rel="stylesheet" type="text/css" href="styles.css"> <!-- CSSの読み込み -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQueryの読み込み -->
    
    <%
        // 現在のページURLをセッションに保存
        HttpSession userSession = request.getSession();
        session.setAttribute("currentPage", "ImportanceToDoServlet");
    %>
    
    <h1>${userName}さんのToDoリスト</h1>
    
    <script>
        // チケット詳細を取得する関数
        function loadTicketDetail(ticketId) {
            console.log("Current Page:", '<%= request.getRequestURI() %>');
            
            if (ticketId === 'new') {
                $('#ticketDetailForm').html(`
                    <h2>新規チケット作成</h2>
                    <button onclick="closeTicketDetail()">閉じる</button>
                    <form action="FixOrCreateTicketServlet" method="post">
                    <input type="hidden" name="currentPage" value="<%= request.getRequestURI() %>">
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

        // 検索フォームを表示・非表示に切り替える関数
        function toggleSearchOptions() {
            var searchOptions = $('#searchOptions');
            var toggleButton = $('#toggleSearchButton'); // ボタンのIDを取得
            
            if (searchOptions.is(':visible')) {
                searchOptions.hide(); // 非表示にする
                toggleButton.text('検索オプションを表示'); // ボタンのテキストを「表示」に変更
            } else {
                searchOptions.show(); // 表示する
                toggleButton.text('検索オプションを閉じる'); // ボタンのテキストを「閉じる」に変更
            }
        }

        // 検索を実行する関数
        function performSearch() {
            var searchCriteria = $('input[name="criteria"]:checked').val();
            var searchText = $('#searchText').val();
            var email = $('input[name="email"]').val(); // email フィールドを取得
        
            // 検索条件をパラメータとして送信
            $.ajax({
                url: 'SearchTicketServlet', // ServletのURLを指定
                type: 'POST', // POSTメソッドを使用
                data: {
                    criteria: searchCriteria, // 検索条件
                    searchText: searchText, // 検索文字列
                    email: email // email を追加
                },
                success: function(data) {
                    $('#searchResults').html(data); // JSPからの結果を表示
                },
                error: function() {
                    alert('検索に失敗しました。');
                }
            });
            return false; // フォームの送信を防ぐ
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
            </div>
            <br>
            <a href="MainToDoServlet">表示切替</a>
            <br>
            <button onclick="loadTicketDetail('new')">起票</button> <!-- 新規作成ボタン -->
        </div>

        <div class="right-pane">
            <h2>チケット一覧</h2>

            <h3>高重要度</h3>
            <c:set var="hasHighImportance" value="false" />
            <c:forEach var="ticket" items="${tickets}">
                <c:if test="${ticket.importance == '高'}">
                    <div>
                        <a href="javascript:void(0);" onclick="loadTicketDetail(${ticket.ticketId})">${ticket.title}</a> - ${ticket.deadline}
                    </div>
                    <c:set var="hasHighImportance" value="true" /> <!-- フラグを設定 -->
                </c:if>
            </c:forEach>
            <c:if test="${!hasHighImportance}">
                <div>高重要度のチケットはありません。</div>
            </c:if>
            
            <h3>中重要度</h3>
            <c:set var="hasMediumImportance" value="false" />
            <c:forEach var="ticket" items="${tickets}">
                <c:if test="${ticket.importance == '中'}">
                    <div>
                        <a href="javascript:void(0);" onclick="loadTicketDetail(${ticket.ticketId})">${ticket.title}</a> - ${ticket.deadline}
                    </div>
                    <c:set var="hasMediumImportance" value="true" /> <!-- フラグを設定 -->
                </c:if>
            </c:forEach>
            <c:if test="${!hasMediumImportance}">
                <div>中重要度のチケットはありません。</div>
            </c:if>
            
            <h3>低重要度</h3>
            <c:set var="hasLowImportance" value="false" />
            <c:forEach var="ticket" items="${tickets}">
                <c:if test="${ticket.importance == '低'}">
                    <div>
                        <a href="javascript:void(0);" onclick="loadTicketDetail(${ticket.ticketId})">${ticket.title}</a> - ${ticket.deadline}
                    </div>
                    <c:set var="hasLowImportance" value="true" /> <!-- フラグを設定 -->
                </c:if>
            </c:forEach>
            <c:if test="${!hasLowImportance}">
                <div>低重要度のチケットはありません。</div>
            </c:if>

        </div>
        <form action="LogoutServlet" method="post">
            <input type="submit" value="ログアウト">
        </form>        
    </div>

    <div class="ticket-detail" id="ticketDetailForm">
        <!-- チケット詳細がここに表示される -->
        <button onclick="closeTicketDetail()">閉じる</button> <!-- 閉じるボタン -->
    </div>

    <div id="searchResults">
        <!-- 検索結果がここに表示される -->
    </div>
</body>
</html>
