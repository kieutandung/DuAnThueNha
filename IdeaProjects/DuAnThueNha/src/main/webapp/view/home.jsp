<%@ page import="com.example.duanthuenha.Model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.duanthuenha.Service.Host.ProductImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Home Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.3.1/mdb.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="/js/home.js"></script>
    <link rel="stylesheet" href="/css/home.css">
</head>
<body>
<header>
    <jsp:include page="header.jsp"/>
</header>
<div class="container my-5">
    <h2 class="mb-4">Danh sách sản phẩm</h2>
    <div class="row">
        <%
            ProductImpl productImpl = new ProductImpl();
            List<Product> productList = productImpl.getAllProducts();

            for (Product product : productList) {
        %>
        <div class="col-md-4 mb-4">
            <div class="card">

                <img src="<%= product.getImage() %>" alt="Anh">

                <div class="card-body">
                    <h5 class="card-title"><%= product.getNameProduct() %>
                    </h5>
                    <%--<p class="card-text"><%= product.getProductDescription() %></p>--%>
                    <p><strong>Giá:</strong> <%= product.getPrice() %> VNĐ</p>
                    <p><strong>Địa chỉ:</strong> <%= product.getAddress() %>
                    </p>
                    <p><strong>Trạng thái:</strong> <%= product.getStatus() %>
                    </p>

                    <a href="rentHouse.jsp?id=<%= product.getIdProduct() %>" class="btn-thue-ngay">Thuê ngay</a>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>
<footer class="mt-5">
    <jsp:include page="footer.jsp"/>
</footer>
</body>
</html>
