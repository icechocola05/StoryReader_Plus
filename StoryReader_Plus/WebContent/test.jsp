<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.User" %>
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
		<span>Story Reader</span>
	</div>
	<div class="main">
		<h3>테스트용 페이지입니다. </h3>
		<%User user = (User)session.getAttribute("currUser"); %>
		<p>사용자 : <%=user.getUserName() %></p>
	</div>		
</body>
</html> 

