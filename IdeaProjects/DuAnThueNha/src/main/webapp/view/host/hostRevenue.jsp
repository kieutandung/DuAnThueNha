<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="/css/hostRevenue.css">
</head>
<body>
<header>
    <jsp:include page="headerHost.jsp"/>
</header>
<div class="header">
    <div class="breadcrumb">Thanh toán / doanh thu</div>
    <h2>Doanh thu</h2>
    <div class="buttons">
        <button class="button">Hàng tháng</button>
        <button class="button">Doanh thu định kì <span class="close-btn">x</span></button>
    </div>
</div>
<div class="container">
    <div>
        <div class="chart-container">
            <canvas id="barChart"></canvas>
        </div>
    </div>
    <div class="top-houses">
        <h3>Top nhà được thuê nhiều nhất</h3>
        <div class="house-card">
            <img src="house1.jpg" alt="Nhà Nha Trang">
            <div class="house-details">
                <p class="price">3.350.000Đ / Day</p>
                <p><strong><em>Căn hộ tại Nha Trang</em></strong></p>
                <p>🛏 bedroom: 05  🛁 bathroom: 04  📏 1000m2</p>
            </div>
        </div>
        <div class="house-card">
            <img src="house2.jpg" alt="Nhà TP HCM">
            <div class="house-details">
                <p class="price">5.450.000Đ / Day</p>
                <p><strong><em>Căn hộ tại TP Hồ Chí Minh</em></strong></p>
                <p>🛏 bedroom: 05  🛁 bathroom: 04  📏 1000m2</p>
            </div>
        </div>
    </div>
    <div class="customer-info">
        <h3>Bảng thông tin khách hàng</h3>
        <table class="table">
            <thead>
            <tr>
                <th>Tên khách hàng</th>
                <th>Thẻ</th>
                <th>Ngày</th>
                <th>Trạng thái</th>
                <th>Số tiền</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Cheese Nguyen Anh</td>
                <td>Doanh thu định kì</td>
                <td>10-01-2025</td>
                <td><span class="badge bg-success">Hoàn thành</span></td>
                <td>$3,46,660</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<script>
    const barCtx = document.getElementById('barChart').getContext('2d');
    new Chart(barCtx, {
        type: 'bar',
        data: {
            labels: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10','11','12'],
            datasets: [{
                label: 'Lượt thuê theo tháng',
                data: [10, 16, 8, 15, 2, 4, 10, 15, 12, 11, 15, 10],
                backgroundColor: 'rgba(137, 196, 244, 0.8)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>
<footer class="footer">
    <div class="container">
        <div class="footer-content">
            <div class="footer-section">
                <h2>WE Bare BEARS.vn</h2>
                <p><i class="fas fa-map-marker-alt"></i> <strong>Địa chỉ:</strong> Tầng 8 Ladeco, 266 Đội Cấn, Hà Nội</p>
                <p><i class="fas fa-phone"></i> <strong>Hotline:</strong> 1900 1011</p>
                <p><i class="fas fa-envelope"></i> <strong>Email:</strong> Chianhn567@gmail.com</p>
            </div>

            <div class="footer-section">
                <h3>Cho thuê căn hộ</h3>
                <ul>
                    <li><a href="#">Trang chủ</a></li>
                    <li><a href="#">Giới thiệu</a></li>
                    <li><a href="#">Sản phẩm</a></li>
                    <li><a href="#">Tin tức</a></li>
                    <li><a href="#">Liên hệ</a></li>
                </ul>
            </div>

            <div class="footer-section">
                <h3>Hỗ trợ khách hàng</h3>
                <ul>
                    <li><a href="#">Bảng giá dịch vụ</a></li>
                    <li><a href="#">Hướng dẫn</a></li>
                    <li><a href="#">Câu hỏi thường gặp</a></li>
                    <li><a href="#">Tin tức và khuyến mãi</a></li>
                    <li><a href="#">Liên hệ</a></li>
                </ul>
            </div>

            <div class="footer-section">
                <h3>Quy định</h3>
                <ul>
                    <li><a href="#">Quy định đăng tin</a></li>
                    <li><a href="#">Quy chế hoạt động</a></li>
                    <li><a href="#">Điều kiện thỏa thuận</a></li>
                    <li><a href="#">Chính sách bảo mật</a></li>
                    <li><a href="#">Giải quyết khiếu nại</a></li>
                </ul>
            </div>
        </div>

        <div class="footer-bottom">
            <p>© Bản quyền thuộc về WE Bare BEARS.vn. Phát triển bởi <strong>mền mền</strong></p>
            <div class="social-icons">
                <a href="#"><i class="fab fa-facebook"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-google"></i></a>
            </div>
        </div>
    </div>
</footer>

</body>
</html>
