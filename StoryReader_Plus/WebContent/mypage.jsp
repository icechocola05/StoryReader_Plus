<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="dto.*"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<%@ include file="head.html" %>
<head>
<link rel="stylesheet" href="CSS/chooseInput.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<h2>마이페이지</h2>
	<div class="my-story-list">
	<%
		ArrayList<Story> myStory = (ArrayList<Story>)session.getAttribute("myStoryList");
		for (int i=0;i< myStory.size();i++){
	%>
		<div class="my-story"><%=myStory.get(i).getStoryName()%></div>
	
	<%} %>
	</div>
	
</body>
