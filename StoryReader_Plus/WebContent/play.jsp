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
		Story currstory = (Story)session.getAttribute("currStory");
		ArrayList<Sentence> sentenceSet = (ArrayList<Sentence>)session.getAttribute("sentenceSet");
	 %>
	<div class="main">
	
		<div class = "story-title">
			<%=currstory.getStoryName()%>
		</div>
		<form method="Post" action="readScript">
		<div class = "script">
			<%for(int i=0 ; i<sentenceSet.size() ; i++){ %>
			<div id = 'sentenceset<%=i%>' class = "sentenceset"> 
				<div class="speaker" id='speaker<%=i%>'><%= sentenceSet.get(i).getSpeaker()%></div>
				<!--voice 붙이기 -->
                <div class="voice" id="voiceVal<%=i%>">
                	<div class="emotion" id ="emotionVal<%=i%>">
                        <label id="emotionFace<%=i%>">
                           <span id='emotionFaceSpan<%=i%>' class='iconify' data-inline='false' data-icon='noto:neutral-face'></span>
                        </label>
                     </div>
                </div>
				<div class="sentence" id='sentence<%=i%>'><%= sentenceSet.get(i).getSentence() %></div>
			</div>
			<%}%>
		</div> 
		<input type="text" style="display:none;" id ="sentNumber" name="sentNumber" value="<%=session.getAttribute("sentNum")%>">
		<div class="audio">
			<button type="submit" name="move_btn" value="pre" id="pre_btn">
				<img src="./Img/previous_w.png" alt="image">
			</button>
            <audio id='player' autoplay controls onended="next(<%=session.getAttribute("sentNum")%>, <%=sentenceSet.size()-1%>)">
               	<source id = "pre-listen-audio" src="output/<%=session.getAttribute("sentNum")%>.wav" type="audio/wav">
            </audio>
            <button type="submit" name="move_btn" value="next" id="next_btn">
				<img src="./Img/next_w.png" alt="image">
			</button>`
         </div>
         </form>
	</div>
	
	<script>
	window.onload = function() {
		var sid = <%=(Integer)session.getAttribute("sentNum")%>;
		var endid = <%=sentenceSet.size()-1%>;
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
			    window.location.href = "/StoryReader_Plus/lastPage.jsp"
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