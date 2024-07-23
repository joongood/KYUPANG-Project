<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="/WEB-INF/views/admin/include_admin/common.jsp" %>
</head>
<script>
	var result = "${msg}";

	if(result == "add"){
		alert("가맹점추가가 완료되었습니다.");
		window.close();
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
               }
               $("#bnumber_result").html(msg); // 메시지를 출력할 요소에 메시지 삽입
            }
         });   
      });
   });   
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

          if (valid=='01'){
        	  alert("사용가능한 사업자 등록번호입니다.");
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
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
    	<div class="content-wrapper" style="width:600px; height:850;">
	     <h2 align="center" style="padding-top:5%;">가맹점추가</h2>
	     <br>
	     <form method="POST" onsubmit="return admin_store_modify()">
	           <div class="form-group">
	             	<label for="semail">이메일</label>
	             	<input type="email" class="form-control" id="semail" name="semail" >
	           </div>
	           <span id="email_result"></span>         
	           <br>
	           <div class="form-group">
	               	<label for="spassword">비밀번호</label>
	               	<input type="password" class="form-control" id="spassword" name="spassword">
	           </div>
	           <br>
	           <div class="form-group" style="margin:0">
	              <label for="password">비밀번호확인</label>
	              <input type="password" class="form-control" id="re_pass" name="re_pass" >                        
	           </div>
	           <span id="pass_check"></span>
	           <br>
	           <br>
	           <div class="form-group">
	               <label for="mutual">상호명</label>
	               <input type="text" class="form-control" id="mutual" name="mutual">
	           </div>
	           <br>
	           <div class="form-group">
	               <label for="ownername">대표자명</label>
	               <input type="text" class="form-control" id="ownername" name="ownername" >
	           </div>
	           <br>
	           <div class="form-group">
	              <label for="bnumber">사업자 등록번호</label>
	              <input type="text" class="form-control" id="bnumber" name="bnumber">
	              <input type="button" class="btn btn-primary" id="bnumberButton" value="사업자 인증" onclick="bnum_check()">
	           </div>
	           <span id="bnumber_result"></span>
	           <br>
	           <div class="form-group">
	               <label for="sphone">대표번호</label>
	               <input type="tel" class="form-control" id="sphone" name="sphone">
	           </div>
	           <br>
	           <div class="form-group">
	               <label for="zip_code">우편번호</label>
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
	           <button type="submit" class="btn btn-primary" id="joinbutton">가맹점추가</button>
	       </form>
       </div>
   </div>
</body>
</html>