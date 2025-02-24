<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
<section class="min-vh-100 d-flex align-items-center justify-content-center gradient-custom">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                <div class="card bg-white text-dark" style="border-radius: 1rem; max-width: 600px;">
                    <div class="card-body p-5 text-center">
                        <div class="mb-md-3 mt-md-4 pb-3">
                            <a href="javascript:history.back()" class="text-decoration-none text-dark d-flex align-items-center">
                                <i class="fas fa-arrow-left me-2"></i>
                            </a>

                            <h2 class="fw-bold mb-2 text-uppercase">Quên mật khẩu</h2>
                            <p class="text-muted mb-5">Vui lòng nhập số điện thoại của bạn để khôi phục tài khoản</p>
                            <div  class="alert alert-success" role="alert"
                                 style="display: ${not empty successMessage ? 'block' : 'none'};">
                                ${successMessage}
                            </div>
                            <div id="alertDiv"  class="alert alert-danger" role="alert"
                                 style="display: ${not empty errorMessage ? 'block' : 'none'};">
                                ${errorMessage}
                            </div>
                            <form action="forgotPasswordServlet" method="post">
                                <div class="form-outline mb-3">
                                    <input type="text" required pattern="^(?:\+84|0)\d{9}$"
                                           title="Gồm 10 số với đầu +84 hoặc 0" id="typePhone" class="form-control form-control-lg"
                                           name="phone" value ="${phone != null ? phone : ''}"/>
                                    <label class="form-label" for="typePhone">Số điện thoại</label>
                                </div>

                                <c:if test="${reset}">
                                    <div data-mdb-input-init class="form-outline mb-3">
                                        <input type="password" required pattern="^(?=.*\d)[A-Za-z\d@$!%*?&]{6,30}$" title="Ít nhất một chữ số, độ dài từ 6 đến 30 ký tự" id="newPassword" class="form-control form-control-lg" name="newPassword" />
                                        <label class="form-label" for="newPassword">Mật khẩu mới</label>
                                    </div>
                                    <div data-mdb-input-init class="form-outline mb-3">
                                        <input type="password"  required pattern="^(?=.*\d)[A-Za-z\d@$!%*?&]{6,30}$" title="Ít nhất một chữ số, độ dài từ 6 đến 30 ký tự" id="confirmPassword" class="form-control form-control-lg" name="confirmPassword" />
                                        <label class="form-label" for="confirmPassword">Xác nhận mật khẩu</label>
                                    </div>
                                </c:if>

                                <button type="submit" class="btn btn-primary btn-lg px-5">
                                    <c:choose>
                                        <c:when test="${reset}">
                                            Đổi mật khẩu
                                        </c:when>
                                        <c:otherwise>
                                            Tiếp tục
                                        </c:otherwise>
                                    </c:choose>
                                </button>

                                <div class="d-flex justify-content-center text-center mt-5 pt-1">
                                    <a href="/registerServlet?action=register" class="text-primary"><i class="fab fa-facebook-f fa-lg"></i></a>
                                    <a href="/registerServlet?action=register" class="text-primary mx-4 px-2"><i class="fab fa-twitter fa-lg"></i></a>
                                    <a href="/registerServlet?action=register" class="text-primary"><i class="fab fa-google fa-lg"></i></a>
                                </div>
                            </form>
                        </div>
                        <div>
                            <p class="mb-0">Bạn chưa có tài khoản? <a href="/registerServlet?action=register" class="text-primary fw-bold">Đăng ký</a></p>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    // Kiểm tra nếu alert đang hiển thị (display != none)
    var alertDiv = document.getElementById("alertDiv");
    if (alertDiv && alertDiv.style.display !== "none") {
        setTimeout(function() {
            alertDiv.style.display = "none";
        }, 3000);
    }
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.js"></script>
</body>
</html>