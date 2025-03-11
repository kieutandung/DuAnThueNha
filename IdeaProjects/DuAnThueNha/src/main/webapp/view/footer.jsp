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
        background-image: url('https://i.postimg.cc/44H24fk4/z6346861583592-862dc98dfcc26c43d1219f679827a619.jpg');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        background-attachment: fixed;
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
        justify-content: space-between;
        flex-wrap: wrap;
    }
    .container {
        width: 80%;
        margin: auto;
    }

    .footer-content {
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
        align-items: flex-start; /* Căn trên để các phần thẳng hàng */

    }
    .footer-section {
        width: 25%; /* Đảm bảo các cột có kích thước bằng nhau */
        margin-bottom: 20px;
        padding: 10px;
        display: flex;
        flex-direction: column; /* Giữ nội dung theo chiều dọc */
        text-align: left; /* Căn trái nội dung */
    }

    .footer-section h2 {
        margin-top: 5px; /* Điều chỉnh khoảng cách lùi xuống */
    }

    .footer-section h3 {
        color: #ffffff;
        margin-bottom: 15px;
    }

    .footer-section p {
        margin: 10px 0; /* Cách đều các dòng thông tin */
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
    .container {
        max-width: 1200px;
        margin: auto;
    }
    .gallery {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 10px;
    }
    .item {
        position: relative;
        background-size: cover;
        background-position: center;
        border-radius: 8px;
        color: white;
        font-size: 18px;
        display: flex;
        align-items: end;
        padding: 10px;
        height: 200px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .item.large {
        grid-column: span 1;
        height: 200px;
    }
    .item.tall {
        grid-row: span 2;
        height: 410px;
    }
    .gallery {
        margin-bottom: 50px;
    }
    h2 {
        font-size: 20px;
        font-weight: normal;
    }
    h2 span {
        text-align: left;
        font-size: 20px;
    }

</style>
<body>
<div class="container">
    <h2><span> Các dự án đã triển khai tại một số thành phố</span></h2>
    <div class="gallery">
        <div class="item large" style="background-image: url('https://docs.portal.danang.gov.vn/images/image/anhdanang_1490838715897.jpg');" >Đà Nẵng</div>
        <div class="item large" style="background-image: url('https://kenh14cdn.com/2019/11/1/snimek-obrazovky-2017-04-16-v-184239-1038x576-15726007989411418593991.png');">Hà Nội</div>
        <div class="item tall" style="background-image: url('https://khachsandalat.pro/wp-content/uploads/2016/08/thanh-pho-da-lat-3.jpg');">Đà Lạt</div>
        <div class="item" style="background-image: url('https://btnmt.1cdn.vn/2022/01/28/hcm.jpg');">Hồ Chí Minh</div>
        <div class="item" style="background-image: url('https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Khu_trung_t%C3%A2m_th%C3%A0nh_ph%E1%BB%91_H%E1%BB%93_Ch%C3%AD_Minh%2C_nh%C3%ACn_t%E1%BB%AB_ph%C3%ADa_qu%E1%BA%ADn_2.JPG/2560px-Khu_trung_t%C3%A2m_th%C3%A0nh_ph%E1%BB%91_H%E1%BB%93_Ch%C3%AD_Minh%2C_nh%C3%ACn_t%E1%BB%AB_ph%C3%ADa_qu%E1%BA%ADn_2.JPG');">Hà Đông</div>
    </div>
</div>

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
