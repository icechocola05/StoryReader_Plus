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
   <link rel="stylesheet" href="CSS/edit.css">   
</head>
<body>
   <jsp:include page="header.jsp"></jsp:include>
   
   <div class="main">
      <div>
         <img class="prog" src="./Img/3.png" alt="image">
      </div>
   </div>
   
   <% 
   
   	Story currStory = (Story)session.getAttribute("currStory");
	ArrayList<Sentence> sentenceSet = (ArrayList<Sentence>)request.getAttribute("sentenceSet");
	ArrayList<String> voiceColorList = (ArrayList<String>)request.getAttribute("voiceColorList");
	ArrayList<String> emoticonNameList = (ArrayList<String>)request.getAttribute("emoticonNameList");
	ArrayList<String> opacityList = (ArrayList<String>)request.getAttribute("opacityList");
    
	//저장한 이야기, 문장, 화자 정보 받아오기
    ArrayList<String> speakerType = (ArrayList<String>) request.getAttribute("speakerType");
    int speakerNum[][] = (int[][]) request.getAttribute("speakerNum");
      
    List<Voice> voiceSet = (List<Voice>)session.getAttribute("voiceSet");
    List<Emotion> emotionSet = (List<Emotion>)session.getAttribute("emotionSet");
      
    session.setAttribute("voiceSet", voiceSet);
    session.setAttribute("emotionSet", emotionSet);
      
      //color 배열 만들기
      String voiceColorSet[] = new String[10];
      for(int i=0; i<voiceSet.size(); i++) {
         String color = voiceSet.get(i).getVoiceColor().substring(1,7);
         voiceColorSet[i] = color;
      }
      
      //js로 보낼 color 배열 생성
      StringBuffer colorBuff = new StringBuffer();
      for(int i=0; i<voiceColorSet.length; i++) {
         if(voiceColorSet[i] == null) break;
         colorBuff.append(voiceColorSet[i]);
         colorBuff.append(",");
      }
      colorBuff.deleteCharAt(colorBuff.lastIndexOf(","));
      
      //js로 보낼 speakerNum 2차원 배열 생성
      StringBuffer voiceBuff = new StringBuffer();
      for(int i=0; i<speakerType.size(); i++) {
         for(int j=0; j<speakerNum[i].length; j++) {
            if(j>0 && speakerNum[i][j] == 0) break;
            voiceBuff.append(speakerNum[i][j]);
            voiceBuff.append(",");
         }
         voiceBuff.deleteCharAt(voiceBuff.lastIndexOf(","));
         voiceBuff.append("/");
      }
      
      session.setAttribute("voiceColorSet", voiceColorSet);
      int speakerArray[][] = new int[50][100];
   %>
   
   <!-- speaker setting -->
   <form method="Post" action="editVoiceEmotion" >
      <div class="set">
         <div class="speakers" >
            <div class="row">
               <% for(int i=0; i<speakerType.size(); i++) { %>
                  <!-- speaker 붙이기-->
                  <div class="col-sm-3">
                        <span id='speaker_type<%=i%>' class="fs-1"> <%= speakerType.get(i) %> </span>
                  </div>
                  
                  <!-- voice option 붙이기-->
                  <div class="col-sm-7">
                     <select id='voiceType<%=i%>' class='form-select fs-2' name='voiceType<%=i%>' onchange="changeVoice(this.value, <%=i%>);">
                        <% for(int j=0; j<voiceSet.size(); j++) { %>
                           <option value= <%=voiceSet.get(j).getVoiceName() + j%> style="background-color: #<%=voiceColorSet[j]%> "> <%=voiceSet.get(j).getVoiceKrName()%> </option>
                        <% } %>
                     </select> <br>
                  </div>
               <% } %>
            </div>
         </div>
      </div>
   
   <!-- sentence setting -->
   <div class="settings">
      <br>
      <%
         //문장 수 만큼 div 생성
         int len = sentenceSet.size(); 
      	 System.out.println("sentence : "+ len);
         for(int i=0; i<len; i++) { 
      %>
         
      <div class="container-fluid align-items-center" style="border:2px solid #C4C4C4; border-radius:20px; margin-bottom: 2%; padding :0% 1% 0% 1%;">
         <div class="row justify-content-between align-items-center">
         
            <!-- speaker 붙이기-->
            <div class="col-1 text-center fs-1 fw-bold" style="color: #3A91DA;">
               <textarea class="speaker" id='speaker<%=i%>' name="speaker<%=i%>"> <%= sentenceSet.get(i).getSpeaker()%> </textarea>
            </div>
            
            <div class="col-md-auto text-center" style="margin: 1%;">
               <!-- voice 붙이기 -->
               <%System.out.println("voiceColor : "+ voiceColorList.get(i)); %>
               <%System.out.println(voiceSet.get(sentenceSet.get(i).getVoiceId()-1).getVoiceName()); %>
               <div class="voice<%=i%>" style="border:3px solid <%=voiceColorList.get(i)%>; border-radius: 35%; background-color: <%=voiceColorList.get(i)%>; width: 150%; height: 180%p; padding-top: 10%;" > 
                  <input type="text" style="display:none;" id ="voiceVal<%=i%>" name="voiceVal<%=i%>" value="<%=voiceSet.get(sentenceSet.get(i).getVoiceId()-1).getVoiceName()%>">
                  <!-- emotion 붙이기-->
                  <div class="col-md-auto text-center" style="margin: 1%;">
                     <label id="emotionFace<%=i%>"  style="opacity: 70%;">
                        <span id='emotionFaceSpan<%=i%>' class='iconify' data-inline='false' data-icon='<%=emoticonNameList.get(i)%>'></span>
                     </label>
                     <select class='form-select fs-2' id='emotion<%=i%>' name='emotion<%=i%>' onchange="changeEmotion(this.value)" style="width: 58%; margin-left: 20%; margin-bottom: 10%;">
                              <% for (int ls=0; ls<emotionSet.size(); ls++)  { %> 
                                 <option value=<%= emotionSet.get(ls).getEmotionName() + i%>><%= emotionSet.get(ls).getEmotionKrName()%></option>
                              <% } %>
                         </select>
                         <input type="text" style="display:none;" id ="emotionVal<%=i%>" name="emotionVal<%=i%>" value="<%=emotionSet.get(sentenceSet.get(i).getEmotionId()-1).getEmotionName()%>"> 
                  </div>
               </div>
            </div>
            
            <!-- emotion intensity 붙이기-->
            <div class="col-1 text-center" style="margin: 2%;">
               <input type="range" name="intensity<%=i%>" min="0" max ="1" step="0.1" value="<%=sentenceSet.get(i).getIntensity()%>" onchange="changeIntensity(this.value, <%=i%>)">
               <input type="text" style="display:none;" id ="intensityVal<%=i%>" name="intensityVal<%=i%>" value="<%=sentenceSet.get(i).getIntensity()%>">
            </div>
            
            <!-- sentence 붙이기-->
            <div class="col-5 text-center"style="margin: 1%;" >
               <textarea id="sentence<%=i%>" class="col-7 form-control fs-1" name="sentence<%=i%>"><%= sentenceSet.get(i).getSentence() %></textarea>
            </div>
            
            <!-- 미리듣기 버튼 붙이기 -->
            <div class="col-1 text-center" style="margin: 1%;">
               <button type="button" id="pre-listen" value="미리듣기" onclick="getPreListen(<%=i%>); return false;">
                  <img id="pre-listen-img" src="./Img/play-button.png" alt="image">
               </button>
            </div>
         </div>
      </div>
         <% } //for문: 문장 수 %>
       </div>
         
      <div class="row justify-content-between align-items-center">
         <div class="audio" style="width: 70%;" >
            <audio id='player' autoplay controls style="width: 100%">
                  <source id = "pre-listen-audio" src="" type="audio/wav;">
            </audio>
         </div>
      </div>
      
      <div class="btn">
         <button type="SUBMIT" class="submit-btn"> 수정 완료 >  </button>
      </div>
   </form>
   <br>
   
   <script>
      function changeVoice(val, tar) {
         //tar = speaker 인덱스
         var valNum = parseInt(val.charAt(val.length - 1)); //option 인덱스
         var colorStr = "<%=colorBuff.toString()%>";
         var colors = colorStr.split(","); //color 배열
         var voiceStr = "<%=voiceBuff.toString()%>";
         var voiceFirst = voiceStr.split("/"); // 1차원 배열로 나누기
         var n = <%= speakerType.size() %>;
         var voices = new Array(n);
         for(var i = 0; i < n; i++) {
            voices[i] = voiceFirst[i].split(","); //voice 2차원 배열
         }
         
         //색 바꾸기 & 값 넣기
         for(var j = 0; j < voices[tar].length; j++) {
            var now = voices[tar][j];
            var element = document.getElementsByClassName('voice' + now);
            element[0].style.borderColor='#' + colors[valNum];
              element[0].style.backgroundColor='#' + colors[valNum];
               var target = document.getElementsByName('voiceVal' + now);
               target[0].value = val.slice(0, -1);
         }
      }
      
      function changeEmotion(val) {
         var valNum = 0; // option 인덱스 - parseInt(val.charAt(val.length - 1));
         var valTimes = 1; // 자리수 산정하는 변수 : 1->10->100
         var sliceVal = 0; //slice 하려는 대상

         while(true){
        	 
        	 console.log(val.slice(-1));
        	 sliceVal = parseInt(val.slice(-1));
        	 
        	 if (sliceVal>=0&& sliceVal<=9){
        		 valNum = valNum + (sliceVal * valTimes);
        		 val = val.slice(0, -1);
        		 console.log(val);
        		 valTimes=valTimes*10;
             }else{
            	 break;
             }
         }
         console.log(valNum);
         
         var element = document.getElementById("emotionFace" + valNum);
         var target = document.getElementById("emotionVal" + valNum);
         
         var deleteElement = document.getElementById('emotionFaceSpan' + valNum);
         deleteElement.parentNode.removeChild(deleteElement);
            
         if(val == "neutral") {
         	var added = document.createElement('span');
            added.setAttribute('id', 'emotionFaceSpan' + valNum);
            added.setAttribute('class', 'iconify');
            added.setAttribute('data-inline', 'false');
            added.setAttribute('data-icon', 'noto:neutral-face');
            element.appendChild(added);
            target.value = val;
         }
         if(val == "happiness") {
            var added = document.createElement('span');
            added.setAttribute('id', 'emotionFaceSpan' + valNum);
            added.setAttribute('class', 'iconify');
            added.setAttribute('data-inline', 'false');
            added.setAttribute('data-icon', 'noto:grinning-face-with-smiling-eyes');
            element.appendChild(added);
            target.value = val;
          }
          if(val == "anger") {
            var added = document.createElement('span');
            added.setAttribute('id', 'emotionFaceSpan' + valNum);
            added.setAttribute('class', 'iconify');
            added.setAttribute('data-inline', 'false');
            added.setAttribute('data-icon', 'noto:angry-face');
            element.appendChild(added);
            target.value = val;
          }
          if(val == "sadness") {
            var added = document.createElement('span');
            added.setAttribute('id', 'emotionFaceSpan' + valNum);
            added.setAttribute('class', 'iconify');
            added.setAttribute('data-inline', 'false');
            added.setAttribute('data-icon', 'noto:crying-face');
            element.appendChild(added);
            target.value = val;
          }
      }
      
      function changeIntensity(val, valNum) {
         var element = document.getElementById('emotionFace' + valNum);
          var target = document.getElementsByName('intensityVal' + valNum);
          if(val >= 0.1 && val <= 0.3) {
             element.style.opacity = "20%";
          }
          else if(val >= 0.4 && val <= 0.7) {
            element.style.opacity = "70%";
          }
          else if(val >= 0.8) {
            element.style.opacity = "100%";
         }
         target.value = val.toString();
      }

      
      function getPreListen(val){
         const xhttp = new XMLHttpRequest();
         var sentence = document.getElementById('sentence'+val).value;
         var voice_name = document.getElementById('voiceVal'+val).value;
         var emotion_name = document.getElementById('emotionVal'+val).value;
         var emotion_intensity = document.getElementById('intensityVal'+val).value;
         console.log(val);
         
         console.log(document.getElementById('voiceVal'+val).value);
         console.log(document.getElementById('emotionVal'+val).value);
         console.log(document.getElementById('intensityVal'+val).value);
         
         console.log("sentence="+sentence+"&voice_name="+voice_name+"&emotion_name="+emotion_name+"&intensity="+emotion_intensity.toString());
           xhttp.onreadystatechange = function () {
             if (xhttp.readyState == 4 && xhttp.status == 200) {
               console.log(xhttp.responseText);
                  document.getElementById("pre-listen-audio").src = "output/"+xhttp.responseText;
               document.getElementById('player').load();
             }
         };
         xhttp.open("POST", "./getPreListen", true);
         xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded; UTF-8");
         xhttp.send("sentence="+sentence+"&voice_name="+voice_name+"&emotion_name="+emotion_name+"&intensity="+emotion_intensity.toString());
      }
   </script>
   
   
</body>
</html>