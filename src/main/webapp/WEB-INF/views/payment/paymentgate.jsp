<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
    .payment-option {
        display: none; /* 처음에는 결제 옵션 숨김 */
    }
    .payment-option.active {
        display: block; /* 선택된 결제 옵션만 표시 */
    }
    .summary-section {
        margin-top: 20px;
        border: 1px solid #ccc;
        padding: 15px;
        border-radius: 5px;
    }
    /* 여백 추가 */
    .container12{
    	margin-left : 500px;
    	margin-top : 100px;
    	margin-bottom: 100px;	
    }
</style>
<div class="container12">
    <div class="row">
        <div class="col-md-8">
            <h2 class="text-center mt-4 mb-4">결제 정보 입력</h2>
            <br>
            <br>
            <!-- 결제 폼 -->
            <form id="paymentForm" action="#" method="POST">
            	<input type="hidden" id="payprice" name="payprice" value="${totalAmount}">
                <input type="hidden" id="odid" name="odid" value="${uuid }">
                <input type="hidden" id="cart" name="cart" value="${cart.cart }">
                <input type="hidden" id="code1" name="code1" value="${param.code }">
                <input type="hidden" id="point" name="point" value="${param.point }">
            	<div class="form-group">
                	<label for="check" style="font-size: 12px;color:#A7A7C9">회원정보 불러오기</label>
                    <input type="checkbox" id="check" name="check" onclick="minformation()">
                </div> 
            
            	<div class="form-group">
                    <label for="buyer">구매자</label>
                    <input type="text" class="form-control" id="buyer" name="buyer" placeholder="무통장 결제시 입금자명과 이름이 동일해야합니다" value="" required>
                </div>        
            
                <div class="form-group">
                    <label for="amount">결제 금액</label>
                    <input type="text" class="form-control" id="amount" name="amount" placeholder="결제할 금액을 입력하세요" value="<fmt:formatNumber value='${totalAmount}' pattern='#,###'/>원">
                </div>

                <!-- 주소 입력 필드 추가 -->
                <div class="form-group">
                    <label for="zipcode">우편번호</label>
                    <input type="text" class="form-control" id="zipcode" name="zipcode" placeholder="우편번호를 입력해주세요." required>
                    <button type="button" class="btn btn-primary" onclick="openZipSearch()">주소검색</button>
                </div>
                <div class="form-group">
                    <label for="address">주소</label>
                    <input type="text" class="form-control" id="address" name="address" placeholder="주소를 입력해주세요." required>
                </div>
                <div class="form-group">
                    <label for="addressdetail">상세주소</label>
                    <input type="text" class="form-control" id="addressdetail" name="addressdetail" placeholder="상세주소를 입력해주세요.">
                </div>
                <!-- 결제 수단 선택 버튼 -->
				<div class="form-group">
				    <label>결제 수단 선택</label><br>
				    <div class="btn-group btn-group-toggle" data-toggle="buttons">
				        <!-- 카카오페이 -->
				        <label class="btn btn-primary active" id="kakaoPayBtn" style="background:none; border:none; box-shadow: none; height:10px;">
				            <input type="radio" name="paymentOption" autocomplete="off" checked>
				            <img src="../img/kakao_logo.png" alt="카카오페이 로고">
				        </label>
				        <!-- 토스페이 -->
				        <label class="btn btn-primary" id="tossPayBtn" style="background:none; border:none; box-shadow: none;">
				            <input type="radio" name="paymentOption" autocomplete="off">
				            <img src="../img/toss_logo.png" alt="토스페이 로고">
				        </label>
						<label class="btn btn-primary" id="bankTransferBtn" style="background:none; border:none; box-shadow: none; height:10px;">
                            <input type="radio" name="paymentOption" autocomplete="off">
                            <img src="../img/bankTransfer.png" alt="토스페이 로고" style="height:40px;">
                        </label>
				    </div>
				</div>
                <!-- 카카오페이 결제 옵션 -->
                <div class="payment-option active" id="kakaoPayOption">
                    <h3 class="mt-3">카카오페이 결제 정보</h3>
                    <!-- 여기에 카카오페이 관련 정보 입력 폼 추가 -->
                    <button type="button" class="btn btn-success mt-3" onclick="kakaopay()"><i class="fas fa-credit-card"></i> 카카오페이로 결제하기</button>
                </div>

                <!-- 토스페이 결제 옵션 -->
                <div class="payment-option" id="tossPayOption">
                    <h3 class="mt-3">토스페이 결제 정보</h3>
                    <!-- 여기에 토스페이 관련 정보 입력 폼 추가 -->
                    <button type="button" class="btn btn-success mt-3" onclick="toss()"><i class="fas fa-mobile-alt"></i> 토스페이로 결제하기</button>
                </div>

                <!-- 무통장 입금 정보 -->
                <div class="payment-option" id="bankTransferOption">
                    <h3 class="mt-3">무통장 입금 정보</h3>
                    <div class="form-group">
                        <label for="bankSelect">은행 선택</label>
                        <select class="form-control" id="bankSelect" name="bankSelect">
                            <option value="">은행을 선택하세요</option>
                            <option value="국민은행">국민은행</option>
                            <option value="신한은행">신한은행</option>
                            <option value="우리은행">우리은행</option>
                            <option value="기업은행">기업은행</option>
                            <option value="KEB하나은행">KEB하나은행</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="bankAccount">은행 계좌 번호</label>
                        <input type="text" class="form-control" id="bankAccount" name="bankAccount" placeholder="무통장 입금을 위한 은행 계좌 번호" readonly>
                    </div>
                    <button type="submit" class="btn btn-success mt-3"><i class="fas fa-coins"></i> 무통장 입금하기</button>
                </div>
            </form>

            <!-- 상품 정보 요약 -->
            <div class="summary-section mt-4" id="summarySection">
                <h3>구매 상품 정보 요약</h3>
                <c:choose>
                	<c:when test="${productcount != 1 }">
                		<p><strong>상품명:</strong> <span id="productName">${cart.pname } 외 ${productcount-1 }개</span></p>
                		<input type="hidden" id="orderName" name="orderName" value="${cart.pname } 외 ${productcount-1}개">
                	</c:when>
                	<c:otherwise>
                		<p><strong>상품명:</strong> <span id="productName">${cart.pname }</span></p>
                		<input type="hidden" id="orderName" name="orderName" value="${cart.pname }">
                	</c:otherwise>
                </c:choose>
                <p><strong>결제 금액:</strong> <span><fmt:formatNumber value='${totalAmount}' pattern='#,###'/>원</span></p>
                <p><strong>주문 번호:</strong> <span>${uuid }</span></p>
                <input type="hidden" id="qty" name="qty" value="${productcount }">
            </div>
        </div>
    </div>
