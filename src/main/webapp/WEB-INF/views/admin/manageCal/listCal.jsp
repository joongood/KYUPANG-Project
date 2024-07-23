<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script>
	var result = "${msg}";

	if(result == "cal"){
		alert("정산요청이 정상적으로 승인되었습니다.");
		window.close();
	}
</script>
  <%@ include file="/WEB-INF/views/admin/include_admin/common.jsp" %>
<script>
    // 회원 정보 상세 보기
    function popup(url){
        var popupWidth = 800;
        var popupHeight = 350;

        // 서브모니터의 위치 및 크기 가져오기
        var monitorLeft = window.screenLeft || window.screenX || 0;
        var monitorTop = window.screenTop || window.screenY || 0;
        var monitorWidth = window.screen.availWidth || 800;
        var monitorHeight = window.screen.availHeight || 350;

        // 팝업 위치 계산
        var popupX = monitorLeft + (monitorWidth / 2) - (popupWidth / 2);
        var popupY = monitorTop + (monitorHeight / 2) - (popupHeight / 2);

        // 팝업 창 열기
        window.open(url, "view", "width="+popupWidth+",height="+popupHeight+",left="+popupX+",top="+popupY);
    }  
</script>
<!-- DataTables CSS -->
<link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.1.0/css/buttons.dataTables.min.css">
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
                  <h3 class="card-title"><b>정산관리</b></h3>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                  <table id="memberTable" class="table table-bordered table-striped">
                    <thead>
                      <tr>
                        <th>번호</th>
                        <th>상품</th>
                        <th>상품명</th>
                        <th>주문번호</th>
                        <th>거래승인일</th>
                        <th>결제금액</th>
                        <th>수량</th>
                        <th>결제상태</th>
                        <th>결제방법</th>
                        <th>정산상태</th>
                        <th>승인</th>
                      </tr>
                    </thead>
                    <tbody>
                      <!-- 회원 목록 데이터 반복 출력 -->
                      <c:set var="number" value="${pageMaker.totalCount - (pageMaker.criteria.page - 1) * pageMaker.criteria.perPageNum }" />
                      <c:forEach var="calList" items="${calList}">
                        <tr>
                          <td>${number}</td>
                          <td><img src="/product_upload/${calList.file1}" style="width: 50px; height: 50px;"/></td>
                          <td>${calList.pname}</td>
                          <td>${calList.odid}</td>
                          <td>${calList.trandate}</td>
                          <td><fmt:formatNumber value="${calList.price}" pattern="#,##0원"/></td>
                          <td>${calList.qty}개</td>
                          <td>${calList.transtatus}</td>
                          <td>${calList.paymethod}</td>
                          <td>${calList.cal}</td>
						  <td>
			                <c:if test="${calList.cal != '정산완료'}">
			                    <button id="requestButton" style="border:none; background:none; color:blue" onclick="popup('/admin/manageCal/updateCal?ctid=${calList.ctid}')">승인</button>
			                </c:if>
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
</body>
<!-- footer -->
<%@ include file="/WEB-INF/views/admin/include_admin/footer.jsp" %>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.1.0/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.1.0/js/buttons.flash.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.1.0/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.1.0/js/buttons.print.min.js"></script>

<script>
  $(function () {
    $("#memberTable").DataTable({
      "responsive": true,
      "autoWidth": true,
      "searching": true,
      "paging": true,
      "pagingType": "full_numbers",
      "dom": 'Bfrtip', // 엑셀 저장 버튼을 추가하기 위한 DOM 설정
      "buttons": [
        'excelHtml5', // 엑셀 저장 버튼
        'print' // 프린트 버튼
      ]
    });
  });
</script>
</html>
