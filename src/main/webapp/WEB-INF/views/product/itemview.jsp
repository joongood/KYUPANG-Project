<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
.carousel-control {
    opacity: 0; /* 기본 투명도 설정 */
}

.carousel-control:hover {
    opacity: 1; /* 마우스를 올렸을 때 투명도 */
}
.carousel-inner {
    width: 100%;
    height: 100%; /* 부모 요소의 높이를 차지하도록 설정 */
}
.carousel-inner img {
    width: 100%;
    height: 100%;
    object-fit: cover; /* 이미지가 잘리지 않도록 조정 */
}
.review {
    max-height: 300px; /* 최대 높이 설정 */
    overflow-y: auto; /* 세로 스크롤 허용 */
    border: 1px solid #ddd;
    padding: 10px;
    margin-top: 20px;
    background-color: #f9f9f9;
    border-radius: 5px;
}
.review-list {
    display: flex;
    flex-direction: column;
}
.review-item {
    border-bottom: 1px solid #eee;
    padding: 10px 0;
}
.review-item:last-child {
    border-bottom: none;
}
.review-item .review-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.review-item .review-body {
    margin-top: 5px;
}
.review-item .review-footer {
    display: flex;
    justify-content: flex-end; /* 버튼을 오른쪽으로 정렬합니다. */
    align-items: center; /* 버튼을 세로 중앙 정렬합니다. */
}
.review-item .review-footer button {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 5px 10px;
    border-radius: 3px;
    cursor: pointer;
    margin-right: 10px; /* 필요에 따라 버튼 사이의 간격을 조정합니다. */
}
.review-item .review-footer button:hover {
    background-color: #0056b3;
}
</style>
<script>	
	function item_ok(){
		document.submit();
	}
