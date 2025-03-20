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
    <link rel="stylesheet" href="/css/adminRevenue.css">

</head>
<body>
<header>
    <jsp:include page="menu.jsp"/>
</header>
<div class="container">
    <div>
        <div class="chart-container">
            <canvas id="barChart"></canvas>
        </div>
        <div class="pie-chart">
            <div class="legend">
                <h3>Số lượng đơn thuê</h3>
                <div><span class="gray"></span> Đơn chờ xử lý</div>
                <div><span class="red"></span> Đơn bị hủy</div>
                <div><span class="green"></span> Đơn hoàn thành</div>
                <div><span class="yellow"></span> Đơn chờ xác nhận</div>
            </div>
            <div class="pie-chart-container">
                <canvas id="pieChart"></canvas>
            </div>
        </div>
    </div>
    <div class="top-houses">
        <h5 class="mb-2">Top ${topHousesCount} nhà được thuê nhiều nhất: </h5>
        ${topProductsHtml}
    </div>
</div>

<script>
    const pieCtx = document.getElementById('pieChart').getContext('2d');

    const orderStatusData = {
        datasets: [{
            data: [
                <%= request.getAttribute("pendingCount") %>,
                <%= request.getAttribute("cancelledCount") %>,
                <%= request.getAttribute("completedCount") %>,
                <%= request.getAttribute("waitingCount") %>,
            ],
            backgroundColor: [
                '#FFCE56',
                '#FF6384',
                '#4BC0C0',
                '#36A2EB',
            ]
        }]
    };


    new Chart(pieCtx, {
        type: 'pie',
        data: orderStatusData,
        options: {
            plugins: {
                legend: {
                    position: 'right'
                }
            }
        }
    });
</script>


<script>
    const revenueData = {
        labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'],
        datasets: [{
            label: 'Doanh thu (đ)',
            data: [
                <%
                    Map<Integer, Double> revenueByMonth = (Map<Integer, Double>) request.getAttribute("revenueByMonth");
                    for (int i = 1; i <= 12; i++) {
                        double revenue = revenueByMonth.getOrDefault(i, 0.0);
                %> <%= revenue %>, <% } %>
            ],
            backgroundColor: 'rgba(54, 162, 235, 0.6)',
            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 1 ,
        }]
    };

    const revenueCtx = document.getElementById('barChart').getContext('2d');
    new Chart(revenueCtx, {
        type: 'bar',
        data: revenueData,
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>
</body>
<footer>
    <jsp:include page="../footer2.jsp"/>
</footer>
</html>
