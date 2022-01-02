<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<%@ include file="head.html" %>
<head>
	<link rel="stylesheet" href="CSS/textInput.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<%
		//제목, 전체 본문 전달받기
		String title = "";
		String mainTxt = "";
		if(request.getAttribute("title") != null) title = (String) request.getAttribute("title");
		if(request.getAttribute("mainTxt") != null) mainTxt = (String) request.getAttribute("mainTxt");
	 %>
	<div class="main">
		<div>
			<!-- progressive bar image -->
			<img class="prog" src="./Img/2.png" alt="image">
		</div>
		
		<div class="input">
			<span id="header">텍스트를 확인해주세요!<button id="btn-modal">?</button></span> <br>
			
			<!-- 파일로 등록한 내용을 확인 및 수정 가능 -->
			<div class="content">
				<form method="Post" action="confirmScript">	
					<div class="context-text">
						<label for='title'>제목</label>
						<input type="text" id="title" name="title" size=53 value="<%=title%>" placeholder="  제목을 입력해주세요.  ">
						<br><br>
						<textarea rows="11" cols="63" id="mainTxt" name="mainTxt"><%=mainTxt%></textarea>
					</div>	
				<button type="submit" id="submit-btn">전송</button>
				</form>
				<br><br>
			</div>
		</div>
		
		<!-- modal로 텍스트 파일 작성 예시 설명 -->
		<div id="modal" class="modal-overlay">
        	<div class="modal-window">
            	<div class="modal-title">
                	<h3>텍스트 파일 작성 예시</h3>
            	</div>
            	<div class="close-area">X</div>
            	<br><br>
            	<div class="content">
                	<p>1. (화자): (문장) 형식으로 스크립트를 작성하세요. </p>
                	<img src="./Img/example.JPG" class = "sentence-examples" id = "ex-1"><br>
                	<br>
                	<br>
                	<p>2. 문장 끝에 ‘.’, ‘?’, ‘!’를 반드시 붙이세요.</p>
                	<br>
                	<p>3. 화자를 작성하지 않으면 “해설”로 자동 설정됩니다.</p>
                	<img src="./Img/examples_nospeaker.JPG" class = "sentence-examples" id = "ex-2"><br>         
            	</div>
        	</div>
		</div>
	</div>
	<script>
	const modal = document.getElementById("modal")
	function modalOn() {
    	modal.style.display = "flex";
	}
	function isModalOn() {
    	return modal.style.display === "flex"
	}
	function modalOff() {
    	modal.style.display = "none";
	}

	//특정 버튼을 클릭하면 모달 display : flex
	const btnModal = document.getElementById("btn-modal")
	btnModal.addEventListener("click", e => {
    	modalOn();
	})

	//close 버튼을 누르면 모달창 꺼질 수 있게
	const closeBtn = modal.querySelector(".close-area")
	closeBtn.addEventListener("click", e => {
    	modalOff()
	})

	//모달창 바깥 영역 누르면 모달창 꺼지게 
	modal.addEventListener("click", e => {
    	const evTarget = e.target
    	if(evTarget.classList.contains("modal-overlay")) {
    	    modalOff()
    	}
	})
	
	//모달창이 켜진 상태에서 ESC 버튼을 누르면 모달창이 꺼지게
	window.addEventListener("keyup", e => {
    	if(isModalOn() && e.key === "Escape") {
     	   modalOff()
    }
})
    </script>

</body>
</html>