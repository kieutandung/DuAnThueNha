<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân</title>
</head>
<style>
    .footer-content h1 {
        font-size: 18px;
        margin-bottom: 10px;
    }

    .footer-content p {
        font-size: 14px;
    }

    .footer-content input {
        padding: 8px;
        width: 250px;
        margin-top: 10px;
        border-radius: 5px;
        border: none;
    }
    .footer {
        background: rgba(0, 0, 0, 0.7);
        color: white;
        padding: 40px 0;
    }

    .container {
        width: 80%;
        margin: auto;
    }

    .footer-content {
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
    }
    .footer {
        background: rgba(0, 0, 0, 0.7);
        color: white;
        padding: 40px 0;
        font-family: Arial, sans-serif;
    }

    .container {
        width: 80%;
        margin: auto;
    }

    .footer-content {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between; /* Căn giữa theo chiều ngang */
        align-items: center;    /* Căn giữa theo chiều dọc */
    }

    .footer-section {
        width: 22%;
        margin-bottom: 20px;
        padding: 10px;
    }

    .footer-section h2, .footer-section h3 {
        color: #0099FF;
        margin-bottom: 15px;
    }

    .footer-section ul {
        list-style: none;
        padding: 0;
    }

    .footer-section ul li {
        margin: 8px 0;
    }

    .footer-section ul li a {
        color: white;
        text-decoration: none;
    }

    .footer-section ul li a:hover {
        text-decoration: underline;
    }

    .footer-content .subscribe-btn {
        background: #007bff;
        color: white;
        padding: 8px 15px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .footer-bottom {
        text-align: center;
        margin-top: 20px;
        border-top: 1px solid gray;
        padding-top: 10px;
    }

    .social-icons {
        margin-top: 10px;
    }

    .social-icons a {
        color: white;
        font-size: 18px;
        margin: 0 10px;
    }

    .social-icons a:hover {
        color: #0099FF;
    }


    /* Điều chỉnh cho thiết bị di động */
    @media (max-width: 768px) {
        .footer-content {
            flex-direction: column;
            align-items: center;
        }
        .footer-section {
            width: 100%;
            text-align: center;
        }
        .footer-section h2, .footer-section h3 {
            margin-bottom: 10px;
        }
        .footer-section ul li {
            margin: 5px 0;
        }
        .footer-bottom {
            padding-top: 20px;
        }
    }


</style>

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
