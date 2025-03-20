document.addEventListener("DOMContentLoaded", function () {
    const startDateInput = document.getElementById("startDate");
    const endDateInput = document.getElementById("endDatePicker");
    const numPeopleInput = document.getElementById("numPeople");
    const rentButton = document.querySelector(".btn-rent");
    const confirmRentButton = document.getElementById("confirmRent");
    const modalElement = document.getElementById("exampleModalCenter");
    const pricePerDayElement = document.getElementById("pricePerDay");
    const totalAmountElement = document.getElementById("totalAmount");
    const orderDateElement = document.getElementById("orderDate");
    const endDateElement = document.getElementById("endDate");
    const numPeopleOrderElement = document.getElementById("numPeopleOrder");
    const form = document.querySelector("form");

    let selectedDays = 0;

    // Lấy giá/ngày từ giao diện
    const pricePerDay = parseInt(pricePerDayElement.innerText.replace(/\D/g, "")) || 0;

    // Hàm cập nhật đơn hàng
    function updateOrder() {
        const startDate = startDateInput.value;
        if (!startDate || selectedDays <= 0) {
            orderDateElement.innerText = "-";
            endDateElement.innerText = "-";
            totalAmountElement.innerText = "0";
            numPeopleOrderElement.innerText = "-";
            return;
        }

        let startDateObj = new Date(startDate);
        let endDateObj = new Date(startDateObj);
        endDateObj.setDate(startDateObj.getDate() + selectedDays);

        const formatDate = (date) => {
            const dd = String(date.getDate()).padStart(2, '0');
            const mm = String(date.getMonth() + 1).padStart(2, '0');
            const yyyy = date.getFullYear();
            return `${dd}/${mm}/${yyyy}`;
        };
        // Cập nhật thông tin đơn hàng
        orderDateElement.innerText = formatDate(startDateObj);
        endDateElement.innerText = formatDate(endDateObj);
        const totalPrice = selectedDays * pricePerDay;
        totalAmountElement.innerText = totalPrice.toLocaleString();

        // Cập nhật input ngày kết thúc
        endDateInput.value = endDateObj.toISOString().split("T")[0];

        // Cập nhật số người thuê
        const numPeopleValue = numPeopleInput.value;
        numPeopleOrderElement.innerText = numPeopleValue ? numPeopleValue : "-";
    }

    // Khi người dùng click vào nút "đặt ngày"
    document.querySelectorAll(".duration-btn").forEach(button => {
        button.addEventListener("click", function () {
            selectedDays = parseInt(this.dataset.days);
            if (startDateInput.value) {
                updateOrder();
            }
        });
    });
    startDateInput.addEventListener("change", function () {
        if (startDateInput.value) {
            if (endDateInput.value) {
                endDateInput.value = "";
                endDateElement.innerText = "-";
                selectedDays = 0;
                numPeopleInput.value = "";
                numPeopleOrderElement.innerText = "-";
            }
            updateOrder();
        }
    });


    // Khi người dùng thay đổi ngày kết thúc thủ công, cập nhật lại selectedDays và thông tin đơn hàng
    endDateInput.addEventListener("change", function () {
        if (startDateInput.value && endDateInput.value) {
            let startDateObj = new Date(startDateInput.value);
            let endDateObj = new Date(endDateInput.value);
            let diffTime = endDateObj.getTime() - startDateObj.getTime();
            selectedDays = Math.floor(diffTime / (1000 * 3600 * 24));
            updateOrder();
        } else {
            endDateElement.innerText = "-";
        }
    });

    // Khi số người thuê thay đổi
    numPeopleInput.addEventListener("input", function () {
        updateOrder();
    });

    function showNotification(message, type) {
        Swal.fire({
            toast: true,
            position: 'top',
            icon: type,
            title: message,
            showConfirmButton: false,
            timer: 2500,
            timerProgressBar: true
        });
    }

    // Khi nhấn "Thuê ngay"
    rentButton.addEventListener("click", function (event) {
        event.preventDefault(); // Ngăn form submit ngay lập tức

        if (!startDateInput.value) {
            showNotification("Vui lòng chọn ngày bắt đầu!", "warning");
            return;
        }

        if (selectedDays <= 0) {
            showNotification("Vui lòng chọn số ngày thuê!", "warning");
            return;
        }

        if (!numPeopleInput.value || numPeopleInput.value <= 0) {
            showNotification("Vui lòng nhập số người thuê!", "warning");
            return;
        }

        // Nếu hợp lệ, mở modal xác nhận
        const modal = new bootstrap.Modal(modalElement);
        modal.show();
    });

    // Khi nhấn "Đồng ý" trong modal, submit form về servlet
    confirmRentButton.addEventListener("click", function () {
        form.submit();
    });

});
