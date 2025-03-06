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

        // Xử lý gửi khiếu nại
        submitComplaint.addEventListener("click", function() {
            let selectedReason = document.querySelector('input[name="reason"]:checked');
            if (!selectedReason) {
                alert("Vui lòng chọn một lý do khiếu nại!");
                return;
            }

            if (selectedReason.value === "other" && !otherReasonText.value.trim()) {
                alert("Vui lòng nhập lý do khiếu nại của bạn!");
                return;
            }

            alert("Khiếu nại đã được gửi thành công!");
            complaintPopup.style.display = "none";
        });
    }
});
document.addEventListener("DOMContentLoaded", function() {
    const otherReason = document.getElementById("otherReason");
    const otherReasonText = document.getElementById("otherReasonText");

    otherReason.addEventListener("click", function() {
        if (otherReasonText.style.display === "none" || otherReasonText.style.display === "") {
            otherReasonText.style.display = "block";
        } else {
            otherReasonText.style.display = "none";
            otherReasonText.value = ""; // Xóa nội dung khi ẩn
            otherReason.checked = false;
        }
    });
});
