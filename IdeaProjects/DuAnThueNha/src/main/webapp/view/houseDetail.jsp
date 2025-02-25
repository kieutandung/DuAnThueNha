<%@ page import="com.example.duanthuenha.Model.Product" %>
<%@ page import="com.example.duanthuenha.Service.Host.ProductImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String productId = request.getParameter("id");

    // Gọi service để lấy sản phẩm theo ID
    ProductImpl productImpl = new ProductImpl();
    Product product = productImpl.getAllProductsById(Integer.parseInt(productId));
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết nhà thuê</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/detail.css">

</head>
<body>
<header>
    <jsp:include page="header.jsp"/>
</header>

<div class="container d-flex justify-content-center align-items-center flex-column">
    <div class="row w-75">
        <div class="col-md-7 d-flex justify-content-center">
            <img src="<%= product.getImage() %>" class="house-image" alt="Hình ảnh sản phẩm">
        </div>
        <div class="col-md-5">
            <div class="house-info text-center">
                <h2><%= product.getNameProduct() %></h2>
                <p><i class="bi bi-geo-alt-fill"></i> <strong>Địa chỉ:</strong> <%= product.getAddress() %></p>
                <p class="price"><i class="bi bi-cash"></i> Giá thuê: <%= product.getPrice() %> VND</p>
                <p><strong>Mô tả:</strong> <%= product.getProductDescription() %></p>
                <p class="status"><i class="bi bi-check-circle"></i> Trạng thái: <%= product.getStatus() %></p>
                <a href="rentHouse.jsp?id=${product.idProduct}" class="btn btn-primary btn-rent">
                    <i class="bi bi-house-door-fill"></i> Thuê ngay
                </a>
            </div>
        </div>
    </div>

    <div class="text-center mt-4">
        <a href="home.jsp" class="btn btn-secondary">
            <i class="bi bi-arrow-left"></i> Quay lại danh sách
        </a>
    </div>
</div>

<footer class="mt-5 text-center">
    <jsp:include page="footer.jsp"/>
</footer>
</body>
</html>
