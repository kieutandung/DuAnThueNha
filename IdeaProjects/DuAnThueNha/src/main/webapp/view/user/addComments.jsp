<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="vi">
<head>
    <title>Viết đánh giá</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/favorite.css">
</head>
<body>
<jsp:include page="../header.jsp"/>

<section class="hero">
    <h2>Đánh giá sản phẩm</h2>
</section>

<div class="container">
    <div class="review-card">
        <h4 class="text-center">Chia sẻ cảm nhận của bạn</h4>
        <form action="commentServlet" method="post">
            <input type="hidden" name="userId" value="${sessionScope.userId}">
            <input type="hidden" name="productId" value="${param.productId}">

            <div class="mb-3">
                <label for="rating" class="form-label">Chất lượng nhà:</label>
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

            <button type="submit" class="btn btn-primary w-100">Gửi đánh giá</button>
        </form>
    </div>
</div>

<jsp:include page="../footer2.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
