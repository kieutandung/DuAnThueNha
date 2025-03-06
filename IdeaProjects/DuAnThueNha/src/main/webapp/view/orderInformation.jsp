<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="vi">
<head>
    <title>Đơn đặt chỗ</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .room-image {
            width: 150px;
            height: 100px;
            object-fit: cover;
            border-radius: 5px;
        }
        .booking-code {
            font-size: 20px; /* Tăng kích thước chữ mã */
            font-weight: bold;
        }
        .custom-card {
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .custom-badge-confirmed {
            background-color: #ccffcc !important; /* Màu nền xanh cốm nhạt */
            color: #008000 !important; /* Màu chữ xanh đậm */
            font-weight: bold;
            padding: 8px 15px;
            border-radius: 5px;
        }
        .custom-btn {
            padding: 6px 12px;
            font-size: 14px;
        }
        .room-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .checkin-checkout {
            display: flex;
            justify-content: flex-start; /* Căn trái */
            gap: 50px;
            margin-top: 20px;
            margin-left: -10px;
        }
        .checkin-info, .checkout-info {
            min-width: 140px;
            text-align: center;
        }
        .checkin-info p, .checkout-info p {
            margin-bottom: 2px;
            line-height: 1.2;
        }
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
</head>
<body>
<header>
    <jsp:include page="header2.jsp"/>
</header>
<div class="container mt-4">
    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link active" href="#">Sắp tới</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">Hoàn tất</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">Đã hủy</a>
        </li>
    </ul>

    <div class="mt-3">
        <label>Tất cả</label>
    </div>

    <!-- Đơn đặt phòng 1 -->
    <div class="card mt-3 custom-card">
        <div class="card-body">
            <div class="order-header">
                <p class="mb-1 booking-code"><strong>Mã: 126305992</strong></p>
                <span class="custom-badge-confirmed">Đã xác nhận</span>
            </div>
            <div class="d-flex align-items-center">
                <img src="https://nhadepshouse.com/hinh-anh/trung-gian/thiet-ke-biet-thu-hien-dai.jpg" class="room-image me-3">
                <div>
                    <h5 class="room-title">Biệt thự sân vườn sát sân bay Nội Bài</h5>
                    <div class="d-flex justify-content-between checkin-checkout">
                        <div class="checkin-info">
                            <p class="text-muted fw-semibold mb-1">Nhận phòng</p>
                            <p class="text-muted mb-0">Th3, 02 thg 4</p>
                        </div>
                        <div class="checkout-info">
                            <p class="text-muted fw-semibold mb-1">Trả phòng</p>
                            <p class="text-muted mb-0">Th6, 05 thg 4</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mt-3 d-flex justify-content-end">
                <button class="btn btn-danger custom-btn me-2">Hủy</button>
                <button class="btn btn-primary custom-btn">Quản lý đặt phòng</button>
            </div>
        </div>
    </div>

    <!-- Đơn đặt phòng 2 -->
    <div class="card mt-3 custom-card">
        <div class="card-body">
            <div class="order-header">
                <p class="mb-1 booking-code"><strong>Mã: 127890123</strong></p>
                <span class="custom-badge-confirmed">Đã xác nhận</span>
            </div>
            <div class="d-flex align-items-center">
                <img src="https://phuquoc.crowneplaza.com/wp-content/uploads/2020/11/B1113691-1024x767.jpg" class="room-image me-3">
                <div>
                    <h5 class="room-title">Resort 5 sao Phú Quốc</h5>
                    <div class="d-flex justify-content-between checkin-checkout">
                        <div class="checkin-info">
                            <p class="text-muted fw-semibold mb-1">Nhận phòng</p>
                            <p class="text-muted mb-0">Th7, 10 thg 5</p>
                        </div>
                        <div class="checkout-info">
                            <p class="text-muted fw-semibold mb-1">Trả phòng</p>
                            <p class="text-muted mb-0">CN, 12 thg 5</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mt-3 d-flex justify-content-end">
                <button class="btn btn-danger custom-btn me-2">Hủy</button>
                <button class="btn btn-primary custom-btn">Quản lý đặt phòng</button>
            </div>
        </div>
    </div>

    <!-- Đơn đặt phòng 3 -->
    <div class="card mt-3 custom-card">
        <div class="card-body">
            <div class="order-header">
                <p class="mb-1 booking-code"><strong>Mã: 128567834</strong></p>
                <span class="custom-badge-confirmed">Đã xác nhận</span>
            </div>
            <div class="d-flex align-items-center">
                <img src="https://du-lich.chudu24.com/f/m/2102/23/crowne-plaza-phu-quoc-starbay-2.jpg?w=800&h=500" class="room-image me-3">
                <div>
                    <h5 class="room-title">Khách sạn trung tâm TP.HCM</h5>
                    <div class="d-flex justify-content-between checkin-checkout">
                        <div class="checkin-info">
                            <p class="text-muted fw-semibold mb-1">Nhận phòng</p>
                            <p class="text-muted mb-0">T2, 20 thg 6</p>
                        </div>
                        <div class="checkout-info">
                            <p class="text-muted fw-semibold mb-1">Trả phòng</p>
                            <p class="text-muted mb-0">T5, 23 thg 6</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mt-3 d-flex justify-content-end">
                <button class="btn btn-danger custom-btn me-2">Hủy</button>
                <button class="btn btn-primary custom-btn">Quản lý đặt phòng</button>
            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<footer class="mt-5">
    <jsp:include page="footer.jsp"/>
</footer>

</body>
</html>
