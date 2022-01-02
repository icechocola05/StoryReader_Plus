<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>StoryReader - explain</title>
    <link rel="stylesheet" href="CSS/explain.css">
</head>
<body>
	<!-- 설명 이미지 보여줌 -->
    <section class="gallery">
    <%for(int i =0; i<9;i++){ %>
        <img src="./Img/explain <%=i+1 %>.JPG" alt="image">
       <%} %>
    </section>
</body>
</html>