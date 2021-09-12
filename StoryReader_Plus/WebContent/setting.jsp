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
   <link rel="stylesheet" href="CSS/setting.css">   
</head>
<body>
   <jsp:include page="header.jsp"></jsp:include>
   <div class="main">
      <div>
         <img class="prog" src="./Img/3.png" alt="image">
      </div>
   </div>
   <% 
      //저장한 이야기, 문장, 화자 정보 받아오기
      ArrayList<String> speaker = (ArrayList<String>) session.getAttribute("speaker_list");
      ArrayList<String> speakerType = (ArrayList<String>) session.getAttribute("speakerType");
      ArrayList<String> sentence = (ArrayList<String>) request.getAttribute("sentence_list");
      
      
      //DB의 Emotion, Voice 가져오기 + session에 저장
      ServletContext sc = getServletContext();
      Connection con = (Connection)sc.getAttribute("DBconnection");
      List<Voice> voiceSet = SettingDao.getVoice(con);
      List<Emotion> emotionSet = SettingDao.getEmotion(con);
      
      session.setAttribute("voiceSet", voiceSet);
      session.setAttribute("emotionSet", emotionSet);
   %>
   
   <form method="Post" action="setVoiceEmotion" >
   <div class="settings">
      
      <br>
         <%
            //default voice, emotion 설정
            //String 
            //문장 수 만큼 div 생성
            int len = sentence.size(); 
            for(int i=0; i<len; i++) { 
         %>
         
         <div class="container-fluid align-items-center" style="border:2px solid #C4C4C4; border-radius:20px; margin-bottom: 2%; padding :1% 2% 1% 2%;">
            <div class="row justify-content-between align-items-center">
            
               <!-- speaker 붙이기-->
               <div class="col-1 text-center fs-1 fw-bold" style="margin: 1%; color: #3A91DA;">
                  <span id='speaker<%=i%>'> <%= speaker.get(i) %> </span>
               </div>
               
               <!-- voice 붙이기 -->
               <div class="col-md-auto text-center" style="margin: 1%;">
                  <div class="voice<%=i%>" style="border:3px solid #ffb4b4; border-radius: 35%;"> 
                     <input type="text" style="display:none;" id ="voiceVal<%=i%>" name="voiceVal<%=i%>" value="ema&nea">
                     
                     <!-- emotion 붙이기-->
                     <div class="col-md-auto text-center" style="margin: 1%;">
                        <label class="emotionFace<%=i%>">
                           <span class='iconify' data-inline='false' data-icon='noto:neutral-face' ></span>
                           <input type="text" style="display:none;" id ="emotionVal<%=i%>" name="emotionVal<%=i%>" value="neutral">
                           <!-- intensity 붙이기 -->
                           <input type="text" style="display:none;" id ="intensityVal<%=i%>" name="intensityVal<%=i%>" value="0.5">
                        </label>
                          </div>
                          
                  </div>
               </div>
               
               <!-- sentence 붙이기-->
               <div class="col-6 text-center " style="margin: 1%;">
                  <textarea id="sentence<%=i%>" class="col-7 form-control fs-1" name="sentence<%=i%>"><%= sentence.get(i) %></textarea>
               </div>
               
               <!-- checkbox 붙이기 -->
               <div class="col-md-auto text-center" style="margin: 1%;">
                  <input type="checkbox" name="settingBox" value="<%=i%>">
               </div>
               
               <!-- 미리듣기 버튼 붙이기 -->
               <div class="col-md-auto text-center" style="margin: 1%;">
                  <button type="button" id="pre-listen" value="미리듣기" onclick="getPreListen(<%=i%>); return false;">
                  	<img id="pre-listen-img" src="./Img/play-button.png" alt="image">
                  </button>
               </div>
            </div>
            
         </div>
      
         <%}//for문 %>   
      	</div>
         <div class="sentence_options container-fluid align-items-center">
            음색
            <select id='voice' class='form-select fs-2' name='voice' onchange="changeVoice(this.value)">
               <%
                  int voiceSetSize = voiceSet.size();
                  for (int j=0; j<voiceSetSize; j++)  { %> 
                     <option value=<%= voiceSet.get(j).getVoiceName() %>><%= voiceSet.get(j).getVoiceKrName() %></option>
               <% } %>
            </select>
            감정 
            <select class='form-select fs-2' id='emotion' name='emotion' onchange="changeEmotion(this.value)">
                        <% for (int ls=0; ls<emotionSet.size(); ls++)  { %> 
                     <option value=<%= emotionSet.get(ls).getEmotionName() %>><%= emotionSet.get(ls).getEmotionKrName() %></option>
                        <% } %>
             </select>
             세기 
            <div class="col-2 text-center" style="margin: 1%;">
               <input type="number" name="range" min="1" max ="10" step="1" value="5" onchange="changeIntensity(this.value)">
            </div>     
         </div>
         
         <div class="checkBtn">
            <input type="button" name="checkSenteceBtn" value="전체 선택" onClick="this.value=selectAll()">
         </div>
         <div class="audio">
            <audio id='player' autoplay controls>
               <source id = "pre-listen-audio" src="" type="audio/wav">
            </audio>
         </div>
         <div class="btn">
            <button type="SUBMIT" class="submit-btn"> 다음 단계로 >  </button>
         </div>
   </form>
      <br>
      


<script type="text/javascript" src="js/setting.js" charset="UTF-8"></script>
</body>

</html>
