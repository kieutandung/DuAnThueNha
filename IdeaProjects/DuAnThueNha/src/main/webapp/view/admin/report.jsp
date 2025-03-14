<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Xem báo cáo</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/report.css">
</head>
<script>
</script>
<header>
    <jsp:include page="menu.jsp"/>
</header>
<body>
<div class="gradient-custom-1 h-100">
    <div class="container-fluid" style="max-width: 90%; margin: 80px auto 0;">
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="table-wrapper bg-white">
                    <table class="table mb-0">
                        <colgroup>
                            <col style="width:5%;">
                            <col style="width:15%;">
                            <col style="width:35%;">
                            <col style="width:15%;">
                            <col style="width:20%;">
                            <col style="width:10%;">
                        </colgroup>
                        <thead class="table-header">
                        <tr>
                            <th scope="col">STT</th>
                            <th scope="col">Khiếu nại</th>
                            <th scope="col">Chi tiết</th>
                            <th scope="col">Người phản ánh</th>
                            <th scope="col">Nghi vấn</th>
                            <th scope="col">Hành động</th>
                        </tr>
                        </thead>
                        <tbody class="table-body">
                        <c:forEach var="r" items="${reportList}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${r.reason}</td>
                                <td>${r.description}</td>
                                <td>${usersReport[status.index].fullName}</td>
                                <td>
                                    <p><b>Chủ sở hữu: </b>${hostList[status.index].fullName}</p>
                                    <p>
                                        <img src="img/${productsList[status.index].image}" alt="no"
                                             style="max-width: 40px; height: auto;">
                                            ${productsList[status.index].nameProduct}
                                    </p>
                                </td>
                                <td>
                                    <!-- Sử dụng data-title và data-id-report -->
                                    <button class="btn btn-sm btn-primary feedback-btn"
                                            data-bs-toggle="modal"
                                            data-bs-target="#feedbackModal"
                                            data-title="Khiếu nại của bạn: ${r.reason}"
                                            data-id-report="${r.idReport}">
                                        Phản hồi
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <form action="adminServlet?action=sendFeedback" method="post">
                        <div class="modal fade" id="feedbackModal" tabindex="-1" aria-labelledby="feedbackModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="feedbackModalLabel">Nhập phản hồi</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Input ẩn chứa title và idReport -->
                                        <input type="hidden" name="title" id="feedbackTitle" value="">
                                        <input type="hidden" name="idReport" id="feedbackIdReport" value="">
                                        <div class="mb-3">
                                            <label for="feedbackText" class="form-label">Phản hồi của bạn:</label>
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
                    <!-- End Modal -->
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Khi nhấn nút "Phản hồi", lấy dữ liệu từ data-title và data-id-report và gán vào input hidden trong modal
    $(document).on("click", ".feedback-btn", function(){
        var title = $(this).data("title");
        var idReport = $(this).data("idReport"); // jQuery chuyển data-id-report thành idReport
        $("#feedbackTitle").val(title);
        $("#feedbackIdReport").val(idReport);
    });
</script>
</body>
<footer>
    <jsp:include page="../footer2.jsp"/>
</footer>
</html>
