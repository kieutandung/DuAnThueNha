<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đăng ký bất động sản</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="../css/addNewHouse.css">
    <style>
        body {
            background-color: #212529;
        }
    </style>
</head>
<body>
<section class="h-100 bg-dark">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col">
                <div class="card card-registration my-4">
                    <div class="row g-0">
                        <div class="col-xl-6 d-none d-xl-block">
                            <img src="https://vnn-imgs-f.vgcloud.vn/2021/10/31/15/3-biet-thu-pho-hien-dai.jpg"
                                 alt="Sample photo" class="img-fluid"
                                 style="border-top-left-radius: .25rem; border-bottom-left-radius: .25rem;"/>
                        </div>
                        <div class="col-xl-6">
                            <div class="card-body p-md-5 text-black">
                                <h3 class="mb-5 text-uppercase">Đăng ký thêm mới nhà</h3>
                                <form action="/productServlet" method="post">
                                    <input type="hidden" name="action" value="addProduct">

                                    <div class="mb-4">
                                        <label for="imageUpload" class="form-label">Tải lên ảnh</label>
                                        <input class="form-control form-control-lg" type="file" id="imageUpload">
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-4">
                                            <div class="form-floating">
                                                <input type="text" id="idUser" name="idUser" class="form-control" placeholder="ID Người dùng">
                                                <label for="idUser">ID Người dùng</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-4">
                                            <div class="form-floating">
                                                <input type="text" id="nameProduct" name="nameProduct" class="form-control" placeholder="Tên bất động sản">
                                                <label for="nameProduct">Tên bất động sản</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <div class="form-floating">
                                            <input type="text" id="price" name="price" class="form-control" placeholder="Mức giá">
                                            <label for="price">Mức giá</label>
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <div class="form-floating">
                                            <input type="text" id="address" name="address" class="form-control" placeholder="Địa chỉ">
                                            <label for="address">Địa chỉ</label>
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <div class="form-floating">
                                            <textarea id="productDescription" name="productDescription" class="form-control" placeholder="Mô tả" style="height: 100px"></textarea>
                                            <label for="productDescription">Mô tả</label>
                                        </div>
                                    </div>

                                    <div class="d-flex justify-content-end pt-3">
                                        <button type="submit" class="btn btn-light btn-lg">Đăng tin</button>
                                        <button type="reset" class="btn btn-warning btn-lg ms-2">Hủy Đăng tin</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>
