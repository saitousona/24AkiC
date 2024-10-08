<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>ToDo管理</title>
    <link rel="stylesheet" type="text/css" href="CSS/style.css"> <!-- CSSの読み込み -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQueryの読み込み -->
<%
    // 現在のページURLをセッションに保存
    HttpSession userSession = request.getSession(); // 変数名を変更
    userSession.setAttribute("currentPage", "MainToDoServlet");
%>

    <h1>${userName}さんのToDoリスト</h1>
    
    <script>
        // チケット詳細を取得する関数
        function loadTicketDetail(ticketId) {
            if (ticketId === 'new') {
                // 新規作成用のフォームを表示
                $('#ticketDetailForm').html(`
                    <h2>新規チケット作成</h2>
                    <button onclick="closeTicketDetail()">閉じる</button>
                    <form id="ticketForm" action="FixOrCreateTicketServlet" method="post">
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
                        <input type="number" id="progress" name="progress" min="0" max="100" value="">
                        <span id="progressError" style="color:red;"></span>
                        <button type="submit" onclick="return validateProgress();" name="action" value="create">作成</button>
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

        // 進捗のバリデーション
        function validateProgress() {
            var progress = $('#progress').val();
            var progressError = $('#progressError');

            if (progress < 0 || progress > 100) {
                progressError.text('進捗は0から100の範囲で入力してください。');
                return false; // バリデーション失敗
            }

            progressError.text(''); // エラーメッセージをクリア
            return true; // バリデーション成功
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
                    $('#ticketDetailForm').html(data); // 検索結果を右側の詳細エリアに表示
                    $('#ticketDetailForm').show(); // 詳細エリアを表示
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
        <style>
			.container {
			    display: grid;
			    grid-template-columns: 0.8fr 1.8fr 1.4fr; /* 左を小さくし、中央と右に余裕を持たせる */
			    gap: 20px;
			    padding: 20px;
			    font-family: 'Arial', sans-serif;
			    height: 100vh; /* ビューポートの高さに合わせる */
			}
			
			.left-pane, .center-pane, .right-pane {
			    height: 100%; /* 各枠の高さを画面全体に合わせる */
			}
			
			.left-pane {
			    background-color: #f0f4f8;
			    padding: 20px;
			    border-radius: 10px;
			    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
			}
			
			.center-pane {
			    display: flex;
			    justify-content: space-between;
			    background-color: #fff;
			    padding: 20px;
			    border-radius: 10px;
			    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
			}
			
			.ticket-column {
			    width: 30%;
			    text-align: left;
			}
			
			.ticket-column h3 {
			    font-size: 1.2em;
			    color: #333;
			    border-bottom: 2px solid #ddd;
			    padding-bottom: 10px;
			    margin-bottom: 10px;
			}
			
			.ticket-column div {
			    margin: 5px 0;
			}
			
			.ticket-column a {
			    color: #007bff;
			    text-decoration: none;
			}
			
			.ticket-column a:hover {
			    text-decoration: underline;
			}
			
			.right-pane {
			    background-color: #f9f9f9;
			    padding: 20px;
			    border-radius: 10px;
			    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
			    display: none; /* デフォルトは非表示 */
			    height: 100%; /* 高さを画面全体にフィットさせる */

			}
			
			button {
			    background-color: #007bff;
			    color: white;
			    border: none;
			    padding: 10px 20px;
			    border-radius: 5px;
			    cursor: pointer;
			}
			
			button:hover {
			    background-color: #0056b3;
			}
			
			.ticket-card {
			    background-color: #f5f5f5;
			    border-radius: 10px;
			    padding: 10px;
			    margin-bottom: 10px;
			    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
			    transition: background-color 0.3s;
			}
			
			.ticket-card:hover {
			    background-color: #e0e0e0;
			}
			
			.ticket-title {
			    font-weight: bold;
			    font-size: 1.2em;
			    margin-bottom: 5px;
			}
			
			.ticket-deadline {
			    color: #666;
			    font-size: 0.9em;
			}
			
			.ticket-card {
			    padding: 10px;
			    margin: 5px;
			    border-radius: 5px;
			    cursor: pointer;
			}
			
			/* 未進行のチケット */
			.not-started {
			    background-color: white; /* 未進行は白 */
			    border: 1px solid #ccc;  /* 薄いグレーのボーダー */
			}
			
			/* 進行中のチケット */
			.in-progress {
			    background-color: #d1ecf1; /* 薄い青 */
			}
			
			/* 完了のチケット */
			.completed {
			    background-color: lightgray; /* 完了はグレー */
			}
    </style>
</head>
<body>
	<div class="container">
	    <div class="left-pane">
	        <!-- 左側の検索・オプション・起票・ログアウトボタン -->
	        <h2>操作</h2>
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
	        <a href="ImportanceToDoServlet" class="switch-link">表示切替</a><br>
	        <button onclick="loadTicketDetail('new')">起票</button> <!-- 新規作成ボタン -->
	        <form action="LogoutServlet" method="post">
	            <button type="submit">ログアウト</button>
	        </form>
	    </div>
	    
	
	    <div class="center-pane">
	        <!-- 真ん中にチケットの一覧を進行度別に表示 -->
			<div class="ticket-column">
			    <h3>未進行 (0%)</h3>
			    <c:forEach var="ticket" items="${notStartedTickets}">
			        <div class="ticket-card ${ticket.progress == 0 ? 'not-started' : ticket.progress == 100 ? 'completed' : 'in-progress'}">
			            <a href="javascript:void(0);" onclick="loadTicketDetail(${ticket.ticketId})">
			                <div class="ticket-title">${ticket.title}</div>
			                <div class="ticket-deadline">${ticket.deadline}</div>
			            </a>
			        </div>
			    </c:forEach>
			    <c:if test="${empty notStartedTickets}">
			        <div>未進行のチケットはありません。</div>
			    </c:if>
			</div>
			
			<div class="ticket-column">
			    <h3>進行中 (1% - 99%)</h3>
			    <c:forEach var="ticket" items="${inProgressTickets}">
			        <div class="ticket-card ${ticket.progress == 0 ? 'not-started' : ticket.progress == 100 ? 'completed' : 'in-progress'}">
			            <a href="javascript:void(0);" onclick="loadTicketDetail(${ticket.ticketId})">
			                <div class="ticket-title">${ticket.title}</div>
			                <div class="ticket-deadline">${ticket.deadline}</div>
			            </a>
			        </div>
			    </c:forEach>
			    <c:if test="${empty inProgressTickets}">
			        <div>進行中のチケットはありません。</div>
			    </c:if>
			</div>
			
			<div class="ticket-column">
			    <h3>完了 (100%)</h3>
			    <c:forEach var="ticket" items="${completedTickets}">
			        <div class="ticket-card ${ticket.progress == 0 ? 'not-started' : ticket.progress == 100 ? 'completed' : 'in-progress'}">
			            <a href="javascript:void(0);" onclick="loadTicketDetail(${ticket.ticketId})">
			                <div class="ticket-title">${ticket.title}</div>
			                <div class="ticket-deadline">${ticket.deadline}</div>
			            </a>
			        </div>
			    </c:forEach>
			    <c:if test="${empty completedTickets}">
			        <div>完了したチケットはありません。</div>
			    </c:if>
			</div>

	    </div>
	
	    <div id="ticketDetailForm" class="right-pane ticket-detail">
	        <!-- クリックしたチケットの詳細がここに表示される -->
	    </div>
	    <div id="searchResults">
	        <!-- 検索結果がここに表示される -->
	    </div>
	</div>
</body>
</html>