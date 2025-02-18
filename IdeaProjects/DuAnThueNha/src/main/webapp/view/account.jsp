<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.example.duanthuenha.Service.Admin.ListAccountImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.duanthuenha.Model.Users" %>

<html>
<head>
    <title>Danh sách tài khoản</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
        }

        .table {
            width: 100%;
            max-width: 1200px; /* Giới hạn chiều rộng tối đa */
            margin: auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        td {
            color: #454545;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd; /* Đường kẻ dưới ô */
        }
        /*#name, #email {*/
        /*    text-align: left;*/
        /*}*/


        th {
            background-color: #4CAF50;
            color: white;
        }

        img {
            width: 50px; /* Kích thước ảnh */
            height: 50px; /* Kích thước ảnh */
            border-radius: 50%; /* Tạo hình tròn cho ảnh */
        }

        button {
            background-color: #008CBA;
            color: white;
            border: none;
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* Hiệu ứng chuyển màu */
        }

        button:hover {
            background-color: #005f73;
        }
    </style>
</head>
<header>
    <jsp:include page="menu.jsp"/>
</header>
<body>
<div>

</div>
<div class="table">
    <table>
        <thead>
        <tr>
            <th>Ảnh Đại Diện</th>
            <th>Tên Người Dùng</th>
            <th>Email</th>
            <th>Số Điện Thoại</th>
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
                <td>${user.phone}</td>
                <td>${user.status}</td>
                <td>
                    <button onclick="changeStatus(${user.idUser})">Change Status</button>
                </td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
</div>

<script>
    function changeStatus(id) {
        // Logic to change the status of the user
        alert("Trạng thái của người dùng với ID " + id + " đã được thay đổi!");
        // Có thể thêm AJAX để cập nhật trạng thái mà không cần tải lại trang
    }
</script>

</body>
</html>
