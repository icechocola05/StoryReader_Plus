<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<%@ include file="head.html" %>
<head>
	<link rel="stylesheet" href="CSS/textInput.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<%
		//텍스트 전달받기
		String title = "";
		String mainTxt = "";
		if(request.getAttribute("title") != null) title = (String) request.getAttribute("title");
		if(request.getAttribute("mainTxt") != null) mainTxt = (String) request.getAttribute("mainTxt");
	 %>
	<div class="main">
		<div>
			<img class="prog" src="./Img/2.png" alt="image">
		</div>
		
		<div class="input">
			<span id="header">텍스트를 확인해주세요!</span> <br>
			
			<div class="content">
				<form method="Post" action="confirmScript">	
					<div class="context-text">
						<label for='title'>제목</label>
						<input type="text" id="title" name="title" size=53 value="<%=title%>" placeholder="  제목을 입력해주세요.  ">
						<br><br>
						<textarea rows="11" cols="63" id="mainTxt" name="mainTxt"><%=mainTxt%></textarea>
					</div>	
				<button type="submit" id="submit-btn">전송</button>
				</form>
				<br><br>
			</div>
		</div>
	</div>

</body>
</html>