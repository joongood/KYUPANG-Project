<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
   .join-container{
      margin: 0 auto;
      width: 500px;
      padding-top: 3%;
      padding-bottom: 3%;
   }
</style>
<script>
   var msg = "${msg}"; 
   
   //로그인 정보가 잘못 되었을 경우
   if(msg != ""){
      alert(msg);
   }
</script>
<script>
//비밀번호 확인 js
$(document).ready(function(){
    // 비밀번호 입력란 값이 변경될 때마다 실행
    $("#spassword, #re_pass").keyup(function(event){    
        // 비밀번호 입력란과 비밀번호 확인 입력란의 값 가져오기
        var password = $("#spassword").val();
        var confirmPassword = $("#re_pass").val();

        // 비밀번호와 비밀번호 확인이 일치하는지 확인
        if(password == confirmPassword) {
            // 일치할 경우 메시지를 파란색으로 표시
            $("#pass_check").html("<font color='blue'>비밀번호가 일치합니다.</font>");
        } else {
            // 불일치할 경우 메시지를 빨간색으로 표시
            $("#pass_check").html("<font color='red'>비밀번호가 일치하지 않습니다.</font>");           
        }
        
        if(password != confirmPassword) {
            // 폼 제출 방지
            event.preventDefault();
        }
    });
});
</script>

<script>
   //이메일 확인 js
   $(document).ready(function(){
      $("#semail").keyup(function(event){      
         if (!(event.keyCode >=37 && event.keyCode<=40)) {
            $(this).val($(this).val().replace(/[^_a-z0-9@.]/gi,"")); //@와 .(점)을 포함하여 영어, 숫자, _만 가능
         }
      	 // 인증번호 전송 버튼을 비활성화
         var SendEmailBtn = document.getElementById("SendEmailBtn");
         SendEmailBtn.disabled = true;
         
         // AJAX를 사용하여 서버로 이메일 전송
         $.ajax({
            url: "/store/emailCheck", // 서버로 전송할 경로
            type: "get", // 데이터 전송 방식
            dataType: "text",
            data: "semail="+$("#semail").val(), // 전송할 데이터: 입력한 이메일
            error:function(){ // 요청이 실패한 경우
               alert("요청 실패");
            },
            success:function(num){ // 요청이 성공한 경우
               var msg = ""; // 메시지 초기화
               if(num == "1") {
                  msg = "<font color=red>이미 등록된 이메일입니다.</font>";                  
               }else if(num == "0") {
                  msg = "<font color=blue>사용 가능한 이메일입니다.</font>";
                  SendEmailBtn.disabled = false; //인증번호 전송 버튼 활성화
               }
               $("#email_result").html(msg); // 메시지를 출력할 요소에 메시지 삽입
            }
         });   
      });
   });   
</script>

<script>
   //사업자 등록번호 확인 js
   $(document).ready(function(){
      $("#bnumber").keyup(function(event){
         $.ajax({
            url: "/store/bnumberCheck", // 서버로 전송할 경로
            type: "get", // 데이터 전송 방식
            dataType: "text",
            data: "bnumber="+$("#bnumber").val(), // 전송할 데이터: 입력한 이메일
            error:function(){ // 요청이 실패한 경우
               alert("요청 실패");
            },
            success:function(num){ // 요청이 성공한 경우
               var msg = ""; // 메시지 초기화
               if(num == "1") {
                  msg = "<font color=red>이미 등록된 사업자 등록번호입니다.</font>";
                  $("#bnumberButton").prop('disabled', true); // 사업자 인증 버튼 비활성화
               }else{
                 $("#bnumberButton").prop('disabled', false); // 사업자 인증 버튼 활성화
               }
               
               $("#bnumber_result").html(msg); // 메시지를 출력할 요소에 메시지 삽입
            }
         });   
      });
   });   
</script>
<script>
   //email 전송 js
   function sendEmail(semail){
      $(document).ready(function(){
         $.ajax({
            url: "/store/email", //전송 페이지 경로
            type: "get", //데이터 전송 방식
            dataType: "text",
            data: "semail="+semail,
            error:function(){ //실패일 경우
               alert("실패");
            },
            success:function(str){ //성공일 경우
               if(str == "success"){
                  alert("메일 발송되었습니다.\n인증번호를 확인후 기입하세요.");
               }else{
                  alert("메일 발송 실패");   
               }            
            }
         });   
      });
   } 
</script>
<script>
   //이메일 인증 확인 js
   function checkEmail(email){
      $(document).ready(function(){
         $.ajax({
            url: "/store/ok", //전송 페이지 경로
            type: "get", //데이터 전송 방식
            dataType: "text",
            data: "str="+email,
            error:function(){ //실패일 경우
               alert("실패");
            },
            success:function(str){ //성공일 경우
               if(str == "yes"){
                  alert("인증번호가 확인되었습니다.\n사업자 인증이 가능합니다.");
                  identification.value = "Y";
                  var bnumberButton = document.getElementById("bnumberButton");
                  bnumber.disabled = false;
                  bnumberButton.disabled = false;
               }else{
                  alert("인증번호를 잘못 입력하셨습니다.");
               }            
            }
         });   
      });
   }
