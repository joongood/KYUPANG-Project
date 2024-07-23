<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- jquery -->
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.4.1.min.js"></script>
<script>
	<% if (request.getAttribute("msg") != null) { %>
	var msg = "<%= request.getAttribute("msg") %>";
	alert(msg);
	<% } %>	
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
	               msg = "<font color=green> 사용가능한 등록번호입니다.</font>";
	               $("#bnumberButton").prop('disabled', true); // 사업자 인증 버튼 비활성화 
	               $("#ok").val("Y");
               }else{
	               $("#bnumberButton").prop('disabled', false); // 사업자 인증 버튼 활성화
	               $("#ok").val("N");
               }
               
               $("#bnumber_result").html(msg); // 메시지를 출력할 요소에 메시지 삽입
               checkFormValidity();
            }
         });   
      });
   });   
</script>
<script>
//비밀번호 확인 js
$(document).ready(function(){
    // 비밀번호 입력란 값이 변경될 때마다 실행
    $("#spassword, #repass").keyup(function(event){    
        // 비밀번호 입력란과 비밀번호 확인 입력란의 값 가져오기
        var password = $("#spassword").val();
        var confirmPassword = $("#repass").val();

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
             $("#ok").val("Y");
             var otpButton = document.getElementById("otpButton");             
          }else {
        	 $("#ok").val("N");
             alert("사업자 등록번호를 다시 입력해주세요.");
          }
          checkFormValidity();			
      },
     error: function(result) {
         console.log(result.responseText); //responseText의 에러메세지 확인
     }
   });
}
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
                    addbutton.disabled = false;
                } else {
                    alert("인증 실패 OTP번호를 확인해주세요.");
                }
            },
            error: function(){
                alert("인증 실패 OTP번호를 확인해주세요.");
            }
         });
      });
   });
</script>
<script>
function checkFormValidity() {
	   if ($("#ok").val() == "Y") {
		   $("#otpButton").prop('disabled', false);
	   } else {
		   $("#otpButton").prop('disabled', true);
	   }
	}

	$(document).ready(function() {
	    checkFormValidity(); // 페이지 로드 시 확인
	    $("#ok").change(checkFormValidity); // ok 값이 변경될 때 확인
	});
</script>
<%@ include file="/WEB-INF/views/mutual/include_mutual/common.jsp" %>
<%@ include file="/WEB-INF/views/mutual/include_mutual/level5only.jsp" %>
</head>
<body class="hold-transition sidebar-mini">
  <div class="wrapper">
  <!-- navbar -->
  <%@ include file="/WEB-INF/views/mutual/include_mutual/navbar.jsp" %>
  <!-- main slide -->
  <%@ include file="/WEB-INF/views/mutual/include_mutual/mainslide.jsp" %>
    <div class="content-wrapper">
      <section class="content" style="padding-top:40px;">
        <div class="container-fluid">
          <div class="row">
            <div class="col-12">
              <div class="card" style="width:50%; margin: 0 auto;">
                <div class="card-header" >
                	<h3 class="card-title"><b>정보수정</b></h3>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
				<form  action="/mutual/manageMutual/modifyMutual" method="POST" onsubmit="return store_modify_reg();">					
		            <input type="hidden" class="form-control" id="ok" name="ok" value="${modify.bnumberok}"/>
					<div class="form-group">
		               	<label for="mutual">상호명<br><span style="color:red;">(변경불가)</span></label>
		               	<input type="text" class="form-control" id="mutual" name="mutual" value="${modify.mutual}" readonly/>
		            </div>
		            <br>
		            <div class="form-group">
		               	<label for="bnumber">사업자<br>등록번호</label>
		               	<input type="text" class="form-control" id="bnumber" name="bnumber" value="${modify.bnumber}"/>
		               	<input type="button" class="btn btn-primary" id="bnumberButton" value="사업자 인증" onclick="bnum_check()" disabled>
		            </div>
		            <span id="bnumber_result"></span>
		            <br>
		            <br>
		            <div class="form-group">
		               	<label for="semail">아이디</label>
		               	<input type="text" class="form-control" id="semail" name="semail" value="${modify.semail}" readonly />
		            </div>
		            <br>
		            <div class="form-group">
		               	<label for="spassword">비밀번호</label>
		               	<input type="password" class="form-control" id="spassword" name="spassword" value=""/>
		            </div>
		            <br>
		            <div class="form-group">
		               	<label for="repass">비밀번호확인</label>
		               	<input type="password" class="form-control" id="repass" name="repass" value=""/>
		            </div>
		            <div>
		            	<span id="pass_check"><br></span>
		            </div>		           
		            <br>
		            <div class="form-group">
		               	<label for="ownername">대표명</label>
		               	<input type="text" class="form-control" id="ownername" name="ownername" value="${modify.ownername}"/>
		            </div>
		            <br>
		            <div class="form-group">
		               	<label for="sphone">연락처</label>
		               	<input type="text" class="form-control" id="sphone" name="sphone" value="${modify.sphone}"/>
		            </div>
		            <br>
			        <div class="form-group">
			            <label for="zipcode">우편번호</label>
			            <input type="text" class="form-control" id="zipcode" name="zipcode" value="${modify.zipcode}" >
			            <button type="button" class="btn btn-primary" onclick="openZipSearch()">주소검색</button>
			        </div>
		            <br>
		            <div class="form-group">
		               	<label for="address">주소</label>
		               	<input type="text" class="form-control" id="address" name="address" value="${modify.address}"/>
		            </div>
		            <br>
		            <div class="form-group">
		               	<label for="addressdetail">상세주소</label>
		               	<input type="text" class="form-control" id="addressdetail" name="addressdetail" value="${modify.addressdetail}"/>
		            </div>
			        <br>
			        <div class="form-group">
				       <label for="otp">OTP 인증</label>
				       <input type="hidden" class="form-control" id="secretkey" name="secretkey" value="${modify.secretkey}" readonly>
				       <input type="text" class="form-control" id="otp" name="otp" required>
				       <button type="button" class="btn btn-primary" id="otpButton" disabled>OTP 인증</button>
			        </div>
			        <br>
		            <button type="submit" class="btn btn-primary" id="addbutton" disabled>정보수정하기</button>
				</form>
                </div>
              </div>
               <!-- /.card -->
            </div>
          </div>
        </div>
      </section>
    </div>
  </div>
</body>
<!-- footer -->
<%@ include file="/WEB-INF/views/mutual/include_mutual/footer.jsp" %>
</html>