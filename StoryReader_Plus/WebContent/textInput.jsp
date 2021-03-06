<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<html>
<%@ include file="head.html" %>
<head>
	<link rel="stylesheet" href="CSS/textInput.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="main">
		<div>
			<img class="prog" src="./Img/2.png" alt="image">
		</div>
		
		<div class="input">
			<span id="header">텍스트를 직접 입력해주세요!</span> <br>
			
			<!-- 텍스트 입력하면 title, mainTxt가 POST 방식으로 confirmScript에 전송 -->
			<div class="content">
				<form method="Post" action="confirmScript">	
					<div class="context-text">
						<label for='title'>제목</label>
						<input type="text" id="title" name="title" size=53 placeholder="  제목을 입력해주세요.  "/>
						<br><br>
						<textarea rows="11" cols="63" id="mainTxt" name="mainTxt" placeholder="   이야기 내용을 입력해주세요.  &#13;&#10;   형식은 '화자 : 텍스트' 입니다. &#13;&#10;   화자를 설정하지 않으면 나레이션으로 지정됩니다.  &#13;&#10;   예시) 여우 : 황새야 맛있게 먹어  "></textarea>
					</div>	
				<button type="submit" id="submit-btn">전송</button>
				</form>
				<br><br>
			</div>
		</div>
	</div>
</body>
</html> 