document.addEventListener("DOMContentLoaded", function () {
    const startDateInput = document.getElementById("startDate");
    const endDateInput = document.getElementById("endDate");
    const confirmButton = document.querySelector(".btn-confirm");
    const rentButton = document.querySelector(".btn-rent");
    const pricePerDay = parseInt(document.getElementById("pricePerDay").innerText.replace(/\D/g, "")) || 0;

    // Xử lý khi ấn "Xác nhận"
    confirmButton.addEventListener("click", function () {
        const startDate = startDateInput.value;
        const endDate = endDateInput.value;

        if (!startDate) {
            startDateInput.classList.add("is-invalid");
            alert("Vui lòng chọn ngày bắt đầu!");
            return;
        } else {
            startDateInput.classList.remove("is-invalid");
        }

        if (!endDate) {
            endDateInput.classList.add("is-invalid");
            alert("Vui lòng chọn ngày kết thúc!");
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
        document.getElementById("orderDate").innerText = startDate; // Ngày bắt đầu
        document.getElementById("displayEndDate").innerText = endDate; // Ngày kết thúc
        document.getElementById("totalAmount").innerText = totalPrice.toLocaleString();
    });

    // Xử lý khi ấn "Thuê ngay"
    rentButton.addEventListener("click", function () {
        if (document.getElementById("totalAmount").innerText === "0") {
            alert("Vui lòng nhập thông tin và xác nhận trước khi thuê!");
        } else {
            alert("Bạn đã thuê thành công!");
        }
    });

    // Khi người dùng nhập ngày bắt đầu, bỏ cảnh báo lỗi
    startDateInput.addEventListener("input", function () {
        if (startDateInput.value) {
            startDateInput.classList.remove("is-invalid");
        }
    });

    // Khi người dùng nhập ngày kết thúc, bỏ cảnh báo lỗi
    endDateInput.addEventListener("input", function () {
        if (endDateInput.value) {
            endDateInput.classList.remove("is-invalid");
        }
    });
});
