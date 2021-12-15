<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>StoryReader - explain</title>
    <style>
        body{
        	background-color:black;
        }
        img {
            height: 30%;
            width: 60%;
            left: 50%;
            transform: translateX(-50%);
            display: block;
            position: relative;
            margin: 200px 0;
        }
        ul {
            position: fixed;
            top: 0;
        }
        ul li {
            list-style: none;
            font-size: 150px;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
        }
    </style>
</head>
<body>
    <section class="gallery">
    <%for(int i =0; i<9;i++){ %>
        <img src="./Img/explain <%=i+1 %>.JPG" alt="image">
       <%} %>
    </section>
</body>
</html>