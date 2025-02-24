<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.3.1/mdb.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="/js/home.js"></script>
    <link rel="stylesheet" href="/css/home.css">
</head>
<body>
<header>
    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
        <div class="container">
            <!-- Logo -->
            <a class="navbar-brand d-flex align-items-center" href="#">
                <img src="https://i.postimg.cc/ht05Yynx/nh-ch-p-m-n-h-nh-2025-02-24-142458.png" alt="Logo" width="40" height="40" class="me-2">
                <span class="fw-bold text-primary">WE Bare BEARS.vn</span>
            </a>

            <!-- Toggle button for mobile -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <i class="fas fa-bars"></i>
            </button>

            <!-- Navbar items -->
            <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link fw-bold active" href="#">Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Giới thiệu</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Sản phẩm</a>
                    </li>
                </ul>
            </div>

            <!-- User, Notification, and Contact -->
            <div class="d-flex align-items-center">
                <a href="#" class="me-3"><i class="fas fa-user fa-lg"></i></a>
                <a href="#" class="me-3"><i class="fas fa-bell fa-lg"></i></a>
                <a href="#" class="btn btn-primary">Liên hệ tư vấn</a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero bg-primary text-white text-center py-5">
        <div class="container">
            <h2 style="text-align: center; color: white; font-size: 24px; font-weight: bold;">
                We Bare Bears.vn xứng đáng với lựa chọn của bạn
            </h2>


            <!-- Search Bar -->
            <div class="search-bar mt-4 p-3 bg-white shadow-sm rounded w-75 mx-auto">
                <form class="row g-2">
                    <div class="col-md-4">
                        <select class="form-select">
                            <option selected>Loại nhà đất</option>
                            <option>Căn hộ</option>
                            <option>Biệt thự</option>
                            <option>Chung cư</option>
                            <option>Nhà phố</option>
                            <option>Văn phòng</option>
                            <option>Cửa hàng</option>
                        </select>
                    </div>
                    <div class="col-md-5">
                        <input type="text" class="form-control" placeholder="Nhập địa điểm hoặc từ khóa">
                    </div>
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-search"></i> Tìm kiếm
                        </button>
                    </div>
                </form>

            </div>

            <!-- Property Categories -->
            <div class="property-types mt-4">
                <div class="row justify-content-center">
                    <div class="col-4 col-md-2 text-center">
                        <i class="fas fa-building fa-2x"></i>
                        <p>Căn hộ</p>
                    </div>
                    <div class="col-4 col-md-2 text-center">
                        <i class="fas fa-home fa-2x"></i>
                        <p>Biệt thự</p>
                    </div>
                    <div class="col-4 col-md-2 text-center">
                        <i class="fas fa-city fa-2x"></i>
                        <p>Chung cư</p>
                    </div>
                    <div class="col-4 col-md-2 text-center">
                        <i class="fas fa-house-user fa-2x"></i>
                        <p>Nhà phố</p>
                    </div>
                    <div class="col-4 col-md-2 text-center">
                        <i class="fas fa-briefcase fa-2x"></i>
                        <p>Văn phòng</p>
                    </div>
                    <div class="col-4 col-md-2 text-center">
                        <i class="fas fa-store fa-2x"></i>
                        <p>Cửa hàng</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
</header>

