<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chủ nhà phê duyệt yêu cầu thuê</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/hostApproveTheRequest.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<header>
    <jsp:include page="headerHost.jsp"/>
</header>

<div class="container" style="min-height: 700px;">
    <div class="table-responsive">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-xs-6">
                        <h2>Danh sách yêu cầu thuê</h2>
                    </div>
                </div>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <th>STT</th>
                    <th>Ảnh</th>
                    <th>Tên nhà thuê</th>
                    <th>Tên người thuê</th>
                    <th>Ngày bắt đầu</th>
                    <th>Ngày kết thúc</th>
                    <th>Số người thuê</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="order" items="${rentalRequests}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td><img src="img/${order.image}" alt="Ảnh nhà thuê" width="50"></td>
                        <td>${order.nameProduct}</td>
                        <td>${order.fullName}</td>
                        <td>${order.startDate}</td>
                        <td>${order.endDate}</td>
                        <td>${order.numPeople}</td>
                        <td>
                            <c:choose>
                                <c:when test="${order.paymentStatus == 'waiting'}">Chờ thanh toán</c:when>
                                <c:when test="${order.paymentStatus == 'pending'}">Đang xử lý</c:when>
                                <c:when test="${order.paymentStatus == 'cancelled'}">Đã huỷ</c:when>
                                <c:otherwise>Không xác định</c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-center">
                            <c:choose>
                                <c:when test="${order.paymentStatus == 'waiting' or order.paymentStatus == 'cancelled'}">
                                    <span class="text-success fw-bold">Đã duyệt</span>
                                </c:when>
                                <c:otherwise>
                                    <div class="btn-group d-flex justify-content-center gap-2" role="group">
                                        <button class="btn btn-success"
                                                onclick="confirmAction('${order.idOrder}', 'waiting', '${order.idUser}')">
                                            Xác nhận
                                        </button>
                                        <button class="btn btn-danger"
                                                onclick="confirmAction('${order.idOrder}', 'cancelled', '${order.idUser}')">
                                            Từ chối
                                        </button>
                                    </div>
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

<!-- Modal Xác nhận -->
<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Xác nhận hành động</h5>
            </div>
            <div class="modal-body">
                <p id="confirmMessage">Bạn có chắc chắn muốn thực hiện hành động này?</p>
            </div>
            <div class="modal-footer">
                <form id="confirmForm" action="listProductHostServlet" method="post">
                    <input type="hidden" name="action" value="updateStatus">
                    <input type="hidden" name="idOrder" id="orderId">
                    <input type="hidden" name="status" id="orderStatus">
                    <input type="hidden" name="idReceiver" id="idReceiver">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Huỷ</button>
                    <button type="submit" class="btn btn-success">Xác nhận</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function confirmAction(orderId, status, idReceiver) {
        document.getElementById('orderId').value = orderId;
        document.getElementById('orderStatus').value = status;
        document.getElementById('idReceiver').value = idReceiver;

        let message = status === 'waiting'
            ? "Bạn có chắc chắn muốn xác nhận đơn hàng này?"
            : "Bạn có chắc chắn muốn từ chối đơn hàng này?";
        document.getElementById('confirmMessage').innerText = message;

        $('#confirmModal').modal('show');
    }
</script>

<footer>
    <jsp:include page="../footer2.jsp"/>
</footer>
</body>
</html>
