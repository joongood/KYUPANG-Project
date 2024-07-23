<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <%@ include file="/WEB-INF/views/admin/include_admin/common.jsp" %>
  <script>
	var result = "${msg}";

	if(result == "suc"){
		alert("카테고리 추가가 완료되었습니다.");
		window.close();
	}else if(result == "modify"){
		alert("카테고리 수정이 완료되었습니다.");
		window.close();
	}else if(result == "del"){
		alert("카테고리 삭제가 완료되었습니다.");
		window.close();
	}
</script>
<script>
    // 회원 정보 상세 보기
    function popup(url){
        var popupWidth = 800;
        var popupHeight = 350;

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
                  <h3 class="card-title"><b>카테고리 관리</b></h3>
         		  <div class="btn-group" style="margin-left:92%;">
 					<button type="button" class="btn btn-primary" onclick="popup('/admin/manageCategory/addCategory')">카테고리추가</button>        		  
         		  </div>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                  <table id="memberTable" class="table table-bordered table-striped">
                    <thead>
                      <tr>
                        <th>코드</th>
                        <th>카테고리명</th>
                        <th>사용여부</th>
                        <th>기능</th>
                      </tr>
                    </thead>
                    <tbody>
                      <!-- 회원 목록 데이터 반복 출력 -->
                      <c:forEach var="cate" items="${cateList}">
                        <tr>
                          <td>
                          	<c:set var="id_len" value="${cate.cid }" />
                          	<c:forEach var="id_num" begin="1" end="${fn:length(id_len)-2}" step="1">
								&nbsp;
							</c:forEach>
							${cate.cid }
                          </td>
                          <td>${cate.cname}</td>
                          <td>${cate.cuse}</td>
                          <td style="text-align:center;">
                          	<button type="button" class="btn btn-primary" onclick="popup('/admin/manageCategory/modifyCategory?cid=${cate.cid}')">수정</button>
                          	<button type="button" class="btn btn-danger"  onclick="popup('/admin/manageCategory/delCategory?cid=${cate.cid}')">삭제</button>
                          </td>
                        </tr>
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
<script>
  $(function () {
    $("#memberTable").DataTable({
      "responsive": true,
      "autoWidth": false,
    });
  });
</script>
</html>
