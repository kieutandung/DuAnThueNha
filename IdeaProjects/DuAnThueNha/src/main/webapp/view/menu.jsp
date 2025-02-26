<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Menu</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Menu.css">
    <script src="/js/Menu.js" defer></script>
</head>
<body>
<div class="menubar">
    <div class="hambclicker" onclick="toggleMenu()"></div>
    <div id="hambmenu" class=""><span></span><span></span><span></span><span></span></div>
</div>
<div id="menu" class="">
    <ul>
        <li><i class=""></i><a href="#" target="_blank">Mục lục</a></li>
        <li><i class=""></i><a href="adminServlet" target="_blank">Danh sách tài khoản</a></li>
        <li><i class=""></i><a href="adminServlet?action=approveAccount" target="_blank">Hợp đồng</a></li>
        <li class="logout-item">
            <a href="/loginServlet" class="logout-link">
                <i class="logout-icon">
                    <img src="data:image/svg+xml;utf8,<svg width='24' height='24' viewBox='0 0 24 24' fill='none' xmlns='http://www.w3.org/2000/svg'><path d='M8.51428 20H4.51428C3.40971 20 2.51428 19.1046 2.51428 18V6C2.51428 4.89543 3.40971 4 4.51428 4H8.51428V6H4.51428V18H8.51428V20Z' fill='currentColor'/><path d='M13.8418 17.385L15.262 15.9768L11.3428 12.0242L20.4857 12.0242C21.038 12.0242 21.4857 11.5765 21.4857 11.0242C21.4857 10.4719 21.038 10.0242 20.4857 10.0242L11.3236 10.0242L15.304 6.0774L13.8958 4.6572L7.5049 10.9941L13.8418 17.385Z' fill='currentColor'/></svg>" alt="Logout Icon" />
                </i>
                Đăng xuất
            </a>
        </li>
    </ul>
</div>
</body>
</html>
