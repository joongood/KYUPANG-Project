<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
    /* Custom CSS styles */
    .container11 {
        margin-top: 50px;
        margin-bottom: 50px;
        margin-left: 400px;
        witdh: 100%;
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
    }
    .form-table {
        width: 100%;
        max-width: 600px;
        margin: 0 auto;
        border-collapse: collapse; /* 테이블 경계선이 합쳐지도록 설정 */
    }
    .form-table th, .form-table td {
        padding: 10px;
        border: 1px solid #dee2e6; /* 경계선 스타일 지정 */
    }
    .form-table th {
        background-color: #f8f9fa; /* 헤더 배경색 */
        font-weight: bold;
    }
    .form-table input[type="text"] {
        width: calc(100% - 10px);
        padding: 10px;
        margin: 5px 0;
        border: 1px solid #ced4da;
        border-radius: 4px;
    }
    .form-table textarea {
        width: calc(100% - 10px);
        height: 500px;
        padding: 10px;
        margin: 5px 0;
        border: 1px solid #ced4da;
        border-radius: 4px;
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
</style>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/smarteditor/2.8.2/js/HuskyEZCreator.js" charset="utf-8"></script>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/smarteditor/2.8.2/css/smart_editor2.css">

<script type="text/javascript">
    $(document).ready(function() {
        var oEditors = [];

        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "contenttext",  // 에디터가 적용될 textarea의 id
            sSkinURI: "https://cdnjs.cloudflare.com/ajax/libs/smarteditor/2.8.2/SmartEditor2Skin.html",
            fCreator: "createSEditor2"
        });

        // 폼 제출 시 내용을 업데이트
        $("form").submit(function(e) {
            oEditors.getById["contenttext"].exec("UPDATE_CONTENTS_FIELD", []);  // 에디터의 내용을 textarea에 반영
        });
    });
</script>
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
                <h3 style="text-align:center;">글수정</h3>
                <div class="card-body">
                    <form action="/board/boardmodify" method="post" enctype="multipart/form-data">
                    <input type="hidden" id="bid" name="bid" value="${modify.bid }">
                        <table class="form-table">
                            <tr>
                                <th>제목</th>
                                <td><input id="title" name="title" type="text" value="${modify.title }" read></td>
                            </tr>
                            <tr>
                                <th>내용</th>
                                <td><textarea id="contenttext" name="contenttext" required>${modify.contenttext }</textarea></td>
                            </tr>
                            <tr>
                                <th>파일 첨부</th>
                                <td><input type="file" id="file1" name="file1" value="${modify.file1}" ></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: right;">
                                    <button type="submit" onclick="return checkWritePermission()">수정하기</button>
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
