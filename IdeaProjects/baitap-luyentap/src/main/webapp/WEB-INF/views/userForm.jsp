<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add User</title>
</head>
<body>
<form action="/addUser" method="post">
    <label>Id:<input type="number" name="id"></label><br>
    <label>Name:<input type="text" name="name"></label><br>
    <label>Email:<input type="text" name="email"></label><br>
    <label>Address:<input type="text" name="address"></label><br>
    <button type="submit">Create</button>
</form>
</body>
</html>
