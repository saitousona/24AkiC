<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <link rel="stylesheet" type="text/css" href="CSS/style.css"> <!-- CSSの読み込み -->

    <title>検索結果</title>
    <style>
        /* SearchResultPage.css */
        .result-container {
            width: 100%; /* 幅を100%に設定 */
            padding: 1em;
            background-color: #f9f9f9; /* 背景色を設定 */
            border-radius: 8px;
        }

        /* 結果ラベルとデータを整列させる */
        .result-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1em;
        }

        .result-label {
            font-weight: bold;
            width: 100px; /* ラベルの幅を固定 */
        }

        .result-data {
            flex-grow: 1;
            text-align: left;
        }

        /* 戻るリンクのスタイル */
        .switch-link {
            display: inline-block; /* インラインブロック要素として表示 */
            margin-top: 1em; /* 上にマージンを追加 */
            text-align: left; /* 左寄せ */
            color: #007BFF; /* リンク色 */
            text-decoration: none; /* 下線を消す */
        }
        
        .switch-link:hover {
            text-decoration: underline; /* ホバー時に下線を表示 */
        }
    </style>
</head>
<body>
    <h1>検索結果</h1>

    <div class="container"> <!-- 全体を囲むコンテナ -->
        <div class="result-container">
            <c:if test="${empty searchResults}">
                <p>該当するチケットがありません。</p>
            </c:if>

            <c:forEach var="ticket" items="${searchResults}">
                <div class="result-row">
                    <span class="result-label">タイトル:</span>
                    <span class="result-data">${ticket.title}</span>
                </div>
                <div class="result-row">
                    <span class="result-label">締め切り:</span>
                    <span class="result-data">${ticket.deadline}</span>
                </div>
                <div class="result-row">
                    <span class="result-label">担当者:</span>
                    <span class="result-data">${ticket.assignedPerson}</span>
                </div>
                <div class="result-row">
                    <span class="result-label">重要度:</span>
                    <span class="result-data">${ticket.importance}</span>
                </div>
                <div class="result-row">
                    <span class="result-label">カテゴリー:</span>
                    <span class="result-data">${ticket.category}</span>
                </div>
                <div class="result-row">
                    <span class="result-label">進捗:</span>
                    <span class="result-data">${ticket.progress}</span>
                </div>
            </c:forEach>

            <%
            // 現在のページURLをセッションに保存
            HttpSession userSession = request.getSession();
            String currentPage = (String) userSession.getAttribute("currentPage");
            %>

            <a href="<%= currentPage %>" class="switch-link">全件表示に戻る</a>
        </div>
    </div>
</body>
</html>
