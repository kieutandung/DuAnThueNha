<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Xem báo cáo</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/report.css">
</head>

<body>
<header>
    <jsp:include page="menu.jsp"/>
</header>
<div class="container-fluid py-5" style="min-height: 700px;">
    <div class="card shadow" style="max-width: 95%; margin: auto;">
        <div class="card-body">
            <h4 class="text-center mb-4">Danh sách khiếu nại</h4>
            <div class="mb-3">
                <a href="adminServlet?action=reportView"
                   class="btn btn-outline-primary me-2 ${param.action eq 'reportView' ? 'active' : ''}">
                    Tất cả
                </a>
                <a href="adminServlet?action=reportViewPending"
                   class="btn btn-outline-secondary ${param.action eq 'reportViewPending' ? 'active' : ''}">
                    Chưa xử lí
                </a>
            </div>
            <div class="table-responsive" style="max-height: 600px; overflow: auto;">
                <table class="table table-striped table-hover table-borderless mb-0 align-middle" style="width: 100%; min-width: 1200px;">
                    <thead class="bg-info text-white">
                    <tr class="text-center">
                        <th>STT</th>
                        <th>Khiếu nại</th>
                        <th>Chi tiết</th>
                        <th>Người phản ánh</th>
                        <th>Nghi vấn</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="r" items="${reportList}" varStatus="status">
                        <tr>
                            <td class="text-center">${status.index + 1}</td>
                            <td class="text-center" >${r.reason}</td>
                            <td style="max-width: 300px">${r.description}</td>
                            <td class="text-center">${usersReport[status.index].fullName}</td>
                            <td>
                                <p><strong>Chủ sở hữu:</strong> ${hostList[status.index].fullName}</p>
                                <p>
                                    <img src="img/${productsList[status.index].image}" alt="no"
                                         style="max-width: 40px; height: auto; border-radius: 4px;">
                                    <span class="ms-2">${productsList[status.index].nameProduct}</span>
                                </p>
                            </td>
                            <td class="text-center" style="max-width: 280px">
                                <c:choose>
                                    <c:when test="${r.status eq 'pending'}">
                                        <!-- Nếu trạng thái là pending thì hiển thị nút "Phản hồi" -->
                                        <button class="btn btn-sm btn-outline-primary feedback-btn"
                                                data-bs-toggle="modal"
                                                data-bs-target="#feedbackModal"
                                                data-title="${r.reason}"
                                                data-id-report="${r.idReport}"
                                                data-id-user="${r.idUser}" >
                                            Phản hồi
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Nếu không phải pending (đã xử lý) thì hiển thị nội dung phản hồi -->
                                        <p><strong> Đã phản hồi: </strong>${r.adminResponse}</p>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!-- Modal phản hồi -->
<form action="adminServlet?action=sendFeedback" method="post">
    <div class="modal fade" id="feedbackModal" tabindex="-1" aria-labelledby="feedbackModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 shadow">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="feedbackModalLabel">Nhập phản hồi</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body">
                    <!-- Truyền dữ liệu ẩn -->
                    <input type="hidden" name="title" id="feedbackTitle" value="">
                    <input type="hidden" name="idReport" id="feedbackIdReport" value="">
                    <input type="hidden" name="idUser" id="feedbackIdUser" value="">
                    <div class="mb-3">
                        <label for="feedbackText" class="form-label fw-semibold">Phản hồi của bạn:</label>
                        <textarea class="form-control" id="feedbackText" name="feedback" rows="3"
                                  placeholder="Nhập phản hồi tại đây..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-primary" id="sendFeedbackBtn">Gửi phản hồi</button>
                </div>
            </div>
        </div>
    </div>
</form>

<!-- JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- MDB script -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.js"></script>

<script>
    // Khi nhấn nút "Phản hồi", lấy dữ liệu từ data-title và data-id-report và gán vào input hidden
    $(document).on("click", ".feedback-btn", function(){
        var title = $(this).data("title");
        var idReport = $(this).data("idReport");
        var idUser = $(this).data("idUser");
        $("#feedbackTitle").val(title);
        $("#feedbackIdReport").val(idReport);
        $("#feedbackIdUser").val(idUser);
    });
</script>

<!-- Footer -->
<footer>
    <jsp:include page="../footer2.jsp"/>
</footer>
</body>
</html>