<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<label for="option">옵션</label>
<select class="form-control" id="option" name="option">
    <c:forEach items="${optionList}" var="opt">
        <option value="${opt.option_value1}">${opt.option_value1}</option>
        <option value="${opt.option_value2}">${opt.option_value2}</option>
        <option value="${opt.option_value3}">${opt.option_value3}</option>
        <option value="${opt.option_value4}">${opt.option_value4}</option>
        <option value="${opt.option_value5}">${opt.option_value5}</option>
    </c:forEach>
</select>