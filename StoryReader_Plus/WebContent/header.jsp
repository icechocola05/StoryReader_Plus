<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="head">
		<span class = "title-section">Story Reader</span>
		<span class = "user-section">
			<c:set var="user" scope="page" value="${sessionScope.currUser }" />
	  		<c:choose>
	  			<c:when test="${user eq null }">
	  				<a href="login.jsp" class="user-button">로그인</a>
	  				<a href="join.jsp" class="user-button">회원가입</a>
	  			</c:when>
	  			<c:otherwise>
	  			<form id="f" name = "post" action = "logout">
	  				<a href="mypage.jsp" class="user-button">마이페이지</a>
	  				<a href="javascript:void(0);" onclick="doLogout();" class="user-button">로그아웃</a>
	  			</form>
	  			</c:otherwise>
	  		</c:choose>
	  		<c:remove var="userId" scope="page" />
		</span>
	</div>