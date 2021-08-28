<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<html>
<%@ include file="head.html" %>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="main">
		<div>
			<img class="prog" src="./Img/2.png" alt="image">
		</div>
		
		<div class="input">
			<span id="title">텍스트를 등록해주세요!</span> <br>
			
			<div class="content">
				<form method="Post" action="uploadFile" enctype="multipart/form-data" onsubmit="return check(this.submitted);">
				<div class="content-file">
					<input class="form-control form-control-lg center-block" name="file" id="input-file" type="file"> <br> <br>
					<span id="sub"> txt 확장자만 가능합니다. </span> <br>
				</div>
					<input type="SUBMIT" class="center-block" id="submit-btn" value="다음 단계로  >" onclick="this.form.submitted=this.value" >
				</form>
			</div>
		</div>	
	</div>
</body>
</html> 