<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.example.duanthuenha.Model.Users" %>
<html>
<head>
    <title>Danh sách tài khoản</title>
</head>
<header>
    <jsp:include page="menu.jsp"/>
</header>
<link rel="stylesheet" href="/css/account.css">
<script src="/js/account.js"></script>
<body>
<div class="actions">
    <div class="left">
        <a href="adminServlet?action=addUser" class="button add">Thêm Người Dùng</a>
        <a href="adminServlet?action=sort" class="button sort">Sắp Xếp</a>
    </div>
    <div class="right">
        <form action="adminServlet?action=search" method="get">
            <input type="text" name="name" class="inputSearch" placeholder="Tìm Kiếm">
            <input type="hidden" name="action" value="search">
            <button type="submit" class="button search">Tìm Kiếm</button>
        </form>
    </div>
</div>
<div class="table">
    <table>
        <thead>
        <tr>
            <th>Ảnh Đại Diện</th>
            <th>Tên Người Dùng</th>
            <th>Email</th>
            <th>Số Điện Thoại</th>
            <th>Vai trò</th>
            <th>Trạng Thái</th>
            <th>Thao Tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${users}" var="user">
            <tr>
                <td><img src="img/${user.image}" alt="User Image" width="50" height="50"></td>
                <td>${user.fullName}</td>
                <td>${user.email}</td>
                <td>${user.phone}</td>
                <td>${user.role}</td>
                <td>${user.status}</td>
                <td>
                    <button class="button change" onclick="changeStatus(${user.idUser})">Edit</button>
                    <button class="button delete" onclick="deleteUser(${user.idUser})">Delete</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
