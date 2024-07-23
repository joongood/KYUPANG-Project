<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
	.join-container{
		margin: 0 auto;
		width: 500px;
		padding-top: 3%;
		padding-bottom: 3%;
	}
</style>
<body>
	<div class="join-container">
		<h2 align="center">회원수정</h2>
		<br>
		<form action="/member/s_memberJoinUp" method="POST">
			<input type="hidden" id="identification" name="identification" value="Y">
			<div class="form-group">
	            <label for="memail">아이디</label>
	            <input type="text" class="form-control" id="memail" name="memail" value="${sessionScope.id}" readonly>
	        </div>
	        <br>
	        <div class="form-group">
	            <label for="mname">이름</label>
	            <input type="text" class="form-control" id="mname" name="mname" value="${update.mname}" required>
	        </div>
	        <br>
	        <div class="form-group">
	            <label for="mage">생년월일</label>
	            <input type="date" class="form-control" id="mage" name="mage" value="${update.mage}" required>
	        </div>
	        <br>
	        <div class="form-group">
	            <label for="mphone">전화번호</label>
	            <input type="text" class="form-control" id="mphone" name="mphone" value="${update.mphone}" required>
	        </div>
	        <br>
	        <div class="form-group">
	            <label for="zipcode">우편번호</label>
	            <input type="text" class="form-control" id="zipcode" name="zipcode" value="${update.zipcode}" required>
	            <button type="button" class="btn btn-primary" onclick="openZipSearch()">주소검색</button>
	        </div>
	        <br>
	        <div class="form-group">
	            <label for="address">주소</label>
	            <input type="text" class="form-control" id="address" name="address" value="${update.address}" required>
	        </div>
	        <br>
	        <div class="form-group">
	            <label for="addressdetail">상세주소</label>
	            <input type="text" class="form-control" id="addressdetail" name="addressdetail" value="${update.addressdetail}" required>
	        </div>
	        <br>
			<div class="form-group">
	            <label for="mgender">성별</label>
	            <c:choose>
	            	<c:when test="${update.mgender == '남자'}">
			            <select class="form-control" id="mgender" name="mgender">
			                <option>남자</option>
			                <option>여자</option>
			            </select>
	            	</c:when>
	            	<c:otherwise>
	            		<select class="form-control" id="mgender" name="mgender">
			                <option>여자</option>
			                <option>남자</option>
			            </select>
	            	</c:otherwise>
	            </c:choose>
	        </div>
	        <br>
	        <button type="submit" class="btn btn-primary">회원수정</button>
	    </form>
	</div>
</body>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>