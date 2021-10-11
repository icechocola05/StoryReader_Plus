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
<head>
<meta charset="EUC-KR">
<title>Story Reader</title>

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@500&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="CSS/index.css">   
</head>
<body>
   <%
   //DB의 Emotion, Voice 가져오기 + session에 저장
    ServletContext sc = getServletContext();
    Connection con = (Connection)sc.getAttribute("DBconnection");
    List<Voice> voiceSet = SettingDao.getVoice(con);
    List<Emotion> emotionSet = SettingDao.getEmotion(con);
    
    session.setAttribute("voiceSet", voiceSet);
    session.setAttribute("emotionSet", emotionSet);
   %>
   <div class="top">
      <div class="sub">당신의 이야기를 읽어드릴게요</div>
      <div class="title">Story Reader</div>
      <button onclick="location='chooseInput.jsp'">Story Reader Start  > </button>
      <button onclick="location='explain.jsp'"style="background-color:#C4C4C4">Story Reader Help  > </button>
   </div>
   <div class="img">
      <img alt="faces" src="Img/faces.png" class="faces">
   </div>
   
</body>
</html>