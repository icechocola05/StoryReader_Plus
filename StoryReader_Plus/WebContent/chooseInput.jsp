<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Story Reader</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@500&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="CSS/chooseInput.css">
</head>
<body>
	<div class="head">
		<span class = "title-section">Story Reader</span>
		<span class = "user-section">
			<c:set var="user" scope="page" value="${sessionScope.currUser }" />
	  		<c:choose>
	  			<c:when test="${user eq null }">
	  				<a href="login.jsp" class="user-button">로그인</a>
	  				<a href="join.jsp" class="user-button">회원가입</a>
	  			</c:when>
	  			<c:otherwise>
	  			<form id="f" name = "post" action = "logout">
	  				<a href="mypage.jsp" class="user-button">마이페이지</a>
	  				<a href="javascript:void(0);" onclick="doLogout();" class="user-button">로그아웃</a>
	  			</form>
	  			</c:otherwise>
	  		</c:choose>
		</span>
	</div>
	<div class="main">
		<div>
			<img class="prog" src="./Img/1.png" alt="image">
		</div>
		
		<div class="select">
			<span>텍스트 등록 방식을 정해주세요!</span> <br>
			<c:choose>
	  			<c:when test="${user eq null }">
	  				<button class="input_btn1" onclick="alertLogin();">텍스트 파일로 등록하기</button> <br>
					<button class="input_btn2" onclick="alertLogin();">직접 입력하기</button>
	  			</c:when>
	  			<c:otherwise>
		  			<button class="input_btn1" onclick="location='test.jsp'">텍스트 파일로 등록하기</button> <br>
					<button class="input_btn2" onclick="location='test.jsp'">직접 입력하기</button>
	  			</c:otherwise>
	  		</c:choose>
			
		</div>
		
	</div>
	<script type="text/javascript" src="js/logout.js" charset="UTF-8"></script>
	<c:remove var="userId" scope="page" />
</body>
</html> 