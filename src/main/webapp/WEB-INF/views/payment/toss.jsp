<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<center>
    <h1>TOSS 결제 확인</h1>
    <input type="hidden" id="paymentKey" name="paymentKey" value="${paymentKey }">
	<input type="hidden" id="amount" name="amount" value="${amount }">
	<input type="hidden" id="orderId" name="orderId" value="${orderId }">
    <form method="post">
	    <button onclick="confirmPayment()">결제완료</button>
    </form>
	

    <script>
        async function confirmPayment() {
            var paymentKey = document.getElementById("paymentKey").value;
            var amount = document.getElementById("amount").value;
            var orderId = document.getElementById("orderId").value;

            var apiUrl = 'https://api.tosspayments.com/v1/payments/confirm';

            try {
                const response = await fetch(apiUrl, {
                    method: 'POST',
                    headers: {
                        'Authorization': 'Basic ' + btoa('test_sk_AQ92ymxN342Dd0P9awyPrajRKXvd' + ':'),
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        paymentKey: paymentKey,
                        amount: amount,
                        orderId: orderId
                    })
                });

                if (!response.ok) {
                    throw new Error(`Failed to confirm payment: ${response.status} ${response.statusText}`);
                }

                // 성공적으로 처리된 경우
                console.log('Payment confirmed successfully:', await response.text());
                alert('성공');
             	
            } catch (error) {
                // 오류 처리
                console.error('Failed to confirm payment:', error.message);
                alert('실패');
            }
        }
    </script>
</center>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>