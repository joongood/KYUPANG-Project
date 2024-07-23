<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <%@ include file="/WEB-INF/views/admin/include_admin/common.jsp" %>
</head>
<script>
    // 회원 정보 상세 보기
    function popup(url){
        var popupWidth = 600;
        var popupHeight = 850;

        // 서브모니터의 위치 및 크기 가져오기
        var monitorLeft = window.screenLeft || window.screenX || 0;
        var monitorTop = window.screenTop || window.screenY || 0;
        var monitorWidth = window.screen.availWidth || 800;
        var monitorHeight = window.screen.availHeight || 600;

        // 팝업 위치 계산
        var popupX = monitorLeft + (monitorWidth / 2) - (popupWidth / 2);
        var popupY = monitorTop + (monitorHeight / 2) - (popupHeight / 2);

        // 팝업 창 열기
        window.open(url, "view", "width="+popupWidth+",height="+popupHeight+",left="+popupX+",top="+popupY);
    }  
</script>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
    	<div class="content-wrapper" style="width:600px; height:650;">
    		<h2 align="center" style="padding-top:5%;">가맹점상세정보</h2>
			<br>
			<form>
				<div class="form-group">
				    <label for="semail">이메일</label>
				    <input type="email" class="form-control" id="semail" name="semail" value="${detail.semail}" readonly>
				</div>
				<div class="form-group">
				    <label for="mutual">상호명</label>
				    <input type="text" class="form-control" id="mutual" name="mutual" value="${detail.mutual}" readonly>
				</div>
				<div class="form-group">
				    <label for="ownername">대표명</label>
				    <input type="text" class="form-control" id="ownername" name="ownername" value="${detail.ownername}" readonly>
				</div>
				<div class="form-group">
				    <label for="bnumber">사업자<br>등록번호</label>
				    <input type="text" class="form-control" id="bnumber" name="bnumber" value="${detail.bnumber}" readonly>
				</div>
				<div class="form-group">
				    <label for="sphone">대표번호</label>
				    <input type="text" class="form-control" id="sphone" name="sphone" value="${detail.sphone}" readonly>
				</div>
				<div class="form-group">
				    <label for="zipcode">우편번호</label>
				    <input type="text" class="form-control" id="zipcode" name="zipcode" value="${detail.zipcode}" readonly>
				</div>
				<div class="form-group">
				    <label for="address">주소</label>
				    <input type="text" class="form-control" id="address" name="address" value="${detail.address}" readonly>
				</div>
				<div class="form-group">
				    <label for="addressdetail">상세주소</label>
				    <input type="text" class="form-control" id="addressdetail" name="addressdetail" value="${detail.addressdetail}" readonly>
				</div>
				<div class="form-group">
				    <label for="joindate">가입날짜</label>
				    <input type="date" class="form-control" id="joindate" name="joindate" value="${detail.joindate}" readonly>
				</div>
				<div class="form-group">
				    <label for="slevel">권한레벨</label>
				    <input type="text" class="form-control" id="slevel" name="slevel" value="${detail.slevel}" readonly>
				</div>
				<div class="form-group">
				    <label for="storestatus">가맹점상태</label>
				    <input type="text" class="form-control" id="storestatus" name="storestatus" value="${detail.storestatus}" readonly>
				</div>
				<div class="form-group">
				    <label for="loginstatus">구분</label>
				    <input type="text" class="form-control" id="loginstatus" name="loginstatus" value="${detail.loginstatus}"readonly>
				</div>
				<div class="form-group">
				    <label for="secretkey">OTP secretkey</label>
				    <input type="text" class="form-control" id="secretkey" name="secretkey" value="${detail.secretkey}" readonly>
				</div>
				<div class="btn-group" style="margin-left: 58%; padding-bottom:5%;">
					<button type="button" class="btn btn-primary" onclick="popup('/admin/manageStore/modifyStore?sid=${detail.sid}')">가맹점수정</button>
					<button type="button" class="btn btn-danger"  onclick="popup('/admin/manageStore/delStore?sid=${detail.sid}')">가맹점탈퇴</button>
				</div>
		    </form>
    	</div>
    </div>
</body>
</html>