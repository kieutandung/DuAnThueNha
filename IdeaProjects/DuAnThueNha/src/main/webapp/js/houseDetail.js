document.addEventListener("DOMContentLoaded", function() {
    const complaintBtn = document.getElementById("complaintBtn");
    const complaintPopup = document.getElementById("complaint-popup");
    const closePopup = document.getElementById("close-popup");
    const submitComplaint = document.getElementById("submit-complaint");
    const otherReason = document.getElementById("otherReason");
    const otherReasonText = document.getElementById("otherReasonText");

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
                alert("Vui lòng chọn một lý do khiếu nại!");
                return;
            }

            // Kiểm tra xem textarea nhập chi tiết lý do có được nhập không
            if (reasonDetails.value.trim() === "") {
                alert("Vui lòng nhập chi tiết lý do khiếu nại!");
                return;
            }

            // Nếu đủ điều kiện, hiển thị thông báo thành công và submit form
            alert("Khiếu nại đã được gửi thành công!");
            complaintPopup.style.display = "none";

            // Submit form (form sẽ được submit tới ReportServlet với action=report)
            document.querySelector('#complaint-popup form').submit();
        });

    }
});
