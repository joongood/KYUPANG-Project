<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script>
	<% if (request.getAttribute("msg") != null) { %>
	var msg = "<%= request.getAttribute("msg") %>";
	alert(msg);
	<% } %>	
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
        <h2 class="text-center mb-4">로그인</h2>
        <!-- 일반 로그인 폼 -->
        <form action="/member/memberLogin" method="POST">
            <div class="form-group">
                <input type="text" class="form-control" name="memail" placeholder="이메일을 입력하세요.">
            </div>
            <div class="form-group">
                <input type="password" class="form-control" name="mpassword" placeholder="비밀번호를 입력하세요.">
            </div>
            <button type="submit" class="btn btn-primary btn-block login-btn">로그인</button>
        </form>
        <hr>
        <p class="text-center">또는</p>
        <button type="button" onclick="location.href='/member/memberJoin';" class="btn btn-secondary btn-block join-btn">회원가입</button>
        <!-- 카카오 로그인 버튼 -->
        <button type="button" onclick="kakaoLogin()" class="btn btn-warning btn-block social-login-btn">카카오 로그인</button>
        <!-- 네이버 로그인 버튼 -->
        <button type="button" id="naverIdLogin_loginButton" class="btn btn-success btn-block social-login-btn">네이버 로그인</button>
    </div> 
</body>
<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
Kakao.init('b891f27f0459dc153a5bfc5345a4b93d'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
	Kakao.Auth.login({
		success: function (response) {
			Kakao.API.request({
			url: '/v2/user/me',
				success: function (response) {
					//회원가입 처리 및 세션 처리
					$.ajax({
					url: "/member/kakao",
					type: "get",
					dataType: "text",
					data: "memail="+response.kakao_account.email,
						success:function(num){
						if(num == 0){
							location.href="/member/s_memberJoinUp"; //수정 페이지로 이동
						}else{
							location.href="/"; //아이디가 있을경우 그냥 로그인 처리
						}						
						}
					});
				},
				fail: function (error) {
					console.log(error)
				},
				})
		},
		fail: function (error) {
		console.log(error)
		},
	});
}

</script>

<!-- 네이버 스크립트 -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script>
// 로그인 페이지 활성
var naverLogin = new naver.LoginWithNaverId(
	{
		clientId: "RfdUYXXGYp4GR7HhbVpv", //내 애플리케이션 정보에 cliendId를 입력해줍니다.
		callbackUrl: "http://localhost:8080:8080/member/naverLogin", // 내 애플리케이션 API설정의 Callback URL 을 입력해줍니다.
		isPopup: false,
		callbackHandle: true
	}
);	
naverLogin.init();
</script>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>