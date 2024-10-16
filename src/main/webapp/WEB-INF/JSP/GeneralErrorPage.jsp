<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="CSS/style.css"> <!-- CSSの読み込み -->
    <title>エラー - システムメンテナンス</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            text-align: center;
            padding: 50px;
        }
        .error-container {
            background-color: white;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            display: inline-block;
        }
        h1 {
            color: #d9534f; /* エラーメッセージの色 */
        }
        p {
            font-size: 1.2em;
        }
        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #5bc0de;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .btn:hover {
            background-color: #31b0d5;
        }
    </style>
</head>
<body>
    <div class="bg_pattern Polka_v2"></div>
    <div class="error-container">

        <p>現在、システムに問題が発生しています。しばらくしてから再度お試しください。</p>
        <p>もし問題が解決しない場合は、管理者にご連絡ください。</p>
        <a href="TopPageServlet" class="btn">ホームに戻る</a> <!-- ホームに戻るボタン -->
    </div>
</body>
</html>
