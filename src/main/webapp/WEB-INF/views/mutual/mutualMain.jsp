<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>월별 매출과 상품 리스트</title>
    <%@ include file="/WEB-INF/views/mutual/include_mutual/common.jsp" %>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.4/css/all.min.css">
    <style>
        .chart-container {
            display: flex;
            justify-content: space-around;
            align-items: flex-start; /* 막대그래프와 상품 리스트를 위아래로 정렬 */
            margin-top: 20px;
        }
        .chart-wrapper {
            width: 100%; /* 막대그래프를 100% 너비로 설정 */
        }
        .product-list {
            width: 100%; /* 상품 리스트를 100% 너비로 설정 */
            margin-top: 20px;
            padding-left: 20px;
        }
        .product-list ul {
            list-style-type: none;
            padding: 0;
        }
        .product-list ul li {
            margin-bottom: 10px;
        }
        .card {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .card-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
    <!-- navbar -->
    <%@ include file="/WEB-INF/views/mutual/include_mutual/navbar.jsp" %>
    <!-- main slide -->
    <%@ include file="/WEB-INF/views/mutual/include_mutual/mainslide.jsp" %>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <!-- 월별 매출 막대그래프 -->
                    <div class="col-lg-6 chart-container">
                        <div class="chart-wrapper">
                            <canvas id="monthlySalesChart" width="700" height="500"></canvas>
                        </div>
                    </div>
                     <!-- To-Do List -->
                    <div class="col-lg-6 todo-list">
                        <div class="card">
                            <div class="card-title">To-Do List</div>
                            <ul id="todoList">
                                <!-- 동적으로 추가될 항목들 -->
                            </ul>
                            <div class="input-group mb-3">
                                <input type="text" id="todoInput" class="form-control" placeholder="할 일 추가...">
                                <button class="btn btn-primary" type="button" onclick="addTodo()">추가</button>
                            </div>
                        </div>
                    </div>
                    <!-- 가장 많이 팔리는 상품 리스트 -->
                    <div class="col-lg-6 product-list">
                        <div class="card">
                            <div class="card-title">가장 많이 팔리는 상품 리스트</div>
                            <ul id="topSellingProducts">
                                <%-- 서버에서 받아온 데이터를 동적으로 추가할 부분 --%>
                                <c:forEach items="${topSellingProducts}" var="product" varStatus="status">
                                    <li>${status.index + 1}. ${product.product_name} (판매량: ${product.total_quantity_sold}개)</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- /.content -->
    </div>
</div>
<!-- footer -->
<%@ include file="/WEB-INF/views/mutual/include_mutual/footer.jsp" %>

<!-- JavaScript -->
<script>
    // 서버에서 월별 매출 데이터 가져오기
    var monthlySalesData = [
        <c:forEach items="${monthlySales}" var="salesData" varStatus="status">
            <c:if test="${!status.first}">,</c:if>
            {
                month: '${salesData.month}', // 월 데이터는 숫자로 가져오기 때문에 그대로 사용
                sales: ${salesData.monthly_sales}
            }
        </c:forEach>
    ];

    // 월별 매출 막대그래프 그리기
    var ctxMonthlySales = document.getElementById('monthlySalesChart').getContext('2d');
    var monthlySalesChart = new Chart(ctxMonthlySales, {
        type: 'bar',
        data: {
            labels: ['01월', '02월', '03월', '04월', '05월', '06월', '07월', '08월', '09월', '10월', '11월', '12월'], // 월별 라벨 설정
            datasets: [{
                label: '월별 매출',
                data: [
                    findSalesData('01'),
                    findSalesData('02'),
                    findSalesData('03'),
                    findSalesData('04'),
                    findSalesData('05'),
                    findSalesData('06'),
                    findSalesData('07'),
                    findSalesData('08'),
                    findSalesData('09'),
                    findSalesData('10'),
                    findSalesData('11'),
                    findSalesData('12')
                ],
                backgroundColor: 'rgba(75, 192, 192, 0.6)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
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
                    text: '월별 매출'
                }
            },
            scales: {
                x: {
                    stacked: true,
                },
                y: {
                    beginAtZero: true,
                    max: 50000000,
                    stepSize: 1000000,
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString() + '원';
                        }
                    }
                }
            }
        }
    });

    // 해당 월의 매출 데이터를 찾는 함수
    function findSalesData(month) {
        var data = monthlySalesData.find(function(item) {
            return item.month === month;
        });
        return data ? data.sales : 0; // 해당 월 데이터가 없으면 0을 반환
    }
    
 	// To-Do List 관련 JavaScript
    function addTodo() {
        var todoInput = document.getElementById('todoInput');
        var todoList = document.getElementById('todoList');
        var todoText = todoInput.value.trim();
        
        if (todoText !== '') {
            var li = document.createElement('li');
            li.textContent = todoText;
            todoList.appendChild(li);
            todoInput.value = '';
        }
    }
</script>
</body>
</html>
