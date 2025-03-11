<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Biểu Đồ Doanh Thu</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* Giới hạn kích thước của canvas */
        #chart-container {
            width: 300px; /* Giảm kích thước */
            height: 200px;
            margin: auto;
        }
    </style>
</head>
<body>

<h2 style="text-align: center;">Biểu Đồ Doanh Thu</h2>
<div id="chart-container">
    <canvas id="revenueChart"></canvas>
</div>

<script>
    var revenueData = [5000, 7000, 8000, 6000, 9000];
    var ctx = document.getElementById('revenueChart').getContext('2d');

    var revenueChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5'],
            datasets: [{
                label: 'Doanh thu (VNĐ)',
                data: revenueData,
                backgroundColor: 'rgba(54, 162, 235, 0.6)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false, // Cho phép chỉnh kích thước theo CSS
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>

</body>
</html>
