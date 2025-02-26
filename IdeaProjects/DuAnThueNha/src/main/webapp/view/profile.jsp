<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thông tin tài khoản</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        .main-container-user {
            max-width: 600px;
            margin: 20px auto 100px auto;
            padding: 0 20px;

        }

        /* Các định dạng khác của nội dung chính */

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
        .required::after {
            content: " *";
            color: red;
            font-weight: bold;
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
<header>
    <jsp:include page="header.jsp"/>
</header>
<main class="main-container-user">
    <div class="account-section">

        <div class="profile-header">
            <c:choose>
                <c:when test="${not empty user}">
                    <!-- Ảnh đại diện -->
                    <img id="preview" src="img/${user.image}" alt="ảnh người dùng" class="profile-pic" onerror="this.onerror=null; this.src='img/defaultImg-removebg-preview.png';">
                    <div>
                        <h1>Thông tin tài khoản </h1>
                        <h2>
                            <div class="info-item">${user.username}</div>
                        </h2>
                    </div>
                    <c:if test="${sessionScope.role == 'host'}">
                    <div style="padding-left: 130px">
                        <a href="productServlet"><i class="shop-icon"><img
                                src="/img/iconShop.png" style="width: 55px"></i></a>
                    </div>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <p>Không tìm thấy thông tin tài khoản!</p>
                </c:otherwise>
            </c:choose>
        </div>

        <c:if test="${not empty user}">
            <div class="row">
                <!-- Cột bên trái -->
                <div class="col-md-6">
                    <div class="info-item"><b>Họ và Tên:</b> ${user.fullName}</div>
                    <div class="info-item"><b>Điện thoại:</b> ${user.phone}</div>
                    <div class="info-item"><b>Email:</b> ${user.email}</div>
                </div>
                <!-- Cột bên phải: thêm 3 hàng thông tin nữa -->
                <div class="col-md-6">
                    <div class="info-item"><b>Ngày sinh:</b> ${not empty user.birthDate ? user.birthDate : "Chưa cập nhật"}</div>
                    <div class="info-item"><b>Địa chỉ:</b> ${not empty user.address ? user.address : "Chưa cập nhật"}</div>
                    <div class="info-item"><b>Giới tính:</b> ${not empty user.gender ? user.gender : "Chưa cập nhật"}</div>
                </div>

            </div>
        </c:if>


        <!-- 2 nút nằm ngang: "Chỉnh sửa" & "Đăng ký" -->
        <div class="button-row">
            <button id="editBtn" type="button" onclick="toggleEditForm()">Chỉnh sửa</button>
            <button id="registerBtn" class="btn btn-success" type="button" onclick="window.location.href='userToHostServlet'">Đăng kí làm chủ nhà
            </button>
        </div>

        <!-- Form CHỈNH SỬA THÔNG TIN (ẩn mặc định) -->
        <form id="editForm" action="profileServlet?action=updateInformation" method="post" style="display: none;">
            <!-- Modal xác nhận (Bootstrap) -->
            <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
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

            <h3 class="text-center">Chỉnh sửa thông tin</h3>

            <div class="text-center">
                <!-- Avatar -->
                <label for="image">Ảnh đại diện:</label>

                <!-- Ẩn file input mặc định -->
                <input type="file" id="image" name="image" accept="image/*" style="display: none;">

                <!-- Ô hiển thị ảnh (preview) -->
                <div style="margin-top: 10px;">
                    <img id="imagePreview" src="img/${user.image != null && user.image != ''  ? user.image : 'defaultImg-removebg-preview.png'}" alt="Ảnh đại diện"  style="max-width: 200px; border: 1px solid #ccc; padding: 5px;">
                </div>

                <button type="button" class="btn btn-primary mt-2" onclick="document.getElementById('image').click();">
                    Chọn ảnh
                </button>
            </div>

            <!-- Họ và Tên -->
            <label for="fullName" class="required" >Họ và Tên:</label>
            <input type="text" id="fullName" name="fullName" value="${user.fullName}" required
                   pattern="^[A-ZÀ-Ỹ][a-zà-ỹ]+(?: [A-ZÀ-Ỹ][a-zà-ỹ]+)*$"
                   title="Tên phải viết hoa chữ cái đầu, không chứa số hoặc ký tự đặc biệt ">

            <!-- Điện thoại -->
            <label for="phone" class="required" >Điện thoại:</label>
            <input type="text" id="phone" name="phone" value="${user.phone}" required pattern="^(?:\+84|0)\d{9}$"
                   title="Gồm 10 số">

            <!-- Email -->
            <label for="email" class="required" >Email:</label>
            <input type="email" id="email" name="email" value="${user.email}" required>


            <label for="birthDate">Ngày sinh:</label>
            <input type="date" id="birthDate" name="birthDate"
                   value="${user.birthDate}"
                   max="<%= java.time.LocalDate.now() %>"
                   onblur="formatDateBeforeSubmit()">
            <input type="hidden" id="formattedBirthDate" name="formattedBirthDate">

            <!-- Địa chỉ -->
            <label for="address">Địa chỉ:</label>
            <input type="text" id="address" name="address" value="${user.address}" placeholder="Nhập địa chỉ của bạn">

            <!-- Giới tính -->
            <label for="gender">Giới tính:</label>
            <select id="gender" name="gender">
                <option value="${user.gender}">-- Chọn giới tính --</option>
                <option value="male" ${user.gender eq 'male' ? 'selected' : ''}>Nam</option>
                <option value="female" ${user.gender eq 'female' ? 'selected' : ''}>Nữ</option>
                <option value="other" ${user.gender eq 'other' ? 'selected' : ''}>Khác</option>
            </select>

            <!-- Password -->
            <label for="password" class="required">Mật khẩu:</label>
            <input type="password" id="password" name="password" value="${user.password}" required
                   pattern="^(?=.*\d)[A-Za-z\d@$!%*?&]{6,30}$"
                   title="Ít nhất một chữ số, độ dài từ 6 đến 30 ký tự">

            <div class="form-actions">
                <!-- Nút Lưu kích hoạt modal xác nhận -->
                <button type="button" class="btn btn-primary" id="saveTriggerButton" data-bs-target="#confirmModal">Lưu
                </button>
                <button type="button" class="btn btn-danger" onclick="toggleEditForm()">Hủy</button>
            </div>
        </form>
    </div>
</main>


<!-- Toggle Form CHỈNH SỬA -->
<script>
    document.getElementById('editForm').addEventListener('keydown', function(event) {
        if (event.key === 'Enter') {
            event.preventDefault();
            return false;
        }
    });
    function toggleEditForm() {
        let editForm = document.getElementById("editForm");
        let editBtn = document.getElementById("editBtn");

        // Mở / đóng form chỉnh sửa
        if (editForm.style.display === "none" || editForm.style.display === "") {
            editForm.style.display = "block";
            editBtn.textContent = "Đóng";
        } else {
            editForm.style.display = "none";
            editBtn.textContent = "Chỉnh sửa";
        }
    }
    function formatDateBeforeSubmit() {
        let dateInput = document.getElementById("birthDate").value;
        if (dateInput) {
            let parts = dateInput.split("-"); // Tách YYYY-MM-DD
            let formattedDate = parts[2] + "/" + parts[1] + "/" + parts[0]; // Đổi thành DD/MM/YYYY
            document.getElementById("formattedBirthDate").value = formattedDate; // Gán vào input hidden
        }
    }
    document.getElementById('image').addEventListener('change', function(event) {
        const file = this.files[0];
        if (file) {
            const preview = document.getElementById('imagePreview');
            preview.src = URL.createObjectURL(file);
        }
    });
    document.getElementById("confirmButton").addEventListener("click", function () {
        // Submit form "editForm" khi người dùng xác nhận
        document.getElementById("editForm").submit();
    });
    document.addEventListener("DOMContentLoaded", function () {
        const editForm = document.getElementById("editForm");
        const saveTriggerButton = document.getElementById("saveTriggerButton");
        const confirmModalElement = document.getElementById("confirmModal");

        saveTriggerButton.addEventListener("click", function () {
            // Kiểm tra tính hợp lệ của form
            if (editForm.checkValidity()) {
                // Nếu form hợp lệ, mở modal xác nhận
                var modal = new bootstrap.Modal(confirmModalElement);
                modal.show();
            } else {
                // Nếu không hợp lệ, hiển thị thông báo lỗi cho người dùng
                editForm.reportValidity();
            }
        });
    });
</script>

<!-- Bootstrap JS Bundle (bao gồm Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<footer>
    <jsp:include page="footer.jsp"/>
</footer>
</body>
</html>
