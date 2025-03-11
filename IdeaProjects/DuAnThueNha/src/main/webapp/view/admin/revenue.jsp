<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rental Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        .container {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
            padding: 20px;
            max-width: 1400px;
            margin: auto;
        }
        .chart-container, .pie-chart, .top-houses {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .chart-container {
            height: 350px;
        }
        .pie-chart {
            height: 250px;
            margin-top: 20px;
        }
        .top-houses .house {
            display: flex;
            align-items: center;
            gap: 10px;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 10px;
        }
        .top-houses img {
            width: 100px;
            height: 80px;
            border-radius: 5px;
            object-fit: cover;
        }
        .legend {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }
        .legend div {
            display: flex;
            align-items: center;
        }
        .legend span {
            width: 15px;
            height: 15px;
            display: inline-block;
            margin-right: 5px;
        }
        .green { background: green; }
        .yellow { background: yellow; }
        .red { background: red; }
        .pie-chart {
            display: flex;
            flex-direction: column;
            align-items: center; /* Căn giữa theo chiều ngang */
            text-align: center;
        }

        .pie-chart-container {
            margin-left: 40px; /* Dịch riêng biểu đồ tròn sang phải */
            width: 200px !important; /* Điều chỉnh kích thước */
            height: 200px !important;
        }

        .legend div {
            display: flex;
            align-items: center;
            margin: 0 10px; /* Khoảng cách giữa các mục */
        }


    </style>
</head>
<body>
<div class="container">
    <div>
        <div class="chart-container">
            <canvas id="barChart"></canvas>
        </div>
        <div class="pie-chart">
            <h3>Số lượng nhà và đơn thuê</h3>
            <div class="pie-chart-container">
                <canvas id="pieChart"></canvas>
            </div>
<%--            <div class="legend">--%>
<%--                <div><span class="green"></span> Đơn thuê đã tạo</div>--%>
<%--                <div><span class="yellow"></span> Nhà đăng mới</div>--%>
<%--                <div><span class="red"></span> Đơn thuê đã hoàn thành</div>--%>
<%--            </div>--%>
        </div>

    </div>
    <div class="top-houses">
        <h3>Top nhà được thuê nhiều nhất</h3>
        <div class="house">
            <img src="house1.jpg" alt="Nhà Nha Trang">
            <div>
                <p><strong>Căn hộ tại Nha Trang</strong></p>
                <p style="color: green;">3.350.000Đ / Day</p>
                <p>🛏 bedroom: 05  🛁 bathroom: 04  📏 1000m2</p>
            </div>
        </div>
        <div class="house">
            <img src="house2.jpg" alt="Nhà TP HCM">
            <div>
                <p><strong>Căn hộ tại TP Hồ Chí Minh</strong></p>
                <p style="color: green;">5.450.000Đ / Day</p>
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
            labels: ['2/2', '3/2', '4/2', '5/2', '6/2', '7/2', '8/2', '9/2', '10/2', '11/2'],
            datasets: [{
                label: 'Lượt thuê',
                data: [10, 16, 8, 15, 2, 4, 10, 15, 12, 11],
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
                    align: 'start', // Để căn chỉnh labels sang trái
                    labels: {
                        boxWidth: 15,
                        padding: 10,
                        usePointStyle: true,
                        align: 'start',
                    }
                }
            }
        }
    });

</script>
</body>
</html>
