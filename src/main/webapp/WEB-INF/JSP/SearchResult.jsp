<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <link rel="stylesheet" type="text/css" href="CSS/style.css"> <!-- CSSの読み込み -->

    <title>検索結果</title>
    <style>
        /* 検索結果のスタイル */
        .result-container {
            width: 500px;
            margin: 0 auto;
            padding: 1em;
            background-color: #f9f9f9;
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
            width: 100px;
        }

        .result-data {
            flex-grow: 1;
            text-align: left;
        }

        /* 戻るリンクのスタイル */
        .switch-link {
            display: block;
            margin-top: 1em;
            text-align: right;
            color: #007BFF;
            text-decoration: none;
        }

        .switch-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h1>検索結果</h1>

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
    </div>

    <%
    // 現在のページURLをセッションに保存
    HttpSession userSession = request.getSession(); // 変数名を変更
    String currentPage = (String) userSession.getAttribute("currentPage");
    %>

    <a href="<%= currentPage %>" class="switch-link">全件表示に戻る</a>

</body>
</html>
