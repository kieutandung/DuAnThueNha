<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Xem báo cáo</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/report.css">
</head>
<header>
    <jsp:include page="menu.jsp"/>
</header>
<body>

<div class="gradient-custom-1 h-100">
    <div class="container-fluid" style="max-width: 90%; margin: 80px auto 0;">
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="table-wrapper bg-white">
                    <table class="table mb-0">
                        <colgroup>
                            <col style="width:5%;">
                            <col style="width:15%;">
                            <col style="width:35%;">
                            <col style="width:15%;">
                            <col style="width:20%;">
                            <col style="width:10%;">
                        </colgroup>
                        <thead class="table-header">
                        <tr>
                            <th scope="col">STT</th>
                            <th scope="col">Khiếu nại</th>
                            <th scope="col">Chi tiết</th>
                            <th scope="col">Người phản ánh</th>
                            <th scope="col">Nghi vấn</th>
                            <th scope="col">Hành động</th>
                        </tr>
                        </thead>
                        <tbody class="table-body">
                        <c:forEach var="r" items="${reportList}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${r.reason}</td>
                                <td>${r.description}</td>
                                <td>${usersReport[status.index].fullName}</td>
                                <td>
                                    <p><b>Chủ sở hữu: </b>${hostList[status.index].fullName}</p>
                                    <p>
                                        <img src="img/${productsList[status.index].image}" alt="no"
                                             style="max-width: 40px; height: auto;">
                                            ${productsList[status.index].nameProduct}
                                    </p>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-primary">Phản hồi</button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
