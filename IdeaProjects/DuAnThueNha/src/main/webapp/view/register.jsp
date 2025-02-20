<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đăng ksi</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
<section class="min-vh-100 d-flex align-items-center justify-content-center gradient-custom">
    <div class="container container py-3 h-100">
        <div class="row d-flex justify-content-center align-items-center">
            <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                <div class="card bg-white text-dark mx-auto" style="border-radius: 1rem; max-width: 600px;">
                    <div class="card-body p-5 text-center">
                        <div class="mb-md-3 mt-md-4 pb-3">
                            <h2 class="fw-bold mb-2 text-uppercase">Đăng ký</h2>
                            <p class="text-muted mb-4">Vui lòng điền thông tin dưới đây để tạo tài khoản</p>

                            <div class="alert alert-danger" role="alert"
                                 style="display: ${not empty errorMessage ? 'block' : 'none'};">
                                ${errorMessage}
                            </div>

                            <form action="registerServlet" method="post">

                                <div class="form-outline mb-3">
                                    <input type="text" required pattern="^[a-zA-Z0-9._]{3,20}$"
                                           title="Độ dài của tên đăng nhập phải từ 3 đến 20 ký tự"
                                           id="typeUsername" class="form-control form-control-lg" name="username" value ="${username != null ? username : ''}"/>
                                    <label class="form-label" for="typeUsername">Tên đăng nhập</label>
                                </div>

                                <div class="form-outline mb-3">
                                    <input type="password" required pattern="^(?=.*\d)[A-Za-z\d@$!%*?&]{6,30}$"
                                           title="Ít nhất một chữ số, độ dài từ 6 đến 30 ký tự"
                                           id="typePassword" class="form-control form-control-lg" name="password" value ="${password != null ? password : ''}"/>
                                    <label class="form-label" for="typePassword">Mật khẩu</label>
                                </div>

                                <div class="form-outline mb-3">
                                    <input type="password" required pattern="^(?=.*\d)[A-Za-z\d@$!%*?&]{6,30}$"
                                           title="Ít nhất một chữ số, độ dài từ 6 đến 30 ký tự"
                                           id="typeRPassword" class="form-control form-control-lg" name="rPassword" value ="${rPassword != null ? rPassword : ''}"/>
                                    <label class="form-label" for="typeRPassword">Nhập lại mật khẩu</label>
                                </div>

                                <!-- Tên đầy đủ -->
                                <div class="form-outline mb-3">
                                    <input type="text" required pattern="^[A-ZÀ-Ỹ][a-zà-ỹ]+(?: [A-ZÀ-Ỹ][a-zà-ỹ]+)*$"
                                           title="Tên phải viết hoa chữ cái đầu, không chứa số hoặc ký tự đặc biệt "
                                           id="typeFullName" class="form-control form-control-lg" name="fullName" value ="${fullname != null ? fullname : ''}"/>
                                    <label class="form-label" for="typeFullName">Tên đầy đủ</label>
                                </div>

                                <!-- Số điện thoại -->
                                <div class="form-outline mb-3">
                                    <input type="text" required pattern="^(?:\+84|0)\d{9}$"
                                           title="Gồm 10 số" id="typePhone" class="form-control form-control-lg"
                                           name="phone" value ="${phone != null ? phone : ''}"/>
                                    <label class="form-label" for="typePhone">Số điện thoại</label>
                                </div>

                                <!-- Email -->
                                <div class="form-outline mb-3">
                                    <input type="email" required id="typeEmail" class="form-control form-control-lg"
                                           name="email" value ="${email != null ? email : ''}"/>
                                    <label class="form-label" for="typeEmail">Email</label>
                                </div>

                                <!-- Button đăng ký -->
                                <button class="btn btn-primary btn-lg px-5" type="submit">Đăng ký</button>
                            </form>

                            <!-- Liên kết đến trang đăng nhập nếu đã có tài khoản -->
                            <div class="text-center mt-4">
                                <p class="mb-0">Đã có tài khoản?
                                    <a href="/registerServlet?action=login" class="text-primary fw-bold">Đăng nhập</a>
                                </p>
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