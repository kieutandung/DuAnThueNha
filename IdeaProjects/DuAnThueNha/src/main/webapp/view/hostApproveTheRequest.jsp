<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chủ nhà phê duyệt yêu cầu thuê </title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/hostApproveTheRequest.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<!-- HEADER -->
<header>
    <nav class="navbar">
        <div class="logo">WE Bare BEARS.vn</div>
        <ul class="nav-links">
            <li><a href="#">Trang chủ</a></li>
            <li><a href="#">Giới thiệu</a></li>
            <li><a href="#">Sản phẩm</a></li>
        </ul>
        <div class="nav-icons">
            <a href="#"><i class="fas fa-user"></i></a>
            <a href="#"><i class="fas fa-bell"></i></a>
            <button class="btn btn-primary">Liên hệ tư vấn</button>
        </div>
    </nav>
</header>
<div class="container">
    <div class="table-responsive">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-xs-6">
                        <h2>Order <b>list</b></h2>
                    </div>
                </div>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <th>Mã</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Address</th>
                    <th>Phone</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>#876369</td>
                    <td>Thomas Hardy</td>
                    <td>thomashardy@mail.com</td>
                    <td>89 Chiaroscuro Rd, Portland, USA</td>
                    <td>(171) 555-2222</td>
                    <td>
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-success">Xác nhận</button>
                            <button type="button" class="btn btn-danger">Từ chối</button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>#876368</td>
                    <td>Dominique Perrier</td>
                    <td>dominiqueperrier@mail.com</td>
                    <td>Obere Str. 57, Berlin, Germany</td>
                    <td>(313) 555-5735</td>
                    <td>
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-success">Xác nhận</button>
                            <button type="button" class="btn btn-danger">Từ chối</button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>#876365</td>
                    <td>Maria Anders</td>
                    <td>mariaanders@mail.com</td>
                    <td>25, rue Lauriston, Paris, France</td>
                    <td>(503) 555-9931</td>
                    <td>
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-success">Xác nhận</button>
                            <button type="button" class="btn btn-danger">Từ chối</button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>#876367</td>
                    <td>Fran Wilson</td>
                    <td>franwilson@mail.com</td>
                    <td>C/ Araquil, 67, Madrid, Spain</td>
                    <td>(204) 619-5731</td>
                    <td>
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-success">Xác nhận</button>
                            <button type="button" class="btn btn-danger">Từ chối</button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>#876366</td>
                    <td>Martin Blank</td>
                    <td>martinblank@mail.com</td>
                    <td>Via Monte Bianco 34, Turin, Italy</td>
                    <td>(480) 631-2097</td>
                    <td>
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-success">Xác nhận</button>
                            <button type="button" class="btn btn-danger">Từ chối</button>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<footer class="mt-5">
    <jsp:include page="footer2.jsp"/>
</footer>
</body>
</html>
