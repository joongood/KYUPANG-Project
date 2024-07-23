<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
    .container11 {
        margin: 0 auto;
        max-width: 900px;
        margin-top: 50px;
        margin-bottom: 50px;
    }
    .text-center {
        text-align: center;
    }
    .wishlist-item img {
        max-width: 80px; /* 이미지 크기 줄임 */
        height: auto;
    }
    .table .product-name {
        max-width: 200px; /* 상품명 최대 너비 */
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }
	.transaction-detail {
	    padding-left: 20px;
	    border-left: 2px solid #ccc;
	    margin-top: 10px;
	    max-height: 900px;
	    display: none;
	    overflow-y: scroll !important; /* 무조건 세로 스크롤 추가 */
	}
    .transaction-detail.show {
        display: block;
    }
    .sidebar {
        margin-top: 100px;
        margin-left: 170px;
        float: right;
    }
</style>
<div class="col-md-3">
    <div class="list-group sidebar">
        <a href="/mypage/mainMypage" class="list-group-item list-group-item-action">Home</a>
        <a href="/mypage/memberJoinUp" class="list-group-item list-group-item-action">회원정보수정</a>
        <a href="/mypage/translist" class="list-group-item list-group-item-action active">구매내역 및 환불</a>
        <a href="/mypage/couponlist" class="list-group-item list-group-item-action">쿠폰목록</a>
        <a href="/mypage/wishlist" class="list-group-item list-group-item-action">위시리스트</a>
    </div>
</div>

<div class="container11">
    <h1 class="text-center mb-4">주문내역</h1>
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead class="thead-light">
                        <tr>
                            <th width="100px" style="vertical-align:middle;">번호</th>
                            <th width="100px">이미지</th>
                            <th width="400px" style="vertical-align:middle;">상품명</th>
                            <th width="120px" style="vertical-align:middle;">가격</th>
                            <th width="100px" style="vertical-align:middle;">거래상태</th>
                            <th width="100px" style="vertical-align:middle;">상세보기</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <%-- 구매내역이 없을 경우 --%>
                            <c:when test="${empty cartList}">
                                <tr>
                                    <td colspan="7" class="text-center">구매내역이 없습니다.</td>
                                </tr>
                            </c:when>
                            <%-- 구매내역이 있을 경우 --%>
                            <c:otherwise>
                                <c:set var="number" value="${pageMaker.totalCount - (pageMaker.criteria.page - 1) * pageMaker.criteria.perPageNum}" />
                                <c:forEach var="cart" items="${cartList}" varStatus="status">
                                    <input type="hidden" id="cart" name="cart" value="${cart.cart}">
                                    <input type="hidden" id="pid" name="pid" value="${cart.pid}">
                                    <input type="hidden" id="odid" name="odid" value="${cart.odid}">
                                    <tr class="wishlist-item" style="font-size: 15px;">
                                        <td style="vertical-align:middle;">${status.index + 1}</td>
                                        <td style="vertical-align:middle;" class="product-thumbnail">
                                            <img style="width:145px; height:80px" alt="poster_1_up" class="shop_thumbnail" src="/product_upload/${cart.file1}">
                                        </td>
                                        <c:choose>
                                            <c:when test="${orderCountMap[cart.odid] > 1}">
                                                <td style="vertical-align:middle; font-size: 15px;" class="product-name">${cart.pname} 외 ${orderCountMap[cart.odid] - 1}개</td>
                                            </c:when>
                                            <c:otherwise>
                                                <td style="vertical-align:middle; font-size: 15px;" class="product-name">${cart.pname}</td>
                                            </c:otherwise>
                                        </c:choose>
                                        <td style="vertical-align:middle;" class="product-subtotal">
                                            <span class="amount"><fmt:formatNumber type="number" value="${cart.payprice}" pattern="#,###" />원</span>
                                        </td>
                                        <td style="vertical-align:middle; font-size: 15px;" class="product-name">${cart.transtatus}</td>
                                        <td style="vertical-align:middle;">
                                            <button class="detail-btn" data-odid="${cart.odid}" style="border:none; background:none; font-size:16px;">상세보기</button>
                                            <button class="close-btn" data-odid="${cart.odid}" style="border:none; background:none; font-size:16px; display:none;">접기</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6">
                                            <!-- 상세 정보를 동적으로 업데이트할 컨테이너 -->
                                            <div class="transaction-detail" id="transactionDetail_${cart.odid}"></div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function() {
    $(".detail-btn").click(function() {
        var odid = $(this).data("odid");

        $.ajax({
            url: "/mypage/transactionlist",
            type: "GET",
            data: {
                odid: odid
            },
            dataType: "html",
            success: function(response) {
                // AJAX로 받아온 HTML을 해당 상품의 컨테이너에 삽입
                $("#transactionDetail_" + odid).html(response);
                // 상세 정보를 펼치기
                $("#transactionDetail_" + odid).slideDown();
                // 상세보기 버튼 숨기고, 접기 버튼 보이도록 처리
                $(".detail-btn[data-odid='" + odid + "']").hide();
                $(".close-btn[data-odid='" + odid + "']").show();
                // 상세 정보를 표시하기 위해 클래스 추가
                $("#transactionDetail_" + odid).addClass("show");
            },
            error: function() {
                alert("상세 내역을 불러오는 중 오류가 발생했습니다.");
            }
        });
    });

    // 접기/펼치기 버튼 클릭 시 상세 정보 토글
    $(document).on("click", ".close-btn", function() {
        var odid = $(this).data("odid");
        var detailDiv = $("#transactionDetail_" + odid);

        if (detailDiv.is(":visible")) {
            detailDiv.slideUp(); // 상세 정보 숨김
            // 접기 버튼 숨기고, 상세보기 버튼 보이도록 처리
            $(this).hide();
            $(".detail-btn[data-odid='" + odid + "']").show();
            // 상세 정보를 숨기기 위해 클래스 제거
            detailDiv.removeClass("show");
        } else {
            detailDiv.slideDown(); // 상세 정보 펼침
            // 상세보기 버튼 숨기고, 접기 버튼 보이도록 처리
            $(".detail-btn[data-odid='" + odid + "']").hide();
            $(this).show();
            // 상세 정보를 표시하기 위해 클래스 추가
            detailDiv.addClass("show");
        }
    });
});
</script>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
