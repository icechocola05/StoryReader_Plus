<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.*"%>
<!DOCTYPE html>
<html>
<%@ include file="head.html" %>
<head>
	<link rel="stylesheet" href="CSS/last.css">	
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="main">
	<%Story currstory = (Story)session.getAttribute("currStory"); %>
	<div class="title"><%=currstory.getStoryName()%></div>
	
	<form method="post" action="readScript">
		<button id = "replay" name="move_btn" value="replay">다시 듣기</button>
	</form>
	<form method="post" action="chooseInput.jsp">
		<button id="another">다른 동화 읽기</button>
	</form>
	</div>
</body>
</html>