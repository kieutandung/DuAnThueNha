<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đăng ký bất động sản</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.css" rel="stylesheet">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
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

                                <div class=" mb-4">
                                    <label for="imageUpload" class="form-label">Tải lên ảnh</label>
                                    <input class="form-control form-control-lg" type="file" id="imageUpload">
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-4">
                                        <div class="form-outline">
                                            <input type="text" id="propertyName" class="form-control form-control-lg"/>
                                            <label class="form-label" for="propertyName">Tên bất động sản</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-4">
                                        <div class="form-outline">
                                            <input type="text" id="price" class="form-control form-control-lg"/>
                                            <label class="form-label" for="price">Mức giá</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-4">
                                        <label class="form-label" for="rentalTime">Thời gian cho thuê</label>
                                        <div class="input-group">
                                            <input type="text" id="rentalTime" class="form-control form-control-lg"
                                                   placeholder="Chọn ngày" readonly/>
                                            <span class="input-group-text calendar-icon" data-target="#rentalTime">
                                           <i class="fas fa-calendar-alt"></i>
                                            </span>
                                        </div>
                                    </div>

                                    <div class="col-md-6 mb-4">
                                        <label class="form-label" for="endTime">Kết thúc</label>
                                        <div class="input-group">
                                            <input type="text" id="endTime" class="form-control form-control-lg"
                                                   placeholder="Chọn ngày" readonly/>
                                            <span class="input-group-text calendar-icon" data-target="#endTime">
                <i class="fas fa-calendar-alt"></i>
            </span>
                                        </div>
                                    </div>
                                </div>


                                <div class="form-outline mb-4">
                                    <textarea id="description" class="form-control form-control-lg" rows="4"></textarea>
                                    <label class="form-label" for="description">Mô tả</label>
                                </div>


                                <div class="d-flex justify-content-end pt-3">
                                    <button type="button" class="btn btn-light btn-lg">Đăng tin</button>
                                    <button type="button" class="btn btn-warning btn-lg ms-2">Hủy Đăng tin</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    $(document).ready(function () {
        $(".calendar-icon").click(function () {
            var inputId = $(this).attr("data-target");
            $(inputId).datepicker({
                format: "dd/mm/yyyy",
                autoclose: true,
                todayHighlight: true
            }).datepicker("show");
        });
    });
</script>


</body>
</html>
