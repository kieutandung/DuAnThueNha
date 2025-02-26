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


                <label class="form-label mt-2">Thuê dài hạn:</label>
                <select id="rentalType" class="form-control">
                    <option value="Tháng">Tháng</option>
                    <option value="Năm">Năm</option>
                </select>


                <label class="form-label mt-2">Ghi chú:</label>
                <textarea id="note" class="form-control" rows="3"></textarea>

                <button type="button" class="btn btn-primary mt-3" onclick="updateOrder()">Xác nhận thuê</button>
            </div>


            <div class="col-md-6">
                <h3 class="text-dark">Đơn hàng</h3>
                <div class="house-info">
                    <img src="<%= product.getImage() %>" class="house-image" alt="Hình ảnh sản phẩm">

                    <p><strong>Tên nhà: </strong> <span id="houseName"><c:out value="<%= product.getNameProduct() %>"/></span></p>
                    <p><strong>Giá: </strong><span id="pricePerDay"><c:out value="<%= product.getFormattedPrice() %>"/></span></p>
                    <p><strong>Ngày đặt: </strong> <span id="orderDate">-</span></p>
                    <p><strong>Ngày kết thúc:</strong> <span id="endDate">-</span></p>
                    <p><strong>Thành tiền:</strong> <span id="totalAmount">0</span> VND</p>

                    <button class="btn btn-success btn-rent">ĐẶT HÀNG</button>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="mt-5">
    <jsp:include page="footer.jsp"/>
</footer>

<script>
    function updateOrder() {
        let startDate = document.getElementById("startDate").value;
        let numDays = document.getElementById("numDays").value;
        let rentalType = document.getElementById("rentalType").value;
        let pricePerDay = 9999999;
        if (!startDate || !numDays) {
            alert("Vui lòng nhập đầy đủ thông tin!");
            return;
        }


        let startDateObj = new Date(startDate);
        let endDateObj = new Date(startDateObj);
        endDateObj.setDate(startDateObj.getDate() + parseInt(numDays));


        let totalAmount = pricePerDay * parseInt(numDays);


        document.getElementById("orderDate").innerText = startDate;
        document.getElementById("endDate").innerText = endDateObj.toISOString().split('T')[0];
        document.getElementById("totalAmount").innerText = totalAmount.toLocaleString() ;
    }


    document.querySelectorAll(".duration-btn").forEach(button => {
        button.addEventListener("click", function() {
            document.getElementById("numDays").value = this.dataset.days;
        });
    });
</script>
</body>
</html>

