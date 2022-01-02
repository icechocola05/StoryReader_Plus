<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="head.html" %>
<head>
<link rel="stylesheet" href="CSS/index.css">   
</head>
<body>
	<!-- 시작 화면 -->
	<div class="top">
		<div class="sub">당신의 이야기를 읽어드릴게요</div>
		<div class="title">Story Reader</div>
		<button onclick="location='chooseInput.jsp'">Story Reader Start  > </button> <!-- 시작 버튼 -->
		<button class="help_btn" onclick="location='explain.jsp'">Story Reader Help  > </button> <!-- 설명 버튼 -->
	</div>
	<div class="img">
		<img alt="faces" src="Img/faces.png" class="faces">
	</div>
</body>
</html>