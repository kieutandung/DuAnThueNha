<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Trở thành người kinh doanh</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/userToHost.css">
</head>
<body>
<header>
    <jsp:include page="header.jsp"/>
</header>
<div class="container rounded bg-white mt-5 mb-5">
    <div class="row">
        <%--        <div class="col-md-3 border-right">--%>
        <%--            <div class="d-flex flex-column align-items-center text-center p-3 py-5"><img class="rounded-circle mt-5" width="150px" src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"><span class="font-weight-bold">Edogaru</span><span class="text-black-50">edogaru@mail.com.my</span><span> </span></div>--%>
        <%--        </div>--%>
        <div class="col-md-4 border-right">
            <div class="p-3 py-5">
                <h4 class="text-center mb-4">Đăng ký làm chủ nhà</h4>
                <form action="userToHostServlet" method="post">
                    <!-- 1. Lựa chọn loại tài liệu -->
                    <div class="mb-3">
                        <label for="documentType" class="form-label">Loại tài liệu:</label>
                        <select id="documentType" name="documentType" class="form-select" required>
                            <option value="">-- Chọn loại tài liệu --</option>
                            <option value="ID Card">Căn cước công dân</option>
                            <option value="Passport">Hộ chiếu</option>
                            <option value="Business License">Giấy phép kinh doanh</option>
                            <option value="House Ownership Certificate">Giấy chứng nhận quyền sở hữu nhà</option>
                            <option value="Other">Khác</option>
                        </select>
                    </div>

                    <!-- 2. Nhập số tài liệu -->
                    <div class="mb-3">
                        <label for="documentId" class="form-label">Số tài liệu:</label>
                        <input type="text" id="documentId" name="documentId" class="form-control"
                               placeholder="Nhập số tài liệu" required>
                    </div>

                    <!-- 3. Chọn ảnh tài liệu -->
                    <div class="mb-3">
                        <label for="image" class="form-label">Chọn ảnh tài liệu:</label>
                        <input type="file" id="image" name="image" class="form-control" accept="image/*">
                    </div>

                    <!-- Nút hành động -->
                    <div class="mt-4 py-4 text-center">
                        <button type="submit" class="btn btn-success">Xác Nhận</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="col-md-8">
            <div class="p-3 py-5">
                <h4 class="text-center mb-4">Toàn bộ giấy tờ của bạn</h4>
                <div class="scrollable-container" style="max-height: 500px; overflow-y: auto;">
                    <c:forEach var="o" items="${allUserDocumentNumber}">
                        <div class="p-3 py-3 border-bottom">
                            <div class="info-item d-flex align-items-center justify-content-between">
                                <div>
                                    <b>${o.documentType}:</b> ${o.documentNumber} &nbsp; <span>${o.status}</span>
                                </div>
                                <div>
<%--                                    <!-- Nút Sửa -->--%>
<%--                                    <a href="/userToHostServlet?action=edit"  class="btn btn-warning btn-sm me-2">--%>
<%--                                        <i class="fas fa-edit"></i> Sửa--%>
<%--                                    </a>--%>

                                    <a href="/userToHostServlet?action=" class="btn btn-info btn-sm">
                                        <i class="fas fa-edit"></i> Xem chi tiết
                                    </a>

                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</div>
<footer>
    <jsp:include page="footer.jsp"/>
</footer>
<script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.js"></script>
</body>
</html>
