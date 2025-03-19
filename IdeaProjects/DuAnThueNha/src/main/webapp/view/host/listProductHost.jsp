<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Toàn bộ nhà của bạn</title>
    <link rel="stylesheet" href="/css/listProductHost.css">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.css" rel="stylesheet">
</head>
<header>
    <jsp:include page="headerHost.jsp"/>
</header>
<body>

<div class="container">
    <div class="row mb-6">
        <div class="col-lg-12 mt-5">

            <div id="alertDivSuc" class="alert alert-success text-center" role="alert"
                 style="display: ${not empty successMessage ? 'block' : 'none'};">
                ${successMessage}
            </div>

            <div class="main-box clearfix">
                <div class="table-responsive">
                    <table class="table user-list">
                        <thead>
                        <tr>
                            <th colspan="6" style="text-align: center; padding: 10px 0;">
                                <form action="listProductHostServlet?action=search" method="post"
                                      style="display: inline-block;">
                                    <input id="searchProductHost" type="text" name="searchProductHost"
                                           placeholder="Tìm kiếm theo tên, địa chỉ" class="search-input"
                                           value="${keyword}">
                                    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                                </form>
                            </th>
                        </tr>
                        <tr>
                            <th class="text-center"><span>STT</span></th>
                            <th><span>Sản phẩm</span></th>
                            <th class="text-center"><span>Giá</span></th>
                            <th class="text-center"><span>Trạng thái</span></th>
                            <th class="text-center"><span>Địa chỉ</span></th>
                            <th class="text-center"><span>Hành động</span></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty listProduct}">
                                <c:forEach var="p" items="${listProduct}" varStatus="status">
                                    <input type="hidden" name="productId" value="${p.idProduct}">
                                    <tr>
                                        <td class="text-center">
                                                ${startIndex + status.index + 1}
                                        </td>
                                        <td>
                                            <img src="img/${p.image}" alt=""
                                                 onerror="this.onerror=null; this.src='img/defaultImg-removebg-preview.png';">
                                            <a href="editProductHostServlet?productId=${p.idProduct}"
                                               class="user-link">${p.nameProduct}</a>
                                        </td>
                                        <td>
                                                ${p.price} VNĐ
                                        </td>
                                        <td class="text-center">
                                            <span class="label label-default"> ${p.status}</span>
                                        </td>
                                        <td>
                                            <a href="editProductHostServlet?productId=${p.idProduct}"> ${p.address}</a>
                                        </td>
                                        <td class="text-center" style="width: 20%;">
                                            <a href="editProductHostServlet?productId=${p.idProduct}"
                                               class="table-link">
                                                <span class="fa-stack">
                                                  <i class="fa fa-square fa-stack-2x"></i>
                                                  <i class="fa fa-pencil fa-stack-1x fa-inverse"></i>
                                                </span>
                                            </a>
                                            <c:choose>
                                                <c:when test="${p.status eq 'Không còn kinh doanh'}">
                                                    <a href="#" class="table-link danger disabled-link"
                                                       style="color: grey; pointer-events: none;">
                                                       <span class="fa-stack">
                                                         <i class="fa fa-square fa-stack-2x"></i>
                                                         <i class="fa fa-trash-o fa-stack-1x fa-inverse"></i>
                                                       </span>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="#" class="table-link danger"
                                                       onclick="showDeleteModal('${p.idProduct}'); return false;">
                                                        <span class="fa-stack">
                                                          <i class="fa fa-square fa-stack-2x"></i>
                                                          <i class="fa fa-trash-o fa-stack-1x fa-inverse"></i>
                                                         </span>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>

                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan=6" class="text-center">Không tìm thấy sản phẩm với từ khóa
                                        "${keyword}"
                                        <a style=" padding-left: 5px" href="/listProductHostServlet"
                                           class="btn-thue-ngay">
                                            <i class="bi bi-house-door-fill"></i> Trở lại trang chủ
                                        </a>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
                <ul class="pagination" style="display: flex;justify-content: center;">

                    <c:if test="${tag > 1}">
                        <li class="page-item disabled"><a href="listProductHostServlet?page=${tag - 1}">Trước</a></li>
                    </c:if>
                    <c:forEach var="i" begin="1" end="${endPageUser}">
                        <li class="page-item ${tag == i?"active":""}"><a href="listProductHostServlet?page=${i}"
                                                                         class="page-link">${i}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${tag < endPageUser}">
                        <li class="page-item"><a href="listProductHostServlet?page=${tag + 1}"
                                                 class="page-link">Tiếp</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteConfirmModal" tabindex="-1"
     aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteConfirmModalLabel">Xác nhận ngừng bán sản phẩm ?</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Đóng"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc chắn muốn ngừng bán sản phẩm này không ?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy
                </button>
                <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Cập nhật</button>
            </div>
        </div>
    </div>
</div>
<script>

    var alertDivSuc = document.getElementById("alertDivSuc");
    if (alertDivSuc && alertDivSuc.style.display !== "none") {
        setTimeout(function () {
            alertDivSuc.style.display = "none";
        }, 3000);
    }

    function showDeleteModal(productId) {
        const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');

        confirmDeleteBtn.onclick = function () {
            window.location.href = "listProductHostServlet?action=delete&productId=" + encodeURIComponent(productId);
        };

        var deleteModalEl = document.getElementById('deleteConfirmModal');
        var deleteModal = new bootstrap.Modal(deleteModalEl, {
            keyboard: false
        });
        deleteModal.show();
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
<footer>
    <jsp:include page="../footer.jsp"/>
</footer>
</html>
