<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông tin tài khoản</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            max-width: 600px;
            margin: 20px auto;
            padding: 0 20px;
        }
        .account-section {
            background-color: #ffffff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .profile-pic {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            margin-right: 20px;
            object-fit: cover;
            cursor: pointer;
        }
        h1 {
            color: #1a1a1a;
            font-size: 24px;
            margin-bottom: 5px;
        }
        .info-item {
            margin: 8px 0;
            color: #444;
            font-size: 14px;
        }
        button {
            background-color: #007bff;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: 0.3s;
        }
        button:hover {
            background-color: #0056b3;
        }
        form {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-top: 15px;
            max-width: 400px;
            margin-left: auto;
            margin-right: auto;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        form input,
        form select,
        form textarea {
            width: 100%;
            box-sizing: border-box;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        label {
            font-size: 14px;
            font-weight: bold;
            color: #444;
            display: block;
            margin-top: 10px;
        }
        .form-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
            width: 100%;
        }
        .form-actions button {
            flex: 1;
            margin: 5px;
        }
        /* Chia hàng cho 2 nút Chỉnh sửa & Đăng ký */
        .button-row {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            margin-top: 15px;
        }
    </style>
</head>
<body>

<%-- Lấy userName từ session (nếu cần) --%>
<c:set var="idUser" value="${sessionScope.userName}"/>

<div class="account-section">
    <div class="profile-header">
        <c:choose>
            <c:when test="${not empty user}">
                <!-- Ảnh đại diện -->
                <img id="preview" src="img/${user.image}" alt="Ảnh đại diện" class="profile-pic">
                <input type="file" id="fileInput" accept="image/*" style="display: none;">
                <div>
                    <h1>Thông tin tài khoản</h1>
                    <h2>
                        <div class="info-item">${user.username}</div>
                    </h2>
                </div>
            </c:when>
            <c:otherwise>
                <p>Không tìm thấy thông tin tài khoản!</p>
            </c:otherwise>
        </c:choose>
    </div>

    <c:if test="${not empty user}">
        <div class="info-item"><b>Họ và Tên:</b> ${user.fullName}</div>
        <div class="info-item"><b>Điện thoại:</b> ${user.phone}</div>
        <div class="info-item"><b>Email:</b> ${user.email}</div>
    </c:if>

    <!-- 2 nút nằm ngang: "Chỉnh sửa" & "Đăng ký" -->
    <div class="button-row">
        <button id="editBtn" type="button" onclick="toggleEditForm()">Chỉnh sửa</button>
        <button id="registerBtn" type="button" onclick="toggleRegisterForm()">Đăng ký</button>
    </div>

    <!-- Form CHỈNH SỬA THÔNG TIN (ẩn mặc định) -->
    <form id="editForm" action="profileServlet?action=updateInformation" method="post" style="display: none;">
        <!-- Modal xác nhận (Bootstrap) -->
        <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <!-- Header -->
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmModalLabel">Xác nhận thay đổi</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                    </div>
                    <!-- Body -->
                    <div class="modal-body">
                        Bạn có chắc chắn muốn thay đổi thông tin cá nhân không?
                    </div>
                    <!-- Footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary" id="confirmButton">Xác nhận</button>
                    </div>
                </div>
            </div>
        </div>

        <h3>Chỉnh sửa thông tin</h3>

        <label for="image">Avatar:</label>
        <input type="file" id="image" accept="image/*" name="image" value="img/${user.image}">

        <label for="fullName">Họ và Tên:</label>
        <input type="text" id="fullName" name="fullName" value="${user.fullName}" required
               pattern="^[A-ZÀ-Ỹ][a-zà-ỹ]+(?: [A-ZÀ-Ỹ][a-zà-ỹ]+)*$"
               title="Tên phải viết hoa chữ cái đầu, không chứa số hoặc ký tự đặc biệt ">

        <label for="phone">Điện thoại:</label>
        <input type="text" id="phone" name="phone" value="${user.phone}" required pattern="^(?:\\+84|0)\\d{9}$"
               title="Gồm 10 số">

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="${user.email}" required>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" value="${user.password}" required
               pattern="^(?=.*\\d)[A-Za-z\\d@$!%*?&]{6,30}$"
               title="Ít nhất một chữ số, độ dài từ 6 đến 30 ký tự">

        <div class="form-actions">
            <!-- Nút Lưu kích hoạt modal xác nhận -->
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#confirmModal">Lưu
            </button>
            <button type="button" onclick="toggleEditForm()">Hủy</button>
        </div>
    </form>

    <!-- Form ĐĂNG KÝ LÀM CHỦ NHÀ (ẩn mặc định) -->
    <form id="registerForm" action="ownerServlet?action=registerOwner" method="post" style="display: none;">
        <h3>Đăng ký làm chủ nhà</h3>

        <label for="ownerFullName">Họ và Tên:</label>
        <input type="text" id="ownerFullName" name="ownerFullName" required>

        <label for="ownerEmail">Email:</label>
        <input type="email" id="ownerEmail" name="ownerEmail" required>

        <label for="ownerPhone">Số điện thoại:</label>
        <input type="text" id="ownerPhone" name="ownerPhone" required>

        <label for="ownerAddress">Địa chỉ:</label>
        <input type="text" id="ownerAddress" name="ownerAddress" required>

        <label for="propertyDescription">Mô tả tài sản cho thuê:</label>
        <textarea id="propertyDescription" name="propertyDescription" rows="4"></textarea>
        <input type="file" id="images" accept="image/*" name="image" value="img/${user.image}">


        <div class="form-actions">
            <button type="submit" class="btn btn-success">Hoàn tất đăng ký</button>
            <button type="button" onclick="toggleRegisterForm()">Hủy</button>
        </div>
    </form>

</div>

<!-- Toggle Form CHỈNH SỬA -->
<script>
    function toggleEditForm() {
        let editForm = document.getElementById("editForm");
        let registerForm = document.getElementById("registerForm");
        let editBtn = document.getElementById("editBtn");
        let registerBtn = document.getElementById("registerBtn");

        // Đóng form đăng ký nếu đang mở
        if (registerForm.style.display === "block") {
            registerForm.style.display = "none";
            registerBtn.textContent = "Đăng ký";
        }

        // Mở / đóng form chỉnh sửa
        if (editForm.style.display === "none" || editForm.style.display === "") {
            editForm.style.display = "block";
            editBtn.textContent = "Đóng";
        } else {
            editForm.style.display = "none";
            editBtn.textContent = "Chỉnh sửa";
        }
    }
</script>

<!-- Toggle Form ĐĂNG KÝ -->
<script>
    function toggleRegisterForm() {
        let editForm = document.getElementById("editForm");
        let registerForm = document.getElementById("registerForm");
        let editBtn = document.getElementById("editBtn");
        let registerBtn = document.getElementById("registerBtn");

        // Đóng form chỉnh sửa nếu đang mở
        if (editForm.style.display === "block") {
            editForm.style.display = "none";
            editBtn.textContent = "Chỉnh sửa";
        }

        // Mở / đóng form đăng ký
        if (registerForm.style.display === "none" || registerForm.style.display === "") {
            registerForm.style.display = "block";
            registerBtn.textContent = "Đóng";
        } else {
            registerForm.style.display = "none";
            registerBtn.textContent = "Đăng ký";
        }
    }
</script>

<!-- Script cho nút Xác nhận trong Modal (chỉ dành cho form edit) -->
<script>
    document.getElementById("confirmButton").addEventListener("click", function () {
        // Submit form "editForm" khi người dùng xác nhận
        document.getElementById("editForm").submit();
    });
</script>

<!-- Script cho ảnh đại diện (preview) -->
<script>
    // Khi click vào ảnh, mở input file
    document.getElementById("preview").addEventListener("click", function () {
        document.getElementById("fileInput").click();
    });

    // Hiển thị ảnh preview khi chọn file
    document.getElementById("fileInput").addEventListener("change", function (event) {
        let file = event.target.files[0];
        if (file) {
            let reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById("preview").src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });
</script>

<!-- Bootstrap JS Bundle (bao gồm Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
