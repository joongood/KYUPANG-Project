<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/admin/include_admin/common.jsp" %>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@3.2.0/dist/css/adminlte.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .chart-container {
            display: flex;
            justify-content: space-around;
            align-items: center;
            height: 400px; /* 전체 높이를 동일하게 설정 */
        }
        .chart-wrapper {
            width: 45%; /* 너비를 동일하게 설정 */
        }
    </style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">
    <!-- Navbar -->
    <%@ include file="/WEB-INF/views/admin/include_admin/navbar.jsp" %>
    <!-- Main Sidebar Container -->
    <%@ include file="/WEB-INF/views/admin/include_admin/mainslide.jsp" %>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Admin Dashboard</h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">Dashboard</li>
                        </ol>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content-header -->

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <!-- Dashboard Stats -->
                <div class="row">
                    <!-- Recent Signup Rate Card -->
                    <div class="col-lg-4 col-6">
                        <div class="small-box bg-info">
                            <div class="inner">
                                <h3 id="recentSignupRate">${recentSignupRate}%</h3>
                                <p>최근 일주일 이내 가입자 비율</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-user-plus"></i>
                            </div>
                        </div>
                    </div>
                    <!-- Recent Unsubscribe Rate Card -->
                    <div class="col-lg-4 col-6">
                        <div class="small-box bg-danger">
                            <div class="inner">
                                <h3 id="recentUnsubscribeRate">${recentUnsubscribeRate}%</h3>
                                <p>최근 일주일 이내 회원 탈퇴 비율</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-user-minus"></i>
                            </div>
                        </div>
                    </div>
                    <!-- Total Orders Today Card -->
                    <div class="col-lg-4 col-6">
                        <div class="small-box bg-success">
                            <div class="inner">
                                <h3 id="totalOrdersToday">${totalOrdersToday}</h3>
                                <p>오늘 날짜 기준 전체 주문 수</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                    <div class="col-lg-6">
                        <!-- Donut Chart -->
                        <div class="card">
                            <div class="card-header border-transparent">
                                <h3 class="card-title">Payment Statistics</h3>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="paymentChart" width="400" height="300"></canvas>
                                </div>
                            </div>
                            <!-- /.card-body -->
                        </div>
                        <!-- /.card -->
                    </div>
                    <!-- /.col-md-6 -->
                    <div class="col-lg-6">
                        <!-- Line Chart -->
                        <div class="card">
                            <div class="card-header border-transparent">
                                <h3 class="card-title">Visitor Statistics (Last 7 Days)</h3>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="visitorChart" width="700" height="400"></canvas>
                                </div>
                            </div>
                            <!-- /.card-body -->
                        </div>
                        <!-- /.card -->
                    </div>
                    <!-- /.col-md-6 -->
                </div>
                <!-- /.row -->

                <!-- 추가된 부분 -->
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-header border-transparent">
                            <h3 class="card-title">Franchise Rankings</h3>
                        </div>
                        <div class="card-body">
                            <div id="franchiseRankings"></div>
                        </div>
                    </div>
                </div>
                <!-- /.col-lg-12 -->
            </div><!-- /.container-fluid -->
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <!-- Main Footer -->
    <%@ include file="/WEB-INF/views/admin/include_admin/footer.jsp" %>
</div>
<!-- ./wrapper -->

<!-- REQUIRED SCRIPTS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2.0/dist/js/adminlte.min.js"></script>

