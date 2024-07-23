<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
    /* Custom CSS styles */
    .container11 {
        margin-top: 50px;
        margin-bottom: 50px;
        margin-left: 340px;
        width: 100%;
    }
    .card {
        border: none;
    }
    .card-header {
        background-color: #007bff;
        color: #fff;
        font-weight: bold;
        border-bottom: none;
        border-radius: 0;
    }
    .card-body {
        padding: 0;
        text-align: center; /* 컨텐츠 가운데 정렬 */
    }
    .table {
        width: 100%; /* 테이블 폭 100% */
        border: 1px solid #dee2e6; /* 테이블 테두리 설정 */
    }
    .table th, .table td {
        border: 1px solid #dee2e6; /* 테이블 행과 열의 테두리 설정 */
        vertical-align: middle; /* 텍스트 수직 정렬 */
    }
    .table thead th {
        background-color: #f8f9fa; /* 테이블 헤더 배경색 설정 */
        border-color: #dee2e6; /* 테이블 헤더 테두리 색상 설정 */
    }
    .btn-primary {
        background-color: #007bff;
        border-color: #007bff;
        border-radius: 20px;
        padding: 10px 20px;
        font-size: 16px;
    }
    .btn-primary:hover {
        background-color: #0056b3;
        border-color: #0056b3;
    }
</style>

<script>
    <% if (request.getAttribute("msg") != null) { %>
    var msg = "<%= request.getAttribute("msg") %>";
    alert(msg);
    <% } %>

    function checkWritePermission() {
        var sessionLevel = "<%= session.getAttribute("level") %>";
        if (sessionLevel != 10 || sessionLevel == null) {
            alert("관리자만 글쓰기를 이용할 수 있습니다.");
            return false;
        }
        return true;
    }
</script>

<div class="container11">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card">
				<h3 style="text-align:center;">공지사항 게시판</h3>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead class="thead-light">
                                <tr>
                                    <th scope="col" style="width: 10%; text-align:center;">번호</th>
                                    <th scope="col" style="width: 60%; text-align:center;">제목</th>
                                    <th scope="col" style="width: 30%; text-align:center;">등록날짜</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:set var="number" value="${pageMaker.totalCount - (pageMaker.criteria.page - 1) * pageMaker.criteria.perPageNum }" />
                                <c:forEach var="list" items="${list}">
                                    <tr>
                                        <td>${number}</td>
                                        <td><a href="/board/boardview?bid=${list.bid}" style="color: #343a40; font-weight: bold;">${list.title}</a></td>
                                        <td>
                                            <fmt:formatDate value="${list.date}" pattern="yyyy년 M월 d일" />
                                        </td>
                                    </tr>
                                <c:set var="number" value="${number - 1 }"/> 
                                </c:forEach>
                            </tbody>
                        </table>
						<div class="text-right mt-4">
						    <a href="/board/boardwrite" onclick="return checkWritePermission()" class="btn btn-primary">글쓰기</a>
						</div>
                    </div>

                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <c:if test="${pageMaker.prev}">
                                <li class="page-item">
                                    <a class="page-link" href="?mutual=${mutual}&cid=${cid}&page=${pageMaker.startPage - 1}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                        <span class="sr-only">Previous</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                                <li class="page-item ${pageMaker.criteria.page == i ? 'active' : ''}">
                                    <a class="page-link" href="?mutual=${mutual}&cid=${cid}&page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${pageMaker.next}">
                                <li class="page-item">
                                    <a class="page-link" href="?mutual=${mutual}&cid=${cid}&page=${pageMaker.endPage + 1}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                        <span class="sr-only">Next</span>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
