<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script>
	<% if (request.getAttribute("msg") != null) { %>
	var msg = "<%= request.getAttribute("msg") %>";
	alert(msg);
	<% } %>	
</script>
<script>
   $(document).ready(function(){
      $("#memail").keyup(function(event){      
         if (!(event.keyCode >=37 && event.keyCode<=40)) {
            $(this).val($(this).val().replace(/[^_a-z0-9@.]/gi,"")); //@와 .(점)을 포함하여 영어, 숫자, _만 가능
         }
         
         // 인증번호 전송 버튼을 비활성화
         var SendEmailBtn = document.getElementById("SendEmailBtn");
         SendEmailBtn.disabled = true;
         
         // AJAX를 사용하여 서버로 이메일 전송
         $.ajax({
            url: "/member/emailCheck", // 서버로 전송할 경로
            type: "get", // 데이터 전송 방식
            dataType: "text",
            data: "memail="+$("#memail").val(), // 전송할 데이터: 입력한 이메일
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
   function sendEmail(memail){
      $(document).ready(function(){
         $.ajax({
            url: "/member/email", //전송 페이지 경로
            type: "get", //데이터 전송 방식
            dataType: "text",
            data: "memail="+memail,
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
   
   function checkEmail(email){
      $(document).ready(function(){
         $.ajax({
            url: "/member/ok", //전송 페이지 경로
            type: "get", //데이터 전송 방식
            dataType: "text",
            data: "str="+email,
            error:function(){ //실패일 경우
               alert("실패");
            },
            success:function(str){ //성공일 경우
               if(str == "yes"){
                  alert("인증번호가 확인되었습니다.");
                  identification.value = "Y";
               }else{
                  alert("인증번호를 잘못 입력하셨습니다.");
               }            
            }
         });   
      });
   }
</script>
<script>
$(document).ready(function(){
    // 비밀번호 입력란 값이 변경될 때마다 실행
    $("#mpassword, #re_pass").keyup(function(event){    
        // 비밀번호 입력란과 비밀번호 확인 입력란의 값 가져오기
        var password = $("#mpassword").val();
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
<body>
   <div class="join-container">
      <h2 align="center">회원가입</h2>
      <br>
      <form method="POST" onsubmit="return member_modify();">
          <input type="hidden" id="identification" name="identification" value="N">
		  <div class="form-group">
		    	<label for="memail">이메일</label>
		    	<input type="email" class="form-control" id="memail" name="memail" >
		    	<input type="button" id="SendEmailBtn" class="btn btn-primary" value="인증번호 전송" onclick="sendEmail(memail.value)" disabled>
		  </div>
         <span id="email_result"></span>         
         <br>
         <br>
           <div class="form-group">
               <label for="check_email">인증번호</label>
               <input type="text" class="form-control" id="check_email" name="check_email">
               <input type="button" class="btn btn-primary" value="인증번호 확인" onclick="checkEmail(check_email.value)">
           </div>
           <br>           
           <div class="form-group">
              <label for="mpassword">비밀번호</label>
              <input type="password" class="form-control" id="mpassword" name="mpassword">
             </div>
             <br>
           <div class="form-group" style="margin:0">
              <label for="password">비밀번호확인</label>
              <input type="password" class="form-control" id="re_pass" name="re_pass">                        
           </div>
           <br>
           <div>
              <span id="pass_check"><br></span>
           </div>
           <br>
           <div class="form-group">
               <label for="mname">이름</label>
               <input type="text" class="form-control" id="mname" name="mname">
           </div>
           <br>
           <div class="form-group">
               <label for="mage">생년월일</label>
               <input type="date" class="form-control" id="mage" name="mage">
           </div>
           <br>
           <div class="form-group">
               <label for="mgender">성별</label>
               <select class="form-control" id="mgender" name="mgender">
                   <option value="남자">남자</option>
                   <option value="여자">여자</option>
               </select>
           </div>
           <br>
           <div class="form-group">
               <label for="mphone">전화번호</label>
               <input type="tel" class="form-control" id="mphone" name="mphone">
           </div>
           <br>
           <div class="form-group">
               <label for="zip_code">우편<br>번호</label>
               <input type="text" class="form-control" id="zipcode" name="zipcode">
               <button type="button" class="btn btn-primary" onclick="openZipSearch()">주소검색</button>
           </div>
           <br>
           <div class="form-group">
               <label for="address">주소</label>
               <input type="text" class="form-control" id="address" name="address">
           </div>
           <br>
           <div class="form-group">
               <label for="address_detail">상세주소</label>
               <input type="text" class="form-control" id="addressdetail" name="addressdetail">
           </div>
           <br>
           <button type="submit" class="btn btn-primary">가입하기</button>
       </form>
   </div>
</body>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>