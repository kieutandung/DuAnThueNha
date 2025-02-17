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

    /* Navbar */
    .navbar {
        display: flex;
        justify-content: space-between;
        padding: 15px 30px;
        background: #fff;
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        align-items: center;
        overflow: hidden; /* Prevents wrapping */
        white-space: nowrap; /* Prevents items from breaking to the next line */
    }

    .logo {
        font-size: 25px;
        font-weight: bold;
        color: #007bff;
    }

    .nav-links {
        margin-left: 50px;
        list-style: none;
        display: flex;
        align-items: center;
    }

    .nav-icon {
        margin-left: auto;
        list-style: none;
        display: flex;
        align-items: center;
    }

    .nav-search {
        list-style: none;
        display: flex;
        align-items: center; /* Align items vertically */
        margin-left: 20px; /* Optional: Add some margin for spacing */
    }

    .search-input {
        width: 400px;
        padding: 8px 30px 8px 8px; /* Add padding on the right for the icon */
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 16px;
        margin-right: 10px; /* Space between input and other elements */
        background-image: url('https://cdn4.iconfinder.com/data/icons/music-ui-solid-24px/24/search-3-512.png');
        background-repeat: no-repeat;
        background-position: right 10px center; /* Position the icon on the right */
        background-size: 20px; /* Size of the icon */
    }

    .nav-links li,
    .nav-icon li {
        margin: 0 20px;
    }

    .nav-links a {
        text-decoration: none;
        color: #333;
        font-size: 20px;
        transition: color 0.3s ease; /* Smooth transition for color change */
    }

    .nav-links a:hover {
        color: #007bff;
    }

    .bell-icon {
        font-size: 20px;
        cursor: pointer;
    }

    .btn {
        background-color: #007bff;
        color: white;
        padding: 8px 15px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .nav-icon img {
        width: 25px;
        height: 25px;
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

        .btn {
            padding: 6px 12px; /* Adjust button size */
        }
    }
</style>
<div class="container">
    <nav class="navbar">
        <div class="logo">WeBareBears.vn</div>
        <ul class="nav-links">
            <li><a href="#">Trang chủ</a></li>
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
            <li><i class="account-icon"><img src="https://cdn0.iconfinder.com/data/icons/ui-3-1/512/user-512.png"></i></li>
            <li><i class="bell-icon"><img src="https://cdn2.iconfinder.com/data/icons/boxicons-solid-vol-1/24/bxs-bell-ring-512.png"></i></li>
            <li><button class="btn">Liên hệ tư vấn</button></li>
        </ul>
    </nav>
</div>
