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
    <script src="/js/rentHouse.js"></script>

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

<form action="rentHouseServlet" method="post">
    <input type="hidden" name="idProduct" value="${product.idProduct}">

    <div class="main-container">
        <div class="col-md-5 rental-info">
            <h3 class="text-primary">Thông tin thuê nhà</h3>

            <label for="startDate" class="form-label">Ngày bắt đầu:</label>
            <input type="date" id="startDate" name="startDate" class="form-control" required>

            <label for="endDate" class="form-label mt-2">Ngày kết thúc:</label>
            <input type="date" id="endDate" name="endDate" class="form-control mt-2" required>

            <label class="form-label mt-2">Số người thuê:</label>
            <input type="number" id="numPeople" name="numPeople" class="form-control" min="1" placeholder="Nhập số người" required>

            <label class="form-label mt-2">Ghi chú:</label>
            <textarea id="note" name="notes" class="form-control" rows="3"></textarea>

            <button type="button" class="btn btn-primary mt-4 btn-confirm">Xác nhận</button>
        </div>

        <div class="separator-vertical"></div>

        <div class="col-md-5 order-summary">
            <h3 class="text-dark">Đơn hàng</h3>
            <div class="house-info position-relative">
                <img src="${product.image}" class="house-image" alt="Hình ảnh sản phẩm">
                <p class="house-name"><strong>Tên nhà: </strong> <span id="houseName"><c:out value="${product.nameProduct}"/></span></p>
                <p><strong>Giá/ngày: </strong><span id="pricePerDay"><c:out value="${product.getFormattedPrice()}"/></span> VNĐ</p>
                <p><strong>Ngày đặt: </strong> <span id="orderDate">-</span></p>
                <p><strong>Ngày kết thúc: </strong> <span id="displayEndDate">-</span></p>
                <p style="margin-bottom: 43px"><strong>Thành tiền:</strong> <span id="totalAmount">0</span> VNĐ</p>

                <button type="submit" class="btn btn-success btn-rent mt-5">Thuê ngay</button>
            </div>
        </div>
    </div>
</form>


<footer class="mt-5">
    <jsp:include page="../footer.jsp"/>
</footer>

</body>
</html>