<!-- Main content -->
<div class="container my-5">
    <h2 class="mb-4">Chỗ ở cho thuê theo tháng lân cận</h2>
    <div class="row">
        <!-- Căn hộ Tây Hồ -->
        <div class="col-lg-6 mb-4">
            <div class="rental-card shadow-sm">
                <div class="rental-image" style="background-image: url('https://images.cenhomes.vn/2020/03/1585033148-can-ho-mau-an-land-complex.jpg');">
                    <span class="badge badge-primary">Cho thuê</span>
                </div>
                <div class="rental-info">
                    <h5>Căn hộ tại Tây Hồ</h5>
                    <p>🛏 Phòng ngủ: 01</p>
                    <p>🛁 Phòng tắm: 01</p>
                    <p>📏 Diện tích trên 30m2</p>
                </div>
            </div>
        </div>

        <!-- Căn hộ Ba Đình -->
        <div class="col-lg-6 mb-4">
            <div class="rental-card shadow-sm">
                <div class="rental-image" style="background-image: url('https://furnist.vn/wp-content/uploads/2020/11/thiet-ke-noi-that-can-ho-chung-cu-vinhome-grandpart-nha-anh-h-2.jpg');">
                    <span class="badge badge-primary">Cho thuê</span>
                </div>
                <div class="rental-info">
                    <h5>Căn hộ tại Ba Đình</h5>
                    <p>🛏 Phòng ngủ: 01</p>
                    <p>🛁 Phòng tắm: 01</p>
                    <p>📏 Diện tích trên 30m2</p>
                </div>
            </div>
        </div>

        <!-- Căn hộ Đà Lạt -->
        <div class="col-lg-6 mb-4">
            <div class="rental-card shadow-sm">
                <div class="rental-image" style="background-image: url('https://homesland.vn/blog/wp-content/uploads/2020/03/noi-that-can-ho-hien-dai-homesland-1024x616.png');">
                    <span class="badge badge-primary">Cho thuê</span>
                </div>
                <div class="rental-info">
                    <h5>Căn hộ tại Đà Lạt</h5>
                    <p>🛏 Phòng ngủ: 01</p>
                    <p>🛁 Phòng tắm: 01</p>
                    <p>📏 Diện tích trên 30m2</p>
                </div>
            </div>
        </div>

        <!-- Căn hộ Đà Nẵng -->
        <div class="col-lg-6 mb-4">
            <div class="rental-card shadow-sm">
                <div class="rental-image" style="background-image: url('https://bicvietnam.com/storage/photos/shares/Tin%20tuc/can-ho-chung-cu-gia-mem.jpg');">
                    <span class="badge badge-primary">Cho thuê</span>
                </div>
                <div class="rental-info">
                    <h5>Căn hộ tại Đà Nẵng</h5>
                    <p>🛏 Phòng ngủ: 01</p>
                    <p>🛁 Phòng tắm: 01</p>
                    <p>📏 Diện tích trên 30m2</p>
                </div>
            </div>
        </div>

        <!-- Căn hộ Tà Xùa -->
        <div class="col-lg-6 mb-4">
            <div class="rental-card shadow-sm">
                <div class="rental-image" style="background-image: url('https://visaho.vn/upload_images/images/2022/04/01/dien-tich-can-ho-chung-cu-2-min.jpg');">
                    <span class="badge badge-primary">Cho thuê</span>
                </div>
                <div class="rental-info">
                    <h5>Căn hộ tại Tà Xùa</h5>
                    <p>🛏 Phòng ngủ: 01</p>
                    <p>🛁 Phòng tắm: 01</p>
                    <p>📏 Diện tích trên 30m2</p>
                </div>
            </div>
        </div>

        <!-- Căn hộ Ba Đình 2 -->
        <div class="col-lg-6 mb-4">
            <div class="rental-card shadow-sm">
                <div class="rental-image" style="background-image: url('https://vcdn1-vnexpress.vnecdn.net/2023/09/13/Mipec-Xuan-Thuy-19-1694609145.jpg?w=460&h=0&q=100&dpr=2&fit=crop&s=vVLVfe6gL6gxRO8B3fZ_Zg');">
                    <span class="badge badge-primary">Cho thuê</span>
                </div>
                <div class="rental-info">
                    <h5>Căn hộ tại Ba Đình</h5>
                    <p>🛏 Phòng ngủ: 01</p>
                    <p>🛁 Phòng tắm: 01</p>
                    <p>📏 Diện tích trên 30m2</p>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <h2>Các dự án <span>đã triển khai tại một số thành phố</span></h2>
    <div class="gallery">
        <div class="item large" style="background-image: url('https://docs.portal.danang.gov.vn/images/image/anhdanang_1490838715897.jpg');" >Đà Nẵng</div>
        <div class="item large" style="background-image: url('https://kenh14cdn.com/2019/11/1/snimek-obrazovky-2017-04-16-v-184239-1038x576-15726007989411418593991.png');">Hà Nội</div>
        <div class="item tall" style="background-image: url('https://khachsandalat.pro/wp-content/uploads/2016/08/thanh-pho-da-lat-3.jpg');">Đà Lạt</div>
        <div class="item" style="background-image: url('https://btnmt.1cdn.vn/2022/01/28/hcm.jpg');">Hồ Chí Minh</div>
        <div class="item" style="background-image: url('https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Khu_trung_t%C3%A2m_th%C3%A0nh_ph%E1%BB%91_H%E1%BB%93_Ch%C3%AD_Minh%2C_nh%C3%ACn_t%E1%BB%AB_ph%C3%ADa_qu%E1%BA%ADn_2.JPG/2560px-Khu_trung_t%C3%A2m_th%C3%A0nh_ph%E1%BB%91_H%E1%BB%93_Ch%C3%AD_Minh%2C_nh%C3%ACn_t%E1%BB%AB_ph%C3%ADa_qu%E1%BA%ADn_2.JPG');">Hà Đông</div>
    </div>
