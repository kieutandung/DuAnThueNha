<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết nhà thuê</title>
    <link rel="stylesheet" href="css/detail.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/houseDetail.js"></script>
</head>
<body>
<header>
    <jsp:include page="../header.jsp"/>
</header>

<div class="container">
    <div class="row">
        <div class="col-md-7">
            <div id="productCarousel" class="carousel slide" data-bs-ride="carousel">

                <div class="carousel-inner">
                    <c:forEach var="i" items="${listImage}" varStatus="status">
                        <div class="carousel-item ${status.first ? 'active' : ''}">
                            <img src="img/${i.img}" class="d-block w-100" alt="Hình ảnh bổ sung">
                        </div>
                    </c:forEach>
                </div>

                <button class="carousel-control-prev" type="button" data-bs-target="#productCarousel"
                        data-bs-slide="prev">
                    <span class="carousel-control-prev-icon"></span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#productCarousel"
                        data-bs-slide="next">
                    <span class="carousel-control-next-icon"></span>
                </button>

            </div>
        </div>

        <div class="col-md-5">
            <h2>
                ${product.nameProduct}
            </h2>
            <button id="complaintBtn">
                <i class="fas fa-exclamation-triangle"></i> Khiếu nại
            </button>

            <!-- Hộp khiếu nại (Ẩn mặc định) -->
            <div id="complaint-popup" class="hidden">
                <h3>Lý do:</h3>
                <ul>
                    <li><input type="radio" name="reason" value="quality"> Không hài lòng về chất lượng phòng thực tế</li>
                    <li><input type="radio" name="reason" value="service"> Thái độ phục vụ của nhân viên</li>
                    <li><input type="radio" name="reason" value="equipment"> Chất lượng các trang thiết bị trong phòng</li>
                    <li><input type="radio" name="reason" value="noise"> Tiếng ồn xung quanh làm bạn không ngủ được</li>
                    <li>
                        <input type="radio" name="reason" value="other" id="otherReason"> Lý do khác
                        <input type="text" id="otherReasonText" class="hidden" placeholder="Nhập lý do của bạn...">
                    </li>
                </ul>
                <button id="submit-complaint">Gửi khiếu nại</button>
                <button id="close-popup">Đóng</button>
            </div>

            <p class="my-2"><i class="bi bi-geo-alt-fill"></i> <strong>Địa chỉ:</strong> ${product.address}
            </p>
            <c:choose>
                <c:when test="${product.status eq 'Hết chỗ'}">
                    <p class="status" style="color: #f93434">
                        <i class="bi bi-x-circle"></i> Trạng thái:
                        <span style="color: red;">${product.status}</span>
                    </p>
                </c:when>
                <c:otherwise>
                    <p class="status" style="color: green">
                        <i class="bi bi-check-circle"></i> Trạng thái:
                        <span>${product.status}</span>
                    </p>
                </c:otherwise>
            </c:choose>
            <%--            <p class="status"><i class="bi bi-check-circle"></i> Trạng thái: ${product.status}--%>
            <p class="price py-2"><i class="bi bi-wallet2"></i> Giá thuê: ${product.getFormattedPrice()}</p>
            </p>

            <h5 class="mt-4">Chủ nhà: </h5>
            <div class="d-flex align-items-center py-4">
                <img src="img/${avtUser.image}" class="rounded-circle me-2" width="60" height="60"
                     alt="Ảnh chủ nhà">
                <div class="px-3">
                    <h5 class="mb-0">${avtUser.fullName}</h5>
                    <small class="text-muted">${avtUser.address}</small>
                </div>
            </div>
            <a href="/orderProductServlet?productId=${product.idProduct}" class="btn btn-primary mt-3 text-center">
                <i class="bi bi-house-door-fill"></i> Thuê ngay
            </a>
            <button class="btn btn-outline-danger mt-3" id="favoriteBtn" onclick="toggleFavorite()">
                <i id="favoriteIcon" class="bi bi-heart"></i> Yêu thích
            </button>

        </div>
    </div>

    <div class="mt-4">
        <h4><i class="bi bi-chat-left-text"></i> Đánh giá sản phẩm</h4>
        <div class="list-group">
            <c:forEach var="cmt" items="${comments}">
                <div class="list-group-item d-flex align-items-start">
                    <div class="me-3">
                        <i class="bi bi-person-circle fs-2"></i>
                    </div>
                    <div>
                        <div>
                            <c:forEach begin="1" end="${cmt.rating}">
                                <i class="bi bi-star-fill text-warning"></i>
                            </c:forEach>
                            <c:forEach begin="${cmt.rating + 1}" end="5">
                                <i class="bi bi-star text-secondary"></i>
                            </c:forEach>
                        </div>
                        <h6 class="mb-1">${cmt.username}</h6>
                        <p class="mb-1">${cmt.comment}</p>
                        <small class="text-muted"><i class="bi bi-clock"></i> ${cmt.commentDate}</small>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>


<footer class="mt-5 text-center">
    <jsp:include page="../footer.jsp"/>
</footer>


<script>
    function changeImage(smallImg) {
        let mainImage = document.getElementById("mainImage");
        mainImage.src = smallImg.src;
    }
</script>

</body>
</html>
