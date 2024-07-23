<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- jstl -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${sessionScope.level != '5' and sessionScope.level != '4'}">
	<script>
		alert("스토어 영역입니다. 자세한 사항은 스토어 관련 담당자에게 문의하여 주시기 바랍니다.");
		location.href="/";
	</script>
</c:if>