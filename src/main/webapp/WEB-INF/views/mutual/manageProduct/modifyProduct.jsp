<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="/WEB-INF/views/mutual/include_mutual/common.jsp" %>
  <%@ include file="/WEB-INF/views/mutual/include_mutual/levelstore.jsp" %>
<script>
function catemiddle(cate){
	$.ajax({
		url: "cate2", //전송받을 페이지 경로
		type: "post", //데이터 전송 방식
		dataType: "text",
		data: "cid="+cate,
		error:function(){ //실패일 경우
			alert("실패");
		},
		success:function(text){ //성공일 경우
			$("#category2_result").html(text);
		}
	});
}	
function item_ok(){
	document.submit();
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
	     <h2 align="center" style="padding-top:5%;">상품추가</h2>
	     <br>
	     <form action="/mutual/manageProduct/modifyProduct" method="POST" enctype="multipart/form-data">
           <div class="form-group">
           		<input type="hidden" class="form-control" id="pid" name="pid" value="${modify.pid }"/>
             	<label for="maincate">카테고리<br><span style="color:red;">(선택필수)</span></label>
				<select class="form-control" id="maincate" name="maincate" onchange="catemiddle(this.value)" required>
					<option>=대분류선택=</option>
					<c:forEach var="c" items="${maincate}">
						<option value="${c.cid}">${c.cname}</option>
					</c:forEach>
				</select>
				<span id="category2_result">
					<select class="form-control" id="category2" name="category2">
						<option value="">=대분류를 먼저 선택하세요=</option>
					</select>
				</span>
           </div>       
           <br>
           <div class="form-group">
               	<label for="mutual">상호명</label>
               	<input type="text" class="form-control" id="mutual" name="mutual" value="${modify.mutual}" readonly/>
           </div>
           <br>
           <div class="form-group">
              <label for="pname">상품명</label>
              <input type="text" class="form-control" id="pname" name="pname" value="${modify.pname}" required/>                        
           </div>
           <br>
           <div class="form-group">
               <label for="price">판매가격</label>
               <input type="text" class="form-control" id="price" name="price" value="${modify.price}" required/>
           </div>
           <br>
           <div class="form-group">
               <label for="point_per">포인트적립률</label>
               <input type="text" class="form-control" id="point_per" oninput="point_cal()" placeholder="%로만 입력해주세요.(예시: 1%, 10% ...)">
           </div>
           <br>
           <div class="form-group">
              <label for="point">적립포인트</label>
              <input type="text" class="form-control" id="point" name="point" value="${modify.point}" readonly>
           </div>
           <br>
           <div class="form-group">
               <label for="qty">수량</label>
               <input type="number" class="form-control" id="qty" name="qty" value="${modify.qty}" required>
           </div>
           <br>
           <div class="form-group">
               <label for="description">상품설명</label>
               <textarea class="form-control" id="description" name="description" required>${modify.description}"</textarea>
           </div>
           <br>
		   <div class="form-group">
			    <label for="product_option">상품옵션<br>추가여부</label>
				<select class="form-control" id="product_option" name="product_option">
				    <option value="N" <c:if test="${modify.product_option eq 'N'}">selected</c:if>>N</option>
				    <option value="Y" <c:if test="${modify.product_option eq 'Y'}">selected</c:if>>Y</option>
				</select>
			    <button type="button" class="btn btn-primary" id="opt_button" style="display: none;" onclick="addOption()">옵션추가</button>
			    <button type="button" class="btn btn-secondary" id="reset_button" style="display: none;" onclick="resetInputs()">입력초기화</button>
		   </div>
		   <br>
			<div class="form-group">
			    <div class="opt_div" id="opt_div">
			        <input type="hidden" class="form-control" id="option_value1" name="option_value1" placeholder="옵션을 입력해주세요."/>
			        <br>
			        <input type="hidden" class="form-control" id="option_value2" name="option_value2" placeholder="옵션을 입력해주세요."/>
			        <br>
			        <input type="hidden" class="form-control" id="option_value3" name="option_value3" placeholder="옵션을 입력해주세요."/>
			        <br>
			        <input type="hidden" class="form-control" id="option_value4" name="option_value4" placeholder="옵션을 입력해주세요."/>
			        <br>
			        <input type="hidden" class="form-control" id="option_value5" name="option_value5" placeholder="옵션을 입력해주세요."/>
			    </div>
			</div>
           <br>
	       <div class="form-group">
	            <label for="distribution">구분<br><span style="color:red;">(선택필수)</span> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</label>
	            <div class="checkbox-container">
	                <div class="form-check">
	                    <input class="form-check-input" type="checkbox" id="productuse" name="productuse" value="Y" checked>
	                    <label class="form-check-label" for="productuse">사용여부</label>
	                </div>
					<div class="form-check">
			            <input class="form-check-input" type="checkbox" id="hit" name="hit" value="Y" onchange="handleCheckboxChange('hit', 'hitHidden')">
			            <input type="hidden" id="hitHidden" name="hit" value="N">
			            <label class="form-check-label" for="hit">히트상품</label>
			        </div>
			        <div class="form-check">
			            <input class="form-check-input" type="checkbox" id="suggest" name="suggest" value="Y" onchange="handleCheckboxChange('suggest', 'suggestHidden')">
			            <input type="hidden" id="suggestHidden" name="suggest" value="N">
			            <label class="form-check-label" for="suggest">추천상품</label>
			        </div>
			        <div class="form-check">
			            <input class="form-check-input" type="checkbox" id="newproduct" name="newproduct" value="Y" onchange="handleCheckboxChange('newproduct', 'newproductHidden')">
			            <input type="hidden" id="newproductHidden" name="newproduct" value="N">
			            <label class="form-check-label" for="newproduct">신상품</label>
			        </div>
			        <div class="form-check">
			            <input class="form-check-input" type="checkbox" id="popular" name="popular" value="Y" onchange="handleCheckboxChange('popular', 'popularHidden')">
			            <input type="hidden" id="popularHidden" name="popular" value="N">
			            <label class="form-check-label" for="popular">인기상품</label>
			        </div>
			        <div class="form-check">
			            <input class="form-check-input" type="checkbox" id="salecheck" name="salecheck" value="Y" onclick="toggleSalebox()" onchange="handleCheckboxChange('salecheck', 'salecheckHidden')">
			            <input type="hidden" id="salecheckHidden" name="salecheck" value="N">
			            <label class="form-check-label" for="salecheck">세일상품</label>
			        </div>
	            </div>
	       </div>
		   <br>
		   <div class="salebox" id="salebox" style="display: none;">
		        <div class="form-group">
		            <label for="sale_per">할인률</label>
		            <input type="text" class="form-control" id="sale_per" oninput="sale_cal()" placeholder="%로만 입력해주세요.(예시: 1%, 10% ...)">
		        </div>
		        <br>
		        <div class="form-group">
		            <label for="saleprice">할인금액</label>
		            <input type="text" class="form-control" id="saleprice" name="saleprice" readonly>
		        </div>
		   </div>
           <br>
           <div id="form-group">
			    <label for="title">상품이미지<br><span style="color:red;">(선택필수)</span></label>&nbsp&nbsp&nbsp
				<!-- 첫번째 이미지 업로드 컨테이너 -->
				<div class="upload-container">
				    <div class="preview-images" id="preview-images1"></div>
				    <button type="button" class="btn-upload" onclick="document.getElementById('file1').click()">
				        <svg class="icon" width="48" height="48" viewBox="0 0 48 48" fill="currentColor" preserveAspectRatio="xMidYMid meet">
				            <path d="M11.952 9.778l2.397-5.994A1.778 1.778 0 0 1 16 2.667h16c.727 0 1.38.442 1.65 1.117l2.398 5.994h10.174c.982 0 1.778.796 1.778 1.778v32c0 .981-.796 1.777-1.778 1.777H1.778A1.778 1.778 0 0 1 0 43.556v-32c0-.982.796-1.778 1.778-1.778h10.174zM24 38c6.075 0 11-4.925 11-11s-4.925-11-11-11-11 4.925-11 11 4.925 11 11 11z"></path>
				        </svg>
				    </button>
				    <input type="file" id="file1" name="file1" onchange="changeValue(this, 'preview-images1')" style="display: none;" accept="image/*" />
				</div>			
				<!-- 두번째 이미지 업로드 컨테이너 -->
				<div class="upload-container">
				    <div class="preview-images" id="preview-images2"></div>
				    <button type="button" class="btn-upload" onclick="document.getElementById('file2').click()">
				        <svg class="icon" width="48" height="48" viewBox="0 0 48 48" fill="currentColor" preserveAspectRatio="xMidYMid meet">
				            <path d="M11.952 9.778l2.397-5.994A1.778 1.778 0 0 1 16 2.667h16c.727 0 1.38.442 1.65 1.117l2.398 5.994h10.174c.982 0 1.778.796 1.778 1.778v32c0 .981-.796 1.777-1.778 1.777H1.778A1.778 1.778 0 0 1 0 43.556v-32c0-.982.796-1.778 1.778-1.778h10.174zM24 38c6.075 0 11-4.925 11-11s-4.925-11-11-11-11 4.925-11 11 4.925 11 11 11z"></path>
				        </svg>
				    </button>
				    <input type="file" id="file2" name="file2" onchange="changeValue(this, 'preview-images2')" style="display: none;" accept="image/*" />
				</div>
				<!-- 세번째 이미지 업로드 컨테이너 -->
				<div class="upload-container">
				    <div class="preview-images" id="preview-images3"></div>
				    <button type="button" class="btn-upload" onclick="document.getElementById('file3').click()">
				        <svg class="icon" width="48" height="48" viewBox="0 0 48 48" fill="currentColor" preserveAspectRatio="xMidYMid meet">
				            <path d="M11.952 9.778l2.397-5.994A1.778 1.778 0 0 1 16 2.667h16c.727 0 1.38.442 1.65 1.117l2.398 5.994h10.174c.982 0 1.778.796 1.778 1.778v32c0 .981-.796 1.777-1.778 1.777H1.778A1.778 1.778 0 0 1 0 43.556v-32c0-.982.796-1.778 1.778-1.778h10.174zM24 38c6.075 0 11-4.925 11-11s-4.925-11-11-11-11 4.925-11 11 4.925 11 11 11z"></path>
				        </svg>
				    </button>
				    <input type="file" id="file3" name="file3" onchange="changeValue(this, 'preview-images3')" style="display: none;" accept="image/*" />
				</div>
				<!-- 네번째 이미지 업로드 컨테이너 -->
				<div class="upload-container">
				    <div class="preview-images" id="preview-images4"></div>
				    <button type="button" class="btn-upload" onclick="document.getElementById('file4').click()">
				        <svg class="icon" width="48" height="48" viewBox="0 0 48 48" fill="currentColor" preserveAspectRatio="xMidYMid meet">
				            <path d="M11.952 9.778l2.397-5.994A1.778 1.778 0 0 1 16 2.667h16c.727 0 1.38.442 1.65 1.117l2.398 5.994h10.174c.982 0 1.778.796 1.778 1.778v32c0 .981-.796 1.777-1.778 1.777H1.778A1.778 1.778 0 0 1 0 43.556v-32c0-.982.796-1.778 1.778-1.778h10.174zM24 38c6.075 0 11-4.925 11-11s-4.925-11-11-11-11 4.925-11 11 4.925 11 11 11z"></path>
				        </svg>
				    </button>
				    <input type="file" id="file4" name="file4" onchange="changeValue(this, 'preview-images4')" style="display: none;" accept="image/*" />
				</div>
				<!-- 다섯번째 이미지 업로드 컨테이너 -->
				<div class="upload-container">
				    <div class="preview-images" id="preview-images5"></div>
				    <button type="button" class="btn-upload" onclick="document.getElementById('file5').click()">
				        <svg class="icon" width="48" height="48" viewBox="0 0 48 48" fill="currentColor" preserveAspectRatio="xMidYMid meet">
				            <path d="M11.952 9.778l2.397-5.994A1.778 1.778 0 0 1 16 2.667h16c.727 0 1.38.442 1.65 1.117l2.398 5.994h10.174c.982 0 1.778.796 1.778 1.778v32c0 .981-.796 1.777-1.778 1.777H1.778A1.778 1.778 0 0 1 0 43.556v-32c0-.982.796-1.778 1.778-1.778h10.174zM24 38c6.075 0 11-4.925 11-11s-4.925-11-11-11-11 4.925-11 11 4.925 11 11 11z"></path>
				        </svg>
				    </button>
				    <input type="file" id="file5" name="file5" onchange="changeValue(this, 'preview-images5')" style="display: none;" accept="image/*" />
				</div>
			</div>
			<br>		
            <button type="submit" class="btn btn-primary" id="addbutton">상품수정하기</button>
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