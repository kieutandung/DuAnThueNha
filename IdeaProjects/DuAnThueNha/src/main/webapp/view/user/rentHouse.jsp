<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title> Gửi yêu cầu nhà thuê</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/rentHouse.css">
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

        .house-image {
            width: 100%;
            height: auto;
            border-radius: 10px;
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
    <jsp:include page="../header.jsp"/>
</header>


<div class="main-container">
    <div class="col-md-5 rental-info">
        <h3 class="text-primary">Thông tin thuê nhà</h3>

        <label for="startDate" class="form-label">Ngày bắt đầu:</label>
        <input type="date" id="startDate" class="form-control" required>

        <label class="form-label mt-2">Đặt ngày:</label>
        <div class="date-buttons">
            <button type="button" class="btn btn-outline-primary duration-btn" data-days="3">3 ngày</button>
            <button type="button" class="btn btn-outline-primary duration-btn" data-days="7">7 ngày</button>
            <button type="button" class="btn btn-outline-primary duration-btn" data-days="10">10 ngày</button>
            <button type="button" class="btn btn-outline-primary duration-btn" data-days="15">15 ngày</button>
        </div>

        <label for="endDatePicker" class="form-label mt-2">Ngày kết thúc:</label>
        <input type="date" id="endDatePicker" class="form-control mt-2" required>

        <label class="form-label mt-2">Số người thuê:</label>
        <input type="number" id="numPeople" class="form-control" min="1" placeholder="Nhập số người">

        <label class="form-label mt-2">Ghi chú:</label>
        <textarea id="note" class="form-control" rows="3"></textarea>
    </div>

    <div class="separator-vertical"></div>

    <div class="col-md-5 order-summary" >
        <h3 class="text-dark">Đơn hàng</h3>
        <div class="house-info position-relative">
            <div class="house-info position-relative ">
                <img src=img/${product.image} class="house-image" alt="Hình ảnh sản phẩm">
                <p class="house-name"><strong>Tên nhà: </strong> <span id="houseName"><c:out
                        value="${product.nameProduct}"/></span></p>
                <p><strong>Giá: </strong><span id="pricePerDay"><c:out value="${product.getFormattedPrice()}"/></span></p>
                <p><strong>Số người thuê:</strong> <span id="numPeopleOrder">-</span></p>
                <p><strong>Ngày đặt: </strong> <span id="orderDate">-</span></p>
                <p><strong>Ngày kết thúc:</strong> <span id="endDate">-</span></p>
                <p style="margin-bottom: 43px"><strong>Thành tiền:</strong> <span id="totalAmount">0</span> VNĐ</p>

                <button class="btn btn-success btn-rent mt-5 ">Thuê ngay</button>
            </div>

        </div>
    </div>
</div>

<script src="/js/rentHouse.js"></script>
</body>
<footer class="mt-5">
    <jsp:include page="../footer.jsp"/>
</footer>
</html>

