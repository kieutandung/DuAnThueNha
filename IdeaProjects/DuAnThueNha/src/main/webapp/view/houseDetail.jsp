<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết nhà thuê</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            padding-top: 30px;
        }
        .house-image {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 10px;
        }
        .house-info {
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .price {
            font-size: 22px;
            font-weight: bold;
            color: red;
        }
        .status {
            font-weight: bold;
            font-size: 16px;
            color: green;
        }
        .btn-rent {
            width: 100%;
            font-size: 18px;
            padding: 10px;
        }
    </style>
</head>

<body>
<header>
    <jsp:include page="header.jsp"/>
</header>

<div class="container">
    <c:forEach var="product" items="${productList}">
        <div class="row mb-4">
            <div class="col-md-7">
                <img src="image/${product.image}" class="house-image" alt="${product.nameProduct}">
            </div>

            <div class="col-md-5">
                <div class="house-info">
                    <h2>${product.nameProduct}</h2>
                    <p><i class="bi bi-geo-alt-fill"></i> <strong>Địa chỉ:</strong> ${product.address}</p>
                    <p class="price"><i class="bi bi-cash"></i> Giá thuê: ${product.price} VND</p>
                    <p><strong>Mô tả:</strong> ${product.productDescription}</p>
                    <p class="status"><i class="bi bi-check-circle"></i> Trạng thái: ${product.status}</p>

                    <!-- Nút Thuê Ngay -->
                    <button class="btn btn-primary btn-rent" data-bs-toggle="modal" data-bs-target="#rentalModal">
                        THUÊ NGAY
                    </button>

                </div>
            </div>
        </div>
    </c:forEach>
</div>
<%--<!-- Modal đặt thuê nhà -->--%>
<%--<div class="modal fade" id="rentalModal" tabindex="-1" aria-labelledby="rentalModalLabel" aria-hidden="true">--%>
<%--    <div class="modal-dialog">--%>
<%--        <div class="modal-content">--%>
<%--            <div class="modal-header">--%>
<%--                <h5 class="modal-title" id="rentalModalLabel">Nhập thông tin thuê nhà</h5>--%>
<%--                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>--%>
<%--            </div>--%>
<%--            <div class="modal-body">--%>
<%--                <form action="submitRental.jsp" method="post">--%>
<%--                    <div class="mb-3">--%>
<%--                        <label class="form-label">Ngày bắt đầu</label>--%>
<%--                        <div class="d-flex gap-2">--%>
<%--                            <input type="number" class="form-control" placeholder="Ngày" name="start_day">--%>
<%--                            <input type="number" class="form-control" placeholder="Tháng" name="start_month">--%>
<%--                            <input type="number" class="form-control" placeholder="Năm" name="start_year">--%>
<%--                        </div>--%>
<%--                    </div>--%>

<%--                    <div class="mb-3">--%>
<%--                        <label class="form-label">Số ngày thuê</label>--%>
<%--                        <input type="number" class="form-control" name="rental_days" placeholder="Nhập số ngày">--%>
<%--                    </div>--%>

<%--                    <div class="mb-3">--%>
<%--                        <label class="form-label">Ghi chú</label>--%>
<%--                        <textarea class="form-control" rows="3" name="note" placeholder="Nhập ghi chú"></textarea>--%>
<%--                    </div>--%>

<%--                    <button type="submit" class="btn btn-success w-100">Xác nhận thuê</button>--%>
<%--                </form>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<footer class="mt-5">
    <jsp:include page="footer.jsp"/>
</footer>

</body>
</html>
