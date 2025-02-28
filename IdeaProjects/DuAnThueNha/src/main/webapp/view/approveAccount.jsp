<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Duyệt Hồ Sơ Người Dùng</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="/css/approveAccount.css">
</head>
<body>
<header><jsp:include page="menu.jsp"/></header>
<div class="table-main">
    <table class="table">
        <thead>
        <tr>
            <th>Ảnh đại diện</th>
            <th>Tên Người Dùng</th>
            <th>Email</th>
            <th>Điện thoại</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${users}" var="user">
            <tr>
                <td><img src="img/${user.image != null ? user.image : 'man.png'}" alt="User Image"></td>
                <td>${user.fullName}</td>
                <td>${user.email}</td>
                <td>${user.phone}</td>
                <td>
                    <button type="button" class="btn btn-primary" onclick="openModal(${user.idUser})">Duyệt</button>
                    <form action="adminServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="promoteUser">
                        <input type="hidden" name="idUser" value="${user.idUser}">
                        <button type="submit" class="btn btn-warning" onclick="promoteUser(${user.idUser})">Thăng Chức</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- Modal for User Profiles -->
<div class="modal fade" id="userProfilesModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Danh sách Hồ Sơ Người Dùng</h5>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Ảnh</th>
                        <th>Loại</th>
                        <th>Số</th>
                        <th>Trạng Thái</th>
                        <th>Lý Do</th>
                        <th>Ngày Tạo</th>
                        <th>Hành Động</th>
                    </tr>
                    </thead>
                    <tbody id="verificationBody">
                    <c:forEach items="${verifications}" var="verification">
                        <tr data-id="${verification.idDocument}">
                            <td><img src="img/${verification.documentImage}" alt="Profile Image"></td>
                            <td>${verification.documentType}</td>
                            <td>${verification.documentNumber}</td>
                            <td class="status-column">${verification.status}</td>
                            <td class="reason-column">${verification.rejectionReason != null ? verification.rejectionReason : 'Không có'}</td>
                            <td>${verification.createdAt}</td>
                            <td>
                                <form action="adminServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="profileFeedback">
                                    <input type="hidden" name="idDocument" value="${verification.idDocument}">
                                    <select name="status">
                                        <option value="approved">Approved</option>
                                        <option value="rejected">Rejected</option>
                                    </select>
                                    <input type="text" name="rejectionReason" placeholder="Nhập lý do..." />
                                    <button type="submit" class="btn btn-primary">Gửi</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>
