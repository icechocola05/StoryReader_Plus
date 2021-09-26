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
	<link rel="stylesheet" href="CSS/display.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<%
		Story currStory = (Story)session.getAttribute("currStory");
		ArrayList<Sentence> sentenceSet = (ArrayList<Sentence>)request.getAttribute("sentenceSet");
		ArrayList<String> voiceColorList = (ArrayList<String>)request.getAttribute("voiceColorList");
		ArrayList<String> emoticonNameList = (ArrayList<String>)request.getAttribute("emoticonNameList");
		int size = sentenceSet.size()-1;
	 %>
	<div class="main">
	
		<div class = "story-title">
			<%=currStory.getStoryName()%>
		</div>
		<div class = "script">
			<%for(int i=0 ; i<sentenceSet.size() ; i++){ %>
			<div id = 'sentenceset<%=i%>' class = "sentenceset"> 
				<div class="speaker" id='speaker<%=i%>'><%= sentenceSet.get(i).getSpeaker()%></div>
				<!--voice 붙이기 -->
                <div class="voice" id="voiceVal<%=i%>" style="background-color:<%=voiceColorList.get(i)%>;">
                	<div class="emotion" id ="emotionVal<%=i%>">
                        <label id="emotionFace<%=i%>">
                           <span id='emotionFaceSpan<%=i%>' class='iconify' data-inline='false' data-icon='<%=emoticonNameList.get(i)%>'></span>
                        </label>
                     </div>
                </div>
				<div class="sentence" id='sentence<%=i%>'><%= sentenceSet.get(i).getSentence() %></div>
			</div>
			<%}%>
		</div> 
		<div class="audio">
			<button type="submit" id="pre_btn" onclick ="javascript:pre_clicked();">
				<img src="./Img/previous_w.png" alt="image">
			</button>
            <audio id='player' autoplay controls onended="javascript:next();">
               	<source id = "play-source" src="output/<%=currStory.getStoryId()+"_"+currStory.getStoryName()+"_"+ "0"%>.wav" type="audio/wav">
            </audio>
            <button type="submit" id="next_btn" onclick = "javascript:next_clicked();">
				<img src="./Img/next_w.png" alt="image">
			</button>`
         </div>
	</div>
	<script>
	var nowNum = 0;
	var lastNum = <%=size%>;
	var story_id = "<%=currStory.getStoryId()%>";
    var story_name = "<%=currStory.getStoryName()%>";
    
	function highlight(){
		//var sentence = document.getElementById('sentence'+nowNum.toString());
        //sentence.style.backgroundColor = "#C8C8C8";
	}
	
	function next(){
		 if(nowNum <= lastNum) {
			 //var sentence = document.getElementById('sentence'+nowNum.toString());
	         //sentence.style.backgroundColor = "#FFFFFF";
	         document.getElementById("next_btn").click();
	      }
	}
	 function pre_clicked(){
	      if(nowNum<=0){
	         return -1;
	      }else{
	         nowNum = nowNum -1;
	         var audio = document.getElementById('player');
	         var source = document.getElementById('play-source');
	         source.src = "output/" + story_id + "_" + story_name + "_" + nowNum.toString()+".wav";
	         
	         var next_sentence = document.getElementById('sentence'+(nowNum+1).toString())
	         next_sentence.style.backgroundColor = "#FFFFFF";
	         var sentence = document.getElementById('sentence'+nowNum.toString());
	         sentence.style.backgroundColor = "#F0F0F0";
	         
	         audio.load();
	         audio.play();
	      }
	   }

	 function next_clicked(){
	      if(nowNum == lastNum) {
	         alert("마지막 문장입니다");
	         if(window.confirm("종료하시겠습니까?")) {
	             window.location.href = "/StoryReader_Plus/lastPage.jsp"
	         }
	         audio.pause();
	      }else{
	         nowNum = nowNum + 1;
	         var audio = document.getElementById('player');
	         var source = document.getElementById('play-source');
	         source.src = "output/" + story_id + "_" + story_name + "_" + nowNum.toString()+".wav";
	         
	         var pre_sentence = document.getElementById('sentence'+(nowNum-1).toString())
	         pre_sentence.style.backgroundColor = "#FFFFFF";
	         
	         var sentence = document.getElementById('sentence'+nowNum.toString());
	         sentence.style.backgroundColor = "#F0F0F0";
	         
	         audio.load(); 
	         audio.play();
	      }
	   }
	
	
	</script>
</body>
</html>