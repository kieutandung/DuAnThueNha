<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Sửa sản phẩm</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="../css/addNewHouse.css">
    <style>
        body {
            background-color: #212529;
        }

        .image-box {
            position: relative;
            border: 1px solid #ccc;
            padding: 5px;
        }

        .image-box img {
            width: 100%;
            height: auto;
            display: block;
        }


        .delete-btn {
            background: none;
            position: absolute;
            top: 5px;
            right: 5px;
            color: #4c4a4a;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            font-size: 14px;
            line-height: 18px;
            text-align: center;
            padding: 2px 5px;
        }
    </style>

</head>
<body>
<section class="h-100 bg-dark">
    <div id="maxImagesAlert" class="alert alert-danger" role="alert"
         style="position: fixed; top: 20px; right: 20px; z-index: 9999; font-size: 1rem; display: none">
        <i class="fa-solid fa-triangle-exclamation"></i>
        Vui lòng chọn tối đa 8 ảnh !
    </div>

    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col">
                <div class="card card-registration my-4">
                    <div class="row g-0">
                        <div class="col-xl-6 d-none d-xl-block border-end">
                            <div class="text-center style" id="previewContainerText">
                                <label class="mt-4 form-label">Ảnh chính</label>
                            </div>
                            <div class="py-4 text-center" id="previewContainer">
                                <img id="previewImage" src="img/${product.image}" alt="Ảnh xem trước"
                                     style="max-width: 200px; padding: 5px;">
                            </div>
                            <div class="px-4" id="additionalPreviewContainerText">
                                <label class="mt-4 form-label">Ảnh phụ</label>
                            </div>

                            <div id="additionalPreviewContainerEdit" class="px-4" style="margin-bottom: 20px;">
                                <div id="additionalPreviewGridEdit"
                                     style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px;">
                                    <c:forEach var="img" items="${imagesProduct}">
                                        <div class="image-box" id="imageBox_${img.idImage}">
                                            <img src="img/${img.img}" alt="Ảnh phụ"
                                                 style="width:100%; height:auto; padding: 5px;">

                                            <button type="button" class="delete-btn"
                                                    onclick="deleteImageFromDB('${img.idImage}')">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="px-4" id="additionalPreviewContainerTextDown" style="display: none">
                                <label class="mt-4 form-label">Ảnh bổ sung</label>
                            </div>
                            <div class="px-4" id="additionalPreviewContainer"
                                 style="display: none; margin-bottom: 20px;">
                                <div id="additionalPreviewGrid"
                                     style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px;"></div>
                            </div>
                        </div>
                        <div class="col-xl-6">
                            <form action="editProductHostServlet?action=updateProductHost&idProduct=${product.idProduct}"
                                  method="post" enctype="multipart/form-data">
                                <div class="card-body p-md-5 text-black">
                                    <h3 class="mb-5 text-uppercase">Sửa thông tin nhà</h3>
                                    <input type="hidden" name="action" value="addProduct">

                                    <div class="mb-4">
                                        <label class="form-label">Chỉnh sửa ảnh chính</label>
                                        <input type="file" id="image" name="imageProduct" class="form-control"
                                               accept="image/*">
                                        <input type="hidden" name="image" value="${product.image}">
                                    </div>

                                    <div class="mb-4">
                                        <label class="form-label">Chỉnh sửa ảnh phụ (tối đa 8 ảnh)</label>
                                        <input type="file" id="additionalImages" name="images" class="form-control"
                                               multiple
                                               accept="image/*">
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-4">
                                            <div class="form-floating">
                                                <input type="text" id="nameProduct" name="nameProduct"
                                                       class="form-control" placeholder="Tên bất động sản" required
                                                       value="${product.nameProduct}">
                                                <label for="nameProduct">Tên bất động sản</label>
                                            </div>
                                        </div>

                                        <div class="col-md-6 mb-4">
                                            <div class="form-floating">
                                                <select required id="statusProduct" name="statusProduct" class="form-select">
                                                    <option value="active" ${product.status eq 'active' ? 'selected' : ''}>Cho thuê</option>
                                                    <option value="for rent" ${product.status eq 'pending' ? 'selected' : ''}>Đã được thuê</option>
                                                    <option value="sold out" ${product.status eq 'blocked' ? 'selected' : ''}>Hết chỗ</option>
                                                </select>
                                                <label for="statusProduct">Trạng thái</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <div class="form-floating">
                                            <input type="number" id="price" name="price" class="form-control"
                                                   placeholder="Mức giá" required value="${product.price}">
                                            <label for="price">Mức giá (Vnd)</label>
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <div class="form-floating">
                                            <input required type="text" id="address" name="address" class="form-control"
                                                   placeholder="Địa chỉ" value="${product.address}">
                                            <label for="address">Địa chỉ</label>
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <div class="form-floating">
                                            <textarea required id="productDescription" name="productDescription"
                                                      class="form-control" placeholder="Mô tả"
                                                      style="height: 100px"> ${product.productDescription}</textarea>
                                            <label for="productDescription">Mô tả</label>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-end pt-3">
                                        <button type="submit" class="btn btn-light btn-lg">Sửa thông tin</button>
                                        <button type="reset" class="btn btn-warning btn-lg ms-2" onclick="window.location.href='listProductHostServlet'">Hủy</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    // Ảnh chính
    document.getElementById('image').addEventListener('change', function (event) {
        var file = this.files[0];
        if (file) {
            // Tạo URL tạm cho file
            var imageUrl = URL.createObjectURL(file);
            // Gán URL cho thẻ img preview
            var previewImage = document.getElementById('previewImage');
            previewImage.src = imageUrl;
        }
    });

    let selectedImages = [];

    // Lắng nghe sự kiện thay đổi của input "additionalImages"
    document.getElementById('additionalImages').addEventListener('change', function (event) {
        // Chuyển FileList thành mảng
        const files = Array.from(this.files);

        // Kiểm tra số lượng file được chọn (tối đa 8)
        if (files.length + ${imagesProduct.size()} > 8 ) {
            showMaxImagesAlert();
            this.value = ""; // Reset file input
            selectedImages = [];
            renderAdditionalPreviewGrid();
            return;
        }

        // Gán các file được chọn vào mảng selectedImages
        selectedImages = files;
        renderAdditionalPreviewGrid();
    });

    function renderAdditionalPreviewGrid() {
        const previewGrid = document.getElementById('additionalPreviewGrid');
        previewGrid.innerHTML = ""; // Xóa preview cũ

        // Hiển thị hoặc ẩn container preview dựa trên số ảnh được chọn
        if (selectedImages.length > 0) {
            document.getElementById('additionalPreviewContainerTextDown').style.display = 'block';
            document.getElementById('additionalPreviewContainer').style.display = 'block';
        } else {
            document.getElementById('additionalPreviewContainer').style.display = 'none';
        }

        selectedImages.forEach((file, index) => {
            const imageUrl = URL.createObjectURL(file);
            const box = document.createElement('div');
            box.classList.add('image-box');

            // Tạo thẻ <img> để hiển thị ảnh
            const imgElem = document.createElement('img');
            imgElem.src = imageUrl;
            imgElem.alt = "Ảnh phụ " + (index + 1);

            const deleteBtn = document.createElement('button');
            deleteBtn.classList.add('delete-btn');
            deleteBtn.innerHTML = '<i class="fas fa-times"></i>';
            deleteBtn.addEventListener('click', function (e) {
                e.stopPropagation();
                selectedImages.splice(index, 1);
                updateFileInput();
                renderAdditionalPreviewGrid();
            });

            box.appendChild(imgElem);
            box.appendChild(deleteBtn);
            previewGrid.appendChild(box);
        });
    }

    function updateFileInput() {
        const dataTransfer = new DataTransfer();
        selectedImages.forEach(file => {
            dataTransfer.items.add(file);
        });
        document.getElementById('additionalImages').files = dataTransfer.files;
    }

    function showMaxImagesAlert() {
        var alertDiv = document.getElementById('maxImagesAlert');
        alertDiv.style.display = 'block';
        setTimeout(function () {
            alertDiv.style.display = 'none';
        }, 3000); // 3 giây
    }

    function deleteImageFromDB(imageId) {
        fetch('editProductHostServlet?imageId=' + encodeURIComponent(imageId) + '&action=deleteImage', {
            method: 'POST'
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    var imageBox = document.getElementById('imageBox_' + imageId);
                    if (imageBox) {
                        imageBox.remove();
                    }
                } else {
                    alert("Xóa ảnh thất bại: " + data.message);
                }
            })
            .catch(error => {
                console.error("Lỗi AJAX:", error);
                alert("Đã xảy ra lỗi khi xóa ảnh.");
            });
    }
</script>
</body>
</html>
