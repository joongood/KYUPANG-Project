<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <%@ include file="/WEB-INF/views/mutual/include_mutual/common.jsp" %>
  <%@ include file="/WEB-INF/views/mutual/include_mutual/level5only.jsp" %>
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
    		<h2 align="center" style="padding-top:5%;">회원상세정보</h2>
			<br>
			<form>
				<div class="form-group">
				    <label for="memail">이메일</label>
				    <input type="email" class="form-control" id="memail" name="memail" value="${detail.memail}" readonly>
				</div>
				<div class="form-group">
				    <label for="mname">이름</label>
				    <input type="text" class="form-control" id="mname" name="mname" value="${detail.mname}" readonly>
				</div>
				<div class="form-group">
				    <label for="identification">본인확인여부</label>
				    <input type="text" class="form-control" id="identification" name="identification" value="${detail.identification}" readonly>
				</div>
				<div class="form-group">
				    <label for="mage">생년월일</label>
				    <input type="date" class="form-control" id="mage" name="mage" value="${detail.mage}" readonly>
				</div>
				<div class="form-group">
				    <label for="mgender">성별</label>
				    <input type="text" class="form-control" id="mgender" name="mgender" value="${detail.mgender}" readonly>
				</div>
				<div class="form-group">
				    <label for="mphone">휴대전화</label>
				    <input type="text" class="form-control" id="mphone" name="mphone" value="${detail.mphone}" readonly>
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
				    <label for="mlevel">권한레벨</label>
				    <input type="text" class="form-control" id="mlevel" name="mlevel" value="${detail.mlevel}" readonly>
				</div>
				<div class="form-group">
				    <label for="memberstatus">회원상태</label>
				    <input type="text" class="form-control" id="memberstatus" name="memberstatus" value="${detail.memberstatus}" readonly>
				</div>
				<div class="form-group">
				    <label for="loginstatus">회원구분</label>
				    <input type="text" class="form-control" id="loginstatus" name="loginstatus" value="${detail.loginstatus}"readonly>
				</div>
				<div class="form-group">
				    <label for="mpoint">보유포인트</label>
				    <input type="text" class="form-control" id="mpoint" name="mpoint" value="${detail.mpoint}" readonly>
				</div>
				<div class="btn-group" style="margin-left: 65%; padding-bottom:5%;">
					<button type="button" class="btn btn-primary" onclick="popup('/mutual/manageUser/modifyUser?mid=${detail.mid}')">회원수정</button>
					<button type="button" class="btn btn-danger"  onclick="popup('/mutual/manageUser/delUser?mid=${detail.mid}')">회원탈퇴</button>
				</div>
		    </form>
    	</div>
    </div>
</body>
</html>