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
        <p>タイトル: ${ticket.title}, 締め切り: ${ticket.deadline}, 担当者: ${ticket.assignedPerson}, 重要度: ${ticket.importance}, カテゴリー: ${ticket.category}, 進捗: ${ticket.progress}</p>
    </c:forEach>
    

    
    <%
    // 現在のページURLをセッションに保存
    HttpSession userSession = request.getSession(); // 変数名を変更
    String currentPage = (String) userSession.getAttribute("currentPage");
	%>

    <a href="<%= currentPage %>">全件表示に戻る</a>
</body>
</html>
