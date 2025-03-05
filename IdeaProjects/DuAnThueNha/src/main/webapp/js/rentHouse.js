document.addEventListener("DOMContentLoaded", function () {
    const startDateInput = document.getElementById("startDate");
    const endDateInput = document.getElementById("endDate");
    const confirmButton = document.querySelector(".btn-confirm");
    const rentButton = document.querySelector(".btn-rent");
    const confirmRentButton = document.getElementById("confirmRent");
    const pricePerDayElement = document.getElementById("pricePerDay");

    // Lấy giá/ngày từ giao diện
    const pricePerDay = parseInt(pricePerDayElement.innerText.replace(/\D/g, "")) || 0;

    // Xử lý khi ấn "Xác nhận"
    confirmButton.addEventListener("click", function () {
        const startDate = startDateInput.value;
        const endDate = endDateInput.value;

        if (!startDate) {
            alert("Vui lòng chọn ngày bắt đầu!");
            startDateInput.classList.add("is-invalid");
            return;
        } else {
            startDateInput.classList.remove("is-invalid");
        }

        if (!endDate) {
            alert("Vui lòng chọn ngày kết thúc!");
            endDateInput.classList.add("is-invalid");
            return;
        } else {
            endDateInput.classList.remove("is-invalid");
        }

        // Tính tổng tiền
        const startDateObj = new Date(startDate);
        const endDateObj = new Date(endDate);
        const rentalDays = (endDateObj - startDateObj) / (1000 * 60 * 60 * 24) + 1; // Số ngày thuê

        if (rentalDays <= 0) {
            alert("Ngày kết thúc phải sau ngày bắt đầu!");
            return;
        }

        const totalPrice = rentalDays * pricePerDay;

        // Cập nhật giao diện "Đơn hàng"
        document.getElementById("orderDate").innerText = startDate;
        document.getElementById("displayEndDate").innerText = endDate;
        document.getElementById("totalAmount").innerText = totalPrice.toLocaleString() + " VNĐ";

        // Cho phép nhấn "Thuê ngay"
        rentButton.disabled = false;
    });

    // Xử lý khi ấn "Thuê ngay" (mở modal xác nhận)
    rentButton.addEventListener("click", function () {
        if (document.getElementById("totalAmount").innerText === "0 VNĐ") {
            alert("Vui lòng nhập thông tin và xác nhận trước khi thuê!");
        } else {
            $("#confirmModal").modal("show"); // Hiển thị modal xác nhận
        }
    });

    // Khi nhấn "Đồng ý" trong modal, tiến hành submit form
    confirmRentButton.addEventListener("click", function () {
        document.querySelector("form").submit();
    });

    // Khi người dùng nhập ngày bắt đầu, bỏ cảnh báo lỗi
    startDateInput.addEventListener("input", function () {
        startDateInput.classList.remove("is-invalid");
    });

    // Khi người dùng nhập ngày kết thúc, bỏ cảnh báo lỗi
    endDateInput.addEventListener("input", function () {
        endDateInput.classList.remove("is-invalid");
    });

    // Kiểm tra nếu form được submit thành công (quay về trang chủ)
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has("success")) {
        alert("Thuê nhà thành công!");
        window.location.href = "homeUserServlet";
    }
});
