<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .text-center {
        text-align: center;
    }
    .btn-custom {
        width: 130px;
    }
    .wishlist-item img {
        max-width: 100px;
        height: auto;
    }
    .product-remove a {
        color: red;
        font-size: 24px;
    }
    .product-remove a:hover {
        text-decoration: none;
    }
    /* 테이블 셀 내부 컨텐츠 세로, 가로 중앙 정렬 */
    .wishlist-item1 td, .wishlist-item th {
        text-align: center;
        vertical-align: middle;
        font-size: 15px;
        margin: 0;
        padding: 0;
        border-spacing: 0;
    }
    .wishlist-item1 {
        margin: 0;
        padding: 0;
        border-spacing: 0;
    }
    /* 테이블 여백 제거 */
    table {
        margin: 0;
        padding: 0;
        border-spacing: 0;
        border-collapse: collapse;
    }
    /* 테이블 내 셀 패딩 제거 */
    .table td, .table th {
        padding: 0;
    }
</style>
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- jstl -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<table class="table table-hover" style="border:none;height:auto;">
    <tbody>
        <c:choose>
            <c:when test="${empty cart}">
                <tr>
                    <td colspan="6" class="text-center">구매내역이 없습니다.</td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:set var="number" value="${pageMaker.totalCount - (pageMaker.criteria.page - 1) * pageMaker.criteria.perPageNum}" />
                <c:forEach var="cart" items="${cart}"> 
                		<input type="hidden" id="cart" name="cart" value="${cart.cart }">
                		<input type="hidden" id="pid" name="pid" value="${cart.pid }">
                		<input type="hidden" id="odid" name="odid" value="${cart.odid }">                                       
                        <tr class="wishlist-item1">
                        	<td style="vertical-align:middle;">${number}<input type="hidden" id="ctid" name="ctid" value="${cart.ctid}"></td>
                            <td  style="vertical-align:middle;" class="product-thumbnail">
                            	<img style="width:145px; height:80px" alt="poster_1_up" class="shop_thumbnail" src="/product_upload/${cart.file1}">
                            </td>
                            <td  style="vertical-align:middle;" class="product-name">${cart.pname}</td>
                            <td  style="vertical-align:middle;" class="product-subtotal">
                               <span class="amount"><fmt:formatNumber type="number" value="${cart.price * cart.qty}" pattern="#,###" />원</span>
                            </td>
                            <td  style="vertical-align:middle;" class="product-name">
                            <c:choose>
                            	<c:when test="${cart.transtatus == '입금대기' && cart.cartstatus != '주문취소'}">
                            		입금대기
                            	</c:when>
                            	<c:otherwise>
                            		${cart.cartstatus}
                            	</c:otherwise>
                            </c:choose>
                            </td>
                            <td  style="vertical-align:middle;">
                            <c:choose>
                            	<c:when test="${cart.cartstatus == '거래완료'}">
                             	<button>환불신청</button> 
                            	</c:when>
                            	<c:when test="${cart.cartstatus != '주문취소'}">
                             	<button id="cancelbtn" class="btn btn-danger" name="cancelbtn">구매취소</button> 
                            	</c:when>
                            	<c:otherwise>
              
                            	</c:otherwise>
                            </c:choose>	                                                                                      
                            </td>                                            
                        </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </tbody>
</table>
<script>
$(document).ready(function() {
    $("#cancelbtn").click(function() {
    	//사용자에게 확인 메세지 표시
    	var userConfirmed = confirm("정말로 구매취소를 하시겠습니까?");
    	
    	//true 일 경우
    	if(userConfirmed){
    		var cart = document.getElementById("cart").value;
    		var pid = document.getElementById("pid").value;
    		var odid = document.getElementById("odid").value;

            $.ajax({
                url: "/mypage/cancel",
                type: "POST", 
                dataType: "text", 
                data: {
                	cart: cart, // 전송할 데이터는 카트 ctid입니다.
                	pid: pid,
                	odid: odid,
                },
                error: function () { // 요청이 실패했을 경우 실행됩니다.
                    alert("요청 실패");
                },
                success: function () { // 요청이 성공했을 경우 실행됩니다. 서버에서 반환한 데이터는 'text' 변수에 담겨 있습니다.
                    alert("취소 처리 되었습니다.");
                	location.reload();
                }
            });	
    	}else{
    		alert("취소되었습니다.");
    	}
    });
});
</script>
<script>
  <% if (request.getAttribute("msg") != null) { %>
      var msg = "<%= request.getAttribute("msg") %>";
      alert(msg);
  <% } %>
</script>
