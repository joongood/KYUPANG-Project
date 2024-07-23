<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="/WEB-INF/views/admin/include_admin/common.jsp" %>
</head>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
    	<div class="content-wrapper" style="width:800px; height:350;">
	     <h2 align="center" style="padding-top:5%;">카테고리 추가</h2>
	     <br>
	     <form method="POST">
	           <div class="form-group">
	             	<label for="cid">카테고리코드</label>
	             	<input type="text" class="form-control" id="cid" value="${modify.cid}" required>
	           </div>
	           <div class="form-group">
	             	<label for="cname">카테고리명</label>
	             	<input type="text" class="form-control" id="cname" name="cname" value="${modify.cname}" required>
	           </div>
			   <div class="form-group">
		            <label for="cuse">사용여부</label>
		            <c:choose>
		            	<c:when test="${modify.cuse == 'Y'}">
				            <select class="form-control" id="cuse" name="cuse">
				                <option>Y</option>
				                <option>N</option>
				            </select>
		            	</c:when>
		            	<c:otherwise>
		            		<select class="form-control" id="cuse" name="cuse">
				                <option>N</option>
				                <option>Y</option>
				            </select>
		            	</c:otherwise>
		            </c:choose>
		        </div>
	          <button type="submit" class="btn btn-primary" id="joinbutton">수정하기</button>
	       </form>
       </div>
   </div>
</body>
</html>