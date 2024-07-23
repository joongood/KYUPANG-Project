<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <%@ include file="/WEB-INF/views/admin/include_admin/common.jsp" %>
</head>
<script>
	var result = "${msg}";

	if(result == "modify"){
		alert("회원수정이 완료되었습니다.");
		window.close();
	}
</script>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
    	<div class="content-wrapper" style="width:600px; height:650;">
    		<h2 align="center" style="padding-top:5%;">회원상세정보수정</h2>
			<br>
			<form method="POST" onsubmit="return admin_member_join_modify();">
				<div class="form-group">
				    <input type="hidden" class="form-control" id="mid" name="mid" value="${modify.mid}" readonly>
				</div>
				<div class="form-group">
				    <label for="memail">이메일</label>
				    <input type="email" class="form-control" id="memail" name="memail" value="${modify.memail}" readonly>
				</div>
				<div class="form-group">
				    <label for="mname">이름</label>
				    <input type="text" class="form-control" id="mname" name="mname" value="${modify.mname}" >
				</div>
				<div class="form-group">
				    <label for="identification">본인확인여부</label>
				    <input type="text" class="form-control" id="identification" name="identification" value="${modify.identification}" readonly>
				</div>
				<div class="form-group">
				    <label for="mage">생년월일</label>
				    <input type="date" class="form-control" id="mage" name="mage" value="${modify.mage}" >
				</div>
				<div class="form-group">
		            <label for="mgender">성별</label>
		            <c:choose>
		            	<c:when test="${modify.mgender == '남자'}">
				            <select class="form-control" id="mgender" name="mgender">
				                <option>남자</option>
				                <option>여자</option>
				            </select>
		            	</c:when>
		            	<c:otherwise>
		            		<select class="form-control" id="mgender" name="mgender">
				                <option>여자</option>
				                <option>남자</option>
				            </select>
		            	</c:otherwise>
		            </c:choose>
		        </div>
				<div class="form-group">
				    <label for="mphone">휴대전화</label>
				    <input type="text" class="form-control" id="mphone" name="mphone" value="${modify.mphone}" >
				</div>
				<div class="form-group">
				    <label for="zipcode">우편번호</label>
				    <input type="text" class="form-control" id="zipcode" name="zipcode" value="${modify.zipcode}" >
				    <button type="button" class="btn btn-primary" onclick="openZipSearch()">주소검색</button>
				</div>
				<div class="form-group">
				    <label for="address">주소</label>
				    <input type="text" class="form-control" id="address" name="address" value="${modify.address}" >
				</div>
				<div class="form-group">
				    <label for="addressdetail">상세주소</label>
				    <input type="text" class="form-control" id="addressdetail" name="addressdetail" value="${modify.addressdetail}" >
				</div>
				<div class="form-group">
				    <label for="joindate">가입날짜</label>
				    <input type="date" class="form-control" id="joindate" name="joindate" value="${modify.joindate}"  readonly>
				</div>
				<div class="form-group">
				    <label for="mlevel">권한레벨</label>
				    <input type="text" class="form-control" id="mlevel" name="mlevel" value="${modify.mlevel}" >
				</div>
				<div class="form-group">
		            <label for="memberstatus">회원상태</label>
		            <c:choose>
		            	<c:when test="${modify.memberstatus == '정상'}">
				            <select class="form-control" id="memberstatus" name="memberstatus">
				                <option>정상</option>
				                <option>정지</option>
				                <option>탈퇴</option>
				            </select>
		            	</c:when>
		            	<c:when test="${modify.memberstatus == '정지'}">
				            <select class="form-control" id="memberstatus" name="memberstatus">
				                <option>정지</option>
				                <option>정상</option>
				                <option>탈퇴</option>
				            </select>
		            	</c:when>
		            	<c:otherwise>
		            		<select class="form-control" id="memberstatus" name="memberstatus">
				                <option>탈퇴</option>
				                <option>정상</option>
				                <option>정지</option>
				            </select>
		            	</c:otherwise>
		            </c:choose>
		        </div>
				<div class="form-group">
				    <label for="loginstatus">회원구분</label>
				    <input type="text" class="form-control" id="loginstatus" name="loginstatus" value="${modify.loginstatus}" readonly>
				</div>
				<div class="form-group">
				    <label for="mpoint">보유포인트</label>
				    <input type="text" class="form-control" id="mpoint" name="mpoint" value="${modify.mpoint}" readonly>
				</div>
				<div class="btn-group" style="margin-left: 75%; padding-bottom:5%;">
					<button type="submit" class="btn btn-primary">회원수정</button>
				</div>
		    </form>
    	</div>
    </div>
</body>
</html>