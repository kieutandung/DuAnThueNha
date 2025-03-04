<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<style>
    .nav-icons a {
        margin-left: 15px;
        font-size: 20px;
        color: #007bff !important;
        text-decoration: none;
    }

    .nav-icons a:visited {
        color: #007bff !important;
    }

    .nav-icons a:hover {
        color: #0056b3 !important;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Arial', sans-serif;
    }

    body {
        background-color: #f8f9fa;
    }

    header {
        width: 100%;
        background: white;
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    }

    .navbar {
        width: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px 30px;
    }

    .logo {
        font-size: 25px;
        font-weight: bold;
        color: #007bff;
        display: flex;
        align-items: center;
    }

    .logo img {
        width: 40px;
        height: 40px;
        margin-right: 10px;
    }

    .nav-links {
        list-style: none;
        display: flex;
        align-items: center;
    }

    .nav-links li {
        margin: 10px 15px;
    }

    .nav-links a {
        text-decoration: none;
        color: #333;
        font-size: 18px;
        font-weight: normal;
        display: inline-block;
        position: relative;
        top: 15px;
    }

    .nav-links a:hover {
        color: #007bff;
    }

    .nav-icons {
        display: flex;
        align-items: center;
    }

    .nav-icons a, .nav-icons button {
        margin-left: 15px;
        font-size: 18px;
    }

    .btn-primary {
        background-color: #007bff;
        color: white;
        border: none;
        padding: 8px 15px;
        border-radius: 5px;
    }

    .hero {
        background-image: url('https://i.postimg.cc/44H24fk4/z6346861583592-862dc98dfcc26c43d1219f679827a619.jpg');
        background-size: cover;
        background-position: center;
        text-align: center;
        color: white;
        padding: 150px 90px;
    }

    .hero h2 {
        font-size: 28px;
        font-weight: bold;
    }
</style>

<header>
    <nav class="navbar">
        <div class="logo">
            <span>WE Bare BEARS.vn</span>
        </div>
        <ul class="nav-links">
            <li><a href="#">Trang chủ</a></li>
            <li><a href="#">Giới thiệu</a></li>
            <li><a href="#">Sản phẩm</a></li>
        </ul>
        <div class="nav-icons">
            <a href="#"><i class="fas fa-user"></i></a>
            <a href="#"><i class="fas fa-bell"></i></a>
            <button class="btn-primary">Liên hệ tư vấn</button>
        </div>
    </nav>
</header>

<section class="hero">
    <h2>Đơn đặt chỗ</h2>
</section>
