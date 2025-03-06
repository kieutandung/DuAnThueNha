<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html lang="vi">
<head>
    <title>Đơn đặt chỗ</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .room-image {
            width: 150px;
            height: 100px;
            object-fit: cover;
            border-radius: 5px;
        }

        .custom-card {
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .custom-badge-confirmed {
            background-color: #ccffcc !important;
            color: #008000 !important;
            font-weight: bold;
            padding: 4px 10px;
            font-size: 14px;
            border-radius: 5px;
            position: relative;
            top: -7px;
        }

        .custom-btn {
            padding: 6px 12px;
            font-size: 14px;
        }

        .room-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .checkin-checkout {
            display: flex;
            justify-content: flex-start; /* Căn trái */
            gap: 50px;
            margin-top: 20px;
            margin-left: -10px;
        }

        .checkin-info, .checkout-info {
            min-width: 140px;
            text-align: center;
        }

        .checkin-info p, .checkout-info p {
            margin-bottom: 2px;
            line-height: 1.2;
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .total-price {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-right: 50px;
        }

        .text-muted.mb-0 {
            color: #c91515;
        }
        .mt-3.d-flex {
            padding-bottom: 15px;
        }
    </style>
</head>
<body>
<header>
    <jsp:include page="../header.jsp"/>
</header>
<div class="container mt-4">
    <ul class="nav nav-tabs">
        <li class="nav-item"><a class="nav-link active" href="#">Tất cả</a></li>
        <%--        <li class="nav-item"><a class="nav-link" href="#">Sắp tới</a></li>--%>
<%--        <li class="nav-item"><a class="nav-link" href="#">Hoàn tất</a></li>--%>
<%--        <li class="nav-item"><a class="nav-link" href="#">Đã hủy</a></li>--%>
    </ul>


    <c:forEach var="order" items="${orders}">
        <div class="custom-card"
             data-id="${order.idOrder}"
             data-start="${order.startDate}"
             data-end="${order.endDate}"
             data-price="${order.price}">
        <div class="card-body">
                <div class="order-header">
                    <c:choose>
                        <c:when test="${order.paymentStatus eq 'pending'}">
                            <span class="badge bg-secondary">Chờ xác nhận</span>
                        </c:when>
                        <c:when test="${order.paymentStatus eq 'cancelled'}">
                            <span class="badge bg-danger">Đã hủy</span>
                        </c:when>
                        <c:when test="${order.paymentStatus eq 'completed'}">
                            <span class="badge bg-success">Hoàn thành</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-dark">${order.paymentStatus}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="d-flex align-items-center">
                    <img src="img/${order.image}" class="room-image me-3">
                    <div>
                        <h5 class="room-title">${order.nameProduct}</h5>
                        <div class="d-flex justify-content-between checkin-checkout">
                            <div class="checkin-info">
                                <p class="text-muted fw-semibold mb-1">Nhận phòng</p>
                                <p class="text-muted mb-0">${order.startDate}</p>
                            </div>
                            <div class="checkout-info">
                                <p class="text-muted fw-semibold mb-1">Trả phòng</p>
                                <p class="text-muted mb-0">${order.endDate}</p>
                            </div>
                            <div class="number-people">
                                <p class="text-muted fw-semibold mb-1">Số người thuê</p>
                                <p class="text-muted mb-0">${order.numPeople}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="mt-3 d-flex justify-content-end">
                    <div class="total-price">
                        <p class="text-muted fw-semibold mb-1">Tổng tiền:</p>
                        <p class="text-muted mb-0">
                            <span id="total-price-${order.idOrder}">
    <fmt:formatNumber value="${order.calculateTotalPrice()}" type="number"/>
</span> VNĐ
                        </p>
                    </div>
                    <c:choose>
                        <c:when test="${order.paymentStatus eq 'completed'}">
                            <a href="commentServlet?productId=${order.idProduct}"
                               class="btn btn-danger custom-btn me-2">
                                Viết đánh giá</a>
                        </c:when>
                        <c:otherwise>
                            <button type="button" class="btn btn-danger custom-btn me-2" onclick="confirmCancel(${order.idOrder})">
                                Hủy
                            </button>
                        </c:otherwise>
                    </c:choose>
                        <%--<button class="btn btn-primary custom-btn">Quản lý đặt phòng</button>--%>
                </div>
            </div>
        </div>
    </c:forEach>

</div>

<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Xác nhận hủy đơn hàng</h5>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn hủy đơn hàng này không?</p>
            </div>
            <div class="modal-footer">
                <form id="confirmForm" action="cancelOrder" method="post">
                    <input type="hidden" name="idOrder" id="orderId">
                    <button type="submit" class="btn btn-danger">Xác nhận</button>
                </form>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
            </div>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<footer class="mt-5">
    <jsp:include page="../footer2.jsp"/>
</footer>
<script>
    function confirmCancel(orderId) {
        document.getElementById("orderId").value = orderId;
        var myModal = new bootstrap.Modal(document.getElementById("confirmModal"));
        myModal.show();
    }
</script>

</body>
</html>
