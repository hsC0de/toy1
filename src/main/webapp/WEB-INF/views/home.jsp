<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page session="false" %>
<html lang="ko">
<head>
  <link rel="stylesheet" href="/resources/css/styles.css" />
  <link rel="stylesheet" href="/node_modules/tui-grid/dist/tui-grid.min.css">
  <script type="text/javascript" src="/node_modules/jquery/dist/jquery.min.js"></script>
  <script type="text/javascript" src="/node_modules/tui-grid/dist/tui-grid.min.js"></script>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta property="og:url" content="http://cxooxc.com">
  <meta property="og:title" content="first spring portfolio">
  <meta property="og:description" content="레거시 스프링, jsp, mysql을 활용한 게시판">
  <meta property="og:image" content="http://cxooxc.com/resources/img/cxooxc-logo-black.png">
  
	<title>cxooxc : portfolio</title>
</head>
<body>
  <div id="wrap">
    <header class="navbar">
      <div class="navbar_header">
	      <div class="navbar_logo">
          <a href="/" class="logoImgLink"><img class="logoImg" src="/resources/img/logo-black.png"></a>
	      </div>
	      <div class="navbar_menu">
	        
	      </div>
      </div>
      <div class="navbar_userInfo">
      <sec:authorize access="isAnonymous()">
        <a href="/common/login" class="loginButton"><span>로그인</span></a>
<!--         <div class="divider"></div> -->
      </sec:authorize>
      <sec:authorize access="isAuthenticated()">
        <a href="" class="userInfoButton"><sec:authentication property="principal.username"/></a>
        <img src="/resources/img/down-fill.png" class="userInfoButtonImg"/>
        <div class="userInfo_popup">
          <div class="userInfo_container">
            <div class="userInfo_profileImg">
              <div class="circle-color" style="--b:10px;">
                <img src="/resources/img/logoMain1.jpg" class="profileImg"/>
              </div>
            </div>
            <div class="userInfo_id_container">
              <div class="userInfo_id">
                <span class="userInfo_name"><b><sec:authentication property="principal.username"/></b>님</span>
                <form role="form" method="post" action="/logout">
                  <a href="#" class="loginButton logout"><span>로그아웃</span></a>
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                </form>
              </div>
              <div class="userInfo_auth">${authName}</div>
              <div class="userInfo_Activities">
                <a href="">내가 쓴 글</a>
                <div class="divider"></div>
                <a href="">내가 올린 파일</a>
              </div>
            </div>
          </div>
        </div>
      </sec:authorize>
      </div>
    </header>
    <div class="front-img">
      <a href="/">
        <img src="/resources/img/building1.jpg" class="mainImg" />
      </a>
    </div>
    <div class="tab">
      <div class="tab_zone">
        <a href="https://github.com/hsC0de/toy1.git" target="_black">github: https://github.com/hsC0de/toy1.git</a>
      </div>
    </div>
    <div>
      <section class="section">
        <a class="toDoList_toggleBtn" href="#">To do list</a>
        <div class="toDoList_Container">
          <div class="toDoList">
            <div class="container">
              <div class="toDoList_header">
                <div class="toDoList_title">
                  <span>To do List</span>
                </div>
                <div class="toDoList_input">
                  <input class="inputList" type="text">
                  <div class="registerButton_container">
                    <a href="#" class="listRegisterBtn"></a>
                    <object class="object" type="image/svg+xml" data="/node_modules/bootstrap-icons/icons/plus-circle.svg"></object>
                  </div>
                </div>
              </div>
              <div class="getToDoList">
                <ul class="toDo_listItems">
                </ul>
              </div>
            </div>
          </div>
          
          <div class="toDoList">
            <div class="container">
              <div class="toDoList_header1">
                <div class="toDoList_title1">
                  <span>To do List&#xD;&#xA;(manager)</span>
                </div>
                <div class="toDoList_input">
                  <input class="inputList1" type="text">
                  <div class="registerButton_container">
                    <a href="manager" class="listRegisterBtn1"></a>
                    <object class="object" type="image/svg+xml" data="/node_modules/bootstrap-icons/icons/plus-circle.svg"></object>
                  </div>
                </div>
              </div>
              <div class="getToDoList1">
                <ul class="toDo_listItems">
                </ul>
              </div>
            </div>
          </div>
        </div>
        <hr/>
        <div class="dashBoard_container">
          <h1 class="dashBoardTitle">Recent</h1>
          
          <div class="dashBoard">
            <div class="dashBoard_contents">
              <div class="dashBoard_contents_tabs">
                <ul class="dashBoard_tabs_list">
                  <li class="dashBoard_tabs_listItem selected_tab">
                    <a class="dashBoard_tabs_btn" href="BN">공지사항</a>
                  </li>
                  <li class="dashBoard_tabs_listItem">
                    <a class="dashBoard_tabs_btn" href="BA">전체게시판</a>
                  </li>
                  <li class="dashBoard_tabs_listItem">
                    <a class="dashBoard_tabs_btn" href="BF">자유게시판</a>
                  </li>
                  <li class="dashBoard_tabs_listItem">
                    <a class="dashBoard_tabs_btn" href="BQ">질문게시판</a>
                  </li>
                </ul>
              </div>
              <div class="dashBoard_articleList">
                <div id="grid"></div>
              </div>
            </div>
          </div>
        </div>
        
        <hr />
        <h1 class="contactTitle">Contact</h1>
        <div>
          <form class="emailForm" method="post" action="/emailMe">
            <ul>
              <li>
                <ul>
                  <li>
                    <span>이름</span><span>*</span>
                  </li>
                  <li>
                    <input type="text" name="name" required>
                  </li>
                </ul>
              </li>
            </ul>
            <ul>
              <li>
                <ul>
                  <li>
                    <span>이메일</span><span>*</span>
                  </li>
                  <li>
                    <input type="email" name="email" required>
                  </li>
                </ul>
              </li>
            </ul>
            <ul>
              <li>
                <ul>
                  <li>
                    <span>웹사이트</span>
                  </li>
                  <li>
                    <input type="text" name="website">
                  </li>
                </ul>
              </li>
            </ul>
            <ul>
              <li>
                <ul>
                  <li>
                    <span>내용</span><span>*</span>
                  </li>
                  <li>
                    <textarea class="emailComment" rows="6" cols="50" name="comments" required></textarea>
                  </li>
                </ul>
              </li>
            </ul>
            <ul>
              <li class="btnLi">
                <input class="emailSubmitBtn" type="submit" >
              </li>
            </ul>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          </form>
        </div>
        
      </section>
      
    </div>
  </div>
  
  <script type="text/javascript">
    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue= "${_csrf.token}";
  </script>
  <script type="text/javascript" src="/resources/js/navbar.js"></script>
  <script type="text/javascript" src="/resources/js/todoList.js"></script>
  <script type="text/javascript" src="/resources/js/email.js"></script>
  <script type="text/javascript" src="/resources/js/dashboard.js"></script>
</body>
</html>
