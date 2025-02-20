<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.example.duanthuenha.Service.Admin.ListAccountImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.duanthuenha.Model.Users" %>
<html>
<head>
    <title>Danh sách tài khoản</title>
    <style>
        .actions {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .button {
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            border: none;
            color: white;
            margin-right: 5px;
        }

        .button.add {
            background-color: #4CAF50;
        }

        .button.sort {
            background-color: #008CBA;
        }

        .button.search {
            background-color: #f44336;
        }
    </style>
</head>
<header>
    <jsp:include page="menu.jsp"/>
</header>
<link rel="stylesheet" href="/css/account.css">
<script src="/js/account.js"></script>
<body>
<div class="actions">
    <div class="left">
        <button class="button add" onclick="addUser()">Thêm Người Dùng</button>
        <button class="button sort" onclick="sortUsers()">Sắp Xếp</button>
    </div>
    <div class="right">
        <form action="adminServlet?action=search" method="get">
            <input type="text" name="name" placeholder="Tìm Kiếm">
            <input type="hidden" name="action" value="search">
            <button type="submit" class="button search">Tìm kiếm</button>
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
                <td><img src="img/${user.image}" alt="User Image"></td>
                <td id="name">${user.fullName}</td>
                <td id="email">${user.email}</td>
                <td>${user.phone}</td>
                <td>${user.role}</td>
                <td>${user.status}</td>
                <td>
                    <button class="button change" onclick="changeStatus(${user.idUser})">edit</button>
                    <button class="button delete" onclick="deleteUser(${user.idUser})">Delete</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script>
    function changeStatus(id) {
        alert("Trạng thái của người dùng với ID " + id + " đã được thay đổi!");
    }

    function deleteUser(id) {
        if (confirm("Bạn có chắc chắn muốn xóa người dùng này?")) {
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "adminServlet?action=delete", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    alert("Người dùng với ID " + id + " đã bị xóa thành công!");
                    location.reload();
                }
            };
            xhr.send("idUser=" + id);
        }
    }
</script>
</body>
</html>
