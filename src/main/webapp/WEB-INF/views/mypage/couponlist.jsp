<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
    .container11 {
        margin: 0 auto;
        max-width: 900px;
        margin-top: 50px;
        margin-bottom: 50px;
    }
    .text-center {
        text-align: center;
    }
    .btn-custom {
        width: 130px; /* 버튼 너비 증가 */
    }
    .wishlist-item img {
        max-width: 100px;
        height: auto;
    }
    .btn-group {
        white-space: nowrap; /* 버튼 그룹이 한 줄에 표시되도록 설정 */
    }
    .product-remove a {
        color: red; /* x의 색상 설정 */
        font-size: 24px; /* x의 글자 크기 조정 */
    }
    .product-remove a:hover {
        text-decoration: none; /* 링크에 호버 시 밑줄 제거 */
    }
    /* 테이블 셀 내부 컨텐츠 세로, 가로 중앙 정렬 */
    .wishlist-item td, .wishlist-item th {
        text-align: center;
        vertical-align: middle;
        font-size: 18px;
    }
    .content-wrapper {
	  	margin-right: 170px;
	    margin-top: 100px;
	    margin-bottom: 100px;
	  }
	  .sidebar {
	  	margin-top: 100px;
		margin-left: 170px;
		float: right;
	  }
	  .card-body p {
	    font-size: 18px; /* <p> 태그 폰트 크기 설정 */
	  }	  
</style>
<div class="col-md-3">
  <div class="list-group sidebar">
    <a href="/mypage/mainMypage" class="list-group-item list-group-item-action">Home</a>
    <a href="/mypage/memberJoinUp" class="list-group-item list-group-item-action">회원정보수정</a>
    <a href="/mypage/translist" class="list-group-item list-group-item-action">구매내역 및 환불</a>
    <a href="/mypage/couponlist" class="list-group-item list-group-item-action active">쿠폰목록</a>
    <a href="/mypage/wishlist" class="list-group-item list-group-item-action">위시리스트</a>
  </div>
</div>
<div class="container11">
    <h1 class="text-center mb-4">보유 쿠폰</h1>
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead class="thead-light">
                        <tr>
                            <th width="400px" style="align:center;">쿠폰명</th>
                            <th width="100px" style="align:center;">유효기간</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <%-- 쿠폰이 있을 경우 --%>
                            <c:when test="${not empty coupon}">
                                <c:forEach var="coupon" items="${coupon}">                                       
                                        <tr class="wishlist-item">                                            
                                            <td style="vertical-align:middle;">${coupon.description}</td>
                                            <td style="vertical-align:middle;">${coupon.expirydate}</td>
                                        </tr>
                                </c:forEach>
                            </c:when>
                            <%-- 쿠폰이 없을 경우 --%>
                            <c:otherwise>
                                <tr>
                                    <td colspan="2" class="text-center">사용 가능한 쿠폰이 없습니다.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
  <% if (request.getAttribute("msg") != null) { %>
      var msg = "<%= request.getAttribute("msg") %>";
      alert(msg);
  <% } %>
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
