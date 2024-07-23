<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script>
    // 회원 정보 상세 보기
    function popup(url){
        var popupWidth = 700;
        var popupHeight = 690;

        // 서브모니터의 위치 및 크기 가져오기
        var monitorLeft = window.screenLeft || window.screenX || 0;
        var monitorTop = window.screenTop || window.screenY || 0;
        var monitorWidth = window.screen.availWidth || 700;
        var monitorHeight = window.screen.availHeight || 690;

        // 팝업 위치 계산
        var popupX = monitorLeft + (monitorWidth / 2) - (popupWidth / 2);
        var popupY = monitorTop + (monitorHeight / 2) - (popupHeight / 2);

        // 팝업 창 열기
        window.open(url, "view", "width="+popupWidth+",height="+popupHeight+",left="+popupX+",top="+popupY);
    }  
</script>
  <%@ include file="/WEB-INF/views/mutual/include_mutual/common.jsp" %>
  <%@ include file="/WEB-INF/views/mutual/include_mutual/levelstore.jsp" %>
<style>
    .form-group .opt_div {
    	width: 100%;
        display: flex;
        flex-direction: column; /* 세로로 요소들을 배치 */
        display: none;
    }
    .checkbox-container {
        display: flex;
        flex-wrap: wrap;
    }

    .checkbox-container .form-check {
        flex: 1 0 30%;
        margin-bottom: 10px;
    }

    .form-check-input {
        margin-right: 5px;
    }
</style>
</head>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
    	<div class="content-wrapper">
	     <h2 align="center" style="padding-top:5%;">배너신청</h2>
	     <br>
	     <form enctype="multipart/form-data">
           <div class="form-group">
               	<label for="title">제목</label>
               	<input type="text" class="form-control" id="title" name="title" value="${detail.title}" required/>
           </div>
           <br>
           <div class="form-group">
              <label for="mutual">상호명<br><span style="color:red;">(변경불가)</span></label>
              <input type="text" class="form-control" id="mutual" name="mutual" value="${detail.mutual}" readonly/>                        
           </div>
           <br>
           <div class="form-group">
               <label for="bprice">제안가격</label>
               <input type="text" class="form-control" id="bprice" name="bprice" value="${detail.bprice}" required/>
           </div>
           <br>
	       <label for="title">상품이미지<br><span style="color:red;">(업체당 1개)</span></label>&nbsp&nbsp&nbsp
		   <!-- 첫번째 이미지 업로드 컨테이너 -->
		   <div class="upload-container">
		      <div class="preview-images" id="preview-images1"></div>
		      <button type="button" class="btn-upload" onclick="document.getElementById('imageurl').click()">
		         <svg class="icon" width="48" height="48" viewBox="0 0 48 48" fill="currentColor" preserveAspectRatio="xMidYMid meet">
		             <path d="M11.952 9.778l2.397-5.994A1.778 1.778 0 0 1 16 2.667h16c.727 0 1.38.442 1.65 1.117l2.398 5.994h10.174c.982 0 1.778.796 1.778 1.778v32c0 .981-.796 1.777-1.778 1.777H1.778A1.778 1.778 0 0 1 0 43.556v-32c0-.982.796-1.778 1.778-1.778h10.174zM24 38c6.075 0 11-4.925 11-11s-4.925-11-11-11-11 4.925-11 11 4.925 11 11 11z"></path>
		         </svg>
		      </button>
		      <input type="file" id="imageurl" name="imageurl" onchange="changeValue(this, 'preview-images1')" style="display: none;" accept="image/*" />
		   </div>
           <br>
           <br>
           <br>
           <div class="form-group">
              <label for="startdate">게시시작일</label>
              <input type="date" class="form-control" id="startdate" name="startdate" value="${detail.startdate}" required>
           </div>
           <br>
           <div class="form-group">
               <label for="enddate">게시종료일</label>
               <input type="date" class="form-control" id="enddate" name="enddate" value="${detail.enddate}" required>
           </div>
		   <br>		
           <button type="button" class="btn btn-primary" id="addbutton" onclick="popup('/mutual/manageBanner/modifyBanner?bid=${detail.bid}')">배너요청수정</button>
           <button type="button" class="btn btn-danger" id="addbutton" onclick="popup('/mutual/manageBanner/delBanner?bid=${detail.bid}')">배너요청취소</button>
	       </form>
       </div>
   </div>
</body>
</html>