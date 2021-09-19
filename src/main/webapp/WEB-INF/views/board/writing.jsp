<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page session="false" %>
<html lang="ko">
<head>
  <link rel="stylesheet" href="/resources/css/styles.css" />
  <link rel="stylesheet" href="/resources/css/screens/writing.css" />
  <link rel="stylesheet" href="/node_modules/@toast-ui/editor/dist/toastui-editor.css" />
  <style type="text/css">
    
  </style>
  <script type="text/javascript" src="/node_modules/jquery/dist/jquery.min.js"></script>
	<meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>Writing</title>
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
    <section class="container">
      <div class="writingWrap">
        <div class="writing_Header">
          <span class="writing_Header_title">게시판 글쓰기</span>
	        <div class="writing_toolArea">
            <sec:authentication property="principal" var="pinfo"/>
            <sec:authorize access="isAuthenticated()">
            <c:if test="${pinfo.username eq boardHtml.id or empty boardHtml}">
	          <a href="#" role="button" class="">
	            <span class="button_txt">등록</span>
	          </a>
            </c:if>
            </sec:authorize>
	        </div>
        </div>
        <div class="writingContent">
          <div class="writingContent_Title" style="width:861px;">
            <div class="row">
              <div class="writing_option_select">
                <div class="kindSelect">

                </div>
                <div class="select_option">
                  <ul class="option_list kindList">
<!--                     <li class="item"> -->
<%--                       <button type="button" class="option" value="${boardInfo.kind}">자유게시판1</button> --%>
<!--                     </li> -->
<!--                     <li class="item"> -->
<!--                       <button type="button" class="option">자유게시판2</button> -->
<!--                     </li> -->
                  </ul>
                </div>
              </div>
              <div class="writing_option_select_type">
                <div class="typeSelect">
                  
                </div>
                <div class="select_option">
                  <ul class="option_list">
                    
                    
                  </ul>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="textarea_input_container" >
                <textarea placeholder="제목을 입력해 주세요." class="textarea_input"></textarea>
              </div>
            </div>
          </div>
          <div id="smartEditor" class="writingContent_smartEditor">
<!--             <textarea placeholder="내용을 입력해 주세요." class="textarea_input" style="height: 520px; width:100%;"></textarea>  -->
             <div id="editor"></div>
          </div>
          <sec:authorize access="isAuthenticated()">
          <div id="tempUsername" style="display:none;"><sec:authentication property='principal.username'/></div>
          <div id="tempAuthorities" style="display:none;"><sec:authentication property="principal.authorities"/></div>
          </sec:authorize>
        </div>
      </div>
    </section>
  </div>
  <script type="text/javascript" src="/node_modules/@toast-ui/editor/dist/toastui-editor.js"></script>
  <script type="text/javascript" src="/resources/js/reply.js"></script>
  <script type="text/javascript" src="/resources/js/list.js"></script>
  <script type="text/javascript" src="/resources/js/navbar.js"></script>
  <script type="text/javascript" src="/resources/js/writing.js"></script>
  <script>
    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue="${_csrf.token}";
    var board = ${board != null and !empty board? board : "0"};
    var boardInfo = ${boardInfo != null and boardInfo != ""? boardInfo : "0"};
        
    
  </script>
</body>
</html>
