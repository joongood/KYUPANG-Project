<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
/* 추가적인 CSS 스타일을 여기에 작성하세요 */
.category-bar {
    background-color: #F5F5F5;
    border: 1px solid #DDDDDD;
    border-radius: 10px;
    padding: 10px;
    margin-bottom: 20px;
    display: flex;
    justify-content: space-around;
    font-size : 15px;
}

.category-bar ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
}

.category-bar ul li {
    position: relative; /* 추가: 상대 위치 설정 */
    display: inline-block;
    margin-right: 10px;
    cursor: pointer;
}

.sub-categories {
    display: none;
    position: absolute;
    background-color: #FFFFFF;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
    top: 100%; /* 추가: 상단에 붙이기 */
    left: 0; /* 추가: 왼쪽 정렬 */
    width: 200px; /* 추가: 너비 조정 */
}

.sub-categories ul {
    list-style-type: none;
    padding: 10px;
    margin: 0;
}

.sub-categories ul li {
    padding: 8px 16px;
    cursor: pointer;
}

.category-bar ul li:hover .sub-categories {
    display: block;
}
.active {
	display: block;
    font-weight: bold;
}
.product-upper {
    position: relative;
    display: inline-block;
    overflow: hidden; /* 내용이 넘치는 경우 가려지도록 설정 */
}

.btn-cart {
    display: none; /* 초기에는 숨김 */
    position: absolute;
    top: 42%; /* 부모 요소에서 정확한 위치 조정 */
    left: 34%;
    transform: translate(-50%, -50%);
    padding: 5px 10px;
    cursor: pointer;
    z-index: 2; /* 다른 내용보다 위에 표시되도록 설정 */
}

.product-upper:hover .btn-cart {
    display: block; /* 마우스 오버 시 버튼 보이기 */
}

.product-upper::before,
.btn-cart:hover ~ .product-upper::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5); /* 검은색 배경, 투명도 조정 가능 */
    z-index: 1; /* 버튼 아래로 배치 */
    opacity: 0;
    transition: opacity 0.3s ease; /* 투명도 애니메이션 추가 */
}

.product-upper:hover::before,
.btn-cart:hover ~ .product-upper::before {
    opacity: 1; /* 호버 시 배경이 나타남 */
}
</style>
<!-- 전체버튼 클릭시 기존 cid,page등 파라메터 초기화 -->
<script>
function removeQueryParameters() {
    // 현재 URL에서 쿼리 문자열 제거
    const urlWithoutParams = window.location.origin + window.location.pathname;
    // 새로운 URL로 리디렉션
    window.history.replaceState({}, document.title, urlWithoutParams);
}
</script>
<script>
	<% if (request.getAttribute("msg") != null) { %>
	var msg = "<%= request.getAttribute("msg") %>";
	alert(msg);
	<% } %>	
</script>
<!-- 카테고리바 추가 -->
<div class="category-bar">
    <ul>
        <!-- cateList를 기반으로 동적으로 대분류 메뉴 생성 -->
        <c:forEach var="brandList" items="${brandList}">
                <li>
                    <a href="?mutual=${brandList.mutual}">${brandList.mutual}</a>
                </li>
        </c:forEach>
    </ul>
