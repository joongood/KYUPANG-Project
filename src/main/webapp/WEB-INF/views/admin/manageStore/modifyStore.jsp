<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <%@ include file="/WEB-INF/views/admin/include_admin/common.jsp" %>
</head>
<script>
	var result = "${msg}";

	if(result == "modify"){
		alert("가맹점수정이 완료되었습니다.");
		window.close();
	}
</script>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
    	<div class="content-wrapper" style="width:600px; height:650;">
    		<h2 align="center" style="padding-top:5%;">가맹점상세정보수정</h2>
			<br>
			<form method="POST" onsubmit="return admin_store_modify();">
				<div class="form-group">
				    <label for="semail">이메일</label>
				    <input type="email" class="form-control" id="semail" name="semail" value="${modify.semail}">
				</div>
				<div class="form-group">
				    <label for="mutual">상호명</label>
				    <input type="text" class="form-control" id="mutual" name="mutual" value="${modify.mutual}">
				</div>
				<div class="form-group">
				    <label for="ownername">대표명</label>
				    <input type="text" class="form-control" id="ownername" name="ownername" value="${modify.ownername}">
				</div>
				<div class="form-group">
				    <label for="bnumber">사업자<br>등록번호</label>
				    <input type="text" class="form-control" id="bnumber" name="bnumber" value="${modify.bnumber}" readonly>
				</div>
				<div class="form-group">
				    <label for="sphone">대표번호</label>
				    <input type="text" class="form-control" id="sphone" name="sphone" value="${modify.sphone}">
				</div>
				<div class="form-group">
				    <label for="zipcode">우편번호</label>
				    <input type="text" class="form-control" id="zipcode" name="zipcode" value="${modify.zipcode}">
				    <button type="button" class="btn btn-primary" onclick="openZipSearch()">주소검색</button>
				</div>
				<div class="form-group">
				    <label for="address">주소</label>
				    <input type="text" class="form-control" id="address" name="address" value="${modify.address}">
				</div>
				<div class="form-group">
				    <label for="addressdetail">상세주소</label>
				    <input type="text" class="form-control" id="addressdetail" name="addressdetail" value="${modify.addressdetail}">
				</div>
				<div class="form-group">
				    <label for="joindate">가입날짜</label>
				    <input type="date" class="form-control" id="joindate" name="joindate" value="${modify.joindate}" readonly>
				</div>
				<div class="form-group">
				    <label for="slevel">권한레벨</label>
				    <input type="text" class="form-control" id="slevel" name="slevel" value="${modify.slevel}" readonly>
				</div>
				<div class="form-group">
		            <label for="storestatus">가맹점상태</label>
		            <c:choose>
		            	<c:when test="${modify.storestatus == '정상'}">
				            <select class="form-control" id="storestatus" name="storestatus">
				                <option>정상</option>
				                <option>정지</option>
				                <option>탈퇴</option>
				            </select>
		            	</c:when>
		            	<c:when test="${modify.storestatus == '정지'}">
				            <select class="form-control" id="storestatus" name="storestatus">
				                <option>정지</option>
				                <option>정상</option>
				                <option>탈퇴</option>
				            </select>
		            	</c:when>
		            	<c:otherwise>
		            		<select class="form-control" id="storestatus" name="storestatus">
				                <option>탈퇴</option>
				                <option>정상</option>
				                <option>정지</option>
				            </select>
		            	</c:otherwise>
		            </c:choose>
		        </div>
				<div class="form-group">
				    <label for="loginstatus">구분</label>
				    <input type="text" class="form-control" id="loginstatus" name="loginstatus" value="${modify.loginstatus}" readonly>
				</div>
				<div class="form-group">
				    <label for="secretkey">OTP secretkey</label>
				    <input type="text" class="form-control" id="secretkey" name="secretkey" value="${modify.secretkey}">
				</div>
				<div class="btn-group" style="margin-left: 78%; padding-bottom:5%;">
					<button type="submit" class="btn btn-primary">가맹점수정</button>
				</div>
		    </form>
    	</div>
    </div>
</body>
</html>