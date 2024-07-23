<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %> 
<style>
    .container14 {
        margin-top: 50px;
        margin-bottom: 50px;
        margin-left: -700px;
    }

    .coupon-page {
        display: flex;
        justify-content: space-between; /* 쿠폰과 안내 박스를 좌우로 정렬 */
    }

    .coupon {
        display: flex;
        flex-direction: column; /* flex 방향을 열로 설정 */
        align-items: center; /* 항목을 가운데 정렬 */
        width: 450px;
        height: 200px;
        border: 1px dashed #ccc;
        padding: 20px;
        margin: 10px 0;
        background: #f9f9f9;
        position: relative; 
        margin-left: -400px;       
    }

    .coupon:before {
        content: "";
        position: absolute;
        top: 0;
        bottom: 0;
        left: -15px;
        width: 30px;
        background: #fff;
        border: 15px solid #f9f9f9;
        border-right: 15px dashed #ccc;
    }

    .coupon:after {
        content: "";
        position: absolute;
        top: 0;
        bottom: 0;
        right: -15px;
        width: 30px;
        background: #fff;
        border: 15px solid #f9f9f9;
        border-left: 15px dashed #ccc;
    }

    .coupon-container {
        text-align: center; /* 중앙 정렬 */
    }

    .btn_gr {
        margin-top: auto; /* 버튼을 아래쪽으로 배치 */
    }

    .btn {
        background: none;
        border: 1px solid blue; /* 테두리를 설정하고, 원하는 색상으로 변경 */
        padding: 10px 20px;
        cursor: pointer;
        color: blue; /* 텍스트 색상을 파란색으로 지정 */
        transition: background-color 0.3s, color 0.3s; /* 호버 효과를 위한 전환 효과 추가 */
    }

    .btn:hover {
        background-color: blue;
        color: white;
    }

    .side-box {
        width: 250px;
        padding: 20px;
        background-color: #f0f0f0;
        border: 1px solid #ccc;
    }

    .side-box h3 {
        font-size: 18px; /* 제목의 글자 크기를 더 크게 조정 */
        font-weight: bold;
        margin-bottom: 15px;
        text-align: center;
    }

    .side-box p {
    	font-size: 15px;
        line-height: 1.5;
        text-align: justify;
    }
</style>
<script>
var result = "${msg}";

if(result == "down"){
	alert("쿠폰이 다운로드 완료되었습니다.");
}else if(result == "alr"){
	alert("이미 다운로드한 쿠폰입니다.");
}
</script>
<c:if test="${sessionScope.id == null }">
   <script>
      alert("로그인 후 이용할 수 있습니다.");
      location.href="/member/memberLogin";
   </script>
 </c:if>
<div class="container14">
    <div class="row justify-content-center coupon-page">
        <div class="side-box">
            <h3>쿠폰 다운로드 안내</h3>
            <p>이 페이지에서는 다양한 할인 쿠폰을 제공합니다. 원하는 쿠폰을 선택하고 다운로드하여 사용하세요. 각 쿠폰의 유효기간을 확인하고, 다운로드 버튼을 클릭하면 쿠폰을 사용할 수 있습니다.</p>
            <p>내 쿠폰은 결제시 목록을 확인할 수 있습니다.</p>
        </div>
        <div class="coupon-container">
            <c:forEach var="coupon" items="${couponList}">
                <form action="downloadCoupon" method="post">
                    <div class="coupon">
                        <h3 class="description">${coupon.description}</h3>
                        <br>
                        <h4 class="expirydate">유효기간 : ${coupon.expirydate}</h4>
                        <input type="hidden" name="description" value="${coupon.description}"/>
                        <input type="hidden" name="expirydate" value="${coupon.expirydate}"/>
                        <input type="hidden" name="couponId" value="${coupon.couponid}"/>
                        <input type="hidden" name="discount" value="${coupon.discount}"/>
                        <input type="hidden" name="minpurchase" value="${coupon.minpurchase}"/>
                        <div class="btn_gr">
                            <button type="submit" class="btn" style="border:none;background:none;color:blue;">다운로드</button>
                        </div>
                    </div>
                </form>
            </c:forEach>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
