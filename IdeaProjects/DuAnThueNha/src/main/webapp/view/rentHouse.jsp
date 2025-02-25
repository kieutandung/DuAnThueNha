<%--
  Created by IntelliJ IDEA.
  User: tranz_quyzn
  Date: 25/02/2025
  Time: 8:21 SA
  To change this template use File | Settings | File Templates.
--%>
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
        .form-container, .order-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
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
            <!-- Phần nhập thông tin thuê nhà -->
            <div class="col-md-6">
                <h3 class="text-primary">Thông tin thuê nhà</h3>

                <!-- Ngày bắt đầu -->
                <label for="startDate" class="form-label">Ngày bắt đầu:</label>
                <input type="date" id="startDate" class="form-control" required>

                <!-- Chọn số ngày thuê -->
                <label class="form-label mt-2">Đặt ngày:</label>
                <div>
                    <button type="button" class="btn btn-outline-primary duration-btn" data-days="3">3 ngày</button>
                    <button type="button" class="btn btn-outline-primary duration-btn" data-days="7">7 ngày</button>
                    <button type="button" class="btn btn-outline-primary duration-btn" data-days="10">10 ngày</button>
                </div>
                <input type="number" id="numDays" class="form-control mt-2" placeholder="Nhập số ngày" required>

                <!-- Chọn thuê theo tháng/năm -->
                <label class="form-label mt-2">Thuê dài hạn:</label>
                <select id="rentalType" class="form-control">
                    <option value="Tháng">Tháng</option>
                    <option value="Năm">Năm</option>
                </select>

                <!-- Ghi chú -->
                <label class="form-label mt-2">Ghi chú:</label>
                <textarea id="note" class="form-control" rows="3"></textarea>

                <button type="button" class="btn btn-primary mt-3" onclick="updateOrder()">Xác nhận thuê</button>
            </div>

            <!-- Phần hiển thị đơn hàng -->
            <div class="col-md-6">
                <h3 class="text-dark">Đơn hàng</h3>
                <div class="house-info">
                    <!-- Hình ảnh nhà -->
                    <img id="houseImage" src="images/sample-house.jpg" class="img-fluid house-image" alt="Hình ảnh nhà">

                    <!-- Thông tin đơn hàng -->
                    <p><strong>Biệt thự:</strong> <span id="houseName">Biệt thự vườn Cầu Giấy</span></p>
                    <p><strong>Giá/ngày:</strong> <span id="pricePerDay">9999999</span> VND</p>
                    <p><strong>Ngày đặt:</strong> <span id="orderDate">-</span></p>
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
        // Lấy giá trị từ form nhập
        let startDate = document.getElementById("startDate").value;
        let numDays = document.getElementById("numDays").value;
        let rentalType = document.getElementById("rentalType").value;
        let pricePerDay = 9999999; // Giá cố định (có thể lấy từ backend)

        if (!startDate || !numDays) {
            alert("Vui lòng nhập đầy đủ thông tin!");
            return;
        }

        // Chuyển đổi ngày bắt đầu thành đối tượng Date
        let startDateObj = new Date(startDate);
        let endDateObj = new Date(startDateObj);
        endDateObj.setDate(startDateObj.getDate() + parseInt(numDays));

        // Tính tổng tiền
        let totalAmount = pricePerDay * parseInt(numDays);

        // Hiển thị dữ liệu vào đơn hàng
        document.getElementById("orderDate").innerText = startDate;
        document.getElementById("endDate").innerText = endDateObj.toISOString().split('T')[0];
        document.getElementById("totalAmount").innerText = totalAmount.toLocaleString() ;
    }

    // Khi click vào nút số ngày, tự động điền vào input số ngày
    document.querySelectorAll(".duration-btn").forEach(button => {
        button.addEventListener("click", function() {
            document.getElementById("numDays").value = this.dataset.days;
        });
    });
</script>
</body>
</html>

