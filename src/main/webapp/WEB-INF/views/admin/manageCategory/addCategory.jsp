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
	             	<input type="text" class="form-control" id="cid" name="cid" required>
	           </div>
	           <div class="form-group">
	             	<label for="cname">카테고리명</label>
	             	<input type="text" class="form-control" id="cname" name="cname" required>
	           </div>
	          <div class="form-group">
	              <label for="cuse">사용여부</label>
	              <select class="form-control" id="cuse" name="cuse">
	                  <option value="Y">Y</option>
	                  <option value="N">N</option>
	              </select>
	          </div>
	          <button type="submit" class="btn btn-primary" id="joinbutton">카테고리추가</button>
	       </form>
       </div>
   </div>
</body>
</html>