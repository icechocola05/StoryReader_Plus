<%@page import="java.io.*"%>
<%@page import="java.util.*" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="dto.*"%>
<%@ page import="model.*"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<%@ include file="head.html" %>
<head>
	<link rel="stylesheet" href="CSS/result.css">	
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="main">
		<form method="Post" action="readScript">
		<%Story currStory = (Story) session.getAttribute("currStory"); %>
			<div class="title"><%=currStory.getStoryName() %></div>
			<%if((int)request.getAttribute("pre-sent_id")>-1){ //이전 문장이 있는지 id 유무로 확인%>
			<div class="content-pre">	
				<div id="pre-speaker"><%=request.getAttribute("pre-speaker")%></div>
				<div id="pre-sentence"><%=request.getAttribute("pre-sentence")%></div> 
			</div>
			<%} %>
			<div class="content-cur">	
				<div id="cur-speaker" ><%=request.getAttribute("speaker")%></div>
				<div id="cur-sentence"><%=request.getAttribute("sentence")%></div> 
			</div>
			<%if((int)request.getAttribute("sentNum")!=(int)request.getAttribute("lastNum")){ //마지막 문장인지 확인%>
			<div class="content-next">	
				<div id="next-speaker"><%=request.getAttribute("next-speaker")%></div>
				<div id="next-sentence"><%=request.getAttribute("next-sentence")%></div> 
			</div>
			<%} %>
			<div class="audio">
  				<button type="submit" name="move_btn" value="pre" id="pre_btn">
					<img src="./Img/previous_w.png" alt="image">
				</button>
				<audio id='player' autoplay controls onended="next(<%=request.getAttribute("sentNum")%>, <%=request.getAttribute("lastNum")%>)">
			    <source src="output/<%=request.getAttribute("sentNum")%>.wav" type="audio/wav">
				</audio>
				<!--<input type="submit" id="next_btn" name="move_btn" value="next">-->
				<button type="submit" name="move_btn" value="next" id="next_btn">
					<img src="./Img/next_w.png" alt="image">
				</button>`
				
			</div>
			
		</form>
	</div>
	
	<script>
	window.onload = function() {
		var sid = <%=(Integer)request.getAttribute("sentNum")%>;
		var endid = <%=(Integer)request.getAttribute("lastNum")%>;
		if(sid == 0) {
			document.getElementById("pre_btn").style.display="hidden";
		}
		else if(sid == endid) {
			document.getElementById("next_btn").style.display="hidden";
		}
	}
	var audio = document.getElementById("player");
	function next(nowNum, lastNum){
		if(nowNum == lastNum) {
			alert("마지막 문장입니다");
			if(window.confirm("종료하시겠습니까?")) {
			    window.location.href = "/StoryReader__Web/lastPage.jsp"
			}
			audio.pause();
		}
		else {
			document.getElementById("next_btn").click();
		}
	}
	
	</script>
</body>
</html> 