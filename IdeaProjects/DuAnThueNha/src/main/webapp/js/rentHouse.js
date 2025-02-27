document.addEventListener("DOMContentLoaded", function () {
    const startDateInput = document.getElementById("startDate");
    const numDaysInput = document.getElementById("numDays");
    const confirmButton = document.querySelector(".btn-confirm");
    const rentButton = document.querySelector(".btn-rent");
    const pricePerDay = parseInt(document.getElementById("pricePerDay").innerText.replace(/\D/g, "")) || 0;

    // Xử lý khi ấn vào các nút số ngày
    document.querySelectorAll(".duration-btn").forEach(button => {
        button.addEventListener("click", function () {
            numDaysInput.value = this.dataset.days;
        });
    });

    // Xử lý khi ấn "Xác nhận"
    confirmButton.addEventListener("click", function () {
        const startDate = startDateInput.value;
        const rentalDays = parseInt(numDaysInput.value) || 0;

        if (!startDate || rentalDays <= 0) {
            alert("Vui lòng nhập ngày bắt đầu và số ngày hợp lệ!");
            return;
        }

        // Tính toán ngày kết thúc
        let startDateObj = new Date(startDate);
        let endDateObj = new Date(startDateObj);
        endDateObj.setDate(startDateObj.getDate() + rentalDays - 1);

        // Định dạng ngày (dd/mm/yyyy)
        const formatDate = (date) => {
            return `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()}`;
        };

        // Tính tổng tiền
        const totalPrice = rentalDays * pricePerDay;

        // Cập nhật giao diện "Đơn hàng"
        document.getElementById("orderDate").innerText = formatDate(startDateObj);
        document.getElementById("endDate").innerText = formatDate(endDateObj);
        document.getElementById("totalAmount").innerText = totalPrice.toLocaleString();
    });

    // Xử lý khi ấn "Thuê ngay"
    rentButton.addEventListener("click", function () {
        if (document.getElementById("totalAmount").innerText === "0 VND") {
            alert("Vui lòng nhập thông tin và xác nhận trước khi thuê!");
        } else {
            alert("Bạn đã thuê thành công!");
        }
    });
});
