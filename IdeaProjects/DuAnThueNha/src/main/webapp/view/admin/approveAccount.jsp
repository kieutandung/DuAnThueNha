<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Duyệt Hồ Sơ Người Dùng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="/css/approveAccount.css">
    <script src="/js/approveAccount.js"></script>

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
                    <button type="button" class="btn btn-primary" onclick="openModal(${user.idUser})">
                        Duyệt
                    </button>
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
<div class="modal fade" id="userProfilesModal" tabindex="-1" aria-labelledby="userProfilesModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="userProfilesModalLabel">Danh sách hồ sơ</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table">
                    <tbody id="documentList">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="feedbackModal" tabindex="-1" aria-labelledby="feedbackModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="feedbackModalLabel">Phản hồi hồ sơ</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="feedbackForm">
                    <input type="hidden" name="action" value="profileFeedback">
                    <input type="hidden" name="idDocument" id="feedback-idDocument">

                    <label for="feedback-status">Trạng thái:</label>
                    <select name="status" id="feedback-status" class="form-select">
                        <option value="approved">Approved</option>
                        <option value="rejected">Rejected</option>
                    </select>

                    <label for="feedback-reason">Lý do từ chối:</label>
                    <input type="text" name="rejectionReason" id="feedback-reason" class="form-control" style="display: none;">

                    <button type="submit" class="btn btn-primary mt-3">Gửi</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
