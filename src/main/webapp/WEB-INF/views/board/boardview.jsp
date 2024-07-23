<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
    /* Custom CSS styles */
    .container11 {
        margin-top: 50px;
        margin-bottom: 50px;
        margin-left: 330px;
        width: 100%;
    }
    .card-header {
        background-color: #007bff;
        color: #fff;
        font-weight: bold;
        border-bottom: none;
        border-radius: 0;
        padding: 15px;
    }
    .card-body {
        padding: 20px;
    }
    .form-table {
        width: 100%;
        max-width: 600px;
        margin: 0 auto;
        border-collapse: collapse;
    }
    .form-table th, .form-table td {
        padding: 10px;
        border: 1px solid #dee2e6;
    }
    .form-table th {
        background-color: #f8f9fa;
        font-weight: bold;
    }
    .form-table input[type="text"], .form-table textarea {
        width: calc(100% - 22px);
        padding: 10px;
        margin: 5px 0;
        border: 1px solid #ced4da;
        border-radius: 4px;
    }
    .form-table textarea {
        height: 500px;
    }
    .form-table input[type="file"] {
        margin-top: 5px;
    }
    .form-table button {
        padding: 10px 20px;
        background-color: #007bff;
        border: none;
        color: #fff;
        font-size: 16px;
        cursor: pointer;
    }
    .form-table button:hover {
        background-color: #0056b3;
    }
    .form-table a button {
        margin-right: 10px;
    }
</style>

<script>
    $(document).ready(function() {
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
    });
</script>

<div class="container11">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card">
                <div class="card-body">
                    <form action="/board/boardwrite" method="post" enctype="multipart/form-data">
                        <table class="form-table">
                            <tr>
                                <th>제목</th>
                                <td><input id="title" name="title" type="text" value="${view.title}" readonly></td>
                            </tr>
                            <tr>
                                <th>내용</th>
                                <td><textarea id="contenttext" name="contenttext" readonly>${view.contenttext}</textarea></td>
                            </tr>
                            <tr>
                                <th>첨부파일</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty view.file1}">
                                            <a href="/board_upload/${view.file1}" download="${view.file1}">${view.file1}</a>
                                        </c:when>
                                        <c:otherwise>첨부 파일 없음</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: right;">
                                    <a href="/board/boardlist"><button type="button">전체 게시물</button></a>
                                    <a href="/board/boardmodify?bid=${view.bid}" onclick="return checkWritePermission()"><button type="button">수정</button></a>
                                    <a href="/board/deleteBoard?bid=${view.bid}"><button type="button">삭제</button></a>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
