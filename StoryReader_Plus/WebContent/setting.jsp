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
					
					<!-- emotion 붙이기-->
					<div class="col-md-auto text-center" style="margin: 1%;">
						<label id="emotionFace<%=i%>">
							<span class='iconify' data-inline='false' data-icon='noto:angry-face' ></span>
						</label>
		            </div>
					
					<!-- emotion intensity 붙이기-->
					<div class="col-2 text-center" style="margin: 1%;">
						<input type="range"name="range<%=i%>" min="0" max ="1" step="0.1" value="0.5">
					</div>
					
					<!-- sentence 붙이기-->
					<div class="col-6 text-center " style="margin: 1%;">
						<textarea id="sentence<%=i%>" class="col-7 form-control fs-1" name="sentence<%=i%>"><%= sentence.get(i) %></textarea>
					</div>
					
					<!-- checkbox 붙이기 -->
					<div class="col-md-auto text-center" style="margin: 1%;">
						<input type="checkbox" name="settingBox" value="settingBox<%=i%>">
					</div>
				</div>
				
			</div>
		
			<% 	} //for문
				%>
		</div>
			<div class="sentence_options">
				<select class='form-select fs-2' id='emotion' name='emotion'>
			               <% for (int ls=0; ls<emotionSet.size(); ls++)  { %> 
							<option value=<%= emotionSet.get(ls).getEmotionName() %>><%= emotionSet.get(ls).getEmotionKrName() %></option>
			               <% } %>
			    </select>
			</div>
			<div class="checkBtn">
				<input type="button" name="checkSenteceBtn" value="전체 선택" onClick="this.value=selectAll()">
				
			</div>
			<div class="btn">
				<button type="SUBMIT" class="submit-btn"> 다음 단계로 >  </button>
			</div>
	</form>
		<br>
		


<script>

		var isChecked = false;

		function selectAll() {
			const checkboxes = document.getElementsByName('settingBox');
			if (isChecked == false) { //전체 체크하기
				checkboxes.forEach((checkbox) => {
					checkbox.checked = true;
				})
				isChecked = true;
				return "체크 해제";
			}
			else { //전체 체크 해제하기
				checkboxes.forEach((checkbox) => {
					checkbox.checked = false;
				})
				isChecked = false;
				return "전체 체크";
			}
			
		}

		function changeEmotion(i) {
			var element = document.getElementById("emotionFace" + i);
			var target = document.getElementById("emotion" + i);
			var val = target.options[target.selectedIndex].text;
			
			while( element.hasChildNodes()) {
				element.removeChild(element.firstChild);
			}
			
			if(val == "화남") {
				var added = document.createElement('span');
				added.setAttribute('class', 'iconify');
				added.setAttribute('data-inline', 'false');
				added.setAttribute('data-icon', 'noto:angry-face');
				element.appendChild(added);
			}
			if(val == "슬픔") {
				var added = document.createElement('span');
				added.setAttribute('class', 'iconify');
				added.setAttribute('data-inline', 'false');
				added.setAttribute('data-icon', 'noto:crying-face');
				element.appendChild(added);
			}
			if(val == "중립") {
				var added = document.createElement('span');
				added.setAttribute('class', 'iconify');
				added.setAttribute('data-inline', 'false');
				added.setAttribute('data-icon', 'noto:neutral-face');
				element.appendChild(added);
			}
			if(val == "기쁨") {
				var added = document.createElement('span');
				added.setAttribute('class', 'iconify');
				added.setAttribute('data-inline', 'false');
				added.setAttribute('data-icon', 'noto:grinning-face-with-smiling-eyes');
				element.appendChild(added);
			}
			
		}
</script>
</body>

</html>
