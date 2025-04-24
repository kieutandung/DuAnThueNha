<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit User</title>
</head>
<body>
<form action="/editUser" method="post">
    <input type="hidden" name="id" value="${user.id}">
    <label>Name: <input type="text" name="name" value="${user.name}"></label><br>
    <label>Email: <input type="email" name="email" value="${user.email}"></label><br>
    <label>Password: <input type="password" name="password" value="${user.password}"></label><br>
    <label>Address: <input type="text" name="address" value="${user.address}"></label><br>
    <button type="submit">submit</button>
</form>
</body>
</html>