</div>
<div class="single-product-area">
    <div class="zigzag-bottom"></div>
    <div class="container">
        <div class="row">  
            <c:set var="maxLength" value="23" /> <!-- 최대 길이 설정 -->
            <c:set var="number" value="${pageMaker.totalCount - (pageMaker.criteria.page - 1) * pageMaker.criteria.perPageNum }" />
            <c:set var="counter" value="0" />
            <div class="row">    
            <c:forEach var="product" items="${productList}">         
                <div class="col-md-4 col-sm-3">
                    <div class="single-shop-product" style="position: relative;">
					    <form method="post" action="/cart/brandaddcart">
					        <input type="hidden" id="cart" name="cart" value="${sessionScope.cart}">
					        <input type="hidden" id="mid" name="mid" value="${sessionScope.id}">
					        <input type="hidden" id="mutual" name="mutual" value="${mutual}">
					        <input type="hidden" id="pid" name="pid" value="${product.pid}">
					        <input type="hidden" id="qty" name="qty" value="1">
					        <input type="hidden" id="point" name="point" value="${product.point}">
					        <input type="hidden" id="file1" name="file1" value="${product.file1}">
					        <input type="hidden" id="pname" name="pname" value="${product.pname}">
					        <input type="hidden" name="page" value="${pageMaker.criteria.page != null ? pageMaker.criteria.page : 1}">
					        <c:choose>
					            <c:when test="${product.qty == 0}">
					                <div class="product-upper" style="position: relative;">
					                    <img src="/product_upload/${product.file1}" style="width:250px;height:250px">
					                    <img src="/img/soldout.png" style="position: absolute; top: 35%; left: 0%; width: 90%;">
					                </div>
					            </c:when>
					            <c:when test="${product.qty <= 20}">
					                <div class="product-upper" style="position: relative;">
					                    <img src="/product_upload/${product.file1}" style="width:250px;height:250px">
					                    <img src="/img/almostsoldout.png" style="position: absolute; top: 0%; left: -5%; width: 40%;">
					                </div>
					            </c:when>
					            <c:when test="${product.saleprice != 0}">
					                <div class="product-upper" style="position: relative;">
					                    <img src="/product_upload/${product.file1}" style="width:250px;height:250px">
					                    <img src="/img/sale.png" style="position: absolute; top: 0%; left: 0%; width: 30%;">
					                </div>
					            </c:when>
					            <c:otherwise>
					                <div class="product-upper">
					                    <img style="width:250px;height:250px" src="/product_upload/${product.file1}">
					                </div>
					            </c:otherwise>
					        </c:choose>
					        <div><a href="/product/itemview?pid=${product.pid}">${fn:substring(product.pname, 0, maxLength)}${fn:length(product.pname) > maxLength ? '...' : ''}</a></div>
					        <div class="product-carousel-price">
					            <c:choose>
					                <c:when test="${product.saleprice != 0}">
					                    <ins><fmt:formatNumber type="number" value="${product.saleprice}" pattern="#,###"/>원</ins>
					                    <del><fmt:formatNumber type="number" value="${product.price}" pattern="#,###"/>원</del>
					                    <input type="hidden" id="price" name="price" value="${product.saleprice}">
					                    <div style="color:red;font-weight: bold">
					                        <script>
					                            var salePrice = ${product.saleprice};
					                            var regularPrice = ${product.price};
					                            var discountPercentage = 100 - (salePrice * 100 / regularPrice);
					                            var discountPercentageRounded = Math.round(discountPercentage);
					                            document.write(discountPercentageRounded + '% 할인');
					                        </script>
					                    </div>
					                </c:when>
					                <c:otherwise>
					                    <ins><fmt:formatNumber type="number" value="${product.price}" pattern="#,###"/>원</ins><br><br>
					                    <input type="hidden" id="price" name="price" value="${product.price}">
					                </c:otherwise>
					            </c:choose>
					        </div>
					        <c:choose>
					            <c:when test="${product.qty == 0 || sessionScope.id == null}"></c:when>
					            <c:otherwise>
					                <button class="btn-cart" type="submit">장바구니담기</button>
					            </c:otherwise>
					        </c:choose>
					    </form>
					</div>
                    <c:set var="number" value="${number - 1 }"/>
                    </div>
                </c:forEach> 
            </div>    
            <!-- /.card-body -->
            <div class="card-footer">
                <div class="row">
                    <div class="col-sm-12 col-md-12">
                        <ul class="pagination justify-content-center">                        
                            <c:if test="${pageMaker.prev}">
                                <li class="page-item"><a class="page-link" href="?mutual=${mutual }&cid=${cid }&page=${pageMaker.startPage - 1}">&laquo;</a></li>
                            </c:if>
                            <c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                                <li class="page-item ${pageMaker.criteria.page == i ? 'active' : ''}"><a class="page-link" href="?mutual=${mutual }&cid=${cid }&page=${i}">${i}</a></li>
                            </c:forEach>
                            <c:if test="${pageMaker.next}">
                                <li class="page-item"><a class="page-link" href="?mutual=${mutual }&cid=${cid }&page=${pageMaker.endPage + 1}">&raquo;</a></li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- /.card -->
        </div>
    </div>
</div>
<script>
document.addEventListener('DOMContentLoaded', function() {
    var productCards = document.querySelectorAll('.single-shop-product');

    productCards.forEach(function(card) {
        var btnCart = card.querySelector('.btn-cart');

        card.addEventListener('mouseenter', function() {
            btnCart.style.display = 'block';
        });

        card.addEventListener('mouseleave', function() {
            btnCart.style.display = 'none';
        });
    });
});
</script>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
