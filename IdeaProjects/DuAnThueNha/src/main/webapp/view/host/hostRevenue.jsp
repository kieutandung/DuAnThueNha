<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="/css/hostRevenue.css">
    <style>
        .table-container {
            max-height: 190px;
            overflow-y: auto;
            border: 1px solid #ddd;
        }
        .table-container th:nth-child(1),
        .table-container td:nth-child(1) {
            width: 10%;
            text-align: center;
        }


        .table-container table {
            width: 100%;
            border-collapse: collapse;
        }


        .table-container thead {
            position: sticky;
            top: 0;
            background: white;
            z-index: 10;
        }


        .table-container tbody {
            display: table;
            width: 100%;
        }


        .table-container::-webkit-scrollbar {
            width: 6px;
        }

        .table-container::-webkit-scrollbar-thumb {
            background-color: #888;
            border-radius: 4px;
        }

        .table-container::-webkit-scrollbar-track {
            background: #f1f1f1;
        }
        .top-houses {
            max-height: 500px; /* Giới hạn chiều cao */
            overflow-y: auto; /* Cho phép cuộn dọc nếu nội dung quá dài */
            scrollbar-width: none; /* Ẩn thanh cuộn trên Firefox */
            -ms-overflow-style: none; /* Ẩn thanh cuộn trên IE/Edge */
        }

        .top-houses::-webkit-scrollbar {
            display: none; /* Ẩn thanh cuộn trên Chrome, Safari */
        }

    </style>
</head>
<body>
<header>
    <jsp:include page="headerHost.jsp"/>
</header>
<div class="header">
    <div class="breadcrumb">Thanh toán / doanh thu</div>
    <h2>Doanh thu</h2>
</div>
<div class="container">
    <div>
        <div class="chart-container">
            <canvas id="barChart"></canvas>
        </div>
    </div>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

    <div class="top-houses">
        <h3>Top ${fn:length(topHouses)} nhà được thuê nhiều nhất</h3>
        <c:forEach var="house" items="${topHouses}">
            <div class="house-card">
                <img src="img/${house.image}" alt="${house.nameProduct}">
                <div class="house-details">
                    <p class="price">${house.price} VNĐ / Ngày</p>
                    <p><strong><em>${house.nameProduct}</em></strong></p>
                    <p>Diện tích: ${house.area}m²</p>
                </div>
            </div>
        </c:forEach>
    </div>


    <div class="customer-info">
        <h3>Bảng thông tin khách hàng</h3>
        <div class="table-container"> <!-- Đảm bảo bọc bảng trong div này -->
            <table class="table">
                <thead>
                <tr>
                    <th>STT</th>
                    <th>Tên khách hàng</th>
                    <th>Ngày</th>
                    <th>Trạng thái</th>
                    <th>Số tiền</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${orders}" var="order" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td>${order.fullName}</td>
                        <td>${order.formattedOrderDate}</td>
                        <td><span class="badge bg-success">Hoàn thành</span></td>
                        <td>${order.price} VNĐ</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</div>
<script>
    const revenueDataHost = [];
    <%
    Map<Integer, Double> revenueByMonthByIdUser = (Map<Integer, Double>) request.getAttribute("revenueByMonthByIdUser");
    for (int i = 1; i <= 12; i++) {
        double revenue = (revenueByMonthByIdUser != null && revenueByMonthByIdUser.containsKey(i)) ? revenueByMonthByIdUser.get(i) : 0.0;
%>
    revenueDataHost[<%= i - 1 %>] = <%= revenue %>;
    <% } %>

    console.log("Doanh thu theo tháng:", revenueDataHost);

    const labels = ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'];

    const barCtx = document.getElementById('barChart').getContext('2d');
    new Chart(barCtx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Doanh thu theo tháng (VND)',
                data: revenueDataHost,
                backgroundColor: 'rgba(46, 204, 113, 0.8)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>
<footer>
    <jsp:include page="../footer2.jsp"/>
</footer>
</body> 
</html>
