<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.example.duanthuenha.Service.Admin.ListAccountImpl" %>
<%@ page import="java.util.List" %>
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
    <button class="button add" onclick="addUser()">Thêm</button>
    <button class="button sort" onclick="sortUsers()">Sắp Xếp</button>
    <input type="text" id="search" placeholder="Tìm Kiếm" onkeyup="searchUsers()">
    <button class="button search" >Tìm kiếm</button>
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
        <%
            ListAccountImpl listAccountService = new ListAccountImpl();
            List<Users> users = listAccountService.getAllUser();
            request.setAttribute("users", users);
        %>

        <c:forEach items="${users}" var="user">
            <tr>
                <td><img src="img/${user.image}" alt="User Image"></td>
                <td id="name">${user.fullName}</td>
                <td id="email">${user.email}</td>
                <td>${user.role}</td>
                <td>${user.phone}</td>
                <td>${user.status}</td>
                <td>
                    <button class="button change" onclick="changeStatus(${user.idUser})">Change Status</button>
                    <button class="button delete" onclick="deleteUser(${user.idUser})">Delete</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
