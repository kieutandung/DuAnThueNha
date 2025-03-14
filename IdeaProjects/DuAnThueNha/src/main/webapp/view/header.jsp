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
            <li><a href="/orderInformationServlet">Đơn thuê</a></li>
            <li><a href="#">Liên hệ</a></li>
        </ul>
<%--        <ul class="nav-search">--%>
<%--            <li>--%>
<%--                <input type="text" placeholder="Tìm kiếm..." class="search-input">--%>
<%--            </li>--%>
<%--        </ul>--%>
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
<%--                <div class="dropdown">--%>
<%--                    <a data-mdb-dropdown-init class="me-3 dropdown-toggle hidden-arrow" href="#" id="navbarDropdownMenuLink"--%>
<%--                       role="button" data-mdb-toggle="dropdown" aria-expanded="false">--%>
<%--                        <i class="fas fa-bell"></i>--%>
<%--                        <span class="badge rounded-pill badge-notification bg-danger">1</span>--%>
<%--                    </a>--%>
<%--                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">--%>
<%--                        <li>--%>
<%--                            <a class="dropdown-item" href="#">Some news</a>--%>
<%--                        </li>--%>
<%--                        <li>--%>
<%--                            <a class="dropdown-item" href="#">Another news</a>--%>
<%--                        </li>--%>
<%--                        <li>--%>
<%--                            <a class="dropdown-item" href="#">Something else here</a>--%>
<%--                        </li>--%>
<%--                    </ul>--%>
<%--                </div>--%>
<%--            </li>--%>

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
