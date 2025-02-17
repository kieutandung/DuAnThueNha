<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân</title>
    <link rel="stylesheet" href="profile.css">
</head>
<body>
<div class="container">
    <!-- Thanh menu -->
    <nav class="navbar">
        <div class="logo">WE Bare BEARS.vn</div>
        <ul class="nav-links">
            <li><a href="#">Trang chủ</a></li>
            <li><a href="#">Giới thiệu</a></li>
            <li><a href="#">Sản phẩm</a></li>
            <li><a href="#">Liên hệ</a></li>
            <li><i class="bell-icon">🔔</i></li>
            <li><button class="btn">Liên hệ tư vấn</button></li>
        </ul>
    </nav>

    <!-- Giao diện thông tin cá nhân -->
    <div class="profile-container">
        <div class="sidebar">
            <ul>
                <li><a href="#">Hồ sơ</a></li>
                <li><a href="#">Đơn hàng</a></li>
                <li><a href="#">Notification</a></li>
                <li><a href="#">Settings</a></li>
            </ul>
        </div>

        <div class="profile-content">
            <div class="profile-card">
                <div class="profile-info">
                    <h2>Tên của bạn</h2>
                    <p>Email: DungPug@gmail.com</p>
                    <p>SDT: 0123456789</p>
                    <button class="save-btn">Lưu</button>
                </div>
                <div class="profile-image">
                    <img src="images/avatar.jpg" alt="Avatar">
                    <button class="upload-btn">Chọn ảnh</button>
                    <button class="business-btn">Kênh kinh doanh</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <h3>Đăng ký nhận thông tin từ WE Bare BEARS.vn</h3>
            <p>Chúng tôi sẽ gửi bạn những thông tin bất động sản mới nhất</p>
            <input type="email" placeholder="Nhập địa chỉ email của bạn">
            <button class="subscribe-btn">Đăng ký ngay</button>
        </div>
    </footer>
</div>
</body>
</html>
