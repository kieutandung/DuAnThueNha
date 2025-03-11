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
<div class="container">
    <div>
        <div class="chart-container">
            <canvas id="barChart"></canvas>
        </div>
        <div class="pie-chart">
            <div class="legend">
                <div><span class="green"></span> Đơn thuê đã tạo</div>
                <div><span class="yellow"></span> Nhà đăng mới</div>
                <div><span class="red"></span> Đơn thuê đã hoàn thành</div>
            </div>
            <div class="pie-chart-container">
                <canvas id="pieChart"></canvas>
            </div>
        </div>
    </div>
    <div class="top-houses">
        <h3>Top nhà được thuê nhiều nhất</h3>
        <div class="house-card">
            <img src="house1.jpg" alt="Nhà Nha Trang">
            <div class="house-details">
                <p class="price">3.350.000Đ / Day</p>
                <p><strong><em>Căn hộ tại Nha Trang</em></strong></p>
                <p>🛏 bedroom: 05  🛁 bathroom: 04  📏 1000m2</p>
            </div>
        </div>
        <div class="house-card">
            <img src="house2.jpg" alt="Nhà TP HCM">
            <div class="house-details">
                <p class="price">5.450.000Đ / Day</p>
                <p><strong><em>Căn hộ tại TP Hồ Chí Minh</em></strong></p>
                <p>🛏 bedroom: 05  🛁 bathroom: 04  📏 1000m2</p>
            </div>
        </div>
    </div>
</div>
<script>
    const barCtx = document.getElementById('barChart').getContext('2d');
    new Chart(barCtx, {
        type: 'bar',
        data: {
            labels: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10','11','12'],
            datasets: [{
                label: 'Lượt thuê theo tháng',
                data: [10, 16, 8, 15, 2, 4, 10, 15, 12, 11, 15, 10],
                backgroundColor: 'rgba(137, 196, 244, 0.8)',
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

    const pieCtx = document.getElementById('pieChart').getContext('2d');
    new Chart(pieCtx, {
        type: 'pie',
        data: {
            labels: ['Đơn thuê đã tạo', 'Nhà đăng mới', 'Đơn thuê đã hoàn thành'],
            datasets: [{
                data: [20, 30, 45],
                backgroundColor: ['green', 'yellow', 'red']
            }]
        },
        options: {
            plugins: {
                legend: {
                    display: false
                }
            }
        }
    });
</script>
</body>
</html>
