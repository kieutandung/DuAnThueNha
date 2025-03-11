document.addEventListener("DOMContentLoaded", function() {
    const complaintBtn = document.getElementById("complaintBtn");
    const complaintPopup = document.getElementById("complaint-popup");
    const closePopup = document.getElementById("close-popup");
    const submitComplaint = document.getElementById("submit-complaint");
    const otherReason = document.getElementById("otherReason");
    const otherReasonText = document.getElementById("otherReasonText");

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

    if (complaintBtn && complaintPopup && closePopup) {
        complaintBtn.addEventListener("click", function() {
            complaintPopup.style.display = "block";
        });

        // Khi nhấn Đóng → Ẩn hộp khiếu nại
        closePopup.addEventListener("click", function() {
            complaintPopup.style.display = "none";
        });

        // Hiện ô nhập nếu chọn "Lý do khác"
        if (otherReason && otherReasonText) {
            otherReason.addEventListener("change", function() {
                if (otherReason.checked) {
                    otherReasonText.classList.remove("hidden");
                    otherReasonText.style.display = "block";
                } else {
                    otherReasonText.classList.add("hidden");
                    otherReasonText.style.display = "none";
                }
            });
        }
        if (complaintBtn) {
            complaintBtn.addEventListener("click", function() {
                complaintPopup.style.display = "block";
            });
        }

        // Đóng hộp thoại khiếu nại
        closePopup.addEventListener("click", function() {
            complaintPopup.style.display = "none";
        });

        // Xử lý gửi khiếu nại
        submitComplaint.addEventListener("click", function(event) {
            event.preventDefault(); // Ngăn form submit mặc định

            // Kiểm tra xem đã chọn lý do khiếu nại chưa
            let selectedReason = document.querySelector('input[name="reason"]:checked');
            if (!selectedReason) {
                showNotification("Vui lòng chọn một lý do khiếu nại!","error");
                return;
            }

            // Kiểm tra xem textarea nhập chi tiết lý do có được nhập không
            if (reasonDetails.value.trim() === "") {
                showNotification("Vui lòng nhập chi tiết lý do khiếu nại!","error");
                return;
            }

            // Nếu đủ điều kiện, hiển thị thông báo thành công và submit form
            showNotification("Khiếu nại đã được gửi thành công!","success");
            complaintPopup.style.display = "none";

            // Submit form (form sẽ được submit tới ReportServlet với action=report)
            document.querySelector('#complaint-popup form').submit();
        });

    }
});