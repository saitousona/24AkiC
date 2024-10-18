<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ログイン</title>
    <link rel="stylesheet" href="CSS/style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 100%;
            max-width: 500px;
            margin: 100px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
            color: #333;
        }

        p {
            text-align: center;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .form-container {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        label {
            font-size: 14px;
            margin-bottom: 5px;
        }

        .form-control {
            padding: 10px;
            font-size: 14px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }

        .btn {
            display: inline-block; /* ボタンのように表示 */
            background-color: #007bff; /* 背景色 */
            color: white; /* テキスト色 */
            border: none; /* ボーダーなし */
            border-radius: 5px; /* 角の丸み */
            padding: 12px 20px; /* 内部の余白 */
            cursor: pointer; /* カーソルをポインタに */
            font-size: 16px; /* フォントサイズ */
            transition: background-color 0.3s ease; /* 背景色のトランジション */
            text-align: center; /* テキストを中央揃え */
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .links {
            text-align: center;
            margin-top: 20px;
        }

        .links a {
            color: #007BFF;
            text-decoration: none;
        }

        .links a:hover {
            text-decoration: underline;
        }

        #error {
            margin-top: 15px;
            text-align: center;
            font-size: 14px;
            color: red;
        }

        /* FAQリンクのスタイル */
        .footer-links {
            text-align: center;
            margin-top: 30px;
            font-size: 14px;
        }

        .footer-links a {
            color: #007BFF;
            text-decoration: none;
        }

        .footer-links a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        // Enterキーでログインボタンを押す処理
        document.addEventListener("DOMContentLoaded", function() {
            document.getElementById("myform").addEventListener("keydown", function(event) {
                if (event.key === "Enter") {
                    buttonclick();
                    event.preventDefault();
                }
            });
        });

        // ログインボタンを押したときの処理
        function buttonclick() {
            if (validateForm()) {
                document.myform.action = "<%= request.getContextPath() %>/LoginServlet";
                document.myform.submit();
            }
        }

        // フォームバリデーション
        function validateForm() {
            let email = document.forms["myform"]["email"].value;
            let password = document.forms["myform"]["password"].value;

            if (email === "" || password === "") {
                document.getElementById("error").innerText = "メールアドレスとパスワードを入力してください";
                return false;
            }

            // メールアドレスの簡単なバリデーション
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                document.getElementById("error").innerText = "有効なメールアドレスを入力してください";
                return false;
            }

            // パスワードのバリデーション: 特定の記号 <>'& をチェックし、含まれている場合エラーメッセージを表示
            if (/[<>&']/.test(password)) {
                document.getElementById("error").innerText = "パスワードに <, >, ', & を含めることはできません";
                return false;
            }

            if (password.length < 8) {
                document.getElementById("error").innerText = "パスワードは8文字以上にしてください";
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>アカウントログイン</h2>
        <p>アカウントをお持ちの方は、下記フォームに情報を入力してください。</p>

        <form name="myform" id="myform" method="post" class="form-container">
            <div class="form-group">
                <label for="email">メールアドレス:</label>
                <input type="text" id="email" name="email" class="form-control">
            </div>
            <div class="form-group">
                <label for="password">パスワード:</label>
                <input type="password" id="password" name="password" class="form-control">
            </div>
            <div class="form-group">
                <input type="button" value="ログイン" class="btn login-btn" onclick="buttonclick();">
            </div>
        </form>

        <!-- エラーメッセージ表示エリア -->
        <div id="error">
            <% 
                String errorMessage = (String) session.getAttribute("errorMessage");
                if (errorMessage != null) {
                    out.println(errorMessage);
                    session.removeAttribute("errorMessage");
                }
            %>
        </div>

        <!-- ユーザー操作のリンク -->
        <div class="links">
            <p>アカウントをお持ちでない方は、<a href="HTML/CreateUserPage.html" class="link">新規作成</a>してください。</p>
            <p>パスワードを忘れた方は、<a href="HTML/ResetPasswordPage.html" class="link">こちらからリセット</a>してください。</p>
        </div>

        <!-- FAQページへのリンクをフッターに追加 -->
        <div class="footer-links">
            <p>よくある質問は<a href="HTML/FAQ.html">こちら</a>をご覧ください。</p>
        </div>
    </div>
</body>
</html>