<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <%@ include file="/WEB-INF/views/admin/include_admin/common.jsp" %>
  <title>배너 신청 목록</title>
  <script>
		var result = "${msg}";
	
		if(result == "ok"){
			alert("배너요청이 승인되었습니다.");
			window.close();
		}else if(result == "del"){
			alert("배너요청이 취소되었습니다.");
			window.close();
		}
	  // Function to open popup window
	  function popup(url) {
	    var popupWidth = 700;
	    var popupHeight = 690;
	    var monitorLeft = window.screenLeft || window.screenX || 0;
	    var monitorTop = window.screenTop || window.screenY || 0;
	    var monitorWidth = window.screen.availWidth || 700;
	    var monitorHeight = window.screen.availHeight || 690;
	    var popupX = monitorLeft + (monitorWidth / 2) - (popupWidth / 2);
	    var popupY = monitorTop + (monitorHeight / 2) - (popupHeight / 2);
	    window.open(url, 'view', 'width=' + popupWidth + ',height=' + popupHeight + ',left=' + popupX + ',top=' + popupY);
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
                  <h3 class="card-title"><b>배너신청목록</b></h3>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                  <table id="memberTable" class="table table-bordered table-striped">
                    <thead>
                      <tr>
                        <th>번호</th>
                        <th>상호명</th>
                        <th>제목</th>
                        <th>이미지</th>
                        <th>제안가격</th>
                        <th>요청날짜</th>
                        <th>게시시작일</th>
                        <th>게시종료일</th>
                        <th>승인상태</th>
                        <th>활성여부</th>
                        <th>기능</th>
                      </tr>
                    </thead>
                    <tbody>
                      <!-- 회원 목록 데이터 반복 출력 -->
                      <c:set var="number" value="${pageMaker.totalCount - (pageMaker.criteria.page - 1) * pageMaker.criteria.perPageNum }" />
                      <c:forEach var="banner" items="${bannerList}">
                        <tr>
                          <td style="vertical-align: middle;">${number}</td>
                          <td style="vertical-align: middle;">${banner.mutual}</td>
                          <td style="vertical-align: middle;">${banner.title}</td>
                          <td style="vertical-align: middle;"><img src="/banner_submit/${banner.imageurl}" style="width: 250px; height: 100px;"/></td>
                          <td style="vertical-align: middle;"><fmt:formatNumber value="${banner.bprice}" pattern="#,##0원"/></td>
                          <td style="vertical-align: middle;">${banner.requestdate}</td>
                          <td style="vertical-align: middle;">${banner.startdate}</td>
                          <td style="vertical-align: middle;">${banner.enddate}</td>
                          <td style="vertical-align: middle;">${banner.approved}</td>
                          <td style="vertical-align: middle;">
                            <button class="btn btn-toggle-status ${banner.status == '활성화' ? 'btn-success' : 'btn-secondary'}" data-bid="${banner.bid}" data-status="${banner.status}">
                              ${banner.status == '활성화' ? '활성화' : '비활성화'}
                            </button>
                          </td>
                          <td style="vertical-align: middle;">
                            <button type="button" class="btn btn-primary btn-ok" onclick="popup('/admin/manageBanner/okBanner?bid=${banner.bid}')">승인</button>
                            <button type="button" class="btn btn-danger btn-del" onclick="popup('/admin/manageBanner/delBanner?bid=${banner.bid}')">취소</button>
                          </td>
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
  <!-- footer -->
  <%@ include file="/WEB-INF/views/admin/include_admin/footer.jsp" %>
  <!-- DataTables Initialization -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
  <script>
    $(document).ready(function () {
      $("#memberTable").DataTable({
        "responsive": true,
        "autoWidth": false
      });

      // Event listener for status toggle buttons
      $('.btn-toggle-status').on('click', function() {
        var bid = $(this).data('bid');
        var currentStatus = $(this).data('status');
        var newStatus = currentStatus === '활성화' ? '비활성화' : '활성화';

        $.ajax({
          url: '/admin/manageBanner/toggleStatus',
          method: 'POST',
          data: { bid: bid, status: newStatus },
          success: function(data) {
            if (data.success) {
              // Update button appearance based on new status
              $(this).toggleClass('btn-success btn-secondary');
              $(this).text(newStatus === '활성화' ? '활성화' : '비활성화');
              $(this).data('status', newStatus);
              alert('배너 상태가 성공적으로 변경되었습니다: ' + newStatus);
            } else {
              alert('상태 변경에 실패했습니다.');
            }
          },
          error: function(xhr, status, error) {
            console.error('Error:', error);
            alert('서버와의 통신 중 오류가 발생했습니다.');
          }
        });
      });
    });
  </script>
</body>
</html>
