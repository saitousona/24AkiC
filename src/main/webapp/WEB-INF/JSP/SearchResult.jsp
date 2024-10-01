<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>検索結果</title>
</head>
<body>
    <h1>検索結果</h1>

    <c:if test="${empty searchResults}">
        <p>該当するチケットがありません。</p>
    </c:if>

    <c:forEach var="ticket" items="${searchResults}">
        <p>タイトル: ${ticket.title}, 進捗: ${ticket.progress}, 重要度: ${ticket.importance}, カテゴリー: ${ticket.category}</p>
    </c:forEach>

    <a href="MainToDoServlet">全件表示に戻る</a>
</body>
</html>
