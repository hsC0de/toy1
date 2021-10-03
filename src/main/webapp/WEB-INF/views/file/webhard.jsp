<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page session="false" %>
<html lang="ko">
<head>
  <link rel="stylesheet" href="/resources/css/styles.css" />
  <link rel="stylesheet" href="/node_modules/tui-pagination/dist/tui-pagination.min.css">
  <link rel="stylesheet" href="/node_modules/tui-grid/dist/tui-grid.min.css">
  <script type="text/javascript" src="/node_modules/jquery/dist/jquery.min.js"></script>
  <script type="text/javascript" src="/node_modules/tui-pagination/dist/tui-pagination.min.js"></script>
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
    <div class="file_container">
      <div class="fileGridTools">
        <div class="fileGridTools_container">
          <a href="#" class="btn_createFolder">새 폴더</a>
          <a href="#" class="btn_openUploadWindow">업로드</a>
          <a href="#" class="btn_unfoldListOrDrop">
            <svg class="unfoldImg" xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-caret-down-square" viewBox="0 0 16 16">
              <path d="M3.626 6.832A.5.5 0 0 1 4 6h8a.5.5 0 0 1 .374.832l-4 4.5a.5.5 0 0 1-.748 0l-4-4.5z"/>
              <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm15 0a1 1 0 0 0-1-1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2z"/>
            </svg>
          </a>
        </div>
        
      </div>
      <div class="createFolder_container">
        <span class="createFolder_title">name</span>
        <div class="folder_input_container">
          <input type="text" class="inputFolderName" placeholder="새 폴더">
          <button type="button" class="btn_inputFolderName">등록</button>
        </div>
      </div>
      <form id="formFile" method="post" enctype="multipart/form-data" >
        <input id="tempInput"
               type="file" 
               name="uploadFile" 
               accept=".zip, .7z, .tar, .jar, application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, text/plain, image/*, .pdf, application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document" 
               multiple="multiple" />
      </form>
      <div class="uploadZone">
        <div id="dropzone">
          <div class="tempFileList">
            <div class="upld_header">
              <span class="file_select">
                <label>
                  <input class="allCheckbox_temp" type="checkbox">
                </label>
              </span>
              <span class="file_name">파일명</span>
              <span class="file_size">용량</span>
            </div>
            
            <div class="upld_fileList">
              <form id="formIdx">
                <ul class="html_fileList">
                  
                </ul>
              </form>
              <div class="dropzoneSpan">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-earmark-arrow-up" viewBox="0 0 16 16">
                  <path d="M8.5 11.5a.5.5 0 0 1-1 0V7.707L6.354 8.854a.5.5 0 1 1-.708-.708l2-2a.5.5 0 0 1 .708 0l2 2a.5.5 0 0 1-.708.708L8.5 7.707V11.5z"/>
                  <path d="M14 14V4.5L9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2zM9.5 3A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.5v2z"/>
                </svg>
                <span>마우스로 파일을 끌어오세요.</span>
              </div>
            </div>
          </div>
          
        </div>
        <div class="uploadTool_container">
          <div class="btn_fileUploadConfirm_container">
            <span class="fic_fileUpload"></span>
            <a href="#" class="btn_fileUploadConfirm">등록</a>
<!--             <input class="btn_fileUploadConfirm" type="button" value="등록" onclick="javascript:fileReg()"> -->
          </div>
          <div class="delete_container">
            <a class="delete_tempList" href="#">
              <object class="object" type="image/svg+xml" data="/node_modules/bootstrap-icons/icons/trash.svg"></object>
              <span>삭제</span>
            </a>
          </div>
        </div>
      </div>
      <div class="board_option">
        <div class="board_option_container">
          <a href="#" class="file_option_save"><span class="fic_zip"></span>모두 저장</a>
            <div class="divider"></div>
          <a href="#" class="file_option_delete"><span class="fic_trash"></span>삭제</a>
        </div>
        <ul>
          <li>
            <select onchange="setPerPage(this.value)">
              <option value="5" >5개씩</option>
              <option value="10" selected>10개씩</option>
              <option value="15" >15개씩</option>
              <option value="20" >20개씩</option>
              <option value="30" >30개씩</option>
              <option value="40" >40개씩</option>
              <option value="50" >50개씩</option>
            </select>
          </li>
        </ul>
        </div>
      <div id="fileListGgrid"></div>
      
    </div>
    
    
  </div>
  
  <script type="text/javascript">
    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue= "${_csrf.token}";
  </script>
  
  <script type="text/javascript" src="/resources/js/navbar.js"></script>
  <script type="text/javascript" src="/resources/js/common/common.js"></script>
  <script type="text/javascript" src="/resources/js/webhard.js"></script>
  
</body>
</html>