</script>
<script>
//사업자 등록번호 확인 js
function bnum_check(){
   let num = document.getElementById('bnumber').value; //사업자번호
   var data = {
       "b_no": [num] // 사업자번호 "xxxxxxx" 로 조회 시,
      }; 
      
   $.ajax({
     url: "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=%2Fg0d1tv%2FITVmpcWHsDmXB18iM8umRt4XF5eBdYr8ui3xIJtVDggGt0XxHRhr3ru2Fh3vTzMiriuFs5fwudxW8A%3D%3D",  // serviceKey 값을 xxxxxx에 입력
     type: "POST",
     data: JSON.stringify(data), // json 을 string으로 변환하여 전송
     dataType: "JSON",
     contentType: "application/json",
     accept: "application/json",
     success: function(result) {
        //console.log(data.b_no);
          //console.log(result.data[0]); 전체객체 뽑기
          console.log(result.data[0]['b_stt_cd']); //사업자 01 번 호출
          let valid = result.data[0]['b_stt_cd'];

          if(valid=='01'){
             alert("사용가능한 사업자 등록번호입니다.\notp가입이 가능합니다.");
             bnumberok.value = "Y";
             var otpButton = document.getElementById("otpButton");
             otpButton.disabled = false;
          }else {
             alert("사업자 등록번호를 다시 입력해주세요.");
          }

      },
     error: function(result) {
         console.log(result.responseText); //responseText의 에러메세지 확인
     }
   });
}
</script>

<script>
   //otp 고유번호 생성
   $(document).ready(function(){
      $("#generateKeyButton").click(function(){
         $.ajax({
            url: "/otp/generateSecretKey",
            type: "get",
            success: function(response){
               // response.key에 비밀 키가 포함되어 있다고 가정합니다.
               $("#secretkey").val(response.key);
            },
            error: function(){
               alert("키 생성 실패");
            }
         });
      });
   });
</script>
<script>
   //otp 인증
   $(document).ready(function(){
      $("#otpButton").click(function(){
         var otp = document.getElementById("otp").value;
         var secretKey = document.getElementById("secretkey").value;
         $.ajax({
            url: "/otp/validateOTP",
            type: "post", // POST 메서드로 변경
            dataType: "text",
            data: {
                secretKey: secretKey,
                otp: otp
            },
            success: function(data){
                if (data.trim() === "true") {
                    alert("인증 성공");
                    var joinbutton = document.getElementById("joinbutton");
                    joinbutton.disabled = false;
                } else {
                    alert("인증 실패\nOTP등록법을 클릭후 방법을 확인해주세요.");
                }
            },
            error: function(){
                alert("인증 실패\nOTP등록법을 클릭후 방법을 확인해주세요.");
            }
         });
      });
   });
</script>
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
<body>
   <div class="join-container">
      <h2 align="center">가맹점 회원가입</h2>
      <br>
      <form method="POST" onsubmit="return store_modify()">
         <input type="hidden" id="identification" name="identification" value="N">
         <input type="hidden" id="bnumberok" name="bnumberok" value="N">
         <div class="form-group">
             <label for="semail">이메일</label>
             <input type="email" class="form-control" id="semail" name="semail" required>
             <input type="button" id="SendEmailBtn" class="btn btn-primary" value="인증번호 전송" onclick="sendEmail(semail.value)">                          
         </div>
         <span id="email_result"></span>         
         <br>
           <div class="form-group">
               <label for="check_email">인증번호</label>
               <input type="text" class="form-control" id="check_email" name="check_email" required>
               <input type="button" class="btn btn-primary" value="인증번호 확인" onclick="checkEmail(check_email.value)">
           </div>
           <br>
           <div class="form-group">
               <label for="spassword">비밀번호</label>
               <input type="password" class="form-control" id="spassword" name="spassword" required>
           </div>
           <br>
           <div class="form-group" style="margin:0">
              <label for="password">비밀번호확인</label>
              <input type="password" class="form-control" id="re_pass" name="re_pass" required>                        
           </div>
           <br>
           <div class="form-group">
               <label for="mutual">상호명</label>
               <input type="text" class="form-control" id="mutual" name="mutual" required>
           </div>
           <br>
           <div class="form-group">
               <label for="ownername">대표자명</label>
               <input type="text" class="form-control" id="ownername" name="ownername" required>
           </div>
           <br>
           <div class="form-group">
              <label for="bnumber">사업자 등록번호</label>
              <input type="text" class="form-control" id="bnumber" name="bnumber" placeholder="이메일 인증을 먼저 진행해주세요." required disabled>
              <input type="button" class="btn btn-primary" id="bnumberButton" value="사업자 인증" onclick="bnum_check()" disabled>
           </div>
           <span id="bnumber_result"></span>
           <br>
           <div class="form-group">
               <label for="sphone">대표번호</label>
               <input type="tel" class="form-control" id="sphone" name="sphone" required>
           </div>
           <br>
           <div class="form-group">
               <label for="zip_code">우편번호</label>
               <input type="text" class="form-control" id="zipcode" name="zipcode" required>
               <button type="button" class="btn btn-primary" onclick="openZipSearch()">주소검색</button>
           </div>
           <br>
           <div class="form-group">
               <label for="address">주소</label>
               <input type="text" class="form-control" id="address" name="address" required>
           </div>
           <br>
           <div class="form-group">
               <label for="address_detail">상세주소</label>
               <input type="text" class="form-control" id="addressdetail" name="addressdetail">
           </div>
           <br>
           <div class="form-group">
            <label for="secretKey">OTP 고유번호</label>
            <input type="text" class="form-control" id="secretkey" name="secretkey" readonly>
            <button type="button" class="btn btn-primary" id="generateKeyButton">OTP 고유번호 생성</button>         
         </div>
         <input align=right class="btn-warning" type="button" value="otp 등록법" onclick="popup()">
         <br>
         <div class="form-group">
            <label for="otp">OTP</label>
            <input type="text" class="form-control" id="otp" name="otp" placeholder="사업자 인증을 먼저 진행해주세요." required>
            <button type="button" class="btn btn-primary" id="otpButton" disabled>OTP 인증</button>
         </div>
         <br>
           <button type="submit" class="btn btn-primary" id="joinbutton" disabled>가입하기</button>
       </form>
   </div>
</body>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>