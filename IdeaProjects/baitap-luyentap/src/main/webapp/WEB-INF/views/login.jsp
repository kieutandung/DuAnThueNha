<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đăng nhập</title>
</head>
<body>
<form action="/login" method="post">
    <label>Tên đăng nhập: <input type="text" name="name" /></label><br>
    <label>Mật khẩu: <input type="password" name="password" /></label><br>
    <button type="submit">Login</button>
</form>
</body>
</html>