<!-- Chart Script -->
<script>
    $(document).ready(function() {
        // 데이터 가져오기 (도넛 차트)
        var countToss = ${countToss};
        var countKakao = ${countKakao};
        var countDeposit = ${countDeposit};

        // 고정된 라벨 설정 (서버에서 받아온 데이터를 기반으로)
        var labels = ['오늘', '1일 전', '2일 전', '3일 전', '4일 전', '5일 전', '6일 전'];

        // 차트 그리기 (도넛 차트)
        var ctxDonut = document.getElementById('paymentChart').getContext('2d');
        var donutChart = new Chart(ctxDonut, {
            type: 'doughnut',
            data: {
                labels: ['토스페이', '카카오페이', '무통장거래'],
                datasets: [{
                    label: '결제 통계',
                    data: [countToss, countKakao, countDeposit],
                    backgroundColor: [
                        'rgba(75, 192, 192, 0.6)',
                        'rgba(255, 99, 132, 0.6)',
                        'rgba(54, 162, 235, 0.6)'
                    ]
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    datalabels: {
                        formatter: function(value, ctx) {
                            var sum = 0;
                            var dataArr = ctx.chart.data.datasets[0].data;
                            dataArr.forEach(function(data) {
                                sum += data;
                            });
                            var percentage = (value * 100 / sum).toFixed(2) + "%";
                            return percentage;
                        },
                        color: '#fff',
                        font: {
                            size: 12
                        }
                    },
                    legend: {
                        position: 'top',
                    },
                    title: {
                        display: true,
                        text: '결제 수단별 통계',
                        fontSize: 18  // 제목 크기 조정
                    }
                }
            }
        });

        // 서버에서 방문자 데이터 가져오기
        $.ajax({
            url: '/admin/visitor', // 데이터를 제공하는 서버의 엔드포인트
            method: 'GET',
            success: function(data) {
                var visitors = data.map(function(entry) {
                    return entry.visitorCount;
                });

                // 방문자 수를 50 단위로 끊어서 보여주기
                var maxVisitors = Math.max(...visitors, 400); // 최대 방문자 수 설정 (최소값 200으로 제한)
                var stepSize = 50;

                // 차트 그리기 (꺾은선 그래프)
                var ctxLine = document.getElementById('visitorChart').getContext('2d');
                var lineChart = new Chart(ctxLine, {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '방문자 수',
                            data: visitors,
                            fill: false,
                            borderColor: 'rgba(75, 192, 192, 0.6)',
                            backgroundColor: 'rgba(75, 192, 192, 0.6)',
                            tension: 0.1
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                position: 'top',
                            },
                            title: {
                                display: true,
                                text: '최근 1주일 방문자 수',
                                fontSize: 18
                            }
                        },
                        scales: {
                            x: {
                                ticks: {
                                    callback: function(value, index, values) {
                                        return labels[value]; // 라벨 배열에서 해당 인덱스의 값을 반환하여 표시
                                    }
                                }
                            },
                            y: {
                                min: 0,
                                max: maxVisitors,
                                ticks: {
                                    stepSize: stepSize,
                                    callback: function(value, index, values) {
                                        return value.toLocaleString(); // 숫자 포맷팅 (3자리 쉼표)
                                    }
                                }
                            }
                        }
                    }
                });
            },
            error: function(xhr, status, error) {
                console.error('Error fetching visitor data:', error);
            }
        });

        // 서버에서 매출 순위별 가맹점 리스트 데이터 가져오기
        $.ajax({
            url: '/admin/franchise-rankings',
            method: 'GET',
            success: function(data) {
                var franchiseRankings = data;

                // 가맹점 리스트를 HTML로 변환하여 페이지에 추가
                var html = '<ul class="list-group">';
                franchiseRankings.forEach(function(franchise, index) {
                    var total_payprice = franchise.total_payprice ? franchise.total_payprice.toLocaleString() + '원' : 'N/A'; // revenue 값이 있을 때만 포맷팅
                    html += '<li class="list-group-item">' + (index + 1) + '. ' + franchise.mutual + ' (매출: ' + total_payprice + ')</li>';
                });
                html += '</ul>';

                $('#franchiseRankings').html(html);
            },
            error: function(xhr, status, error) {
                console.error('Error fetching franchise rankings:', error);
            }
        });

    });
</script>
</body>
</html>
