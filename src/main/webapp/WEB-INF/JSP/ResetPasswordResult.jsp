<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>パスワード変更結果</title>
</head>
<body>
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
