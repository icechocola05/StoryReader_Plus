<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<%@ include file="head.html" %>
<head>
	<link rel="stylesheet" href="CSS/chooseInput.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="main">
		<div>
			<img class="prog" src="./Img/1.png" alt="image">
		</div>
		
		<div class="select">
			<span>텍스트 등록 방식을 정해주세요!</span> <br>
			<c:set var="user" scope="page" value="${sessionScope.currUser }" />
			<c:choose>
	  			<c:when test="${user eq null }">
	  				<button class="input_btn1" onclick="alertLogin();">텍스트 파일로 등록하기</button> <br>
					<button class="input_btn2" onclick="alertLogin();">직접 입력하기</button>
	  			</c:when>
	  			<c:otherwise>
		  			<button class="input_btn1" onclick="location='fileInput.jsp'">텍스트 파일로 등록하기</button> <br>
					<button class="input_btn2" onclick="location='textInput.jsp'">직접 입력하기</button>
	  			</c:otherwise>
	  		</c:choose>
		</div>
		
	</div>
	<script type="text/javascript" src="js/logout.js" charset="UTF-8"></script>
	<c:remove var="userId" scope="page" />
</body>
</html> 