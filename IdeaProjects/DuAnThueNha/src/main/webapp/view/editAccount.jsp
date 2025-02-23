<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Sửa Tài Khoản</title>
    <link rel="stylesheet" href="/css/addAccount.css">
</head>
<header>
    <jsp:include page="menu.jsp"/>
</header>
<body>
<div class="container">
    <h2>Sửa Tài Khoản</h2>
    <form action="adminServlet?action=editUser" method="post">
        <input type="hidden" name="idUser" value="${user.idUser}"/> <!-- Hidden field for user ID -->
        <table>
            <tr>
                <td>Tên Đăng Nhập:</td>
                <td><input type="text" name="username" value="${user.username}" required /></td>
            </tr>
            <tr>
                <td>Họ Và Tên:</td>
                <td><input type="text" name="fullName" value="${user.fullName}" required /></td>
            </tr>
            <tr>
                <td>Số Điện Thoại:</td>
                <td><input type="text" name="phone" value="${user.phone}" required /></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><input type="email" name="email" value="${user.email}" required /></td>
            </tr>
            <tr>
                <td>Mật Khẩu:</td>
                <td><input type="password" name="password" value="${user.password}" required /></td>
            </tr>
            <tr>
                <td>Vai Trò:</td>
                <td>
                    <select name="role">
                        <option value="${user.role}" ${user.role == 'default' ? 'selected' : ''}>${user.role}</option>

                        <c:if test="${user.role != 'admin'}">
                            <option value="admin" ${user.role == 'admin' ? 'selected' : ''}>admin</option>
                        </c:if>

                        <c:if test="${user.role != 'host'}">
                            <option value="host" ${user.role == 'host' ? 'selected' : ''}>host</option>
                        </c:if>

                        <c:if test="${user.role != 'user'}">
                            <option value="user" ${user.role == 'user' ? 'selected' : ''}>user</option>
                        </c:if>
                    </select>


                </td>
            </tr>
            <tr>
                <td>Trạng Thái:</td>
                <td>
                    <select name="status">
                        <option value="${user.status}" ${user.status == 'default' ? 'selected' : ''}>${user.status}</option>
                        <c:if test="${user.status != 'active'}">
                            <option value="active" ${user.status == 'active' ? 'selected' : ''}>active</option>
                        </c:if>

                        <c:if test="${user.status != 'block'}">
                            <option value="block" ${user.status == 'block' ? 'selected' : ''}>block</option>
                        </c:if>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <button class="button" type="submit">Cập nhật tài khoản</button>
                </td>
            </tr>
        </table>
    </form>
    <div id="message">${message}</div>
</div>
</body>
</html>
