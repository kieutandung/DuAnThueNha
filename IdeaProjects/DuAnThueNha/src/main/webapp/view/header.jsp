<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: Arial, sans-serif;
    }
    body {
        padding-top: 80px;
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
        z-index: 9999; /* Đảm bảo hiển thị trên cùng */
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

    .nav-icon {
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
        z-index: 99999 !important;
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

    .dropdown-content.show {
        display: block; /* Khi có class .show, dropdown-content sẽ hiện */
    }

    .notification-item:hover {
        background-color: #f1f1f1;
    }

    .notification-header {
        margin-bottom: 5px;
    }

    .notification-content {
        max-height: 150px;
        overflow-y: auto;
        white-space: normal;
        word-wrap: break-word;
    }

    .bell-icon {
        position: relative; /* Để badge có thể định vị tuyệt đối dựa trên .bell-icon */
        display: inline-block;
        width: 25px; /* điều chỉnh theo kích thước icon chuông */
        height: 25px; /* điều chỉnh theo kích thước icon chuông */
    }

    /* Badge số thông báo */
    .notification-badge {
        position: absolute;
        top: -5px;
        right: -7px;
        background-color: #3b71ca;
        color: white;
        border-radius: 90%;
        padding: 2px 6px;
        font-size: 12px;
        line-height: 1;
        z-index: 1000;
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
            <li><a href="/introductionServlet">Giới thiệu</a></li>
            <li><a href="/orderInformationServlet">Đơn hàng</a></li>
            <li><a href="/chatServlet">Liên hệ</a></li>
        </ul>

        <ul class="nav-icon">
            <li>
                <a href="chatServlet" title="Nhắn tin" class="relative text-black text-2xl">
                    <img src="img/chat (1).png" alt="Chat" class="w-6 h-6 icon-black">
                </a>
            </li>
            <li class="dropdown">
                <i class="bell-icon">
                    <img src="img/bell.png" alt="Notifications" class="icon-black">
                    <c:if test="${sessionScope.unreadCount gt 0}">
                        <span class="notification-badge">${sessionScope.unreadCount}</span>
                    </c:if>
                </i>
                <div class="dropdown-content-ui">
                    <!-- Gán ID cho dropdown thông báo -->
                    <div id="notificationDropdown" class="dropdown-content"
                         style="width: 300px; max-height: 400px; overflow-y: auto;">
                        <c:if test="${not empty sessionScope.notificationList}">
                            <c:forEach var="n" items="${sessionScope.notificationList}" varStatus="status">
                                <div class="notification-item p-2 border-bottom">
                                    <p class="notification-header">
                                        <strong>${n.type}</strong>
                                    </p>
                                    <div class="notification-content">
                                        <p>${n.title} : ${n.message}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty sessionScope.notificationList}">
                            <p class="text-center text-muted p-2">Không có thông báo mới</p>
                        </c:if>
                        <%--                        <a href="/profileServlet" class="d-block text-center mt-2">Xem tất cả thông báo</a>--%>
                    </div>
                </div>
            </li>
            <!-- Dropdown cho Account -->
            <li class="dropdown">
                <i class="account-icon">
                    <img src="img/userIcon.png" alt="Account">
                </i>
                <!-- Gán ID cho dropdown tài khoản -->
                <div id="accountDropdown" class="dropdown-content">
                    <a href="/profileServlet">Thông tin cá nhân</a>
                    <a href="/homeUserServlet?action=showFavorite" title="Bộ sưu tập"
                       class="relative text-black text-2xl">
                        Bộ sưu tập
                    </a>
                    <a href="/orderInformationServlet">Lịch sử thuê nhà</a>
                    <hr style="margin: 0">
                    <a href="/loginServlet" style="text-align: center">Đăng xuất</a>
                </div>
            </li>
        </ul>
    </nav>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const bellIcon = document.querySelector('.bell-icon');
        const notificationDropdown = document.getElementById('notificationDropdown');

        const accountIcon = document.querySelector('.account-icon');
        const accountDropdown = document.getElementById('accountDropdown');


        bellIcon.addEventListener('click', function (event) {
            event.stopPropagation();
            notificationDropdown.classList.toggle('show');
            accountDropdown.classList.remove('show');

            fetch('notificationUserServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: ''
            }).then(response => {

                const badge = document.querySelector('.notification-badge');
                if (badge) {
                    badge.style.display = 'none';
                }
                return response.text();
            })
        });


        accountIcon.addEventListener('click', function (event) {
            event.stopPropagation();
            accountDropdown.classList.toggle('show');

            notificationDropdown.classList.remove('show');
        });

        document.addEventListener('click', function (event) {
            if (!notificationDropdown.contains(event.target) && !bellIcon.contains(event.target)) {
                notificationDropdown.classList.remove('show');
            }
            if (!accountDropdown.contains(event.target) && !accountIcon.contains(event.target)) {
                accountDropdown.classList.remove('show');
            }
        });
    });
</script>