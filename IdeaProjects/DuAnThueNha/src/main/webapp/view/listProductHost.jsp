<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Toàn bộ nhà của bạn</title>
    <link rel="stylesheet" href="css/listProductHost.css">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.css" rel="stylesheet">
</head>
<header>
    <jsp:include page="headerHost.jsp"/>
</header>
<body>

<div class="container">
    <div class="row">
        <div class="col-lg-12 mt-5">

            <div id="alertDivSuc" class="alert alert-success" role="alert"
                 style="display: ${not empty successMessage ? 'block' : 'none'};">
                <strong>Thành công!</strong> ${successMessage}
            </div>

            <div class="main-box clearfix">
                <div class="table-responsive">
                    <table class="table user-list">
                        <thead>
                        <tr>
                            <th><span>Sản phẩm</span></th>
                            <th><span>Giá</span></th>
                            <th class="text-center"><span>Trạng thái</span></th>
                            <th><span>Địa chỉ</span></th>
                            <th>&nbsp;</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="p" items="${listProduct}">

                            <input type="hidden" name="productId" value="${p.idProduct}">
                            <tr>
                                <td>
                                    <img src="img/${p.image}" alt=""
                                         onerror="this.onerror=null; this.src='img/defaultImg-removebg-preview.png';">
                                    <a href="editProductHostServlet" class="user-link">${p.nameProduct}</a>
                                    <span class="user-subhead">Admin</span>
                                </td>
                                <td>
                                        ${p.price} VNĐ
                                </td>
                                <td class="text-center">
                                    <span class="label label-default"> ${p.status}</span>
                                </td>
                                <td>
                                    <a href="#"> ${p.address}</a>
                                </td>
                                <td style="width: 20%;">
                                    <a href="productServlet" class="table-link">
									<span class="fa-stack">
										<i class="fa fa-square fa-stack-2x"></i>
										<i class="fa fa-search-plus fa-stack-1x fa-inverse"></i>
									</span>
                                    </a>
                                    <a href="editProductHostServlet?productId=${p.idProduct}" class="table-link">
									<span class="fa-stack">
										<i class="fa fa-square fa-stack-2x"></i>
										<i class="fa fa-pencil fa-stack-1x fa-inverse"></i>
									</span>
                                    </a>
                                    <a href="#" class="table-link danger"
                                       onclick="showDeleteModal('${p.idProduct}'); return false;">
                                                  <span class="fa-stack">
                                                      <i class="fa fa-square fa-stack-2x"></i>
                                                      <i class="fa fa-trash-o fa-stack-1x fa-inverse"></i>
                                                  </span>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <div class="modal fade" id="deleteConfirmModal" tabindex="-1"
                             aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="deleteConfirmModalLabel">Xác nhận xóa</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Đóng"></button>
                                    </div>
                                    <div class="modal-body">
                                        Bạn có chắc chắn muốn xóa sản phẩm này không?
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy
                                        </button>
                                        <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Xóa</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </tbody>
                    </table>
                </div>

                <%--                <ul class="pagination pull-right">--%>
                <%--                    <li><a href="#"><i class="fa fa-chevron-left"></i></a></li>--%>
                <%--                    <li><a href="#">1</a></li>--%>
                <%--                    <li><a href="#">2</a></li>--%>
                <%--                    <li><a href="#">3</a></li>--%>
                <%--                    <li><a href="#">4</a></li>--%>
                <%--                    <li><a href="#">5</a></li>--%>
                <%--                    <li><a href="#"><i class="fa fa-chevron-right"></i></a></li>--%>
                <%--                </ul>--%>
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
    <jsp:include page="footer.jsp"/>
</footer>
</html>
