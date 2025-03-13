<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Phản hồi hồ sơ</title>
</head>
<header>
    <jsp:include page="menu.jsp"/>
</header>
<body
<%
    String idUser = request.getParameter("idUser");
    request.setAttribute("idUser", idUser);
%>
<div class="table-container">
<table class="table">
    <thead>
    <tr>
        <th>STT</th>
        <th>Ảnh</th>
        <th>Loại tài liệu</th>
        <th>Số tài liệu</th>
        <th>Ngày gửi</th>
        <th>Trạng thái</th>
        <th>Lý do</th>
        <th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="doc" items="${verifications}" varStatus="status">
        <c:if test="${doc.idUser == idUser}">
            <tr>
                <td>${status.index + 1}</td>
                <td><img src="img/${doc.documentImage}" alt="" width="100"></td>
                <td>${doc.documentType}</td>
                <td>${doc.documentNumber}</td>
                <td>${doc.createdAt}</td>
                <td>${doc.status}</td>
                <td>${doc.rejectionReason}</td>
                <td><button>Phản hồi</button></td>
            </tr>
        </c:if>
    </c:forEach>
    </tbody>
</table>
</div>
</body>
</html>
