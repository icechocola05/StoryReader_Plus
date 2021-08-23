<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="doLogin">
		User ID: <input type="text" name="user_input_id" > <br>
		Password: <input type="password" name="user_input_pw" > <br>
		<button onclick="location='login.jsp'"> Login </button>
	</form>
	<button onclick="location='signin.jsp'"> Join Here </button>
	

</body>
</html>