<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Phê duyệt yêu cầu thuê</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
    <h2 class="text-center">Danh sách yêu cầu thuê</h2>
    <table class="table table-bordered table-hover">
        <thead>
        <tr class="active">
            <th>Ảnh nhà thuê</th>
            <th>Tên nhà thuê</th>
            <th>Tên người thuê</th>
            <th>Điện thoại</th>
            <th>Ngày bắt đầu</th>
            <th>Ngày kết thúc</th>
            <th>Số người thuê</th>
            <th>Trạng thái</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${rentalRequests}">
            <tr>
                <td>${order.image}</td>
                <td>${order.nameProduct}</td>
                <td>${order.fullName}</td>
                <td>${order.phone}</td>
                <td>${order.startDate}</td>
                <td>${order.endDate}</td>
                <td>${order.numPeople}</td>
                <td>${order.paymentStatus}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>




<jsp:include page="../footer2.jsp"/>

</body>
</html>
