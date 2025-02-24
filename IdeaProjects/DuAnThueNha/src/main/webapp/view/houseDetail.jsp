<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết thông tin nhà</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body>
<header>
    <jsp:include page="header.jsp"/>
</header>
<div class="container mt-4">
    <h2 class="text-center">Chi tiết nhà thuê</h2>
    <div class="row">
        <div class="col-md-8">
            <img src="images/house1.jpg" class="img-fluid" alt="Hình ảnh nhà">
            <h3>${product.nameProduct}</h3>
            <p><strong>Địa chỉ:</strong> ${product.address}</p>
            <p><strong>Giá thuê:</strong> ${product.price} VND</p>
            <p><strong>Mô tả:</strong> ${product.productDescription}</p>
            <p><strong>Trạng thái:</strong> ${product.status}</p>
            <a href="rent-house.jsp?id=${product.idProduct}" class="btn btn-primary">Thuê ngay</a>
        </div>
    </div>
    <a href="house-list.jsp" class="btn btn-secondary mt-3">Quay lại danh sách</a>
</div>
<footer>
    <jsp:include page="footer.jsp"/>
</footer>

</body>
</html>