</script>
<div class="single-product-area">
    <div class="zigzag-bottom"></div>
    <div class="container">
        <div class="row"> 
            <div class="col-md-12">
                <!-- Product Content -->
                <div class="product-content">
                    <div class="product-breadcrumb">
           				<!-- 규만 수정1  -->
                        <a>${cate.categoryname }</a> /
                        <a>${cate.middlecatename }</a> / 
                        <a>${cate.pname}</a>
                        <!-- 수정1 마무리  --> 
                    </div>

                    <div class="row">
                        <!-- Slider Area -->
                        <div class="col-md-6">
                            <div id="slide-list" class="carousel slide" data-ride="carousel">
                                <!-- Indicators -->
                                <ol class="carousel-indicators">
                                    <c:forEach var="i" begin="0" end="4">
                                        <li data-target="#slide-list" data-slide-to="${i}" class="<c:if test='${i == 0}'>active</c:if>"></li>
                                    </c:forEach>
                                </ol>
                                <!-- Wrapper for slides -->
                                <div class="carousel-inner" role="listbox">
                                    <c:set var="imagePrefix" value="/product_upload/" />
                                    <c:forEach var="i" begin="0" end="4">
                                        <c:set var="imageKey" value='file${i + 1}' />
                                        <c:if test="${not empty product[imageKey]}">
                                            <div class="item <c:if test='${i == 0}'>active</c:if>">
                                                <img src="${imagePrefix}${product[imageKey]}" alt="Product Image">
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                                <!-- Controls -->
                                <a class="left carousel-control" href="#slide-list" role="button" data-slide="prev">
                                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="false"></span>
                                    <span class="sr-only">Previous</span>
                                </a>
                                <a class="right carousel-control" href="#slide-list" role="button" data-slide="next">
                                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="false"></span>
                                    <span class="sr-only">Next</span>
                                </a>
                            </div>
                        </div>
                        <!-- End Slider Area -->

                        <!-- Product Details -->
                        <div class="col-md-6">
                            <div class="product-details">
                                <input type="hidden" id="cart" name="cart" value="${sessionScope.cart}">
                            	<input type="hidden" id="pid" name="pid" value="${product.pid }">
                               	<input type="hidden" id="mutual" name="mutual" value="${product.mutual }">
                               	<input type="hidden" id="point" name="point" value="${product.point }">
                               	<input type="hidden" id="session_id" name="session_id" value="${sessionScope.id}" />
                               	<input type="hidden" id="file1" name="file1" value="${product.file1}" />
                               	<input type="hidden" id="pname" name="pname" value="${product.pname}">                               	
                                <h2 class="product-name">${product.pname}</h2>
                                <div class="product-price">
                                    <c:choose>
                                        <c:when test="${product.saleprice != '0'}">
                                            <ins style="font-size:23px;"><fmt:formatNumber type="number" value="${product.saleprice}" pattern="#,###" />원</ins>
                                            <input type="hidden" id="price" name="price" value="${product.saleprice}">
                                            <del style="font-size:20px;"><fmt:formatNumber type="number" value="${product.price}" pattern="#,###" />원</del>
                                            <div class="discount-percentage" style="color:red; font-size:15px; font-weight: bold;">
                                                <script>
                                                    var salePrice = ${product.saleprice};
                                                    var regularPrice = ${product.price};
                                                    var discountPercentage = 100 - (salePrice * 100 / regularPrice);
                                                    var discountPercentageRounded = Math.round(discountPercentage);
                                                    document.write(discountPercentageRounded + '% 할인');
                                                </script>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <ins style="font-size:23px;"><fmt:formatNumber type="number" value="${product.price}" pattern="#,###" />원</ins>
                                            <input type="hidden" id="price" name="price" value="${product.price}">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <br>
                                <br>
                                <br>
                                <br>
                                <div class="product-actions">
                                    <c:choose>
                                        <c:when test="${sessionScope.id != null and product.qty != '0' }">
                                            <div class="quantity">
                                                <label for="qty">수량</label>
                                                <br>
                                                <input type="number" size="4" class="input-text qty text" title="Qty" value="1" name="quantity" min="1" step="1" id="qty">
                                            </div>
                                            <div class="btn-group" style=" margin-top:4.3%;">
                                            	<button class="add_to_cart_button" type="button" onclick="addcart()">장바구니 담기</button>
                                            	<button class="add_to_cart_button" type="button" onclick="wish()">찜하기</button>
                                        	</div>
                                        	<br><br>
                                            <div class="option">
                                            	<input type="hidden" id="product_option" name="product_option" value="${product.product_option}">
											    <div id="option_result"></div>
											</div>
											<br>
											<div class="submit-review">
		                                    	<br>
		                                    	<br>
		                                        <div class="form-group">
		                                            <label for="name">이름</label>
		                                            <input type="text" class="form-control" id="writer" name="writer" readonly value="${sessionScope.name}">
		                                        </div>                                        
		                                        <div class="form-group">
		                                            <label for="review">리뷰 내용</label>
		                                            <textarea class="form-control" id="comment_text" name="comment_text" rows="5"></textarea>
		                                        </div>
		                                        <c:if test="${sessionScope.id != null}">
		                                        	<button id="addreview" class="btn btn-primary">리뷰 작성</button>
		                                        </c:if>
                                			</div>
                                        </c:when>
                                        <c:when test="${product.qty != '0'}">
                                        	<div class="product-out-of-stock">로그인 후 구매 가능합니다.</div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="product-out-of-stock">품절</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <!-- End Product Details -->
                    </div>
					<br>
					<br>
                    <!-- Tab Panel for Description and Reviews -->
                    <div class="product-tabs">
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active">
                            	<a href="#description" aria-controls="description" role="tab" data-toggle="tab">상품 설명</a>
                            </li>
                            <li role="presentation">
                            	<a href="#reviews" aria-controls="reviews" role="tab" data-toggle="tab">리뷰(<span id="total_conunt"></span>)</a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="description">
                            	<br>
								<br>
                                <p>${product.description}</p>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="reviews">
                            	<div class="review">
                                    <div id="review-list" class="review-list">
                                    	<table class="table table-striped">                                    	
                                    		<tbody>
                                                <!-- 리뷰 항목들이 여기에 동적으로 추가됩니다 -->
                                            </tbody>
                                    	</table>                                    	
                                    	<div class="pagination-container">
                                            <ul class="pagination">
                                                <!-- 페이지 번호들이 여기에 동적으로 추가됩니다 -->
                                            </ul>
                                        </div>                                        
                                    </div>
								</div>
                                
                            </div>
                        </div>
                    </div>
                    <!-- End Tab Panel -->
                </div>
                <!-- End Product Content -->
            </div>
        </div>
    </div>
