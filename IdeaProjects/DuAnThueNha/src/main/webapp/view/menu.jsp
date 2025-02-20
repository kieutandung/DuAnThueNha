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
        <li><i class="r"></i><a href="#" target="_blank">Hợp đồng</a></li>
        <li><i class="r"></i><a href="#" target="_blank">Hàng chờ</a></li>
        <li><i class="r"></i><a href="#" target="_blank">Tin nhắn</a></li>
        <li><i class="r"></i><a href="#" target="_blank">Thông báo</a></li>
        <li><i class="r"></i><a href="#" target="_blank">Báo cáo</a></li>
        <li><i class="r"></i><a href="#" target="_blank">Khiếu nại</a></li>
    </ul>
</div>
</body>
</html>
