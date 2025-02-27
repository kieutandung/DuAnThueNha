<%@ page import="com.example.duanthuenha.Model.Product" %>
<%@ page import="com.example.duanthuenha.Service.Host.ProductImpl" %>
<%@ page import="com.example.duanthuenha.Model.Comment" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.duanthuenha.Service.Comment.CommentImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String productId = request.getParameter("id");

    ProductImpl productImpl = new ProductImpl();
    Product product = productImpl.getAllProductsById(Integer.parseInt(productId));

    CommentImpl commentService = new CommentImpl();
    List<Comment> comments = commentService.getCommentsByProductId(Integer.parseInt(productId));
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết nhà thuê</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="/css/detail.css">
</head>
<body>
<header>
    <jsp:include page="header.jsp"/>
</header>

<div class="container">
    <div class="row">
        <div class="col-md-7">
            <div id="productCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach var="img" items="<%= product.getAdditionalImages()%>" varStatus="status">
                        <div class="carousel-item ${status.first ? '' : 'active'}">
                            <img src="${img}" class="d-block w-100" alt="Hình ảnh bổ sung">
                        </div>
                    </c:forEach>
                </div>

                <button class="carousel-control-prev" type="button" data-bs-target="#productCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon"></span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#productCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon"></span>
                </button>
            </div>
        </div>

        <div class="col-md-5">
            <h2><%= product.getNameProduct() %>
            </h2>
            <p><i class="bi bi-geo-alt-fill"></i> <strong>Địa chỉ:</strong> <%= product.getAddress() %>
            </p>
            <p class="price"><i class="bi bi-cash"></i> Giá thuê: <%= product.getFormattedPrice() %></p>
            <p><strong>Mô tả:</strong> <%= product.getProductDescription() %>
            </p>
            <p class="status"><i class="bi bi-check-circle"></i> Trạng thái: <%= product.getStatus() %>
            </p>

            <h5>Chủ nhà</h5>
            <div class="d-flex align-items-center">
                <img src="<%= product.getOwnerImage() %>" class="rounded-circle me-2" width="80" height="80"
                     alt="Ảnh chủ nhà">
                <p><strong><%= product.getOwnerName() %>
                </strong></p>

            </div>

            <a href="rentHouse.jsp?id=<%= product.getIdProduct() %>" class="btn btn-primary mt-3">
                <i class="bi bi-house-door-fill"></i> Thuê ngay
            </a>
            <button class="btn btn-outline-danger mt-3" id="favoriteBtn" onclick="toggleFavorite(<%= product.getIdProduct() %>)">
                <i id="favoriteIcon" class="bi bi-heart"></i> Yêu thích
            </button>
        </div>
    </div>

    <div class="mt-4">
        <h4><i class="bi bi-chat-left-text"></i> Đánh giá sản phẩm</h4>
        <div class="list-group">
            <c:forEach var="comment" items="<%= comments %>">
                <div class="list-group-item d-flex align-items-start">
                    <div class="me-3">
                        <i class="bi bi-person-circle fs-2"></i>
                    </div>
                    <div>
                        <h6 class="mb-1">${comment.username}</h6>
                        <p class="mb-1">${comment.comment}</p>
                        <small class="text-muted"><i class="bi bi-clock"></i> ${comment.commentDate}</small>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <div class="mt-4">
        <h4>Thêm đánh giá</h4>
        <form action="addComment.jsp" method="post">
            <input type="hidden" name="idProduct" value="<%= productId %>">
            <div class="mb-3">
                <textarea name="comment" class="form-control" rows="3" required placeholder="Viết đánh giá của bạn..."></textarea>
            </div>
            <button type="submit" class="btn btn-primary"><i class="bi bi-send"></i> Gửi đánh giá</button>
        </form>
    </div>
</div>


<footer class="mt-5 text-center">
    <jsp:include page="footer.jsp"/>
</footer>


<script>
    function changeImage(smallImg) {
        let mainImage = document.getElementById("mainImage");
        mainImage.src = smallImg.src;
    }
</script>

</body>
</html>
