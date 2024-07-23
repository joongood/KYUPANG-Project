<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>OTP 생성</title>
</head>
<script>
	var msg = "${msg}"; 
	var storeStatus = "${sessionScope.storestatus}";
	
	//OTP인증 완료된 경우
	if(msg != ""){
		alert(msg);
	}
	
	//회원 상태가 정상이 아닌 경우
	if (storeStatus !== "정상") {
		alert("회원님 아이디는 "+storeStatus+"상태입니다.");
        location.href = "/";
    }
</script>
<style>
	.login-container{
		margin: 0 auto;
		width: 500px;
		padding-top: 3%;
		padding-bottom: 3%;
	}
</style>
<body>
	<div class="login-container">
		<h2 class="text-center mb-4">OTP 인증</h2>
		<form action="/otp/StoreValidateOTP" method="post">
			<div class="form-group">
                <input type="hidden" class="form-control" name="secretKey" value="${key }"">
            </div>
            <div class="form-group">
                <input type="text" class="form-control" name="otp" placeholder="인증키를 입력하세요.">
            </div>
		    <button type="submit" class="btn btn-primary btn-block login-btn">OTP 검증</button>		
		</form>
   	</div>
</body>
</html>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
