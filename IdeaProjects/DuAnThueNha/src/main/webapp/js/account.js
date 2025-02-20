function changeStatus(id) {
    alert("Trạng thái của người dùng với ID " + id + " đã được thay đổi!");
}

function deleteUser(id) {
    if (confirm("Bạn có chắc chắn muốn xóa người dùng này?")) {
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "adminServlet?action=delete", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                alert("Người dùng với ID " + id + " đã bị xóa thành công!");
                location.reload();
            }
        };
        xhr.send("idUser=" + id);
    }
}

