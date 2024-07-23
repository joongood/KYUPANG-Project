<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="/WEB-INF/views/admin/include_admin/common.jsp" %>
<script>
  // 회원 정보 상세 보기
  function popup(url){
      var popupWidth = 700;
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
    	<div class="content-wrapper" style="width:700px; height:850;">
	     <h2 align="center" style="padding-top:5%;">상품상세</h2>
	     <br>
	     <form enctype="multipart/form-data">
           <div class="form-group">
	            <label for="maincate">카테고리</label>
               	<input type="text" class="form-control" id="maincate" name="maincate" value="${cate.categoryname}" readonly/>
               	<input type="text" class="form-control" id="middlecate" name="middlecate" value="${cate.middlecatename}" readonly/>
		   </div>
           <br>
           <div class="form-group">
               	<label for="mutual">상호명</label>
               	<input type="text" class="form-control" id="mutual" name="mutual" value="${detail.mutual}" readonly/>
           </div>
           <br>
           <div class="form-group">
              <label for="pname">상품명</label>
              <input type="text" class="form-control" id="pname" name="pname" value="${detail.pname}" readonly/>                        
           </div>
           <br>
           <div class="form-group">
               <label for="price">판매가격</label>
               <input type="text" class="form-control" id="price" name="price" value="${detail.price}" readonly/>
           </div>
           <br>
           <div class="form-group">
              <label for="point">적립포인트</label>
              <input type="text" class="form-control" id="point" name="point" value="${detail.point}" readonly>
           </div>
           <br>
           <div class="form-group">
               <label for="qty">수량</label>
               <input type="number" class="form-control" id="qty" name="qty" value="${detail.qty}" readonly>
           </div>
           <br>
           <div class="form-group">
               <label for="description">상품설명</label>
               <textarea class="form-control" id="description" name="description" readonly>${detail.description}</textarea>
           </div>
           <br>
		   <div class="form-group">
			    <label for="product_option">상품옵션<br>추가여부</label>
			    <input class="form-control" id="product_option" name="product_option" value="${detail.product_option}" readonly> 
			    <button type="button" class="btn btn-primary" id="opt_button" style="display: none;" onclick="addOption()">옵션추가</button>
			    <button type="button" class="btn btn-secondary" id="reset_button" style="display: none;" onclick="resetInputs()">입력초기화</button>
		   </div>
		   <br>
	       <div class="form-group">
	            <label for="distribution">구분 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</label>
	            <div class="checkbox-container">
					<div class="form-check">
					    <input class="form-check-input" type="checkbox" id="productuse" name="productuse" value="Y" 
					           <c:if test="${detail.productuse eq 'Y'}">checked</c:if>>
					    <label class="form-check-label" for="productuse">사용여부</label>
					</div>
					<div class="form-check">
					    <input class="form-check-input" type="checkbox" id="hit" name="hit" value="Y" onchange="handleCheckboxChange('hit', 'hitHidden')" 
					           <c:if test="${detail.hit eq 'Y'}">checked</c:if>>
					    <input type="hidden" id="hitHidden" name="hit" value="N">
					    <label class="form-check-label" for="hit">히트상품</label>
					</div>
					<div class="form-check">
					    <input class="form-check-input" type="checkbox" id="suggest" name="suggest" value="Y" onchange="handleCheckboxChange('suggest', 'suggestHidden')" 
					           <c:if test="${detail.suggest eq 'Y'}">checked</c:if>>
					    <input type="hidden" id="suggestHidden" name="suggest" value="N">
					    <label class="form-check-label" for="suggest">추천상품</label>
					</div>
					<div class="form-check">
					    <input class="form-check-input" type="checkbox" id="newproduct" name="newproduct" value="Y" onchange="handleCheckboxChange('newproduct', 'newproductHidden')" 
					           <c:if test="${detail.newproduct eq 'Y'}">checked</c:if>>
					    <input type="hidden" id="newproductHidden" name="newproduct" value="N">
					    <label class="form-check-label" for="newproduct">신상품</label>
					</div>
					<div class="form-check">
					    <input class="form-check-input" type="checkbox" id="popular" name="popular" value="Y" onchange="handleCheckboxChange('popular', 'popularHidden')" 
					           <c:if test="${detail.popular eq 'Y'}">checked</c:if>>
					    <input type="hidden" id="popularHidden" name="popular" value="N">
					    <label class="form-check-label" for="popular">인기상품</label>
					</div>
					<div class="form-check">
					    <input class="form-check-input" type="checkbox" id="salecheck" name="salecheck" value="Y" onclick="toggleSalebox()" onchange="handleCheckboxChange('salecheck', 'salecheckHidden')" 
					           <c:if test="${detail.salecheck eq 'Y'}">checked</c:if>>
					    <input type="hidden" id="salecheckHidden" name="salecheck" value="N">
					    <label class="form-check-label" for="salecheck">세일상품</label>
					</div>
	            </div>
	        </div>
	        <br>		
            <div class="btn-group" style="margin-left: 82%; padding-bottom:5%;">
				<button type="button" class="btn btn-danger"  onclick="popup('/admin/manageProduct/delProduct?pid=${detail.pid}')">상품삭제</button>
			</div>
	       </form>
       </div>
   </div>
<script>
function handleCheckboxChange(checkboxId, hiddenId) {
    var checkbox = document.getElementById(checkboxId);
    var hiddenInput = document.getElementById(hiddenId);

    if (checkbox.checked) {
        if (hiddenInput) {
            hiddenInput.remove(); // 이미 존재하는 경우 삭제
        }
    } else {
        if (!hiddenInput) {
            // 존재하지 않는 경우 새로 생성하여 추가
            hiddenInput = document.createElement('input');
            hiddenInput.type = 'hidden';
            hiddenInput.id = hiddenId;
            hiddenInput.name = checkboxId;
            hiddenInput.value = 'N';
            document.querySelector('div.container').appendChild(hiddenInput);
        }
    }
}
</script>
<script>
function updateButtonVisibility() {
    // "product_option" 요소의 값 가져오기
    var optionValue = document.getElementById("product_option").value;

    // 버튼과 옵션 div 요소 가져오기
    var button = document.getElementById("opt_button");
    var div = document.getElementById("opt_div");

    // "product_option" 값이 "Y"인 경우 버튼과 div를 보이도록 설정
    if (optionValue === "Y") {
        button.style.display = "block";
        div.style.display = "block";
    } else {
        // 그렇지 않으면 버튼과 div를 숨김
        button.style.display = "none";
        div.style.display = "none";
    }
}

// 페이지가 로드될 때 실행되는 함수
document.addEventListener('DOMContentLoaded', function() {
    // "product_option" 요소의 변경 이벤트를 감지하여 updateButtonVisibility 함수 호출
    document.getElementById("product_option").addEventListener('change', updateButtonVisibility);

    // 페이지가 로드될 때 초기 버튼 상태 설정을 위해 updateButtonVisibility 함수 호출
    updateButtonVisibility();
});

</script>
</body>
</html>