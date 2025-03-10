<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Sản phẩm yêu thích</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="/css/favorite.css">
</head>

<header>
    <jsp:include page="../header.jsp"/>
</header>

<section class="hero">
    <h2> Danh sách sản phẩm yêu thích</h2>
</section>

<body>
<div class="container mx-auto">

    <c:if test="${empty listProduct}">
        <p class="text-center text-gray-600">Bạn chưa có sản phẩm yêu thích nào.</p>
    </c:if>

    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        <c:forEach var="p" items="${listProduct}">
            <div class="border rounded-lg shadow-lg p-4 bg-white relative mt-4">
                <div class="relative h-48">
                    <img src="img/${p.image}" alt="Ảnh" onclick="redirectToDetail('${p.idProduct}')"
                         class="w-full h-full object-cover mx-auto block">
                </div>
                <h2 class="text-lg font-semibold mt-4 truncate">${p.nameProduct}</h2>
                <p class="text-gray-600 truncate">${p.address}</p>
                <p class="text-gray-600">Giá: <fmt:formatNumber value="${p.price}" pattern="#,###"/> VNĐ</p>
                <p class="text-gray-600 mb-3">
                    Diện tích: ${p.area} m<sup>2</sup>
                </p>
                <div class="flex justify-end">
                    <i class="fas fa-heart text-red-500 text-2xl cursor-pointer"></i>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<footer class="mt-5 text-center">
    <jsp:include page="../footer2.jsp"/>
</footer>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/js/favorite.js"></script>
<script>
    function redirectToDetail(productId) {
        window.location.href = '/detailProductUser?productId=' + encodeURIComponent(productId);
    }
</script>
</body>
</html>