</div>
<script>
document.addEventListener("DOMContentLoaded", function() {
    const productOption = document.getElementById("product_option").value;
    const optionDiv = document.querySelector(".option");

    if (productOption === "Y") {
        optionDiv.style.display = "block";
    } else if (productOption === "N") {
        optionDiv.style.display = "none";
    }
});
</script>
<script>
$(document).ready(function() {
    optionadd(); // 페이지 로드 시 optionadd() 함수를 호출합니다.

    // 기본 가격을 data attribute에 저장
    var basePrice = ${product.price};
    var salePrice = ${product.saleprice};
    document.getElementById("price").dataset.basePrice = basePrice;
    document.getElementById("price").dataset.salePrice = salePrice;

    // 초기 가격 업데이트
    updatePrice();

 	// 수량 입력 필드의 값이 변경될 때마다 호출되는 함수
    document.getElementById("qty").addEventListener("change", function() {
        var qty = parseInt(this.value);
        var maxQty = ${product.qty}; // 서버에서 전달한 상품의 최대 재고 수량

        // 수량이 최대 재고 수량을 초과할 경우 경고 메시지를 표시하고 수량을 최대 재고 수량으로 설정
        if (qty > maxQty) {
            alert("재고보다 많은 수량을 선택하셨습니다.\n수량을 줄여주세요.");
            this.value = maxQty;
        }

        updatePrice();
    })
});

//가격을 동적으로 업데이트하는 함수
function updatePrice() {
    var qty = document.getElementById("qty").value;
    var basePrice = parseFloat(document.getElementById("price").dataset.basePrice); // 기본 가격
    var salePrice = parseFloat(document.getElementById("price").dataset.salePrice); // 세일 가격
    var isSale = salePrice != 0;
    var totalPrice = qty * (isSale ? salePrice : basePrice); // 수량에 따른 총 가격 계산

    // 가격 필드 업데이트
    document.getElementById("price").value = totalPrice;
    
    // 화면에 표시되는 가격 업데이트
    document.querySelector(".product-price ins").innerText = totalPrice.toLocaleString() + "원";
}

//장바구니 담기
function addcart(){
	var cart = document.getElementById("cart").value;
	var mid = document.getElementById("session_id").value;
	var mutual = document.getElementById("mutual").value;
	var pid = document.getElementById("pid").value;
	var price = document.getElementById("price").value;
	var point = document.getElementById("point").value;
	var qty = document.getElementById("qty").value;
	var file1 = document.getElementById("file1").value;
	var pname = document.getElementById("pname").value;
	var option_value1 = document.getElementById("product_option").value;

	$.ajax({
	    url: "/cart/addcart", // 전송받을 페이지 경로
	    type: "POST", // 데이터 전송 방식
	    dataType: "text", // 서버 응답의 형식
	    data: {
	    	cart : cart,
	    	mid : mid,
	    	mutual: mutual,
	    	pid: pid,
	        price: price,
	        point: point,
	        qty: qty,
	        file1 : file1,
	        pname : pname,
	        option_value1 : option_value1
	    },
	    error: function () { // 실패일 경우
	    	alert("요청 실패");
	    },
	    success: function (response) { // 성공일 경우
	    	alert("장바구니에 담았습니다.");
	    	location.reload();
	    }
	});
}

