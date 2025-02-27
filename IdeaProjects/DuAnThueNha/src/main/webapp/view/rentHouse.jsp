<%@ page import="com.example.duanthuenha.Model.Product" %>
<%@ page import="com.example.duanthuenha.Service.Host.ProductImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String productId = request.getParameter("id");
    ProductImpl productImpl = new ProductImpl();
    Product product = productImpl.getAllProductsById(Integer.parseInt(productId));
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title> Gửi yêu cầu nhà thuê</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            padding-top: 30px;
        }

        .btn-rent {
            width: 100%;
            font-size: 18px;
            padding: 10px;
        }
        .house-image { width: 100%; height: auto; border-radius: 10px;
        }
        .house-info {
            position: relative;
            padding-bottom: 50px;
        }

        .btn-rent {
            position: absolute;
            bottom: 10px;
            right: 10px;
            width: auto;
            padding: 10px 20px;
        }

    </style>
</head>

<body>
<header>
    <jsp:include page="header.jsp"/>
</header>

<div class="container">
    <div class="container mt-4">
        <div class="row">

            <div class="col-md-6">
                <h3 class="text-primary">Thông tin thuê nhà</h3>


                <label for="startDate" class="form-label">Ngày bắt đầu:</label>
                <input type="date" id="startDate" class="form-control" required>


                <label class="form-label mt-2">Đặt ngày:</label>
                <div>
                    <button type="button" class="btn btn-outline-primary duration-btn" data-days="3">3 ngày</button>
                    <button type="button" class="btn btn-outline-primary duration-btn" data-days="7">7 ngày</button>
                    <button type="button" class="btn btn-outline-primary duration-btn" data-days="10">10 ngày</button>
                </div>
                <input type="number" id="numDays" class="form-control mt-2" placeholder="Nhập số ngày" required>


                <label class="form-label mt-2">Số người thuê:</label>
                <input type="number" id="numPeople" class="form-control" min="1" placeholder="Nhập số người">



                <label class="form-label mt-2">Ghi chú:</label>
                <textarea id="note" class="form-control" rows="3"></textarea>

                <button type="button" class="btn btn-primary mt-3" onclick="updateOrder()">Xác nhận thuê</button>
            </div>


            <div class="col-md-6">
                <h3 class="text-dark">Đơn hàng</h3>
                <div class="house-info position-relative">
                    <img src="<%= product.getImage() %>" class="house-image" alt="Hình ảnh sản phẩm">
                    <p><strong>Tên nhà: </strong> <span id="houseName"><c:out value="<%= product.getNameProduct() %>"/></span></p>
                    <p><strong>Giá: </strong><span id="pricePerDay"><c:out value="<%= product.getFormattedPrice() %>"/></span></p>
                    <p><strong>Ngày đặt: </strong> <span id="orderDate">-</span></p>
                    <p><strong>Ngày kết thúc:</strong> <span id="endDate">-</span></p>
                    <p><strong>Thành tiền:</strong> <span id="totalAmount">0</span> VND</p>

                    <button class="btn btn-success btn-rent">Thuê ngay</button>
                </div>

            </div>
        </div>
    </div>
</div>

<footer class="mt-5">
    <jsp:include page="footer.jsp"/>
</footer>

</body>
</html>

