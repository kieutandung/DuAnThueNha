<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông tin tài khoản</title>
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
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
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
        }

        h1 {
            color: #1a1a1a;
            font-size: 24px;
            margin-bottom: 5px;
        }

        h2 {
            color: #333;
            font-size: 20px;
            margin: 15px 0;
        }

        h3 {
            color: #666;
            font-size: 16px;
            margin: 12px 0 8px;
        }

        .info-item {
            margin: 8px 0;
            color: #444;
            font-size: 14px;
        }

        .note {
            color: #999;
            font-size: 12px;
            margin-top: 15px;
            line-height: 1.4;
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
        }

        form h3 {
            margin-bottom: 15px;
            font-size: 18px;
            color: #333;
        }

        label {
            font-size: 14px;
            font-weight: bold;
            color: #444;
            display: block;
            margin-top: 10px;
        }

        input, select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        .form-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
        }

        .form-actions button {
            flex: 1;
            margin: 5px;
            background-color: #007bff;
        }

        .form-actions button:hover {
            background-color:#0056b3;
        }

        .form-actions button:nth-child(2) {
            background-color: #555555;
        }

        .form-actions button:nth-child(2):hover {
            background-color: #363636;
        }
        body { font-family: 'Arial', sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: left; }
        th { background-color: #f4f4f4; }
        .avatar { width: 50px; height: 50px; border-radius: 50%; object-fit: cover; }
    </style>
</head>
<body>
<div class="account-section">
    <div class="profile-header">
        <img src="image/IMG_2039.PNG" alt="Ảnh đại diện" class="profile-pic">
        <div>
            <h1>Thông tin tài khoản</h1>
            <h2>Chỉ Anh</h2>
        </div>
    </div>

    <div class="personal-info">
        <h3>Thông tin cá nhân</h3>
        <div class="info-item">Giới tính Nam</div>
        <div class="info-item">Ngày sinh 13 tháng 03, 2005</div>
        <div class="info-item">Điện thoại +84 346 682 183</div>
    </div>

    <div class="note">
        Chỉ bạn bè có lưu số của bạn trong danh bạ máy xem được số này
    </div>
    <button id="editBtn" onclick="toggleEditForm()">Chỉnh sửa</button>

    <form id="editForm" action="UpdateAccountServlet" method="post" style="display: none;">
        <h3>Chỉnh sửa thông tin</h3>

        <label for="username">Họ và Tên:</label>
        <input type="text" id="username" name="username" value="<%= request.getAttribute("username") %>" required>

        <label for="gender">Giới tính:</label>
        <select id="gender" name="gender">
            <option value="Nam" <%= "Nam".equals(request.getAttribute("gender")) ? "selected" : "" %>>Nam</option>
            <option value="Nữ" <%= "Nữ".equals(request.getAttribute("gender")) ? "selected" : "" %>>Nữ</option>
        </select>

        <label for="dob">Ngày sinh:</label>
        <input type="date" id="dob" name="dob" value="<%= request.getAttribute("dob") %>" required>

        <label for="phone">Điện thoại:</label>
        <input type="text" id="phone" name="phone" value="<%= request.getAttribute("phone") %>" required>

        <div class="form-actions">
            <button type="submit">Lưu</button>
            <button type="button" onclick="toggleEditForm()">Hủy</button>
        </div>
    </form>

    <script>
        function toggleEditForm() {
            let form = document.getElementById("editForm");
            let button = document.getElementById("editBtn");

            if (form.style.display === "none") {
                form.style.display = "block";
                button.textContent = "Đóng";
            } else {
                form.style.display = "none";
                button.textContent = "Chỉnh sửa";
            }
        }
    </script>

</div>
</body>
</html>