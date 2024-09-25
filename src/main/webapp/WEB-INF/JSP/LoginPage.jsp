<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>ログイン</title>
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
	        <input type="button" value="ログイン" onclick="buttonclick();">
	    </div>
	</form>
    <div id="error" style="color:red;">
        <% if (request.getAttribute("errorMessage") != null) { %>
            <%= request.getAttribute("errorMessage") %>
        <% } %>
    </div>
</body>
</html>