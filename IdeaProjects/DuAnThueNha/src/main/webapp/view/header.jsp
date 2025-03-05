<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
    * {
        margin-left: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: Arial, sans-serif;
    }

    body {
        background-color: #f5f5f5;
    }

    header, .navbar {
        width: 100%;
        margin: 0 auto;
    }

    /* Navbar */
    .navbar {
        display: flex;
        justify-content: space-between;
        padding: 15px 30px;
        background: #fff;
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
        margin-left: 20px; /* Optional: Add some margin for spacing */
    }

    .search-input {
        width: 250px;
        padding: 8px 30px 8px 8px; /* Add padding on the right for the icon */
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 16px;
        background-image: url('https://cdn4.iconfinder.com/data/icons/music-ui-solid-24px/24/search-3-512.png');
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

<div class="container-fluid" style="padding: 0">
    <nav class="navbar">
        <div class="logo">WeBareBears.vn</div>
        <ul class="nav-links">
            <li><a href="/homeUserServlet">Trang chủ</a></li>
            <li><a href="#">Giới thiệu</a></li>
            <li><a href="#">Sản phẩm</a></li>
            <li><a href="#">Liên hệ</a></li>
        </ul>
        <ul class="nav-search">
            <li>
                <input type="text" placeholder="Tìm kiếm..." class="search-input">
            </li>
        </ul>
        <ul class="nav-icon">
            <!-- Ví dụ các mục icon khác -->
            <li>
                <a href="#" title="Bộ sưu tập" class="relative text-black text-2xl">
                    <i class="fas fa-heart"></i>
                </a>
            </li>
            <li>
                <i class="bell-icon">
                    <img src="https://cdn2.iconfinder.com/data/icons/boxicons-solid-vol-1/24/bxs-bell-ring-512.png" alt="Notifications">
                </i>
            </li>
            <!-- Dropdown cho Account -->
            <li class="dropdown">
                <a href="/profileServlet">
                    <i class="account-icon">
                        <img src="https://cdn0.iconfinder.com/data/icons/ui-3-1/512/user-512.png" alt="Account">
                    </i>
                </a>
                <div class="dropdown-content">
                    <a href="/profileServlet">Thông tin cá nhân</a>
                    <a href="/orderServlet">Lịch sử thuê nhà</a>
                    <a href="/loginServlet">Đăng xuất</a>
                </div>
            </li>
        </ul>
    </nav>
</div>
