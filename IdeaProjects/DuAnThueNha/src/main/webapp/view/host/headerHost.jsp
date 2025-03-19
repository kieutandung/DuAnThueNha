<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
    * {
        margin-left: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: Arial, sans-serif;
    }

    body {
        padding-top: 70px;
    }

    header, .navbar {
        width: 100%;
        margin: 0 auto;
    }


    /* Navbar */
    .navbar {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        background: #fff;
        z-index: 1000; /* Đảm bảo hiển thị trên cùng */
        display: flex;
        justify-content: space-between;
        padding: 15px 30px;
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        align-items: center;
        overflow: visible; /* Đã chuyển từ hidden sang visible */
        white-space: nowrap; /* Prevents items from breaking to the next line */
    }

    .logo {
        font-size: 25px;
        font-weight: bold;
        color: #007bff;
    }

    .nav-links {
        padding-top: 15px;
        margin-left: 50px;
        list-style: none;
        display: flex;
        align-items: center;
    }

    .nav-icon, .nav-search {
        padding-top: 15px;
        list-style: none;
        display: flex;
        align-items: center;
    }
    .nav-search {
        padding-top: 15px;
        list-style: none;
        display: flex;
        align-items: center; /* Align items vertically */
        margin-left: 20px; /* Optional: Add some margin for spacing */
    }

    .search-input {
        width: 250px;
        padding: 8px 30px 8px 8px; /* Add padding on the right for the icon */
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 16px;
        background-repeat: no-repeat;
        background-position: right 10px center; /* Position the icon on the right */
        background-size: 20px; /* Size of the icon */
    }

    .nav-links li,
    .nav-icon li {
        margin: 0 20px;
        position: relative;
    }

    .nav-links a, .nav-icon a {
        text-decoration: none;
        color: #333;
        font-size: 20px;
        transition: color 0.3s ease; /* Smooth transition for color change */
    }

    .nav-links a:hover, .nav-icon a:hover {
        color: #007bff;
    }

    .bell-icon {
        font-size: 20px;
        cursor: pointer;
    }

    .nav-icon img {
        width: 25px;
        height: 25px;
    }

    .icon-black {
        filter: brightness(0) saturate(100%);
    }


    /* Dropdown Styles */
    .dropdown-content {
        display: none;
        position: absolute;
        top: 100%;
        right: 0;
        background-color: #fff;
        min-width: 150px;
        box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
        z-index: 99999 !important; /* Z-index cao để đảm bảo hiển thị trên cùng */
        border-radius: 4px;
        overflow: hidden;
    }

    .dropdown-content a {
        color: #333;
        padding: 10px 16px;
        text-decoration: none;
        display: block;
        font-size: 16px;
        transition: background-color 0.3s ease;
        z-index: 99999 !important;
        text-align: left;
    }

    .dropdown-content a:hover {
        background-color: #f1f1f1;
    }

    /* Hiển thị dropdown khi hover */
    .dropdown:hover .dropdown-content {
        display: block;
    }



    /* Responsive Styles */
    @media (max-width: 768px) {
        .navbar {
            padding: 10px 20px; /* Adjust padding for smaller screens */
        }

        .nav-links {
            margin-left: 20px; /* Adjust margin for smaller screens */
        }

        .nav-icon {
            margin-left: 20px; /* Adjust margin for smaller screens */
        }

        .nav-links li,
        .nav-icon li {
            margin: 0 10px; /* Adjust margin for smaller screens */
        }
    }

    @media (max-width: 480px) {
        .logo {
            font-size: 18px; /* Reduce logo size */
        }

        .nav-links a,
        .nav-icon a {
            font-size: 14px; /* Reduce font size for links */
        }
    }
</style>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<div class="container-fluid" style="padding: 0">

    <nav class="navbar">
        <div class="logo">WeBareBears.vn</div>
        <ul class="nav-links">
            <li><a href="/homeUserServlet">Trang chủ</a></li>
            <li class="dropdown">
                <a href="#" class="nav-link">Quản lý</a>
                <div class="dropdown-content">
                    <a href="/listProductHostServlet?action=manageRentalRequests">Quản lý yêu cầu thuê</a>
                    <a href="listProductHostServlet">Quản lý sản phẩm</a>
                    <a href="paymentManagementServlet">Quản lý thanh toán</a>
                </div>
            </li>
            <li><a href="revenueServlet">Doanh thu</a></li>
            <li><a href="addProductHostServlet">Thêm sản phẩm mới</a></li>
        </ul>

        <form action="listProductHostServlet?action=search" method="post" style=" margin-bottom: 0px;">
            <ul class="nav-search">
                <li>
                    <input id="searchProductHost" type="text" name="searchProductHost" placeholder="Tìm kiếm theo tên, địa chỉ"
                           class="search-input" value="${keyword}">
                </li>
            </ul>
        </form>

        <ul class="nav-icon">
            <li>
                <a href="chatServlet" title="Nhắn tin" class="relative text-black text-2xl">
                    <img src="img/chat (1).png" alt="Char"
                         class="w-6 h-6 icon-black">
                </a>
            </li>
            <li>
                <i class="bell-icon">
                    <img src="img/bell.png"
                         alt="Notifications" class="icon-black">
                </i>
            </li>

            <!-- Dropdown cho Account -->
            <li class="dropdown">

                <i class="account-icon">
                    <img src="img/userIcon.png" alt="Account">
                </i>

                <div class="dropdown-content">
                    <a href="/profileServlet">Thông tin cá nhân</a>
                    <a href="/homeUserServlet?action=showFavorite" title="Bộ sưu tập" class="relative text-black text-2xl"> Bộ sưu tập
                    </a>
                    <a href="/orderInformationServlet">Lịch sử thuê nhà</a>
                    <a href="/loginServlet">Đăng xuất</a>
                </div>
            </li>
        </ul>
    </nav>
</div>



