<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script>
	var result = "${msg}";

	if(result == "del"){
		alert("상품 삭제가 완료되었습니다.");
		window.close();
	}
</script>
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
</head>
<body class="hold-transition sidebar-mini">
  <div class="wrapper">
  <!-- navbar -->
  <%@ include file="/WEB-INF/views/admin/include_admin/navbar.jsp" %>
  <!-- main slide -->
  <%@ include file="/WEB-INF/views/admin/include_admin/mainslide.jsp" %>
    <div class="content-wrapper">
      <section class="content" style="padding-top:40px;">
        <div class="container-fluid">
          <div class="row">
            <div class="col-12">
              <div class="card">
                <div class="card-header">
                  <h3 class="card-title"><b>상품목록</b></h3>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                  <table id="memberTable" class="table table-bordered table-striped">
                    <thead>
                      <tr>
                        <th>번호</th>
                        <th>썸네일</th>
                        <th>상품명</th>
                        <th>상품가격</th>
                        <th>수량</th>
                        <th>대분류</th>
                        <th>중분류</th>
                        <th>판매게시일</th>
                        <th>조회수</th>
                      </tr>
                    </thead>
                    <tbody>
                      <!-- 회원 목록 데이터 반복 출력 -->
                      <c:set var="number" value="${pageMaker.totalCount - (pageMaker.criteria.page - 1) * pageMaker.criteria.perPageNum }" />
                      <c:forEach var="product" items="${productList}">
                        <tr>
                          <td>${number }</td>
                          <td><img src="/product_upload/${product.file1}" style="width: 50px; height: 50px;"/></td>
                          <td>
                          	<span onclick="popup('/admin/manageProduct/detailProduct?pid=${product.pid}')">
							  	<c:choose>
	                                <c:when test="${fn:length(product.pname) > 10}">
	                                    ${fn:substring(product.pname, 0, 10)}...
	                                </c:when>
	                                <c:otherwise>
	                                    ${product.pname}
	                                </c:otherwise>
	                            </c:choose>
						  	</span>
						  </td>
                          <td><fmt:formatNumber value="${product.price}" pattern="#,##0 원"/></td>
                          <td>${product.qty}개</td>
                          <td>${product.maincate}</td>
                          <td>${product.middlecate}</td>
                          <td>${product.listingdate}</td>
                          <td>${product.readcount}</td>
                        </tr>
                        <c:set var="number" value="${number - 1 }"/> 
                      </c:forEach>
                    </tbody>
                  </table>
                </div>
                <!-- /.card-body -->
                <div class="card-footer">
                  <div class="row">
                    <div class="col-sm-12 col-md-12">
                      <ul class="pagination justify-content-center">
                        <c:if test="${pageMaker.prev}">
                          <li class="page-item"><a class="page-link" href="?page=${pageMaker.startPage - 1}">&laquo;</a></li>
                        </c:if>
                        <c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                          <li class="page-item ${pageMaker.criteria.page == i ? 'active' : ''}"><a class="page-link" href="?page=${i}">${i}</a></li>
                        </c:forEach>
                        <c:if test="${pageMaker.next}">
                          <li class="page-item"><a class="page-link" href="?page=${pageMaker.endPage + 1}">&raquo;</a></li>
                        </c:if>
                      </ul>
                    </div>
                  </div>
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
<%@ include file="/WEB-INF/views/admin/include_admin/footer.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script>
  $(function () {
    $("#memberTable").DataTable({
      "responsive": true,
      "autoWidth": true,
      "searching": true,
      "paging": true,
      "pagingType": "full_numbers"
    });
  });
</script>
</html>
