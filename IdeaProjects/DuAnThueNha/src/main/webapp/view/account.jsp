<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.example.duanthuenha.Model.Users" %>
<html>
<head>
    <title>Danh sách tài khoản</title>
</head>
<link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
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
                <td>
                    <img src="img/${user.image != '' ? user.image : 'man.png'}" alt="User Image" width="50" height="50">
                </td>

                <td>${user.fullName}</td>
                <td>${user.email}</td>
                <td>${user.phone}</td>
                <td>${user.role}</td>
                <td>${user.status}</td>
                <td>
                    <a href="adminServlet?action=editUser&idUser=${user.idUser}" class="button edit">
                        <img class="edit-icon" src="img/edit-yellow.png" alt="Edit User" />
                    </a>
                    <style>
                        .button.delete {
                            background: none;
                            border: none;
                            cursor: pointer;
                        }

                        .button.delete svg path {
                            fill: black; /* Default color */
                            transition: fill 0.3s; /* Smooth transition */
                        }

                        .button.delete:hover svg path {
                            fill: red; /* Hover color */
                        }
                    </style>

                    <button class="button delete" onclick="deleteUser(${user.idUser})">
                        <i>
                            <svg
                                    width="24"
                                    height="24"
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    xmlns="http://www.w3.org/2000/svg"
                            >
                                <path
                                        fill-rule="evenodd"
                                        clip-rule="evenodd"
                                        d="M17 5V4C17 2.89543 16.1046 2 15 2H9C7.89543 2 7 2.89543 7 4V5H4C3.44772 5 3 5.44772 3 6C3 6.55228 3.44772 7 4 7H5V18C5 19.6569 6.34315 21 8 21H16C17.6569 21 19 19.6569 19 18V7H20C20.5523 7 21 6.55228 21 6C21 5.44772 20.5523 5 20 5H17ZM15 4H9V5H15V4ZM17 7H7V18C7 18.5523 7.44772 19 8 19H16C16.5523 19 17 18.5523 17 18V7Z"
                                        fill="black"
                                />
                                <path d="M9 9H11V17H9V9Z" fill="black" />
                                <path d="M13 9H15V17H13V9Z" fill="black" />
                            </svg>
                        </i>
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
