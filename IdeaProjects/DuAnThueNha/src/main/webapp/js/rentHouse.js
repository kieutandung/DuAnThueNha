document.addEventListener("DOMContentLoaded", function () {
    const startDateInput = document.getElementById("startDate");
    const endDateInput = document.getElementById("endDate");
    const numPeopleInput = document.getElementById("numPeople");
    const confirmButton = document.querySelector(".btn-confirm");
    const rentButton = document.querySelector(".btn-rent");
    const confirmRentButton = document.getElementById("confirmRent");
    const modalElement = document.getElementById("exampleModalCenter");
    const pricePerDayElement = document.getElementById("pricePerDay");
    const totalAmountElement = document.getElementById("totalAmount");
    const form = document.querySelector("form");

    let isConfirmed = false;

    // Lấy giá/ngày từ giao diện
    const pricePerDay = parseInt(pricePerDayElement.innerText.replace(/\D/g, "")) || 0;

    // Khi bấm "Xác nhận"
    confirmButton.addEventListener("click", function () {
        const startDate = startDateInput.value.trim();
        const endDate = endDateInput.value.trim();
        const numPeople = numPeopleInput.value.trim();

        // Kiểm tra ngày bắt đầu
        if (!startDate) {
            alert("Vui lòng chọn ngày bắt đầu!");
            startDateInput.classList.add("is-invalid");
            return;
        } else {
            startDateInput.classList.remove("is-invalid");
        }

        // Kiểm tra ngày kết thúc
        if (!endDate) {
            alert("Vui lòng chọn ngày kết thúc!");
            endDateInput.classList.add("is-invalid");
            return;
        } else {
            endDateInput.classList.remove("is-invalid");
        }

        // Kiểm tra ngày hợp lệ
        const startDateObj = new Date(startDate);
        const endDateObj = new Date(endDate);
        if (endDateObj <= startDateObj) {
            alert("Ngày kết thúc phải sau ngày bắt đầu!");
            return;
        }

        // Kiểm tra số người thuê
        if (!numPeople || parseInt(numPeople) <= 0) {
            alert("Vui lòng nhập số người thuê hợp lệ!");
            numPeopleInput.classList.add("is-invalid");
            return;
        } else {
            numPeopleInput.classList.remove("is-invalid");
        }

        // Tính tổng tiền thuê
        const rentalDays = (endDateObj - startDateObj) / (1000 * 60 * 60 * 24) + 1;
        const totalPrice = rentalDays * pricePerDay;

        // Hiển thị thông tin đơn hàng
        document.getElementById("orderDate").innerText = startDate;
        document.getElementById("displayEndDate").innerText = endDate;
        totalAmountElement.innerText = totalPrice.toLocaleString();

        isConfirmed = true;
        alert("Thông tin đã được xác nhận!");
    });

    // Khi bấm "Thuê ngay"
    rentButton.addEventListener("click", function () {
        if (!isConfirmed) {
            alert("Vui lòng bấm 'Xác nhận' trước khi thuê!");
            return;
        }

        // Mở modal xác nhận
        const modal = new bootstrap.Modal(modalElement);
        modal.show();
    });

    // Khi nhấn "Đồng ý" trong modal, submit form về servlet
    confirmRentButton.addEventListener("click", function () {
        if (!isConfirmed) {
            alert("Bạn chưa xác nhận thông tin!");
            return;
        }
        console.log("Form đang submit...");
        form.submit();
    });

    // Khi nhập ngày, bỏ cảnh báo lỗi
    startDateInput.addEventListener("input", () => startDateInput.classList.remove("is-invalid"));
    endDateInput.addEventListener("input", () => endDateInput.classList.remove("is-invalid"));
    numPeopleInput.addEventListener("input", () => numPeopleInput.classList.remove("is-invalid"));
});
