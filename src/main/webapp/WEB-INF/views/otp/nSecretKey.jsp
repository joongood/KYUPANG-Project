<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<script>
var popupX = (window.screen.width / 2) - (950 / 2);
var popupY = (window.screen.height / 2) - (580 / 2);

function popup() {
    var ctx = "${pageContext.request.contextPath}"; // 컨텍스트 경로를 가져옵니다.
    var popupWindow = window.open("", "view", "width=950,height=580,left="+popupX+",top="+popupY+",resizable=no");

    popupWindow.document.write(`
        <html>
            <head>
                <style>
                    body {
                        margin: 0;
                        overflow: hidden;
                    }
                    img {
                        width: 100%;
                        height: 100%;
                        object-fit: contain;
                    }
                </style>
            <title>OTP 등록방법</title>
            </head>
            <body>
                <img src='` + ctx + `/img/otpuse.PNG'>
            </body>
        </html>
    `);

    // 팝업 창의 크기를 고정합니다.
    popupWindow.addEventListener('resize', function() {
        popupWindow.resizeTo(950, 580);
    });
}
</script>
<script>
	var msg = "${msg}"; 
	
	//로그인 정보가 잘못 되었을 경우
	if(msg != ""){
		alert(msg);
	}
</script>

<center>
<form action="/otp/nvalidateOTP" method="get">
    <br><h1>OTP 생성</h1>
  	<input type="text" name="secretKey" value="${key }"/>
    <input type="text" name="otp"/><br><br>
    <input class="btn-warning" type="button" value="otp 등록법" onclick="popup()">
    <br><br>
    <button type="submit">OTP 검증</button>    
	<br><br>
</form>

</center>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
