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
    <a href="/mypage/couponlist" class="list-group-item list-group-item-action">쿠폰목록</a>
    <a href="/mypage/wishlist" class="list-group-item list-group-item-action active">위시리스트</a>
  </div>
</div>
<div class="container11">
    <h1 class="text-center mb-4">위시리스트</h1>
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead class="thead-light">
                        <tr>
                            <th width="100px" style="vertical-align:middle;">삭제</th>
                            <th width="100px">이미지</th>
                            <th width="400px" style="vertical-align:middle;">상품명</th>
                            <th width="100px" style="vertical-align:middle;">가격</th>
                            <th width="100px" style="vertical-align:middle;">수량</th>
                            <th width="100px" style="vertical-align:middle;">적립포인트</th>
                            <th width="150px" style="vertical-align:middle;">담기</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <%-- 위시리스트 아이템이 있을 경우 --%>
                            <c:when test="${not empty wish}">
                                <c:forEach var="wishItem" items="${wish}">
                                    <form action="/wish/sendcart" method="POST">                                    	
                                        <input type="hidden" id="mid" name="mid" value="${wishItem.mid}">
                                        <input type="hidden" id="mutual" name="mutual" value="${wishItem.mutual}">
                                        <input type="hidden" id="pid" name="pid" value="${wishItem.pid}">
                                        <input type="hidden" id="pname" name="pname" value="${wishItem.pname}">
                                        <input type="hidden" id="price" name="price" value="${wishItem.price}">
                                        <input type="hidden" id="point" name="point" value="${wishItem.point}">
                                        <input type="hidden" id="qty" name="qty" value="${wishItem.qty}">
                                        <input type="hidden" id="file1" name="file1" value="${wishItem.file1}">
                                        <input type="hidden" id="option_value1" name="option_value1" value="${wishItem.option_value1}">
                                        <input type="hidden" id="option_value2" name="option_value2" value="${wishItem.option_value2}">
                                        <input type="hidden" id="option_value3" name="option_value3" value="${wishItem.option_value3}">
                                        <input type="hidden" id="option_value4" name="option_value4" value="${wishItem.option_value4}">
                                        <input type="hidden" id="option_value5" name="option_value5" value="${wishItem.option_value5}">
                                        <tr class="wishlist-item">
                                            <td class="product-remove" style="vertical-align:middle;">
                                                <a href="/mypage/wishdelete?wid=${wishItem.wid}"><strong>x</strong></a> <!-- x를 강조하기 위해 strong 태그 사용 -->
                                                <input type="hidden" id="wid" name="wid" value="${wishItem.wid}">
                                            </td>
                                            <td style="vertical-align:middle;"><img src="/product_upload/${wishItem.file1}" class="img-fluid"></td>
                                            <td style="vertical-align:middle;"><a href="/product/itemview?pid=${wishItem.pid}">${wishItem.pname}</a></td>
                                            <td style="vertical-align:middle;"><fmt:formatNumber type="number" value="${wishItem.price}" pattern="#,###" />원</td>
                                            <td style="vertical-align:middle;">${wishItem.qty}개</td>
                                            <td style="vertical-align:middle;"><fmt:formatNumber type="number" value="${wishItem.point}" pattern="#,###" />p</td>
                                            <td style="vertical-align:middle;">
                                                <div class="btn-group">
                                                    <button type="submit" class="btn" style="border:none; background:none; color:black;"><i class="fa fa-shopping-cart" aria-hidden="true"></i></button>
                                                </div>
                                            </td>
                                        </tr>
                                    </form>
                                </c:forEach>
                            </c:when>
                            <%-- 위시리스트 아이템이 없을 경우 --%>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" class="text-center">위시리스트가 비었습니다.</td>
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
