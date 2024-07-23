<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<body>
	<div class="join-container">
		<h2 align="center">회원수정</h2>
		<br>
		<form action="/member/memberJoinUp" method="POST" onsubmit="return member_modify();">
			<div class="form-group">
	            <label for="memail">아이디</label>
	            <input type="text" class="form-control" id="memail" name="memail" value="${update.memail}" readonly>
	        </div>
	        <br>
	        <input type="button" class="form-control" style="color:white;background-color: #428BCA" id="password_button" value="비밀번호 수정" onclick="pass_show();">
	        <div class="form-group" style="display: none">
	            <label for="mpassword">비밀번호</label>
	            <input type="password" class="form-control" id="mpassword" name="mpassword" value="${update.mpassword}" >
	        </div>
	        <div class="form-group" style="display: none">
	            <label for="mpassword_check">비밀번호확인</label>
	            <input type="password" class="form-control" id="mpassword_check" name="mpassword_check" value="${update.mpassword}" >
	        </div>
	        <br>
	        <div class="form-group">
	            <label for="mname">이름</label>
	            <input type="text" class="form-control" id="mname" name="mname" value="${update.mname}" >
	        </div>
	        <br>
	        <div class="form-group">
	            <label for="mage">생년월일</label>
	            <input type="date" class="form-control" id="mage" name="mage" value="${update.mage}" >
	        </div>
	        <br>
	        <div class="form-group">
	            <label for="mphone">전화번호</label>
	            <input type="text" class="form-control" id="mphone" name="mphone" value="${update.mphone}" >
	        </div>
	        <br>
	        <div class="form-group">
	            <label for="zipcode">우편번호</label>
	            <input type="text" class="form-control" id="zipcode" name="zipcode" value="${update.zipcode}" >
	            <button type="button" class="btn btn-primary" onclick="openZipSearch()">주소검색</button>
	        </div>
	        <br>
	        <div class="form-group">
	            <label for="address">주소</label>
	            <input type="text" class="form-control" id="address" name="address" value="${update.address}" >
	        </div>
	        <br>
	        <div class="form-group">
	            <label for="addressdetail">상세주소</label>
	            <input type="text" class="form-control" id="addressdetail" name="addressdetail" value="${update.addressdetail}" >
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