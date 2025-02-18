<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đăng ksi</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
<section class="vh-100 gradient-custom">
    <div class="container py- h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                <div class="card bg-white text-dark" style="border-radius: 1rem;">
                    <div class="card-body p-4 text-center">
                        <div class="mb-md-3 mt-md-4 pb-3">
                            <h2 class="fw-bold mb-2 text-uppercase">Đăng ký</h2>
                            <p class="text-muted mb-5">Vui lòng điền thông tin dưới đây để tạo tài khoản</p>
                            <div class="alert alert-danger" role="alert"
                                 style="display: ${not empty errorMessage ? 'block' : 'none'};">
                                ${errorMessage}
                            </div>
                            <!-- Form đăng ký -->
                            <form action="registerServlet" method="post">

                                <!-- Tên đăng nhập -->
                                <div data-mdb-input-init class="form-outline mb-4">
                                    <input type="text" required pattern="^[a-zA-Z0-9._]{3,20}$" title="Độ dài của tên đăng nhập phải từ 3 đến 20 ký tự" id="typeUsername" class="form-control form-control-lg" name="username"  />
                                    <label class="form-label" for="typeUsername">Tên đăng nhập</label>
                                </div>

                                <!-- Mật khẩu -->
                                <div data-mdb-input-init class="form-outline mb-4">
                                    <input type="password" required pattern="^(?=.*\d)[A-Za-z\d@$!%*?&]{8,30}$" title="Ít nhất một chữ số, độ dài từ 8 đến 30 ký tự" id="typePassword" class="form-control form-control-lg" name="password" />
                                    <label class="form-label" for="typePassword">Mật khẩu</label>
                                </div>

                                <div data-mdb-input-init class="form-outline mb-4">
                                    <input type="password" required pattern="^(?=.*\d)[A-Za-z\d@$!%*?&]{8,30}$" title="Ít nhất một chữ số, độ dài từ 8 đến 30 ký tự" id="typeRPassword" class="form-control form-control-lg" name="Rpassword" />
                                    <label class="form-label" for="typePassword">Nhập lại mật khẩu</label>
                                </div>

                                <!-- Tên đầy đủ -->
                                <div data-mdb-input-init class="form-outline mb-4">
                                    <input type="text" required pattern="^[A-Za-zÀ-ÿ]+(?: [A-Za-zÀ-ÿ]+)*$" title="Không chứa số, kí tự đặc biệt và dấu cách không cần thiết"  id="typeFullName" class="form-control form-control-lg" name="fullName" />
                                    <label class="form-label" for="typeFullName">Tên đầy đủ</label>
                                </div>

                                <!-- Số điện thoại -->
                                <div data-mdb-input-init class="form-outline mb-4">
                                    <input type="text" required pattern="^(?:\+84|0)\d{9}$" title="Gồm 10 số" id="typePhone" class="form-control form-control-lg" name="phone" />
                                    <label class="form-label" for="typePhone">Số điện thoại</label>
                                </div>

                                <!-- Email -->
                                <div data-mdb-input-init class="form-outline mb-4">
                                    <input type="email" required id="typeEmail" class="form-control form-control-lg" name="email" />
                                    <label class="form-label" for="typeEmail">Email</label>
                                </div>

                                <!-- Button đăng ký -->
                                <button data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-lg px-5" type="submit">Đăng ký</button>
                            </form>
                                <!-- Liên kết đến trang đăng nhập nếu đã có tài khoản -->
                                <div class="d-flex justify-content-center text-center mt-5 pt-1">
                                    <p class="mb-0">Đã có tài khoản? <a href="/registerServlet?action=login" class="text-primary fw-bold">Đăng nhập</a></p>
                                </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.js"></script>
</body>
</html>