// 찜하기
function wish() {
    var mid = document.getElementById("session_id").value;
    var mutual = document.getElementById("mutual").value;
    var pid = document.getElementById("pid").value;
    var price = document.getElementById("price").value;
    var point = document.getElementById("point").value;
    var qty = document.getElementById("qty").value;
    var file1 = document.getElementById("file1").value;
    var pname = document.getElementById("pname").value;

    $.ajax({
        url: "/wish/wishCreate",
        type: "POST",
        dataType: "text",
        data: {
            mid: mid,
            mutual: mutual,
            pid: pid,
            price: price,
            point: point,
            qty: qty,
            file1: file1,
            pname: pname
        },
        error: function() {
            alert("찜하기 요청 실패");
        },
        success: function(response) {
            if(response.trim() === "true") {
                alert("이미 찜하신 상품입니다.");
            } else {
                alert("찜목록에 추가되었습니다.");
                location.reload();
            }
        }
    });
}

function optionadd(){
    var pid = document.getElementById("pid").value; // 입력된 상품 ID를 가져옵니다.
    $.ajax({
        url: "/product/option", // 데이터를 전송할 서버의 경로입니다. 예를 들어, "/product/option" 경로로 POST 요청을 보냅니다.
        type: "POST", // HTTP 요청 방식은 POST입니다.
        dataType: "text", // 서버로부터 예상되는 데이터 형식은 텍스트입니다.
        data: {
            pid : pid, // 전송할 데이터는 상품 ID입니다.
        },
        error: function () { // 요청이 실패했을 경우 실행됩니다.
            alert("요청 실패");
        },
        success: function (text) { // 요청이 성공했을 경우 실행됩니다. 서버에서 반환한 데이터는 'text' 변수에 담겨 있습니다.
            $("#option_result").html(text); // 서버에서 받은 결과를 id가 'option_result'인 요소에 삽입합니다.
        }
    });
}
</script>
<script>
var pid = "${param.pid}";

getAllComment(); //총 게시물 수
var CommentPage = 1;
getCommentPageList(1); //페이징 처리된 리스트

//총 게시물 수
function getAllComment() { 
	$.getJSON("/comments/count/"+pid,
		function(data){
			$("#total_conunt").text(data.length);
		}
	);
}

//글 등록
$("#addreview").on("click",function(){
	var writer = $("#writer").val();
	var comment_text = $("#comment_text").val();
	
	// 리뷰 내용이 비어 있으면 등록되지 않게 처리
    if (!comment_text.trim()) {
        alert("리뷰 내용을 입력해주세요.");
        return; // 함수 실행을 중단하여 빈 리뷰가 등록되지 않게 함
    }
	
	$.ajax({
		type: 'post',
		url: '/comments/',
		headers: {
			"Content-Type" : "application/json"
		},
		dataType: 'text',
		data:JSON.stringify({
			pid : pid,
			writer : writer,
			comment_text : comment_text
		}),
		success: function(result){
			if(result == 'success'){
				alert("리뷰가 작성되었습니다.");
				getAllComment(); //총 게시물 수
				getCommentPageList(1); //리뷰 목록 다시 불러오기
				
				//글 작성후 null처리
				$("#comment_text").val("");
			}
		}
	});
});

//리뷰 수정 버튼 클릭 시 텍스트 입력 필드로 변경
$(document).on("click", "#modifyreview", function() {
    var reviewItem = $(this).closest("tr.review-item");
    var cmid = reviewItem.find(".cmid").val();
    var currentText = reviewItem.find(".review-body").text().replace("내용:", "").trim();

    // 기존 내용을 텍스트 입력 필드로 변경
    reviewItem.find(".review-body").html("<textarea class='edit-comment-text'>" + currentText + "</textarea>");
    // 버튼 변경
    $(this).replaceWith("<button id='savereview'>저장</button>");
});

