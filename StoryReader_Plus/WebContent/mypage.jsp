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
	<div class="my-story-list" >
	<%
		ArrayList<Story> myStory = (ArrayList<Story>)session.getAttribute("myStoryList");
		for (int i=0;i< myStory.size();i++){
	%>
	<div class="card" style="width: 18rem; text-align: center; display: inline-block; margin: 1%;">
	  <div class="card-body">
	    <h3 class="card-title"><%=myStory.get(i).getStoryName()%></h5>
	    <a href="#" class="btn btn-primary">읽기</a>
	  </div>
	</div>
	
	<%} %>
	</div>
	
</body>
