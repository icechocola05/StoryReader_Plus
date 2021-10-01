<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="dto.*"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<%@ include file="head.html" %>
<head>
<link rel="stylesheet" href="CSS/chooseInput.css">
<style>
      .bd-placeholder-img {
        font-size: 3rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
      
      .readBtn {
         width: 100%;
         background-color: #97C6EE;
         font-size: 2rem;
         border: solid #97C6EE 1px;
         border-radius: 40px;
         padding: 1%;
         font-color: #FFFFFF;
      }
    </style>
</head>
<body>
   <jsp:include page="header.jsp"></jsp:include>
   
      <div class="album py-5 bg-light">
       <div class="container">
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
      <%
           
         ArrayList<Story> myStory = (ArrayList<Story>)session.getAttribute("myStoryList");
         for (int i=0;i< myStory.size();i++){
         %>
      <form method="Post" action="readMyScript">
           <div class="col">
             <div class="card shadow-sm">
               <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#eceeef" dy=".3em"><%=myStory.get(i).getStoryName()%></text></svg>
   
               <div class="card-body">
                 <p class="card-text"></p>
                 <div class="d-flex justify-content-between align-items-center">
                 <input type="text" style="display:none;" id ="selectedStoryId<%=i%>" name="selectedStoryId<%=i%>" value="<%=i%>">
                   <button class="readBtn" name="read_btn" value="<%=i%>" id="read_btn">읽기</button>
                 </div>
               </div>
             </div>
           </div>
           </form>
       <%} %>
       </div>
         
           </div>
           </div>
      
</body>