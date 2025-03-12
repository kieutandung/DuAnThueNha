function changeImage(smallImg) {
    let mainImage = document.getElementById("mainImage");
    mainImage.src = smallImg.src;
}

function toggleFavorite() {
    let favoriteBtn = document.getElementById("favoriteBtn");
    let productId = favoriteBtn.getAttribute("data-product-id");
    let icon = document.getElementById("favoriteIcon");

    fetch('/detailProductUser?action=toggleFavorite', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'productId=' + encodeURIComponent(productId)
    })
        .then(response => response.text())
        .then(data => {
            data = data.trim();
            console.log(data);
            if (data === "added") {
                showNotification('Sản phẩm đã được thêm vào bộ sưu tập.', 'success');
                icon.classList.remove("bi-heart");
                icon.classList.add("bi-heart-fill", "text-danger");
            } else if (data === "removed") {
                showNotification('Sản phẩm đã được gỡ khỏi bộ sưu tập.', 'info');
                icon.classList.remove("bi-heart-fill", "text-danger");
                icon.classList.add("bi-heart");
            } else if (data === "error") {
                showNotification('Bộ sưu tập đã đầy . Vui lòng xóa bớt sản phẩm trước khi thêm!', 'error');
            }
        })
        .catch(() => showNotification('Lỗi kết nối khi cập nhật bộ sưu tập!', 'error'));
}

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