<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<select class="form-control" id="middlecate" name="middlecate" required>
	<option value="">=중분류 선택=</option>
	<c:forEach var="c" items="${middlecate }">
		<option value="${c.cid}">${c.cname}</option>
	</c:forEach>
</select>