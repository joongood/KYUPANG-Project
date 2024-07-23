<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="/WEB-INF/views/admin/include_admin/common.jsp" %>
</head>
<script>
	var result = "${msg}";

	if(result == "add"){
		alert("회원추가가 완료되었습니다.");
		window.close();
	}
</script>
<script>
   $(document).ready(function(){
      $("#memail").keyup(function(event){      
         if (!(event.keyCode >=37 && event.keyCode<=40)) {
            $(this).val($(this).val().replace(/[^_a-z0-9@.]/gi,"")); //@와 .(점)을 포함하여 영어, 숫자, _만 가능
         }
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
               }
               $("#email_result").html(msg); // 메시지를 출력할 요소에 메시지 삽입
            }
         });   
      });
   });   
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
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
    	<div class="content-wrapper" style="width:600px; height:850;">
	     <h2 align="center" style="padding-top:5%;">회원추가</h2>
	     <br>
	     <form method="POST" onsubmit="return admin_member_modify();">
			  <div class="form-group">
		    	 <label for="memail">이메일</label>
		    	 <input type="email" class="form-control" id="memail" name="memail" >
			  </div>
		      <span id="email_result"></span>         
		      <br>
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
	          <div>
	          <span id="pass_check"><br></span>
	          <br>
		      <br> 
	          </div>
	          <div class="form-group">
	              <label for="mname">이름</label>
	              <input type="text" class="form-control" id="mname" name="mname">
	          </div>
	          <div class="form-group">
	              <label for="mage">생년월일</label>
	              <input type="date" class="form-control" id="mage" name="mage">
	          </div>
	          <div class="form-group">
	              <label for="mgender">성별</label>
	              <select class="form-control" id="mgender" name="mgender">
	                  <option value="남자">남자</option>
	                  <option value="여자">여자</option>
	              </select>
	          </div>
	          <div class="form-group">
	              <label for="mphone">전화번호</label>
	              <input type="tel" class="form-control" id="mphone" name="mphone">
	          </div>
	          <div class="form-group">
	              <label for="zip_code">우편번호</label>
	              <input type="text" class="form-control" id="zipcode" name="zipcode">
	              <button type="button" class="btn btn-primary" onclick="openZipSearch()">주소검색</button>
	          </div>
	          <div class="form-group">
	              <label for="address">주소</label>
	              <input type="text" class="form-control" id="address" name="address">
	          </div>
	          <div class="form-group">
	              <label for="address_detail">상세주소</label>
	              <input type="text" class="form-control" id="addressdetail" name="addressdetail">
	          </div>
	          <div class="form-group">
	              <label for="mlevel">권한레벨</label>
	              <input type="text" class="form-control" id="mlevel" name="mlevel">
	          </div>
	          <button type="submit" class="btn btn-primary">가입하기</button>
	      </form>
       </div>
   </div>
</body>
</html>