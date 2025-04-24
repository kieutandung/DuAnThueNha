<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register User</title>
</head>
<body>
<form action="/register" method="post">
    <label>name:<input type="text" name="name"></label><br>
    <label>password:<input type="password" name="password"></label><br>
    <label>email:<input type="email" name="email"></label><br>
    <button type="submit">Register</button>
</form>
</body>
</html>
