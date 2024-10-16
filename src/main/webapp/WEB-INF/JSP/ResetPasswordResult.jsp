<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="CSS/style.css"> <!-- CSSの読み込み -->
    <title>パスワード変更結果</title>
</head>
<body>
    <div class="bg_pattern Polka_v2"></div> 
<% String successMessage = (String) request.getAttribute("successMessage"); %>
<% String errorMessage = (String) request.getAttribute("errorMessage"); %>

<% if (successMessage != null) { %>
    <h3><%= successMessage %></h3>
<% } %>

<% if (errorMessage != null) { %>
    <h3 style="color:red;"><%= errorMessage %></h3>
<% } %>

<a href="TopPageServlet">戻る</a>
</body>
</html>
