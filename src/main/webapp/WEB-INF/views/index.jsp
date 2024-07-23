<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script>
	var msg = "${msg}"; 

	if(msg == "otp_ok"){
		alert("OTP인증이 완료되었습니다.\n로그인을 다시 시도해주세요.");
	}else if(msg != ""){
		alert(msg);
	}else{
		
	}	
</script>
<script>
	function addcartform(pid){
		document.getElementById("addcart-" + pid).submit();
	}
</script>
<!-- Start slider area -->
<div class="slider-area">
    <div class="zigzag-bottom"></div>
    <div id="slide-list" class="carousel carousel-fade slide" data-ride="carousel">
        <div class="slide-bulletz">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <ol class="carousel-indicators slide-indicators">
                            <!-- 슬라이드 인디케이터 -->
                            <c:forEach items="${banners}" var="banner" varStatus="iterStat">
                                <li data-target="#slide-list" data-slide-to="${iterStat.index}" class="<c:if test='${iterStat.index == 0}'>active</c:if>"></li>
                            </c:forEach>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        <div class="carousel-inner" role="listbox">
            <c:forEach items="${banners}" var="banner" varStatus="iterStat">
                <div class="item <c:if test='${iterStat.index == 0}'>active</c:if>">
                    <div class="single-slide">
                        <div class="slide-bg" style="background-image: url('/banner_submit/<c:out value="${banner.imageurl}" />');"></div>
                    </div>
                    <div class="slide-text-wrapper">
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<!-- End slider area -->
<div class="promo-area">
    <div class="zigzag-bottom"></div>
    <div class="container">
        <div class="row">
            <div class="col-md-3 col-sm-6">
            	<a href="/board/boardlist" style="color:white;">
	                <div class="single-promo">
	                    <i class="fa fa-info-circle"></i>
	                    <p>공지사항</p>
	                </div>
                </a>
            </div>
            <div class="col-md-3 col-sm-6">
            	<a href="/mypage/mainMypage" style="color:white;">
	                <div class="single-promo">
	                    <i class="fa fa-user"></i>
	                    <p>마이페이지</p>
	                </div>
                </a>
            </div>
            <div class="col-md-3 col-sm-6">
            	<a href="/coupon/couponList" style="color:white;">
	                <div class="single-promo">
	                    <i class="fa fa-gift"></i>
	                    <p>쿠폰발행</p>
	                </div>
                </a>
            </div>
            <div class="col-md-3 col-sm-6">
                <a href="/wish/wishlist" style="color:white;">
	                <div class="single-promo">
	                    <i class="fa fa-list"></i>
	                    <p>위시리스트</p>  
	                </div>
                </a>
            </div>
        </div>
    </div>
</div> <!-- End promo area -->
<div class="maincontent-area">
    <div class="zigzag-bottom"></div>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="latest-product">
                    <h2 class="section-title">최신상품</h2>                   
                    <div class="product-carousel">
	                    <c:forEach var="product" items="${productList }">	
	                    	<form id="addcart-${product.pid}" method="post" action="/cart/addcart">
			                    <input type="hidden" id="cart" name="cart" value="${sessionScope.cart}">
					            <input type="hidden" id="mid" name="mid" value="${sessionScope.id}">
					            <input type="hidden" id="mutual" name="mutual" value="${product.mutual}">
					            <input type="hidden" id="pid" name="pid" value="${product.pid}">
					            <input type="hidden" id="qty" name="qty" value="1">
					            <input type="hidden" id="point" name="point" value="${product.point}">
					            <input type="hidden" id="file1" name="file1" value="${product.file1}">
					            <input type="hidden" id="pname" name="pname" value="${product.pname}">                    
	                        <div class="single-product">	                        	                     	
	                            <div class="product-f-image">                            
	                            <img src="/product_upload/${product.file1 }" style="height:230px">
	                            <c:choose>
		                        	<c:when test="${product.qty == 0  || sessionScope.id == null}"></c:when>
			                        <c:otherwise>
			                        	<div class="product-hover">
		                                    <a href="#" onclick="document.getElementById('addcart-${product.pid}').submit()" class="add-to-cart-link"><i class="fa fa-shopping-cart"></i>장바구니담기</a>
		                                </div>
			                        </c:otherwise>
		                        </c:choose>
	                            </div>
	                            <c:set var="maxLength" value="13" /> <!-- 최대 길이 설정 -->
	                            <h2><a href="/product/itemview?pid=${product.pid }">${fn:substring(product.pname, 0, maxLength)}${fn:length(product.pname) > maxLength ? '...' : ''}</a></h2>
	                            <div class="product-carousel-price">
	                                <c:choose>
		                                <c:when test="${product.saleprice != '0' }">
		                                    <ins><fmt:formatNumber type="number" value="${product.saleprice}" pattern="#,###" />원</ins>
		                                    <del><fmt:formatNumber type="number" value="${product.price }" pattern="#,###" />원</del>
		                                    <input type="hidden" id="price" name="price" value="${product.saleprice}">
		                                    <div style="color:red;font-weight: bold">
		                                    	<script>
											        var salePrice = ${product.saleprice};
											        var regularPrice = ${product.price};
											        var discountPercentage = 100 - (salePrice * 100 / regularPrice);
											        var discountPercentageRounded = Math.round(discountPercentage); // 소수점 없이 반올림하여 표시
											
											        document.write(discountPercentageRounded + '% 할인');
											    </script>
		                                    </div>
		                                </c:when>
		                                <c:otherwise>
		                                    <ins><fmt:formatNumber type="number" value="${product.price }" pattern="#,###" />원</ins><br><br>
		                                    <input type="hidden" id="price" name="price" value="${product.price}">
		                                </c:otherwise> 
		                            </c:choose> 
	                            </div>	                            
                        	</div>
                        	</form>                        
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div> <!-- End main content area -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>