<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.gson.Gson"%>

<c:if test="${sessionScope.cart == null }">
	<script>
      alert("로그인 후 이용할 수 있습니다.");
      location.href="/member/memberLogin";
   </script>
</c:if>
<script>
    <%if (request.getAttribute("msg") != null) {%>
    var msg = "<%=request.getAttribute("msg")%>";
    alert(msg);
    <%}%>    
</script>

<style>
.container11 {
	display: flex;
	justify-content: center;
	margin: 50px auto;
}

.product-content-right {
	width: 100%;
}

.footer {
	position: fixed;
	bottom: 0;
	width: 100%;
}

.coupon {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}

.point {
	position: relative; /* fixed 대신 relative로 변경 */
	display: flex;
	align-items: center;
	margin-top: 70px;
}

.coupon label, .point label {
	margin-right: 10px;
	font-weight: bold;
	font-size: 16px;
}

.coupon select, .point input[type="text"] {
	padding: 8px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.coupon input[type="button"], .point input[type="button"] {
	padding: 8px 20px;
	font-size: 14px;
	background-color: #007bff;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	height: 40px;
}

.coupon input[type="button"]:hover, .point input[type="button"]:hover {
	background-color: #0056b3;
}
</style>
<script>
document.addEventListener('DOMContentLoaded', function() {
    var qtyInputs = document.querySelectorAll('.qtyInput');
    var totalAmountElement = document.getElementById('totalAmount'); // 총 결제 금액 요소
    var shippingFee = 3000; // 배송비
    var proceedButton = document.getElementById('proceed'); // 결제 버튼

    function updateTotalAmount() {
        var totalAmount = 0;
        qtyInputs.forEach(function(qtyInput) {
            var unitPriceElement = qtyInput.closest('tr').querySelector('.product-price .amount');
            var unitPrice = parseFloat(unitPriceElement.textContent.replace(/[^\d.-]/g, ''));
            var newQty = parseInt(qtyInput.value);
            var totalPrice = unitPrice * newQty;
            totalAmount += totalPrice;
            qtyInput.closest('tr').querySelector('.product-subtotal .amount').textContent = totalPrice.toLocaleString() + '원';
        });
        totalAmountElement.textContent = (totalAmount + shippingFee).toLocaleString() + '원';
        
     	// 결제 버튼 비활성화 검사
        if (totalAmount === 0) {
            proceedButton.disabled = true;
            proceedButton.style.backgroundColor = '#ccc';
            proceedButton.textContent = '결제';
        } else {
            proceedButton.disabled = false;
            proceedButton.style.backgroundColor = '';
            proceedButton.textContent = '결제';
        }
    }

    qtyInputs.forEach(function(qtyInput) {
        qtyInput.addEventListener('change', function() {
            var inputValue = this.value;
            var pid = this.closest('tr').querySelector('input[name="pid"]').value;
            var originalQty = this.defaultValue; // 변경 전 수량 저장

            $.ajax({
                url: "/cart/qtychange",
                type: "POST",
                data: {
                    qty: inputValue,
                    pid: pid
                },
                success: function(response) {
                    if (response === "재고보다 많은 수량을 선택하셨습니다.\n수량을 줄여주세요.") {
                        qtyInput.value = originalQty; // 수량을 원래대로 돌림
                        updateTotalAmount(); // 총 금액 업데이트
                    } else {
                        console.log("수량 변경 성공");
                        updateTotalAmount();
                        location.reload();
                    }
                },
                error: function() {
                    console.log("수량 변경 실패");
                    qtyInput.value = originalQty; // 수량을 원래대로 돌림
                    updateTotalAmount(); // 총 금액 업데이트
                }
            });
        });
    });

    // 페이지 로드 시 총 결제 금액 초기화
    updateTotalAmount();

    // 쿠폰 목록 JSON 데이터
    var couponList = JSON.parse('<%=new Gson().toJson((List<?>) request.getAttribute("couponList"))%>');

    // 쿠폰 적용 버튼 클릭 이벤트
    var applyCouponButton = document.querySelector('input[name="apply_coupon"]');
    applyCouponButton.addEventListener('click', function() {
        var selectedCouponCode = document.getElementById('coupon_code').value;

        // 선택한 쿠폰 찾기
        var selectedCoupon = couponList.find(coupon => coupon.code === selectedCouponCode);

        if (selectedCoupon) {
            var minPurchase = selectedCoupon.minpurchase;
            var discount = selectedCoupon.discount;

            // 현재 총 금액 가져오기
            var currentTotalAmount = parseFloat(totalAmountElement.textContent.replace(/[^\d.-]/g, ''));

            if (minPurchase === 0 || currentTotalAmount >= minPurchase) {
                // 쿠폰 적용
                if (Number.isInteger(discount)) {
                    var newTotalAmount = currentTotalAmount - discount;
                    totalAmountElement.textContent = newTotalAmount.toLocaleString() + '원';
                    alert('할인 금액 ' + discount.toLocaleString() + '원이 적용되었습니다.');
                } else {
                    var discountPercent = Math.abs(discount);
                    var saleShippingFee = 3000 * discountPercent;
                    var newTotalAmount = Math.floor(currentTotalAmount - (currentTotalAmount * discountPercent) + saleShippingFee);
                    totalAmountElement.textContent = newTotalAmount.toLocaleString() + '원';
                    alert('할인율 ' + (discountPercent * 100).toFixed(1) + '%가 적용되었습니다.');
                }
                // 쿠폰 적용 버튼 비활성화
                applyCouponButton.disabled = true;
                applyCouponButton.style.backgroundColor = '#ccc';
                applyCouponButton.value = '쿠폰 적용됨';
                
                document.getElementById('codecheck').value = selectedCouponCode;
                
            } else {
                alert('쿠폰을 적용하기 위한 최소 구매 금액이 부족합니다.');
            }
        }
    });

    // 포인트 적용 버튼 클릭 이벤트
    var applyPointButton = document.querySelector('input[name="apply_point"]');
    applyPointButton.addEventListener('click', function() {
        var enteredPoint = parseInt(document.getElementById('point').value);
        var sessionPoint = parseInt('<%=session.getAttribute("point")%>');
        
        if (isNaN(enteredPoint) || enteredPoint <= 0) {
            alert('보유 포인트가 부족합니다. 유효한 포인트 값을 입력해 주세요.');
            return;
        }

        if (enteredPoint <= sessionPoint) {
            // 현재 총 금액 가져오기
            var currentTotalAmount = parseFloat(totalAmountElement.textContent.replace(/[^\d.-]/g, ''));

            // 포인트 적용
            var newTotalAmount = currentTotalAmount - enteredPoint;
            totalAmountElement.textContent = newTotalAmount.toLocaleString() + '원';
            alert(enteredPoint.toLocaleString() + ' 포인트가 적용되었습니다.');

            // 포인트 적용 버튼 비활성화
            applyPointButton.disabled = true;
            applyPointButton.style.backgroundColor = '#ccc';
            applyPointButton.value = '포인트 적용됨';
            
            document.getElementById('pointcheck').value = enteredPoint;
        } else {
            alert('포인트가 부족합니다.');
        }     	
    });
});
</script>

<div class="container11">
	<div class="col-md-8">
		<div class="product-content-right">
			<div class="woocommerce">
				<table cellspacing="0" class="shop_table cart">
					<thead>
						<tr>
							<th class="product-remove">삭제</th>
							<th class="product-remove">번호</th>
							<th class="product-thumbnail">상품사진</th>
							<th class="product-name">상품명</th>
							<th class="product-price">가격</th>
							<th class="product-quantity">수량</th>
							<th class="product-subtotal">합계</th>
						</tr>
					</thead>
					<tbody>
						<!-- 카트 목록 데이터 반복 출력 -->
						<c:set var="number"
							value="${pageMaker.totalCount - (pageMaker.criteria.page - 1) * pageMaker.criteria.perPageNum }" />
						<c:forEach var="cart" items="${cartlist}">
							<form method="post" action="/cart/cartdelete">
								<tr class="cart_item">
									<input type="hidden" id="pid" name="pid" value="${cart.pid }">
									<td class="product-remove"><a
										href="/cart/cartdelete?ctid=${cart.ctid }">x</a></td>

									<td>${number }</td>

									<td class="product-thumbnail"><a href="#"><img
											width="145" height="145" alt="poster_1_up"
											class="shop_thumbnail" src="/product_upload/${cart.file1}"></a>
									</td>

									<td class="product-name"><a href="#">${cart.pname}</a></td>

									<td class="product-price"><span class="amount"><fmt:formatNumber
												type="number" value="${cart.productprice }" pattern="#,###" />원</span>
									</td>

									<td class="product-quantity">
										<div class="quantity buttons_added">
											<input type="number" class="input-text qty text qtyInput"
												id="qty" title="Qty" value="${cart.qty}" min="0" step="1">
										</div>
									</td>

									<td class="product-subtotal"><span class="amount"><fmt:formatNumber
												type="number" value="${cart.price * cart.qty}"
												pattern="#,###" />원</span></td>
								</tr>
							</form>
							<c:set var="number" value="${number - 1 }" />
						</c:forEach>
						<!-- 카트 목록 데이터 반복 출력 끝-->
						<tr>
							<td class="actions" colspan="7">
								<div class="coupon">
									<label for="coupon_code">쿠폰 선택</label> <select id="coupon_code"
										name="coupon_code" class="input-text">
										<c:forEach var="coupon" items="${couponList}">
											<option value="${coupon.code}">${coupon.description}</option>
										</c:forEach>
									</select> <input type="button" value="쿠폰적용" name="apply_coupon"
										class="button">
								</div>
								<div class="point">
									<label for="point">포 인 트&nbsp&nbsp&nbsp</label> <input
										type="text" id="point" name="point" class="input-text">
									<input type="button" value="포인트적용" name="apply_point"
										class="button">
								</div>
								<div class="btn-group" style="padding-left: 1100px;">
									<input type="hidden" id="codecheck" name="codecheck" value="">
									<input type="hidden" id="pointcheck" name="pointcheck" value="">
									<button type="button" id="proceed" name="proceed"
										class="add_to_cart_button" style="height: 40px;"
										onclick="location.href='/payment/paymentgate?totalAmount=' + document.getElementById('totalAmount').textContent.replace(/[^\d]/g, '')
								    		+'&code='+document.getElementById('codecheck').value+'&point='+document.getElementById('pointcheck').value">결제</button>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="cart-collaterals">
					<div class="cart_totals">
						<h2>총결제 금액</h2>
						<table cellspacing="0">
							<tbody>
								<tr class="shipping">
									<th>배송비</th>
									<td>3,000원</td>
								</tr>
								<tr class="order-total">
									<th>총결제금액</th>
									<td><strong><span class="amount" id="totalAmount"><fmt:formatNumber
													type="number" value="${totalAmount + 3000}" pattern="#,###" />원</span></strong>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.qtyInput').forEach(function(input) {
        input.addEventListener('change', function() {
            var inputValue = this.value;
            var pid = this.closest('tr').querySelector('input[name="pid"]').value;

            $.ajax({
                url: "/cart/qtychange",
                type: "POST",
                data: {
                    qty: inputValue,
                    pid: pid
                },
                success: function(response) {
                    if (response === "재고보다 많은 수량을 선택하셨습니다.\n수량을 줄여주세요.") {
                        alert(response);
                    } else {
                        console.log("수량 변경 성공");
                        // 필요에 따라 수량 변경 후 추가 작업을 여기에 추가할 수 있습니다.
                    }
                },
                error: function() {
                    console.log("수량 변경 실패");
                }
            });
        });
    });
});
</script>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