</div>

<!-- Main content -->

<!-- Footer -->
<footer class="text-center text-lg-start bg-body-tertiary text-white">
    <section>
        <div class="container text-center text-md-start mt-5">
            <div class="row mt-3">
                <div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4">
                    <h6 class="text-uppercase fw-bold mb-4"><i class="fas fa-gem me-3"></i>We Bare BEARS.vn</h6>
                    <p>Bản quyền thuộc về We Bare BEARS.vn . Phát triển bởi nhóm mèn mén</p>
                </div>
                <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
                    <h6 class="text-uppercase fw-bold mb-4">Cho thuê căn hộ</h6>
                    <p><a href="#" class="text-reset">Trang chủ</a></p>
                    <p><a href="#" class="text-reset">Giới thiệu</a></p>
                    <p><a href="#" class="text-reset">Sản phẩm</a></p>
                    <p><a href="#" class="text-reset">Tin tức</a></p>
                    <p><a href="#" class="text-reset">Liên hệ</a></p>

                </div>
                <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mb-4">
                    <h6 class="text-uppercase fw-bold mb-4">Hỗ trợ khách hàng</h6>
                    <p><a href="#" class="text-reset">Bảng giá dịch vụ</a></p>
                    <p><a href="#" class="text-reset">Hướng dẫn</a></p>
                    <p><a href="#" class="text-reset">Câu hỏi thường gặp</a></p>
                    <p><a href="#" class="text-reset">Tin tức và khuyến mãi</a></p>
                    <p><a href="#" class="text-reset">Liên hệ</a></p>

                </div>
                <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">
                    <h6 class="text-uppercase fw-bold mb-4">Contact</h6>
                    <p><i class="fas fa-home me-3"></i> Địa chỉ : Tầng 8 Ladeco , 266 Đội Cấn , Hà Nội</p>
                    <p><i class="fas fa-envelope me-3"></i> Chianhn567@gmail.com</p>
                    <p><i class="fas fa-phone me-3"></i> Hotline 1900 1011</p>
                </div>
            </div>
            <section class="d-flex justify-content-center justify-content-lg-between p-4 border-bottom">
                <div class="me-5 d-none d-lg-block">
                </div>
                <div>
                    <a href="#" class="me-4 text-reset"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="me-4 text-reset"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="me-4 text-reset"><i class="fab fa-google"></i></a>
                    <a href="#" class="me-4 text-reset"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="me-4 text-reset"><i class="fab fa-linkedin"></i></a>
                    <a href="#" class="me-4 text-reset"><i class="fab fa-github"></i></a>
                </div>
            </section>

        </div>

    </section>
</footer>
<!-- Footer -->

<!-- JS -->
<script type="module" src="assets/js/home.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.3.1/mdb.min.js"></script>

</body>
</html>
