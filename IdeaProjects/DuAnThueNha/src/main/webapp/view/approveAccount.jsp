<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản lý hợp đồng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        .table-main {
            background: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #007BFF;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        img {
            border-radius: 50%;
        }

        a {
            text-decoration: none;
            color: #007BFF;
            margin-right: 10px;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="table-main">
    <table>
        <thead>
        <tr>
            <th>Ảnh đại diện</th>
            <th>Tên Người Dùng</th>
            <th>Email</th>
            <th>Điện thoại</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${empty verifications}">
            <tr>
                <td colspan="4" style="text-align: center; color: gray;">Không có dữ liệu</td>
            </tr>
        </c:if>
        <c:forEach items="${verifications}" var="verification">
            <c:forEach items="${users}" var="user">
            <tr>
                <td>
                    <img src="img/${user.image != null && user.image != '' ? user.image : 'man.png'}" alt="User Image" width="50" height="50">
                </td>
                <td>${user.fullName}</td>
                <td>${user.email}</td>
                <td>${user.phone}</td>
            </tr>
            </c:forEach>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
