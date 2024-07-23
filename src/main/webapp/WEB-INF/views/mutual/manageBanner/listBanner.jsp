<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script>
	var result = "${msg}";

	if(result == "add"){
		alert("배너신청이 완료되었습니다.");
		window.close();
	}else if(result == "mod"){
		alert("배너신청 수정이 완료되었습니다.");
		window.close();
	}else if(result == "del"){
		alert("배너신청 취소가 완료되었습니다.");
		window.close();
	}
</script>
  <%@ include file="/WEB-INF/views/mutual/include_mutual/common.jsp" %>
  <%@ include file="/WEB-INF/views/mutual/include_mutual/levelstore.jsp" %>
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
</head>
<body class="hold-transition sidebar-mini">
  <div class="wrapper">
  <!-- navbar -->
  <%@ include file="/WEB-INF/views/mutual/include_mutual/navbar.jsp" %>
  <!-- main slide -->
  <%@ include file="/WEB-INF/views/mutual/include_mutual/mainslide.jsp" %>
    <div class="content-wrapper">
      <section class="content" style="padding-top:40px;">
        <div class="container-fluid">
          <div class="row">
            <div class="col-12">
              <div class="card">
                <div class="card-header">
                  <h3 class="card-title"><b>배너신청목록</b></h3>
         		  <div class="btn-group" style="margin-left:87%;">
 					<button type="button" class="btn btn-primary" onclick="popup('/mutual/manageBanner/addBanner')">배너신청</button>        		  
         		  </div>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                  <table id="memberTable" class="table table-bordered table-striped">
                    <thead>
                      <tr>
                      	<th>번호</th>
                        <th>제목</th>
                        <th>제안가격</th>
                        <th>요청날짜</th>
                        <th>게시시작일</th>
                        <th>게시종료일</th>
                        <th>승인상태</th>
                      </tr>
                    </thead>
                    <tbody>
                      <!-- 회원 목록 데이터 반복 출력 -->
                      <c:set var="number" value="${pageMaker.totalCount - (pageMaker.criteria.page - 1) * pageMaker.criteria.perPageNum }" />
                      <c:forEach var="banner" items="${bannerList}">
                        <tr>
                          <td>${number}</td>
                          <td><span onclick="popup('/mutual/manageBanner/detailBanner?bid=${banner.bid}')">${banner.title}</span></td>
                          <td><fmt:formatNumber value="${banner.bprice}" pattern="#,##0원"/></td>
                          <td>${banner.requestdate}</td>
                          <td>${banner.startdate}</td>
                          <td>${banner.enddate}</td>
                          <td>${banner.approved}</td>
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
<%@ include file="/WEB-INF/views/mutual/include_mutual/footer.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script>
  $(function () {
    $("#memberTable").DataTable({
      "responsive": true,
      "autoWidth": false,
    });
  });
</script>
</html>
