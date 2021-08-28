<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="CSS/loginjoin.css">
</head>
<body>
	<div class="head">
		<span>Story Reader</span>
	</div>
	<div class="login-section">
		<p class ="login-title">로그인</p>
		<hr>
		<form method="post" action="doLogin">
		<label>아이디
			<input type="text" class = "input-user" name="user_input_id" >
		</label><br />
		<label>비밀번호
			<input type="password" class = "input-user" name="user_input_pw" >
		</label><br />
		
		<button onclick="location='login.jsp'" class = "login-btn"> Login </button>
	</form>
	<button onclick="location='join.jsp'" class = "join-btn"> 회원가입하기 </button>
	</div>		
</body>
</html> 

