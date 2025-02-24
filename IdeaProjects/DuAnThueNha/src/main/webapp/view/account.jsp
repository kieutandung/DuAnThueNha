<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.example.duanthuenha.Model.Users" %>
<html>
<head>
    <title>Danh sách tài khoản</title>
</head>
<link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
<header>
    <jsp:include page="menu.jsp"/>
</header>
<link rel="stylesheet" href="/css/account.css">
<link rel="stylesheet" href="/css/addAccount.css">
<script src="/js/account.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<body>
<div class="actions">
    <div class="left">
        <button type="button" class="button add" data-toggle="modal" data-target="#addAccountModal">Thêm Người Dùng</button>
        <a href="adminServlet?action=sort" class="button sort">Sắp Xếp</a>
    </div>
    <div class="right">
        <form action="adminServlet?action=search" method="get">
            <input type="text" name="name" class="inputSearch" placeholder="Tìm Kiếm">
            <input type="hidden" name="action" value="search">
            <button type="submit" class="button search">Tìm Kiếm</button>
        </form>
    </div>
</div>

<div class="table-main">
    <table>
        <thead>
        <tr>
            <th id="avatar">Ảnh Đại Diện</th>
            <th id="fullName">Tên Người Dùng</th>
            <th id="email">Email</th>
            <th id="phone">Số Điện Thoại</th>
            <th id="role">Vai trò</th>
            <th id="status">Trạng Thái</th>
            <th id="action">Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${empty users}">
            <tr>
                <td colspan="4" style="text-align: center; color: gray;">Không có dữ liệu</td>
            </tr>
        </c:if>
        <c:forEach items="${users}" var="user">
            <tr>
                <td>
                    <img src="img/${user.image != '' ? user.image : 'man.png'}" alt="User Image" width="50" height="50">
                </td>
                <td>${user.fullName}</td>
                <td>${user.email}</td>
                <td>${user.phone}</td>
                <td>${user.role}</td>
                <td>${user.status}</td>
                <td>
                    <button type="button" class="button edit"
                            onclick='openEditModal({"idUser": "${user.idUser}", "username": "${user.username}", "fullName": "${user.fullName}", "phone": "${user.phone}", "email": "${user.email}", "role": "${user.role}", "status": "${user.status}"})'>
                        <svg width='24' height='24' viewBox='0 0 24 24' fill='none' xmlns='http://www.w3.org/2000/svg'>
                            <path fill-rule='evenodd' clip-rule='evenodd' d='M21.2635 2.29289C20.873 1.90237 20.2398 1.90237 19.8493 2.29289L18.9769 3.16525C17.8618 2.63254 16.4857 2.82801 15.5621 3.75165L4.95549 14.3582L10.6123 20.0151L21.2189 9.4085C22.1426 8.48486 22.338 7.1088 21.8053 5.99367L22.6777 5.12132C23.0682 4.7308 23.0682 4.09763 22.6777 3.70711L21.2635 2.29289ZM16.9955 10.8035L10.6123 17.1867L7.78392 14.3582L14.1671 7.9751L16.9955 10.8035ZM18.8138 8.98525L19.8047 7.99429C20.1953 7.60376 20.1953 6.9706 19.8047 6.58007L18.3905 5.16586C18 4.77534 17.3668 4.77534 16.9763 5.16586L15.9853 6.15683L18.8138 8.98525Z' fill='black'/>
                            <path d='M2 22.9502L4.12171 15.1717L9.77817 20.8289L2 22.9502Z' fill='black'/>
                        </svg>
                    </button>
                    <style>
                        .button.edit {
                            background: none;
                            border: none;
                            cursor: pointer;
                            display: inline-block; /* Ensure the button is inline-block */
                        }

                        .button.edit svg path {
                            transition: fill 0.3s; /* Smooth transition */
                        }

                        .button.edit:hover svg path {
                            fill: #007BFF; /* Hover color */
                        }
                    </style>
                    <style>
                        .button.delete {
                            background: none;
                            border: none;
                            cursor: pointer;
                        }

                        .button.delete svg path {
                            fill: black; /* Default color */
                            transition: fill 0.3s; /* Smooth transition */
                        }

                        .button.delete:hover svg path {
                            fill: red; /* Hover color */
                        }
                    </style>
                    <button class="button delete" onclick="deleteUser(${user.idUser})">
                        <i>
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd" clip-rule="evenodd" d="M17 5V4C17 2.89543 16.1046 2 15 2H9C7.89543 2 7 2.89543 7 4V5H4C3.44772 5 3 5.44772 3 6C3 6.55228 3.44772 7 4 7H5V18C5 19.6569 6.34315 21 8 21H16C17.6569 21 19 19.6569 19 18V7H20C20.5523 7 21 6.55228 21 6C21 5.44772 20.5523 5 20 5H17ZM15 4H9V5H15V4ZM17 7H7V18C7 18.5523 7.44772 19 8 19H16C16.5523 19 17 18.5523 17 18V7Z" fill="black"/>
                                <path d="M9 9H11V17H9V9Z" fill="black"/>
                                <path d="M13 9H15V17H13V9Z" fill="black"/>
                            </svg>
                        </i>
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- Add Account Modal (Same as before) -->
<div class="modal fade" id="addAccountModal" tabindex="-1" role="dialog" aria-labelledby="addAccountModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addAccountModalLabel">Thêm Tài Khoản</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="adminServlet?action=addUser" method="post">
                    <table class="table-modal-add">
                        <tr>
                            <td>Tên Đăng Nhập:</td>
                            <td><input type="text" class="username" name="username" required></td>
                        </tr>
                        <tr>
                            <td>Họ Và Tên:</td>
                            <td><input type="text" class="fullName" name="fullName" required></td>
                        </tr>
                        <tr>
                            <td>Số Điện Thoại:</td>
                            <td><input type="text" class="phone" name="phone" required></td>
                        </tr>
                        <tr>
                            <td>Email:</td>
                            <td><input type="email" name="email" required></td>
                        </tr>
                        <tr>
                            <td>Mật Khẩu:</td>
                            <td><input type="password" name="password" required></td>
                        </tr>
                        <tr>
                            <td>Vai Trò:</td>
                            <td>
                                <select name="role">
                                    <option value="ADMIN">Admin</option>
                                    <option value="HOST">Host</option>
                                    <option value="USER">User</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: center;">
                                <button class="button" type="submit">Thêm tài khoản</button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- Edit Account Modal -->
