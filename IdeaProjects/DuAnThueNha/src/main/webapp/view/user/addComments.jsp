<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="vi">
<head>
    <title>Viết đánh giá</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .review-card {
            margin: 20px auto;
            max-width: 600px;
        }
    </style>
</head>
<body>
<jsp:include page="../header.jsp"/>

<div class="container review-card mt-5">
    <div class="card">
        <div class="card-header bg-primary text-white">
            Viết đánh giá cho đơn hàng <strong>${param.orderId}</strong>
        </div>
        <div class="card-body">
            <form action="commentServlet" method="post">
                <input type="hidden" name="userId" value="${sessionScope.userId}">
                <input type="hidden" name="productId" value="${param.productId}">

                <div class="mb-3">
                    <label for="rating" class="form-label">Chọn số sao:</label>
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
