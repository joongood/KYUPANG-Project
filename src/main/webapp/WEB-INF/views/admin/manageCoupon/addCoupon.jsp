<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="/WEB-INF/views/admin/include_admin/common.jsp" %>
</head>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
    	<div class="content-wrapper" style="width:800px; height:350;">
	     <h2 align="center" style="padding-top:5%;">쿠폰양식추가</h2>
	     <br>
	     <form method="POST">
	           <div class="form-group">
	             	<label for="description">설명</label>
	             	<input type="text" class="form-control" id="description" name="description" placeholder="설명을 입력해주세요." required>
	           </div>
	           <div class="form-group">
	             	<label for="discount">할인</label>
	             	<input type="text" class="form-control" id="discount" name="discount" placeholder="할인율을 소수점단위로 입력해주세요(ex. 0.1 ...)" required>
	           </div>
		       <div class="form-group">
	             	<label for="expirydate">유효기간</label>
	             	<input type="date" class="form-control" id="expirydate" name="expirydate" required>
	           </div>
	           <div class="form-group">
	             	<label for="minpurchase">최소구매금액(조건)</label>
	             	<input type="text" class="form-control" id="minpurchase" name="minpurchase" placeholder="최소금액조건이 없을경우 0을 입력해주세요." required>
	           </div>
	          <button type="submit" class="btn btn-primary" id="joinbutton">쿠폰양식추가</button>
	       </form>
       </div>
   </div>
</body>
</html>