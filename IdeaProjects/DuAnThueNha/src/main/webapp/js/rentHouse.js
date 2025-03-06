document.addEventListener("DOMContentLoaded", function () {
    const startDateInput = document.getElementById("startDate");
    const endDatePicker = document.getElementById("endDatePicker");
    const numPeopleInput = document.getElementById("numPeople");
    const rentButton = document.querySelector(".btn-rent");
    const pricePerDay = parseInt(document.getElementById("pricePerDay").innerText.replace(/\D/g, "")) || 0;
    let selectedDays = 0;  // Lưu số ngày được chọn từ các nút "đặt ngày"

    // Hàm cập nhật thông tin đơn hàng
    function updateOrder() {
        const startDate = startDateInput.value;
        if (!startDate || selectedDays <= 0) {
            // Nếu thiếu thông tin, hiển thị giá trị mặc định
            document.getElementById("orderDate").innerText = "-";
            document.getElementById("endDate").innerText = "-";
            document.getElementById("totalAmount").innerText = "0";
            document.getElementById("numPeopleOrder").innerText = "-";
            return;
        }
        let startDateObj = new Date(startDate);
        let endDateObj = new Date(startDateObj);
        // Tính ngày kết thúc dựa trên số ngày đã chọn (bao gồm ngày bắt đầu)
        endDateObj.setDate(startDateObj.getDate() + selectedDays - 1);

        // Hàm định dạng ngày dạng dd/mm/yyyy
        const formatDate = (date) => {
            return `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()}`;
        };

        // Cập nhật thông tin đơn hàng
        document.getElementById("orderDate").innerText = formatDate(startDateObj);
        document.getElementById("endDate").innerText = formatDate(endDateObj);
        const totalPrice = selectedDays * pricePerDay;
        document.getElementById("totalAmount").innerText = totalPrice.toLocaleString();

        // Cập nhật input "Ngày kết thúc" theo định dạng yyyy-mm-dd
        endDatePicker.value = endDateObj.toISOString().split("T")[0];

        // Cập nhật số người thuê bên đơn hàng
        const numPeopleValue = numPeopleInput.value;
        document.getElementById("numPeopleOrder").innerText = numPeopleValue ? numPeopleValue : "-";
    }

    // Khi người dùng click vào nút "đặt ngày"
    document.querySelectorAll(".duration-btn").forEach(button => {
        button.addEventListener("click", function () {
            selectedDays = parseInt(this.dataset.days);
            // Nếu đã chọn ngày bắt đầu, cập nhật đơn hàng ngay lập tức
            if (startDateInput.value) {
                updateOrder();
            }
        });
    });

    // Khi ngày bắt đầu được thay đổi, nếu đã chọn số ngày, tự động cập nhật đơn hàng
    startDateInput.addEventListener("change", function () {
        if (selectedDays > 0) {
            updateOrder();
        }
    });

    // Khi số người thuê được thay đổi, tự động cập nhật đơn hàng
    numPeopleInput.addEventListener("input", function () {
        if (selectedDays > 0 && startDateInput.value) {
            updateOrder();
        }
    });

    // Nút "Thuê ngay" sử dụng để xác nhận đơn hàng
    rentButton.addEventListener("click", function () {
        if (document.getElementById("totalAmount").innerText === "0") {
            alert("Vui lòng nhập thông tin hợp lệ!");
        } else {
            alert("Bạn đã thuê thành công!");
        }
    });
});
