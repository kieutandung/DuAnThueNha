<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Phản hồi hồ sơ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<style>
    /* Căn giữa bảng, bo góc, đổ bóng */
    .table-container {
        max-width: 90%;
        margin: 20px auto;
        padding: 15px;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        z-index: 9;
    }

    /* Tiêu đề trang */
    .table-title {
        font-size: 22px;
        font-weight: bold;
        text-align: left;
        margin-bottom: 15px;
        color: #333;
    }

    /* Giữ cố định phần tiêu đề, chỉ cuộn nội dung */
    .table-wrapper {
        max-height: 500px;
        overflow-y: auto;
        z-index: 9;
    }

    /* Fix lỗi tiêu đề bị che khi cuộn */
    .table thead tr {
        top: 0;
        background-color: #007bff;
        color: white;
        z-index: 10;
    }

    /* Định dạng bảng */
    .table {
        width: 100%;
        border-collapse: collapse;
        z-index: 9;
    }

    /* Định dạng hàng tiêu đề */
    .table th {
        padding: 12px;
        text-align: center;
        border: 1px solid #ddd;
        text-transform: uppercase;
        z-index: 9;
    }

    /* Định dạng ô dữ liệu */
    .table td {
        padding: 10px;
        text-align: center;
        border: 1px solid #ddd;
        z-index: 9;
    }

    /* Giữ khoảng cách đều giữa th và td */
    .table tbody tr {
        background-color: white;
        z-index: 9;
    }

    /* Tô màu xen kẽ */
    .table tbody tr:nth-child(even) {
        background-color: #f9f9f9;
        z-index: 9;
    }

    /* Hiệu ứng nút bấm */
    .btn-primary {
        background-color: #007bff;
        color: white;
        border: none;
        padding: 8px 12px;
        border-radius: 5px;
        cursor: pointer;
        transition: background 0.3s ease;
        z-index: 9;
    }

    .btn-primary:hover {
        background-color: #0056b3;
        z-index: 9;
    }

    /* Chữ đã phản hồi */
    .text-success {
        font-weight: bold;
        color: #28a745;
    }

    /* Fix giao diện trên điện thoại */
    @media (max-width: 768px) {
        .table-container {
            max-width: 95%;
        }

        .table th, .table td {
            padding: 8px;
            font-size: 14px;
        }

        .table img {
            width: 60px;
        }

        .btn-primary {
            padding: 6px 10px;
            font-size: 12px;
        }
    }
</style>
<header>
    <jsp:include page="menu.jsp"/>
</header>
<body>
<%
    String idUser = request.getParameter("idUser");
    request.setAttribute("idUser", idUser);
%>
<div class="table-container">
    <div class="table-title">Danh sách tài liệu xác minh</div> <!-- Tiêu đề cố định -->

    <div class="table-wrapper">
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
                        <td>
                            <c:if test="${not empty doc.documentFile}">
                                <a href="/files/${doc.documentFile}" target="_blank">
                                    <c:choose>
                                        <c:when test="${not empty doc.documentImage}">
                                            <img src="img/${doc.documentImage}" alt="Tài liệu" width="50">
                                        </c:when>
                                        <c:otherwise>
                                            <img src=img/"id-card.png" alt="Không có ảnh" width="50">
                                        </c:otherwise>
                                    </c:choose>
                                </a>
                            </c:if>
                        </td>
                        <td>${doc.documentType}</td>
                        <td>${doc.documentNumber}</td>
                        <td>${doc.createdAt}</td>
                        <td>
                            <c:choose>
                                <c:when test="${doc.status == 'approved'}">
                                    <span class="text-success">Chấp nhận</span>
                                </c:when>
                                <c:when test="${doc.status == 'rejected'}">
                                    <span class="text-danger">Từ chối</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-warning">Chờ xác nhận</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${doc.rejectionReason}</td>
                        <td>
                            <c:choose>
                                <c:when test="${doc.status == 'pending'}">
                                    <button class="btn btn-primary open-modal"
                                            data-bs-toggle="modal"
                                            data-bs-target="#exampleModal"
                                            data-document-id="${doc.idDocument}"
                                            data-user-id="${doc.idUser}">
                                        Phản hồi
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-success">Đã phản hồi</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Phản hồi khiếu nại</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="responseForm" action="/verificationServlet" method="post">
                    <input type="hidden" id="idDocument" name="idDocument">
                    <div class="form-group">
                        <label for="response-action">Hành động:</label>
                        <select class="form-control" id="response-action" name="action">
                            <option value="accept">Chấp nhận</option>
                            <option value="reject">Từ chối</option>
                        </select>
                    </div>
                    <div class="form-group" id="reason-group" style="display: none;">
                        <label for="message-text" class="col-form-label">Lý do:</label>
                        <textarea class="form-control" id="message-text" name="reason" placeholder="Nhập lý do"></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-primary">Gửi phản hồi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        let buttons = document.querySelectorAll(".open-modal");
        let idDocumentInput = document.getElementById("idDocument");
        let actionSelect = document.getElementById("response-action");
        let reasonGroup = document.getElementById("reason-group");
        let reasonInput = document.getElementById("message-text");
        let responseForm = document.getElementById("responseForm");
        let modalElement = document.getElementById("exampleModal");
        let modalInstance = new bootstrap.Modal(modalElement);

        // Xử lý khi bấm "Phản hồi" để mở modal
        buttons.forEach(button => {
            button.addEventListener("click", function () {
                let idDocument = this.getAttribute("data-document-id");
                idDocumentInput.value = idDocument;
                actionSelect.value = "accept"; // Mặc định là "Chấp nhận"
                reasonGroup.style.display = "none"; // Ẩn ô nhập lý do
                reasonInput.value = ""; // Xóa nội dung cũ
            });
        });

        // Khi chọn "Từ chối" thì hiển thị ô nhập lý do
        actionSelect.addEventListener("change", function () {
            if (this.value === "reject") {
                reasonGroup.style.display = "block";
            } else {
                reasonGroup.style.display = "none";
            }
        });

        // Xử lý khi gửi form
        responseForm.addEventListener("submit", function (event) {
            event.preventDefault(); // Ngăn form submit mặc định

            let formData = {
                idDocument: idDocumentInput.value,
                action: actionSelect.value,
                reason: reasonInput.value
            };

            fetch("/verificationServlet", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: new URLSearchParams(formData)
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Cập nhật nút thành "Đã phản hồi"
                        let btn = document.querySelector(`[data-document-id='${data.idDocument}']`);
                        if (btn) {
                            btn.outerHTML = `<span class="text-success">Đã phản hồi</span>`;
                        }

                        // Đóng modal
                        modalInstance.hide();
                    } else {
                        // Hiển thị thông báo lỗi nếu thất bại
                        alert("Lỗi: " + data.message);
                    }
                })
                .catch(error => alert("Lỗi hệ thống: " + error.message));
        });
    });
</script>
</body>
<footer>
    <jsp:include page="../footer2.jsp"/>
</footer>
</html>
