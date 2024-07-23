<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>규팡 관리자 페이지</title>

  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="/plugins/fontawesome-free/css/all.min.css">
  <!-- fullCalendar -->
  <link rel="stylesheet" href="/plugins/fullcalendar/main.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/dist/css/adminlte.min.css">
  
  <!-- Custom CSS -->
  <link rel="stylesheet" href="/css/owl.carousel.css">
  <link rel="stylesheet" href="/css/style.css">
  <link rel="stylesheet" href="/css/responsive.css">
  
  <!-- css -->
  <link rel="stylesheet" href="/css/join.css">
  <link rel="stylesheet" href="/css/productimg.css">
  
  <!-- jstl -->
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  
  <!-- jquery -->
  <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
  <script src="http://code.jquery.com/jquery-migrate-1.4.1.min.js"></script>
  
  <!-- js -->
  <script src="/js/reg.js"></script>
  <script src="/js/joinupreg.js"></script>
  <script src="/js/storereg.js"></script>
  <script src="/js/storemodifyreg.js"></script>
  <script src="/js/adminjoinreg.js"></script>
  <script src="/js/adminjoinupreg.js"></script>
  <script src="/js/adminstorereg.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="/js/daumadrr.js"></script>
  <script src="/js/point_cal.js"></script>
  <script src="/js/sale_cal.js"></script>
  <script src="/js/disable_salebox.js"></script>
  <script src="/js/add_option.js"></script>
  <script src="/js/imgupload.js"></script>
  
<c:if test="${sessionScope.level != '5' and sessionScope.level != '4'}">
    <script>
        alert("가맹점 영역입니다.");
        location.href="/";
    </script>
</c:if>
	  
</head>
