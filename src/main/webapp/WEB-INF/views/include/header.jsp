<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>탁월한 선택! 규팡</title>
    
    <!-- jstl -->
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
    
    <!-- Google Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Titillium+Web:400,200,300,700,600' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:400,700,300' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Raleway:400,100' rel='stylesheet' type='text/css'>
    
    <!-- Bootstrap -->
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="/css/owl.carousel.css">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/responsive.css">
    
     <!-- Slick CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel/slick/slick-theme.css"/>
    
    
    <!-- css -->
    <link rel="stylesheet" href="/css/join.css">
    
    <!-- jquery -->
    <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.4.1.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- js -->
    <script src="/js/reg.js"></script>
    <script src="/js/joinupreg.js"></script>
    <script src="/js/storereg.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="/js/daumadrr.js"></script>
    <script src="/js/passshow.js"></script>
    
     <!-- Slick JS -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel/slick/slick.min.js"></script>
    
    <!-- Bootstrap bundle (includes Popper.js) -->
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    
    <style>
        .search-container {
            display: flex;
            align-items: center;
        }

        .search-input {
            margin-right: 80px;
            padding: 5px;
        }

        .search-button {
        	bottom: 0px;
        	left: 250px;
        	position:absolute;
            padding: 5px 10px;
        }
        .search-select {
        	position:absolute;
        	margin-left: -415px;
        	bottom: 0.5px;
        	height: 40px;
        }
        .back{
        	border:none;
        	background:none;
        }
    </style>
</head>
<body>
    <div class="header-area">
        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <div class="user-menu">
                        <ul>
                            <c:choose>
                                <c:when test="${sessionScope.id != null && sessionScope.level != null }">
                                    <c:choose>
                                        <c:when test="${sessionScope.level eq 10}">
                                            <li><a href="/admin/adminMain"><i class="fa fa-user-circle"></i>관리자페이지</a></li>
                                            <li><a href="/member/logout"><i class="fa fa-sign-out"></i>로그아웃</a></li>
                                            <li><a href="">${sessionScope.name}님 반갑습니다.</a></li>
                                        </c:when>
                                        <c:when test="${sessionScope.level eq 5}">
                                            <li><a href="/mutual/mutualMain"><i class="fa fa-archive"></i>가맹점페이지</a></li>
                                            <li><a href="/store/storelogout"><i class="fa fa-sign-out"></i>로그아웃</a></li>
                                            <li><a href="">${sessionScope.label}님 반갑습니다.</a></li>
                                        </c:when>
                                        <c:when test="${sessionScope.level eq 4}">
                                            <li><a href="/mutual/mutualMain"><i class="fa fa-archive"></i>가맹점페이지</a></li>
                                            <li><a href="/store/storelogout"><i class="fa fa-sign-out"></i>로그아웃</a></li>
                                            <li><a href="">${sessionScope.name}님 반갑습니다.</a></li>
                                        </c:when>
                                        <c:when test="${sessionScope.level eq 1 and sessionScope.loginstatus eq '일반'}">
											<li><a href=""><i class="fa fa-money"></i> <span class="point-info"></span></a></li>
                                            <li><a href="/member/logout"><i class="fa fa-sign-out"></i>로그아웃</a></li>
                                            <li><a href="">${sessionScope.name}님 반갑습니다.</a></li>
                                        </c:when>
                                        <c:when test="${sessionScope.level eq 1 and sessionScope.loginstatus eq '소셜'}">
											<li><a href=""><i class="fa fa-money"></i> <span class="point-info"></span></a></li>
                                            <li><a href="/member/slogout"><i class="fa fa-sign-out"></i>로그아웃</a></li>
                                            <li><a href="">${sessionScope.name}님 반갑습니다.</a></li>
                                        </c:when>
                                    </c:choose>
                                </c:when>    
                                <c:otherwise>
                                    <li><a href="/member/memberLogin"><i class="fa fa-sign-in"></i>로그인/회원가입</a></li>
                                    <li><a href="/store/storeLogin"><i class="fa fa-archive"></i>가맹점</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div> <!-- End header area -->
    <div class="site-branding-area">
    <div class="container">
        <div class="row">
            <div class="col-sm-6" style="top:30px;">
                <div class="logo" >
                    <a href="/"><img src="/img/logo.png" style="width:100px; padding-top: 15px"></a>
                </div>
            </div>  
            <div class="col-sm-6" style="top:30px;">
                <div class="search">
		            <form class="search-container" method="GET" action="/product/search">
		            	<select name="searchType" class="search-select">
		            		<option value="" ${criteria.searchType == null?'selected':''}>전체검색</option>
							<option value="productName" ${criteria.searchType eq 'productName'?'selected':''}>상품명검색</option>
							<option value="brand" ${criteria.searchType eq 'brand'?'selected':''}>브랜드검색</option>
		            	</select>
		                <input  name="search" value="${criteria.search }" class="search-input" type="search" placeholder="검색어를 입력해주세요.">
		                <span><button class="search-button" type="submit"><i class="fa fa-search"></i></button></span>
		            </form>
                </div>
            </div> 
            <div class="col-sm-6">
                <div class="shopping-item" style="bottom:50px;">
                    <a href="/cart/cartlist">Cart - 
                    <fmt:formatNumber type="number" value="${sessionScope.totalPrice != null ? sessionScope.totalPrice : 0}" pattern="#,###" />원 
                    <i class="fa fa-shopping-cart"></i> 
                    <span class="product-count">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div> <!-- End site branding area -->
<div class="mainmenu-area">
    <div class="container">
        <div class="row">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div> 
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li><a href="/product/itemlist">전체상품</a></li>
                    <li><a href="/product/itemlistm">브랜드관</a></li>
                    <li><a href="/product/itemlistp">인기상품</a></li>
                    <li><a href="/product/itemlists">특가상품</a></li>
                    <li><a href="/product/itemlists2">오늘의 추천상품</a></li>
                </ul>
            </div>  
        </div> 
    </div>
</div> <!-- End mainmenu area -->
<!-- JavaScript -->
<script>
$(document).ready(function() {
    // 페이지 로드 시 포인트를 가져와서 업데이트
    updatePoint();

    // 포인트 업데이트 함수
    function updatePoint() {
        $.ajax({
            type: "GET",
            url: "/member/getPoint", // 포인트를 가져오는 서블릿 또는 컨트롤러 URL
            dataType: "json",
            success: function(data) {
                if (data.point) {
                    var formattedPoint = new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(data.point);
                    $('.point-info').text(formattedPoint); // 보유포인트를 span.point-info 요소에 표시
                }
            },
            error: function() {
                console.log('포인트 정보를 가져오는 중 오류가 발생했습니다.');
            }
        });
    }
});
</script>
</body>
</html>
