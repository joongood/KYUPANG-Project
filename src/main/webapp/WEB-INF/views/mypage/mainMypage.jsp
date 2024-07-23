<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<c:if test="${sessionScope.id == null || sessionScope.id == ''}">
	<script>
		alert("로그인 후 이용할 수 있습니다.");
		location.href="/member/memberLogin";
	</script>
</c:if>
<style>
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
    <a href="/mypage/mainMypage" class="list-group-item list-group-item-action active">Home</a>
    <a href="/mypage/memberJoinUp" class="list-group-item list-group-item-action">회원정보수정</a>
    <a href="/mypage/translist" class="list-group-item list-group-item-action">구매내역 및 환불</a>
    <a href="/mypage/couponlist" class="list-group-item list-group-item-action">쿠폰목록</a>
    <a href="/mypage/wishlist" class="list-group-item list-group-item-action">위시리스트</a>
  </div>
</div>
<div class="container content-wrapper">    `
    <!-- Main content -->
    <div class="col-md-9 main-content">
      <div class="card">
        <div class="card-header">
          <h2>환영합니다, ${sessionScope.name}님!</h2>
        </div>
        <div class="card-body">
          <p>소중한 고객님, 다시 뵙게 되어 매우 반갑습니다! 저희 쇼핑몰 마이페이지에 오신 것을 진심으로 환영합니다. 이곳에서 고객님은 다양한 기능과 혜택을 누리실 수 있습니다.</p>
          
          <p>먼저, 고객님의 프로필을 최신 상태로 유지해 주세요. 최신 정보를 제공해 주시면 보다 정확하고 신속한 서비스를 제공해 드릴 수 있습니다. 또한, 주문 내역을 확인하고 배송 상태를 추적할 수 있으며, 마음에 드는 상품을 찜 목록에 추가할 수도 있습니다.</p>
          
          <p>지금 저희 쇼핑몰에서는 특별한 이벤트와 할인 행사가 진행 중입니다. 마이페이지에서 회원 전용 할인 쿠폰을 확인하고, 최신 프로모션 소식을 놓치지 마세요. 새로운 시즌 상품이 입고되었으며, 다양한 인기 브랜드의 신상품도 준비되어 있습니다. 빠르게 품절될 수 있으니 서둘러 확인해 보세요!</p>
          
          <p>또한, 저희의 추천 상품 섹션을 통해 고객님의 취향에 맞춘 제품을 발견해 보세요. AI 기반의 개인 맞춤형 추천 시스템으로 고객님께 꼭 맞는 상품을 제안해 드립니다.</p>
          
          <p>쇼핑을 즐기시면서 궁금한 점이나 불편한 사항이 있으시면 언제든지 고객센터를 통해 문의해 주세요. 저희 친절한 고객 지원 팀이 언제나 도움을 드릴 준비가 되어 있습니다.</p>
          
          <p>앞으로도 저희 쇼핑몰과 함께 즐거운 쇼핑 되시길 바라며, 항상 최고의 서비스와 혜택을 제공하기 위해 최선을 다하겠습니다. 감사합니다!</p>
          
          <p><strong>지금 바로 최신 할인 혜택과 이벤트를 확인하세요!</strong></p>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
