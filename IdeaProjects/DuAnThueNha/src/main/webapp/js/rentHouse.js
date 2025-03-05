// Hàm hiển thị alert lỗi
function showAlert(message) {
    const alertBox = document.getElementById("errorAlert");
    const alertMessage = document.getElementById("errorMessage");

    alertMessage.innerText = message;
    alertBox.classList.remove("d-none"); // Hiện thông báo

    // Tự động ẩn sau 3 giây
    setTimeout(() => {
        alertBox.classList.add("d-none");
    }, 3000);
}

// Hàm hiển thị alert thành công
function showSuccess(message) {
    const successBox = document.getElementById("successAlert");
    const successMessage = document.getElementById("successMessage");

    successMessage.innerText = message;
    successBox.classList.remove("d-none"); // Hiện thông báo

    // Tự động ẩn sau 3 giây
    setTimeout(() => {
        successBox.classList.add("d-none");
    }, 3000);
}

document.addEventListener("DOMContentLoaded", function () {
    const startDateInput = document.getElementById("startDate");
    const endDateInput = document.getElementById("endDate");
    const confirmButton = document.querySelector(".btn-confirm");
    const rentButton = document.querySelector(".btn-rent");

    confirmButton.addEventListener("click", function () {
        const startDate = startDateInput.value;
        const endDate = endDateInput.value;

        if (!startDate) {
            showAlert("Vui lòng chọn ngày bắt đầu!");
            return;
        }

        if (!endDate) {
            showAlert("Vui lòng chọn ngày kết thúc!");
            return;
        }

        // Chuyển đổi sang đối tượng Date
        const startDateObj = new Date(startDate);
        const endDateObj = new Date(endDate);
        const rentalDays = (endDateObj - startDateObj) / (1000 * 60 * 60 * 24);

        if (rentalDays < 1) {
            showAlert("Ngày kết thúc phải sau ngày bắt đầu ít nhất 1 đêm!");
            return;
        }

        // Cập nhật đơn hàng
        document.getElementById("orderDate").innerText = startDate;
        document.getElementById("displayEndDate").innerText = endDate;
        document.getElementById("totalAmount").innerText = ((rentalDays + 1) * 350000).toLocaleString("vi-VN");
    });

    // Xử lý thuê nhà
    rentButton.addEventListener("click", function (event) {
        const startDate = document.getElementById("orderDate").innerText;
        const endDate = document.getElementById("displayEndDate").innerText;

        if (startDate === "-" || endDate === "-") {
            showAlert("Vui lòng xác nhận thông tin trước khi thuê!");
            event.preventDefault(); // Ngăn chặn submit nếu chưa nhập thông tin
            return;
        }

        // Hiển thị thông báo thuê thành công
        showSuccess("Thuê nhà thành công! Chúc bạn có kỳ nghỉ vui vẻ!");

        // Ngăn form submit ngay lập tức để hiển thị thông báo
        event.preventDefault();

        // Sau 3 giây mới submit form
        setTimeout(() => {
            document.querySelector("form").submit();
        }, 3000);
    });
});
