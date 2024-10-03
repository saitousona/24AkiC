<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>ログイン</title>
    <link rel="stylesheet" href="CSS/style.css">
   <script>
        function buttonclick() {
            // アクションURLを設定
            document.myform.action = "<%= request.getContextPath() %>/LoginServlet";
            // フォームを送信
            document.myform.submit();
        }
        function validateForm() {
            let userId = document.forms["loginForm"]["email"].value;
            let password = document.forms["loginForm"]["password"].value;
            if (userId == "" || password == "") {
                document.getElementById("error").innerText = "ユーザーIDとパスワードを入力してください";
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
	<!-- 背景要素 -->
	<div class="bg_pattern Polka_v2"></div> 
	<div class="container">

    <h2>ログイン</h2>
	<form name="myform" action="<%= request.getContextPath() %>/LoginServlet" method="post">
	    <div>
	        <label for="email">ユーザーID:</label>
	        <input type="text" id="email" name="email">
	    </div>
	    <div>
	        <label for="password">パスワード:</label>
	        <input type="password" id="password" name="password">
	    </div>
	    <div>
	        <input type="button" value="ログイン" class="login-bottan" onclick="buttonclick();" ><br/>
	    </div>
	</form>
    <div id="error" style="color:red;">
        <% if (request.getAttribute("errorMessage") != null) { %>
            <%= request.getAttribute("errorMessage") %>
        <% } %>
        <br/>
        <a href="HTML/ResetPasswordPage.html" class="button">パスワードリセット</a>
        &nbsp;
         <%-- スペース　--%>
        <a href="HTML/CreateUserPage.html" class="button">ユーザー作成</a>
    </div>
    
</body>
</html>