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
<section class="hero">
    <h2>We Bare Bears.vn xứng đáng với lựa chọn của bạn</h2>
    <form action="homeUserServlet" method="post">
        <div class="search-bar">
            <select name="category">
                <option value="">Loại nhà đất</option>
                <option ${category eq 'Căn hộ' ? 'selected' : ''} >Căn hộ</option>
                <option ${category eq 'Biệt thự' ? 'selected' : ''} >Biệt thự</option>
                <option ${category eq 'Chung cư' ? 'selected' : ''} >Chung cư</option>
            </select>
            <input value="${keywordUser}" name="keyword" type="text" placeholder="Nhập địa điểm, diện tích hoặc từ khóa"
                   style="border: 2px solid #c4c5bc;
              border-radius: 5px;
              padding: 8px;
              width: 250px;
              background-color: transparent;">
            <button type="submit"><i class="fas fa-search" style="color: white; margin-right: 5px;"></i> TÌM KIẾM
            </button>
        </div>
    </form>
</section>
<div class="container my-5">
    <h2 class="mb-4" style="font-weight: bold">Danh sách sản phẩm</h2>
    <c:choose>
        <c:when test="${not empty listProduct}">
            <div class="row">
                <c:forEach var="p" items="${listProduct}">
                    <div class="col-md-4 mb-4">
                        <input type="hidden" name="id" value="${p.idProduct}">
                        <div class="card">
                            <img src="img/${p.image}" alt="Ảnh" onclick="redirectToDetail('${p.idProduct}')">
                            <div class="card-body">
                                <h5 class="card-title">${p.nameProduct}</h5>
                                <p><strong>Giá:</strong> ${p.getFormattedPrice()}</p>
                                <p><strong>Địa chỉ:</strong> ${p.address}</p>
                                <p><strong>Diện tích</strong> ${p.area} m2</p>
                                <c:choose>
                                    <c:when test="${p.status eq 'Hết chỗ'}">
                                        <p class="status" style="color: #f93434">
                                            <i class="bi bi-x-circle"></i> Trạng thái:
                                            <span style="color: red;">${p.status}</span>
                                        </p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="status" style="color: green">
                                            <i class="bi bi-check-circle"></i> Trạng thái:
                                            <span>${p.status}</span>
                                        </p>
                                    </c:otherwise>
                                </c:choose>
                                <a href="/orderProductServlet?productId=${p.idProduct}" class="btn-thue-ngay">
                                    <i class="bi bi-house-door-fill"></i> Thuê ngay
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row">
                <div class="col-12 text-center">
                    <p style="color: red">Không tìm thấy sản phẩm với từ khóa "${keywordUser}"
                    </p>
                    <a href="/homeUserServlet">
                        <i class="bi bi-house-door-fill"></i> Trở lại trang chủ
                    </a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
    <ul class="pagination">
        <c:if test="${tag > 1}">
            <li class="page-item disabled"><a href="homeUserServlet?page=${tag - 1}"> Trước </a></li>
        </c:if>
        <c:forEach var="i" begin="1" end="${endPageUser}">
            <li class="page-item ${tag == i?"active":""}"><a href="homeUserServlet?page=${i}" class="page-link">${i}</a>
            </li>
        </c:forEach>
        <c:if test="${tag < endPageUser}">
            <li class="page-item"><a href="homeUserServlet?page=${tag + 1}" class="page-link"> Tiếp </a></li>
        </c:if>
    </ul>

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