<div class="modal fade" id="editAccountModal" tabindex="-1" role="dialog" aria-labelledby="editAccountModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editAccountModalLabel">Sửa Tài Khoản</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="adminServlet?action=editUser" method="post">
                    <input type="hidden" name="idUser" id="modalIdUser" value=""/> <!-- Hidden field for user ID -->
                    <table class="table">
                        <tr>
                            <td>Tên Đăng Nhập:</td>
                            <td><input type="text" name="username" id="modalUsername" required /></td>
                        </tr>
                        <tr>
                            <td>Họ Và Tên:</td>
                            <td><input type="text" name="fullName" id="modalFullName" required /></td>
                        </tr>
                        <tr>
                            <td>Số Điện Thoại:</td>
                            <td><input type="text" name="phone" id="modalPhone" required /></td>
                        </tr>
                        <tr>
                            <td>Email:</td>
                            <td><input type="email" name="email" id="modalEmail" required /></td>
                        </tr>
                        <tr>
                            <td>Mật Khẩu:</td>
                            <td><input type="password" name="password" id="modalPassword" required /></td>
                        </tr>
                        <tr>
                            <td>Vai Trò:</td>
                            <td>
                                <select name="role" id="modalRole">
                                    <option value="default" ${user.role == 'default' ? 'selected' : ''}>Chọn vai trò</option>

                                    <c:if test="${user.role != 'admin'}">
                                        <option value="admin" ${user.role == 'admin' ? 'selected' : ''}>Admin</option>
                                    </c:if>

                                    <c:if test="${user.role != 'host'}">
                                        <option value="host" ${user.role == 'host' ? 'selected' : ''}>Host</option>
                                    </c:if>

                                    <c:if test="${user.role != 'user'}">
                                        <option value="user" ${user.role == 'user' ? 'selected' : ''}>User</option>
                                    </c:if>
                                </select>
                            </td>

                        </tr>
                        <tr>
                            <td>Trạng Thái:</td>
                            <td>
                                <select name="status" id="modalStatus">
                                    <option value="active">Active</option>
                                    <option value="block">Block</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: center;">
                                <button class="button" type="submit">Cập nhật tài khoản</button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function openEditModal(user) {
        document.getElementById('modalIdUser').value = user.idUser;
        document.getElementById('modalUsername').value = user.username;
        document.getElementById('modalFullName').value = user.fullName;
        document.getElementById('modalPhone').value = user.phone;
        document.getElementById('modalEmail').value = user.email;
        document.getElementById('modalPassword').value = user.password;
        document.getElementById('modalRole').value = user.role;
        document.getElementById('modalStatus').value = user.status;

        $('#editAccountModal').modal('show');
    }
</script>

</body>
</html>
