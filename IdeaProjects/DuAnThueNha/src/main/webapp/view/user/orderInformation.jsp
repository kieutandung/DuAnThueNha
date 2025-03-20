<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html lang="vi">
<head>
    <title>Đơn đặt chỗ</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .room-image {
            width: 150px;
            height: 100px;
            object-fit: cover;
            border-radius: 5px;
        }
        .card-body{
            margin-top: 20px;
        }

        .custom-card {
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 15px; /* Tăng padding để tạo khoảng trống */
            margin-bottom: 20px; /* Tăng khoảng cách giữa các đơn */
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
            margin-bottom: 10px; /* Giảm khoảng cách với phần tiếp theo */
        }

        .checkin-checkout {
            display: flex;
            justify-content: flex-start; /* Căn trái */
            gap: 80px;
            margin-top: 30px;
            margin-left: -10px;
            text-align: center;
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

        .text-muted.mb-0 span{
            color: #c91515;
        }
        .form-control{
            width: 250px;
            margin-top: -20px;
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
                        <c:when test="${order.paymentStatus eq 'waiting'}">
                            <span class="badge bg-danger">Chưa thanh toán</span>
                        </c:when>
                        <c:when test="${order.paymentStatus eq 'cancelled'}">
                            <span class="badge bg-danger">Đã huỷ</span>
                        </c:when>
                        <c:when test="${order.paymentStatus eq 'completed'}">
                            <span class="badge bg-success">Đã hoàn thành</span>
                        </c:when>
                        <c:when test="${order.paymentStatus eq 'paid'}">
                            <span class="badge bg-success">Đã thanh toán</span>
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
                            <div class="total-price">
                                <p class="text-muted fw-semibold mb-1">Tổng tiền</p>
                                <p class="text-muted mb-0">
            <span id="total-price-${order.idOrder}">
                <fmt:formatNumber value="${order.calculateTotalPrice()}" type="number"/>
            </span> VNĐ
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            <div class="mt-3 d-flex justify-content-end gap-2 p-2">
                <c:choose>
                    <c:when test="${order.paymentStatus eq 'waiting'}">
                        <button class="btn btn-primary btn-payment"
                                data-idOrder="${order.idOrder}"
                                data-image="img/${order.image}"
                                data-nameProduct="${order.nameProduct}"
                                data-price="${order.price}"
                                data-numDate="${order.calculateDays()}"
                                data-totalPrice="${order.calculateTotalPrice()}">
                            Thanh toán
                        </button>
                    </c:when>
                </c:choose>
                <c:choose>
                    <c:when test="${order.paymentStatus eq 'completed'}">
                        <a href="commentServlet?productId=${order.idProduct}"
                           class="btn btn-danger custom-btn">
                            Viết đánh giá
                        </a>
                    </c:when>
                    <c:when test="${order.paymentStatus eq 'cancelled'}">

                    </c:when>
                    <c:when test="${order.paymentStatus eq 'completed'}">

                    </c:when>
                    <c:otherwise>
                        <button type="button" class="btn btn-danger custom-btn" onclick="confirmCancel(${order.idOrder})">
                            Hủy
                        </button>
                    </c:otherwise>
                </c:choose>
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
                <form id="confirmForm" action="/cancelOrderServlet" method="post">
                    <input type="hidden" name="idOrder" id="orderId">
                    <button type="submit" class="btn btn-danger">Xác nhận</button>
                </form>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="orderPayment" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="Title">Thanh toán đơn hàng</h5>
            </div>
            <div class="modal-body">
                <div class="d-flex align-items-center gap-3">
                    <img class="room-image" style="width: 100px; height: 70px; object-fit: cover;">
                    <p class="room-title flex-grow-1"></p>
                </div>
                <hr class="my-2">
                <div class="d-flex justify-content-between align-items-start mt-3">
                    <div class="text-left">
                        <p>Ghi chú</p>
                        <textarea id="notes" name="notes" placeholder="Thêm ghi chú cho đơn hàng" class="form-control" rows="1"></textarea>
                    </div>
                    <div class="text-right">
                        <div class="d-flex flex-column gap-2">
                            <div class="d-flex justify-content-between">
                                <span class="fw-bold">Giá/ngày:</span>
                                <span class="fw-bold price ms-4"></span>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span class="fw-bold">Số ngày:</span>
                                <span class="fw-bold numDate ms-4"></span>
                            </div>
                            <div class="d-flex justify-content-between border-top pt-2">
                                <span class="fw-bold">Tổng cộng:</span>
                                <span class="fw-bold text-danger totalPrice ms-4"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <form id="PayOrder" action="/updateOrderStatusServlet" method="post">
                    <input type="hidden" name="idOrder" id="idOrder">
                    <input type="hidden" name="notes" id="hiddenNotes"> <!-- Trường ẩn để gửi ghi chú -->
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
    document.addEventListener("DOMContentLoaded", function () {
        const paymentButtons = document.querySelectorAll(".btn-payment");

        paymentButtons.forEach(button => {
            button.addEventListener("click", function () {
                const idOrder = this.getAttribute("data-idOrder");
                const image = this.getAttribute("data-image");
                const nameProduct = this.getAttribute("data-nameProduct");
                const price = this.getAttribute("data-price");
                const numDate = this.getAttribute("data-numDate");
                const totalPrice = this.getAttribute("data-totalPrice");

                // Cập nhật nội dung modal
                document.querySelector("#orderPayment .room-image").src = image;
                document.querySelector("#orderPayment .room-title").textContent = nameProduct;
                document.querySelector("#orderPayment .price").textContent = price + " đ";
                document.querySelector("#orderPayment .numDate").textContent = numDate + " Ngày";
                document.querySelector("#orderPayment .totalPrice").textContent = totalPrice + " đ";

                // Cập nhật giá trị idOrder và notes
                document.getElementById("idOrder").value = idOrder;

                // Hiển thị modal
                var myModal = new bootstrap.Modal(document.getElementById("orderPayment"));
                myModal.show();
            });
        });

        document.getElementById("PayOrder").addEventListener("submit", function () {
            const notes = document.getElementById("notes").value; // Lấy giá trị ghi chú
            document.getElementById("hiddenNotes").value = notes; // Cập nhật giá trị vào trường ẩn
    });
    });
</script>

</body>
</html>