</div>
<script>
    // 결제 옵션 선택 처리
    $('#kakaoPayBtn').click(function() {
        $('.payment-option').removeClass('active');
        $('#kakaoPayOption').addClass('active');
        showSummary('카카오페이');
    });

    $('#tossPayBtn').click(function() {
        $('.payment-option').removeClass('active');
        $('#tossPayOption').addClass('active');
        showSummary('토스페이');
    });

    $('#bankTransferBtn').click(function() {
        $('.payment-option').removeClass('active');
        $('#bankTransferOption').addClass('active');
        showSummary('무통장 입금');
    });
    
 	// 은행 계좌 번호 설정 함수
    $('#bankSelect').change(function() {
        var bankAccounts = {
            '국민은행': '000000-00-000000',
            '신한은행': '111111-11-111111',
            '우리은행': '222222-22-222222',
            '기업은행': '333333-33-333333',
            'KEB하나은행': '444444-44-444444'
        };
        var selectedBank = $(this).val();
        $('#bankAccount').val(bankAccounts[selectedBank] || '');
    });
 	
 	//회원정보 불러오기
 	function minformation(){
 		var checkBox = document.getElementById("check");
 	    var buyer = document.getElementById("buyer"); // 구매자명 입력란의 ID에 맞게 변경하세요
 	   	var zipcode = document.getElementById("zipcode");
 	  	var address = document.getElementById("address");
 	 	var addressdetail = document.getElementById("addressdetail");

 	    if (checkBox.checked == true) {
 	        // 체크박스가 체크되었을 때, 구매자명 입력란에 회원의 이름을 넣음
 	        buyer.value = '${member.mname}';
 	       	zipcode.value = '${member.zipcode}';
 	       	address.value = '${member.address}';
 	      	addressdetail.value = '${member.addressdetail}';	     
 	    } else {
 	        // 체크박스가 체크 해제되었을 때, 구매자명 입력란을 초기화하거나 다른 처리를 수행할 수 있음
 	        buyer.value = ''; // 혹은 다른 초기화 로직을 추가할 수 있습니다.
 	       	zipcode.value = '';
 	      	address.value = '';
 	     	addressdetail.value = '';
 	    }
 	}
