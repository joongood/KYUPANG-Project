<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
function closePopup() {
    if (window.opener) {
        window.opener.location.href = '/'; // 메인 페이지를 인덱스 페이지로 리디렉션
        alert("결제가 완료되었습니다.")
    }
    window.close(); // 현재 창을 닫는 JavaScript 함수
}
</script>
<center>

<h3>결제가 성공적으로 이루어 졌습니다.</h3>
<button onclick="closePopup()">닫기</button>

</center>
