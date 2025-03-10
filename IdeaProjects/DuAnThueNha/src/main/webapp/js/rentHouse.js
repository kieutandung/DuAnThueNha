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
    const pricePerDay = parseInt(pricePerDayElement.innerText.replace(/\D/g, "")) || 0;

    // Hàm định dạng ngày theo định dạng dd/mm/yyyy
    const formatDate = (date) => {
        const dd = String(date.getDate()).padStart(2, '0');
        const mm = String(date.getMonth() + 1).padStart(2, '0');
        const yyyy = date.getFullYear();
        return `${dd}/${mm}/${yyyy}`;
    };

    // Hàm cập nhật thông tin đơn hàng dựa trên ngày bắt đầu và ngày kết thúc hiện có
    function updateOrder() {
        const startDate = startDateInput.value;
        if (!startDate) {
            orderDateElement.innerText = "-";
            endDateElement.innerText = "-";
            totalAmountElement.innerText = "0";
            numPeopleOrderElement.innerText = "-";
            return;
        }

        let startDateObj = new Date(startDate);
        let endDateObj = null;

        if (endDateInput.value) {
            // Nếu người dùng đã chọn ngày kết thúc thủ công, dùng giá trị đó
            endDateObj = new Date(endDateInput.value);
            // Tính số ngày thuê từ hiệu số giữa ngày kết thúc và ngày bắt đầu (cộng 1)
            let diffTime = endDateObj.getTime() - startDateObj.getTime();
            selectedDays = Math.floor(diffTime / (1000 * 3600 * 24)) + 1;
        } else if (selectedDays > 0) {
            // Nếu chưa có ngày kết thúc được chọn thủ công, tính tự động dựa trên số ngày thuê từ nút "đặt ngày"
            endDateObj = new Date(startDateObj);
            endDateObj.setDate(startDateObj.getDate() + selectedDays - 1);
            // Cập nhật lại input ngày kết thúc tự động
            endDateInput.value = endDateObj.toISOString().split("T")[0];
        }

        // Cập nhật hiển thị ngày (giữ nguyên giá trị đã chọn)
        orderDateElement.innerText = formatDate(startDateObj);
        endDateElement.innerText = endDateObj ? formatDate(endDateObj) : "-";

        // Tính và cập nhật tổng tiền dựa trên số ngày thuê và giá/ngày
        const totalPrice = selectedDays * pricePerDay;
        totalAmountElement.innerText = totalPrice.toLocaleString();

        // Cập nhật số người thuê hiển thị
        const numPeopleValue = numPeopleInput.value;
        numPeopleOrderElement.innerText = numPeopleValue ? numPeopleValue : "-";
    }

    // Khi người dùng click vào nút "đặt ngày"
    document.querySelectorAll(".duration-btn").forEach(button => {
        button.addEventListener("click", function () {
            // Cập nhật selectedDays dựa trên nút được chọn (ví dụ: 1,2,3,5)
            selectedDays = parseInt(this.dataset.days);
            // Nếu đã có ngày bắt đầu, cập nhật đơn hàng; nếu chưa, updateOrder sẽ hiển thị "-" cho ngày kết thúc
            if (startDateInput.value) {
                updateOrder();
            }
        });
    });

    // Khi người dùng thay đổi ngày bắt đầu
    startDateInput.addEventListener("change", function () {
        if (startDateInput.value) {
            // Nếu ngày kết thúc đã được chọn, giữ nguyên ngày đó và tính lại số ngày thuê
            if (endDateInput.value) {
                let startDateObj = new Date(startDateInput.value);
                let endDateObj = new Date(endDateInput.value);
                let diffTime = endDateObj.getTime() - startDateObj.getTime();
                selectedDays = Math.floor(diffTime / (1000 * 3600 * 24)) + 1;
            }
            updateOrder();
        }
    });

    // Khi người dùng thay đổi ngày kết thúc thủ công
    endDateInput.addEventListener("change", function () {
        if (startDateInput.value && endDateInput.value) {
            let startDateObj = new Date(startDateInput.value);
            let endDateObj = new Date(endDateInput.value);
            let diffTime = endDateObj.getTime() - startDateObj.getTime();
            selectedDays = Math.floor(diffTime / (1000 * 3600 * 24)) + 1;
            updateOrder();
        } else {
            endDateElement.innerText = "-";
        }
    });

    // Khi số người thuê thay đổi
    numPeopleInput.addEventListener("input", function () {
        updateOrder();
    });

    // Khi nhấn "Thuê ngay"
    rentButton.addEventListener("click", function (event) {
        event.preventDefault();

        if (!startDateInput.value) {
            alert("Vui lòng chọn ngày bắt đầu!");
            return;
        }
        if (selectedDays <= 0) {
            alert("Vui lòng chọn số ngày thuê!");
            return;
        }
        if (!numPeopleInput.value || numPeopleInput.value <= 0) {
            alert("Vui lòng nhập số người thuê!");
            return;
        }

        const modal = new bootstrap.Modal(modalElement);
        modal.show();
    });

    // Khi nhấn "Đồng ý" trong modal, submit form về servlet
    confirmRentButton.addEventListener("click", function () {
        form.submit();
    });
});
