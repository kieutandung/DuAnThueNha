function openModal(userId) {
    $.ajax({
        url: "adminServlet?action=browseProfile&userId=" + userId,
        method: "GET",
        success: function(response) {
            $("#verificationBody").html(response); // Cập nhật nội dung hồ sơ
            $("#userProfilesModal").modal("show"); // Hiển thị modal
        },
        error: function() {
            alert("Lỗi khi tải dữ liệu!");
        }
    });
}
function promoteUser(userId) {
    if (confirm("Bạn có chắc muốn thăng chức người dùng này không?")) {
        $.ajax({
            url: "adminServlet",
            method: "POST",
            data: { action: "promoteUser", idUser: userId },
            success: function(response) {
                alert("Người dùng đã được thăng chức!");
                location.reload(); // Load lại trang để cập nhật thông tin
            },
            error: function() {
                alert("Lỗi khi thăng chức!");
            }
        });
    }
}
    function confirmPromotion(idUser) {
    if (confirm("Bạn có chắc chắn muốn phê duyệt người dùng này?")) {
    window.location.href = "adminServlet?action=promoteUser&idUser=" + idUser;
}
}

$(document).ready(function() {
    $("#statusSelect").change(function() {
        if ($(this).val() === "rejected") {
            $("#reasonInput").show();
        } else {
            $("#reasonInput").hide();
        }
    });
});

