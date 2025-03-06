function openModal(userId) {
    console.log("Opening modal for userId:", userId); // Debug

    $.ajax({
        url: "adminServlet?action=browseProfile&userId=" + userId,
        method: "GET",
        success: function (response) {
            $("#documentList").html(response); // Load dữ liệu từ AJAX vào modal
            $("#userProfilesModal").modal("show"); // Hiển thị modal
        },
        error: function () {
            alert("Không thể tải dữ liệu!");
        }
    });
}


function promoteUser(userId) {
    if (confirm("Bạn có chắc muốn thăng chức người dùng này không?")) {
        $.ajax({
            url: "adminServlet",
            method: "POST",
            data: {action: "promoteUser", idUser: userId},
            success: function (response) {
                alert("Người dùng đã được thăng chức!");
                location.reload(); // Load lại trang để cập nhật thông tin
            },
            error: function () {
                alert("Lỗi khi thăng chức!");
            }
        });
    }
}

function showRejectReason(idDocument) {
    let reason = prompt("Nhập lý do từ chối (mặc định là 'Không hợp lệ'):", "Không hợp lệ");
    if (reason !== null) {
        updateStatus(idDocument, 'rejected', reason);
    }
}

function updateStatus(idDocument, status, reason = null) {
    // Gửi yêu cầu AJAX để cập nhật trạng thái
    let xhr = new XMLHttpRequest();
    xhr.open("POST", "adminServlet", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            // Cập nhật thành công, có thể làm mới trang hoặc cập nhật giao diện
            alert("Cập nhật trạng thái thành công!");
            location.reload(); // Làm mới trang để cập nhật dữ liệu
        }
    };

    // Gửi dữ liệu đến servlet
    let params = "action=updateStatus&idDocument=" + idDocument + "&status=" + status;
    if (reason) {
        params += "&rejectionReason=" + encodeURIComponent(reason);
    }
    xhr.send(params);
}