// 저장 버튼 클릭 시 서버로 수정된 내용 전송
$(document).on("click", "#savereview", function() {
    var reviewItem = $(this).closest("tr.review-item");
    var cmid = reviewItem.find(".cmid").val();
    var editedText = reviewItem.find(".edit-comment-text").val();

    $.ajax({
        type: 'put',
        url: '/comments/modify/' + cmid,
        headers: {
            "Content-Type": "application/json",
            "X-HTTP-Method-Override": "PUT"
        },
        dataType: 'text',
        data: JSON.stringify({
            comment_text: editedText
        }),
        success: function(result) {
            if (result == 'success') {
                alert("수정 되었습니다.");
                getAllComment();
                getCommentPageList(1);
            }
        }
    });
});

//글 삭제
$(document).on("click", "#deletereview", function() {
	var cmid = $(this).closest("tr.review-item").find(".cmid").val();

	$.ajax({
		type : 'delete',
		url : '/comments/delete/' + cmid,	
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "DELETE"
		},
		dataType : 'text',
		success : function(result) {
			if (result == 'success') {
				alert("삭제 되었습니다.");
                getAllComment();       // 전체 댓글을 다시 가져오는 함수 호출
                getCommentPageList(1); // 페이지 재로드
			}
		}
	});
});

//페이징
function getCommentPageList(page){
	$.getJSON("/comments/"+pid+"/"+page , function(data){

		var str="";
		
		if(data.list.length === 0){ //등록된 리뷰가 없을 시
			str = "<tr class='no-reviews'><td colspan='3'>등록된 리뷰가 없습니다.</td></tr>"
		} else{
			
			$(data.list).each(function(){
				
				var reviewItem = "<tr class='review-item'>"
					+ "<input type='hidden' id='cmid' class='cmid' value='" + this.cmid + "' />"
	                + "<td class='review-header'><strong> 작성자:" + this.writer + "</strong></td>"
	                + "<td class='review-body'> 내용:" + this.comment_text + "</td>";

	            // 작성자와 세션 사용자의 이름이 일치할 경우에만 "mode" 버튼을 추가합니다.
	            if ("${sessionScope.name}" === this.writer) {
	                reviewItem += "<td class='review-footer' data-rno='"+this.cmid+"' data-str='"+this.comment_text+"'><button id='modifyreview'>수정</button><button id='deletereview'>삭제</button></td>";
	            } else {
	                reviewItem += "<td class='review-footer'></td>"; // 작성자가 아닐 경우 버튼 없이 빈 공간으로 처리합니다.
	            }

	            reviewItem += "</tr>";
	            str += reviewItem;
	        });
		}
		
		$("#review-list").html(str);	 

		printPaging(data.pageMaker); // Map 타입의 속성 pageMaker
	});
}

//pageMaker를 이용해서 화면에 페이지 번호를 출력
//상단에 getPageList(1); 추가
function printPaging(pageMaker){
	var str = "";

	if(pageMaker.prev){
		str += "<li><a href='" + (pageMaker.startPage - 1) + "'> << </a></li>";
	}

	for(var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++){
        var strClass = pageMaker.criteria.page == i ? 'class="active"' : '';
        str += "<li " + strClass + "><a href='" + i + "'>" + i + "</a></li>";
    }

    if(pageMaker.next){
        str += "<li><a href='" + (pageMaker.endPage + 1) + "'> >> </a></li>";
    }

	$('.pagination').html(str);
}

//상단에 replyPage=1; 추가
$(".pagination").on("click", "li a", function(event){
	event.preventDefault(); // <a href="">태그의 기본 동작인 페이지 전환을 막는 역활을 한다.
	var replyPage = $(this).attr("href"); // 클릭된 페이지의 번호를 얻는 역활을 한다.
	getCommentPageList(replyPage);
});
</script>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>