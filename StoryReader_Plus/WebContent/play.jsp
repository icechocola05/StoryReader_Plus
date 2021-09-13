<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*" %>
<%@ page import="dto.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<%@ include file="head.html" %>
<head>
	<link rel="stylesheet" href="CSS/play.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<%
		ArrayList<Sentence> sentenceSet = (ArrayList<Sentence>)request.getAttribute("sentenceSet");
	 %>
	<div class="main">
		<div class = "script">
			<%for(int i=0 ; i<sentenceSet.size() ; i++){ %>
			<div id = 'sentenceset<%=i%>'> 
				<div class="speaker" id='speaker<%=i%>'><%= sentenceSet.get(i).getSpeaker()%></div>
				<div class="sentence" id='sentence<%=i%>'><%= sentenceSet.get(i).getSentence() %></div>
			</div>
			<%}%>
		</div>
		<div class="audio">
            <audio id='player' autoplay controls>
               	<source id = "pre-listen-audio" src="output/1.wav" type="audio/wav">
            </audio>
         </div>
	</div>

</body>
</html>