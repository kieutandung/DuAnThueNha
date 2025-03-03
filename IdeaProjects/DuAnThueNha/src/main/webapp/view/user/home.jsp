<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Home Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.3.1/mdb.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <script src="/js/home.js"></script>
    <link rel="stylesheet" href="/css/home.css">
</head>
<body>
<header>
    <jsp:include page="../header.jsp"/>
</header>
<div class="container my-5">
    <h2 class="mb-4">Danh sách sản phẩm</h2>
    <div class="row">
        <c:forEach var="p" items="${listProduct}">

            <div class="col-md-4 mb-4">
                <input type="hidden" name="id" value="${p.idProduct}">

                <div class="card" >
                    <img src="img/${p.image}" alt="Anh" onclick="redirectToDetail('${p.idProduct}')">

                    <div class="card-body">
                        <h5 class="card-title"> ${p.nameProduct}</h5>
                        <p><strong>Giá:</strong> ${p.getFormattedPrice()}</p>
                        <p><strong>Địa chỉ:</strong> ${p.address}</p>
                        <p><strong>Trạng thái:</strong> ${p.status}</p>

                        <a href="/detailProductUser" class="btn-thue-ngay">
                            <i class="bi bi-house-door-fill"></i> Thuê ngay
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<script>
    function redirectToDetail(productId) {
        window.location.href = '/detailProductUser?productId=' + encodeURIComponent(productId);
    }
</script>
<footer class="mt-5">
    <jsp:include page="../footer.jsp"/>
</footer>
</body>
</html>