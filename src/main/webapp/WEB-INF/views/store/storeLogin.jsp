<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script>
	var msg = "${msg}"; 
	
	//로그인 정보가 잘못 되었을 경우
	if(msg != ""){
		alert(msg);
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
        <h2 class="text-center mb-4">가맹점 로그인</h2>
        <!-- 일반 로그인 폼 -->
        <form action="/store/storeLogin" method="POST">
            <div class="form-group">
                <input type="text" class="form-control" name="semail" placeholder="이메일을 입력하세요.">
            </div>
            <div class="form-group">
                <input type="password" class="form-control" name="spassword" placeholder="비밀번호를 입력하세요.">
            </div>
            <button type="submit" class="btn btn-primary btn-block login-btn">로그인</button>
        </form>
        <hr>
        <p class="text-center">또는</p>
        <button type="button" onclick="location.href='/store/storeJoin';" class="btn btn-secondary btn-block join-btn">가맹점 신청</button>
    </div> 
</body>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>