</script>
<script src="https://js.tosspayments.com/v1/payment"></script>
<script>
function toss(){
	var payprice = document.getElementById("payprice").value;
	var odid = document.getElementById("odid").value;
	var buyer = document.getElementById("buyer").value;
	var orderName = document.getElementById("orderName").value;
	var zipcode = document.getElementById("zipcode").value;
	var address = document.getElementById("address").value;
	var addressdetail = document.getElementById("addressdetail").value;
	var cart = document.getElementById("cart").value;
	var code = document.getElementById("code1").value;
	var point = document.getElementById("point").value;
	
	$.ajax({
        url: "/payment/tosssave", // 전송받을 페이지 경로
        type: "POST", // 데이터 전송 방식
        dataType: "text", // 서버 응답의 형식
        data: {
        	buyer: buyer,
        	zipcode: zipcode,
        	address: address,
            addressdetail: addressdetail,
            cart: cart,
            code: code,
            point: point
        },
        error: function () { // 실패일 경우
            console.log("실패");
        },
        success: function (response) { // 성공일 경우
            console.log("성공");
        }
    });
	
	// 구매자명이나 주소 관련 필드 중 하나라도 비어 있는 경우
    if (buyer.trim() === '' || zipcode.trim() === '' || address.trim() === '') {
        alert('구매자 또는 주소 관련 정보가 비어 있습니다.');
        return; // 결제 요청을 중지하고 함수를 종료
    }
	
	// 클라이언트 키로 객체 초기화
    var clientKey = 'test_ck_ZLKGPx4M3MPaERzKmvoe8BaWypv1';
    var tossPayments = TossPayments(clientKey);

    // 결제창 띄우기
    tossPayments.requestPayment('카드', {
      amount: document.getElementById("payprice").value,
      orderId: odid,
      orderName: orderName,
      customerName: buyer,
      successUrl: "http://localhost:8080/payment/toss",
      failUrl: 'http://localhost:8080/',
    })
    .catch(function (error) {
      if (error.code === 'USER_CANCEL') {
        // 결제 고객이 결제창을 닫았을 때 에러 처리
      } else if (error.code === 'INVALID_CARD_COMPANY') {
        // 유효하지 않은 카드 코드에 대한 에러 처리
      }
    });
}
//카카오페이
var popupX = (window.screen.width / 2) - (600 / 2);
var popupY = (window.screen.height / 2) - (700 / 2);

function kakaopay(){
	$.ajax({ 
		url : '/payment/kakaopay',
		type : 'post',
		headers: {
			"Content-Type" : "application/json"
		},
		data:JSON.stringify({
			odid : $("input[name='odid']").val(),
			buyer : $("input[name='buyer']").val(),
			payprice : $("input[name='payprice']").val(),
			zipcode : $("input[name='zipcode']").val(),
			address : $("input[name='address']").val(),
			addressdetail : $("input[name='addressdetail']").val(),
			orderName : $("input[name='orderName']").val(),
			qty : $("input[name='qty']").val(),
			code : $("input[name='code1']").val(),
			point : $("input[name='point']").val(),
			
		}),		
		success : function(response){
			//alert(response.next_redirect_pc_url); //확인 후 주석처리
			var popupUrl = response.next_redirect_pc_url;
		    window.open(popupUrl, "view", "width=550,height=700,left="+popupX+",top="+popupY+",resizable=no");
		}
	});
	// 팝업 창의 크기를 고정합니다.
    popupWindow.addEventListener('resize', function() {
        popupWindow.resizeTo(550, 700);
    });
}
</script>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
