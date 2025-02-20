<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Thêm Tài Khoản</title>
    <link rel="stylesheet" href="/css/addAccount.css">
</head>
<header>
    <jsp:include page="menu.jsp"/>
</header>
<body>
<div class="container">
    <h2>Thêm Tài Khoản</h2>
    <form action="addAccount" method="post">
        <table>
            <tr>
                <td>Tên Đăng Nhập:</td>
                <td><input type="text" name="accountName" required></td>
            </tr>
            <tr>
                <td>Họ Và Tên:</td>
                <td><input type="text" name="fullName" required></td>
            </tr>
            <tr>
                <td>Số Điện Thoại:</td>
                <td><input type="text" name="phone" required></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><input type="email" name="email" required></td>
            </tr>
            <tr>
                <td>Mật Khẩu:</td>
                <td><input type="password" name="password" required></td>
            </tr>
            <tr>
                <td>Vai Trò:</td>
                <td>
                    <select name="role">
                        <option value="ADMIN">Admin</option>
                        <option value="HOST">Host</option>
                        <option value="USER">User</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <a href="adminServlet" class="button add">Thêm Tài Khoản</a> <!-- Thay nút gửi bằng thẻ a -->
                </td>
            </tr>
        </table>
    </form>
    <div id="message"></div>
</div>
</body>
</html>
