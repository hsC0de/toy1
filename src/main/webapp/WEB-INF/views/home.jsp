<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html lang="ko">
<head>
  <link rel="stylesheet" href="/resources/css/styles.css" />
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>Main</title>
	<script>
	  
	</script>
</head>
<body>
  <div id="wrap">
    <header class="navbar">
      <div class="navbar_header">
	      <div class="navbar_logo">
	      </div>
	      <div class="navbar_menu">
	        <div class="navbar_menu_element">
	          <ul>
	            <li>
	    				  <a href="/board/list">게시판</a>
	    				  <ul>
	    				    <li>공지글</li>
	    				    <li>자유게시판</li>
	    				    <li>질문게시판</li>
	    				  </ul>
	            </li>
	          </ul>
	        </div>
	      </div>
      </div>
      <div class="navbar_userInfo">
        <a href="#"><img/></a>
        <a href="#"><img/></a>
        <a href="/common/login" style="color: #fff;"><img/>Login</a>
      </div>
    </header>
    <div class="front-img">
      <a href="#">
        <img src="http://placehold.it/861x150" />
      </a>
    </div>
    <div class="tab">
      <div class="tab_zone">
      </div>
    </div>
  </div>
  <a href="/common/getBoardList">aaaaa</a>
</body>
</html>
