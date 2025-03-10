<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="vi">
<head>
    <title>Viết đánh giá</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/favorite.css">
    <style>
        .review-card {
            margin: 20px auto;
            max-width: 600px;
        }
    </style>
</head>
<body>
<jsp:include page="../header.jsp"/>

<section class="hero">
    <h2> Đánh giá sản phẩm</h2>
</section>

<div class="container review-card mt-5">
    <div class="card">
        <div class="card-body">
            <div class="mb-4">
                <h5 class="mb-3 text-center"><strong>Thông tin đơn hàng</strong></h5>
                <div class="row align-items-center">
                    <div class="col-md-4">
                        <img src="img/${product.image}" alt="${product.nameProduct}" class="img-fluid rounded">
                    </div>
                    <div class="col-md-8 d-flex flex-column justify-content-center">
                        <p><strong>Tên sản phẩm:</strong> ${product.nameProduct}</p>
                        <p><strong>Địa chỉ:</strong> ${product.address}</p>
                        <p><strong>Giá thuê:</strong> <fmt:formatNumber value="${product.price}" pattern="#,###"/> VNĐ</p>
                        <p><strong>Số người thuê:</strong> ${order.numPeople}</p>
                        <p><strong>Ngày thuê:</strong> ${order.startDate}</p>
                        <p><strong>Ngày trả:</strong> ${order.endDate}</p>
                        <p><strong>Diện tích:</strong> ${product.area}<sup>2</sup></p>
                    </div>
                </div>
            </div>

            <form action="commentServlet" method="post">
                <input type="hidden" name="userId" value="${sessionScope.userId}">
                <input type="hidden" name="productId" value="${param.productId}">

                <div class="input-group mb-3">
                    <span class="input-group-text text-center" id="rating-label">Chất lượng nhà:</span>
                    <select name="rating" id="rating" class="form-select" required>
                        <option value="">Chọn số sao</option>
                        <option value="5">⭐⭐⭐⭐⭐ (5 sao)</option>
                        <option value="4">⭐⭐⭐⭐ (4 sao)</option>
                        <option value="3">⭐⭐⭐ (3 sao)</option>
                        <option value="2">⭐⭐ (2 sao)</option>
                        <option value="1">⭐ (1 sao)</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="reviewText" class="form-label">Nội dung đánh giá:</label>
                    <textarea name="reviewText" id="reviewText" class="form-control" rows="5" required></textarea>
                </div>

                <button type="submit" class="btn btn-primary">Gửi đánh giá</button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../footer2.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
