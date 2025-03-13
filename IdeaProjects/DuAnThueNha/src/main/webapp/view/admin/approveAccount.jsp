<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Duyệt Hồ Sơ Người Dùng</title>
    <link rel="stylesheet" href="css/approveAccount.css">
    <script src="js/approveAccount.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
<header><jsp:include page="menu.jsp"/></header>
<div class="table-main">
    <h3 class="table-title">Danh Sách Người Dùng Chờ Duyệt</h3>
    <c:choose>
        <c:when test="${not empty users}">
            <table class="table">
                <thead>
                <tr>
                    <th>Stt</th>
                    <th>Ảnh đại diện</th>
                    <th>Tên Người Dùng</th>
                    <th>Email</th>
                    <th>Điện thoại</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${users}" var="user" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td><img src="img/${user.image != null ? user.image : 'man.png'}" alt="User Image"></td>
                        <td>${user.fullName}</td>
                        <td>${user.email}</td>
                        <td>${user.phone}</td>
                        <td>
                            <a href="/verificationServlet?idUser=${user.idUser}" class="btn btn-primary">Duyệt hồ sơ</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p class="no-data">Không có hồ sơ nào cần duyệt.</p>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
