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
<div class="container">
    <div class="table-responsive">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-xs-6">
                        <h2>Danh sách <b>yêu cầu thuê</b></h2>
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
                    <th id="phone">Điện thoại</th>
                    <th id="startDate">Ngày bắt đầu</th>
                    <th id="endDate">Ngày kết thúc</th>
                    <th>Số người thuê</th>
                    <th>Trạng thái</th>
                    <th id="action">Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="order" items="${rentalRequests}" varStatus="status">
                    <tr>
                        <td class="stt">${status.index + 1}</td>
                        <td><img src="img/${order.image}" alt="Ảnh nhà thuê" width="50"></td>
                        <td>${order.nameProduct}</td>
                        <td>${order.fullName}</td>
                        <td>${order.phone}</td>
                        <td>${order.startDate}</td>
                        <td>${order.endDate}</td>
                        <td id="numPeople">${order.numPeople}</td>
                        <td id="status">${order.paymentStatus}</td>
                        <td class="text-center">
                            <c:choose>
                                <c:when test="${order.paymentStatus == 'completed' or order.paymentStatus == 'cancelled'}">
                                    <span class="text-success fw-bold d-inline-block">Đã duyệt</span>
                                </c:when>
                                <c:otherwise>
                                    <div class="btn-group d-flex justify-content-center gap-2" role="group">
                                        <button class="btn btn-success" onclick="confirmAction('${order.idOrder}', 'waiting')">Xác nhận</button>
                                        <button class="btn btn-danger" onclick="confirmAction('${order.idOrder}', 'cancelled')">Từ chối</button>
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
                <p>Bạn có chắc chắn muốn thực hiện hành động này?</p>
            </div>
            <div class="modal-footer">
                <form id="confirmForm" action="listProductHostServlet" method="post">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Huỷ</button>
                    <input type="hidden" name="action" value="updateStatus">
                    <input type="hidden" name="idOrder" id="orderId">
                    <input type="hidden" name="status" id="orderStatus">
                    <button type="submit" class="btn btn-success1">Xác nhận</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function confirmAction(orderId, status) {
        document.getElementById('orderId').value = orderId;
        document.getElementById('orderStatus').value = status;
        $('#confirmModal').modal('show');
    }
</script>

<footer>
    <jsp:include page="../footer2.jsp"/>
</footer>
</body>
</html>
