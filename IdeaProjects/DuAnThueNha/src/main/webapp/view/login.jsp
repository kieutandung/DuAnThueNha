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
                            <h2 class="fw-bold mb-2 text-uppercase">Đăng nhập</h2>
                            <p class="text-muted mb-5">Vui lòng nhập tên đăng nhập hoặc mật khẩu</p>
                            <div class="alert alert-danger" role="alert"
                                 style="display: ${not empty errorMessage ? 'block' : 'none'};">
                                ${errorMessage}
                            </div>
                            <div class="alert alert-success" role="alert"
                                 style="display: ${not empty successMessage ? 'block' : 'none'};">
                                ${successMessage}
                            </div>
                            <form action="loginServlet" method="post">
                                <div data-mdb-input-init class="form-outline mb-4">
                                    <input type="text" required id="typeEmailX" class="form-control form-control-lg" name="username" />
                                    <label class="form-label" for="typeEmailX">Tên đăng nhập</label>
                                </div>

                                <div data-mdb-input-init class="form-outline mb-4">
                                    <input type="password" required id="typePasswordX" class="form-control form-control-lg" name="password" />
                                    <label class="form-label" for="typePasswordX">Mật khẩu</label>
                                </div>

                                <p class="small mb-3 pb-lg-2 text-start"><a class="text-primary ms-2" href="#!">Quên mật khẩu?</a></p>
                                <form action="/profileServlet" method="get">
                                    <button data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-lg px-5" type="submit">Đăng nhập</a>
                                    </button>
                                </form>
                                <div class="d-flex justify-content-center text-center mt-5 pt-1">
                                    <a href="#!" class="text-primary"><i class="fab fa-facebook-f fa-lg"></i></a>
                                    <a href="#!" class="text-primary mx-4 px-2"><i class="fab fa-twitter fa-lg"></i></a>
                                    <a href="#!" class="text-primary"><i class="fab fa-google fa-lg"></i></a>
                                </div>
                            </form>
                        </div>
                        <div>
                            <p class="mb-0">Chưa có tài khoản? <a href="/registerServlet?action=register" class="text-primary fw-bold">Đăng ký</a></p>
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