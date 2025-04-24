<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Danh sách sản phẩm</title>
    <style>
        td,th {
            border: 1px solid #999;
        }
    </style>
</head>
<body>
<h2>Danh sách người dùng</h2>
<form action="/search" method="get" style="margin-bottom: 10px;">
    <input type="text" name="keyword" placeholder="Tìm kiếm...">
    <button type="submit">Search</button>
</form>
<a href="/userForm">Add user</a><br>
<table>
    <thead>
    <tr>
        <th>Id</th>
        <th>Tên</th>
        <th>Email</th>
        <th>Địa chỉ</th>
        <th></th>
        <th></th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="user" items="${users}">
        <tr>
            <td>${user.id}</td>
            <td>${user.name}</td>
            <td>${user.email}</td>
            <td>${user.address}</td>
            <td><a href="/edit/${user.id}">edit</a></td>
            <td>
                <a href="/delete/${user.id}" onclick="return confirm('Xác nhận xóa?')">Delete</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
