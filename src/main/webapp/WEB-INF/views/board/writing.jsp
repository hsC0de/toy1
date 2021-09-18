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
  <script>
    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue="${_csrf.token}";
    var board = ${board != null and !empty board? board : "0"};
    var id = $("#tempUsername").text();
//     var auth = $("#tempAuthorities").text().substring(6, $("#tempAuthorities").text().length - 1);
    var boardInfo = ${boardInfo != null and boardInfo != ""? boardInfo : "0"};
    console.log(boardInfo);
    console.log(board);
    var editor;
    document.addEventListener("DOMContentLoaded", function(){
      
      editor = new toastui.Editor({
        el: document.querySelector("#editor"),
        height: "500px",
        initialEditType: "markdown",
        initialValue: board.content,
        previewStyle: "vertical",
      });
    });
    
    $(function() {
      
      $.ajax({
        url : '/menu/menuList',
        method : 'get',
        data : {
          upid : 'B'
        },
        dataType : 'json',
        success : function(menuData) {
          var str = '';
          var str1 = '';
          console.log(menuData);
          if(board == "0") {
            console.log("s");
            if(boardInfo.auth === false) {
              if(boardInfo.kind !== 'BA' && boardInfo.kind !== 'BN') {
                str1 += '<button type="button" class="optionButton" value="' + boardInfo.kind + '">';
                str1 += boardInfo.kind_nm;
                str1 += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
                str1 += '</button>';
              }
              else {
                str1 += '<button type="button" class="optionButton" value="">';
                str1 += '게시판을 선택해 주세요.';
                str1 += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
                str1 += '</button>';
              }
              
            }
            else {
              if(boardInfo.kind !== 'BA') {
                str1 += '<button type="button" class="optionButton" value="' + boardInfo.kind + '">';
                str1 += boardInfo.kind_nm;
                str1 += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
                str1 += '</button>';
              }
              else {
                str1 += '<button type="button" class="optionButton" value="">';
                str1 += '게시판을 선택해 주세요.';
                str1 += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
                str1 += '</button>';
              }
            }
          }
          else {
            if(board.auth === false) {
              console.log(board.kind);
              if(board.kind !== 'BA' && board.kind !== 'BN') {
                str1 += '<button type="button" class="optionButton" value="' + board.kind + '">';
                str1 += board.menu_nm;
                str1 += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
                str1 += '</button>';
              }
              else {
                str1 += '<button type="button" class="optionButton" value="">';
                str1 += '게시판을 선택해 주세요.';
                str1 += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
                str1 += '</button>';
              }
              
            }
            else {
              if(board.kind !== 'BA') {
                str1 += '<button type="button" class="optionButton" value="' + board.kind + '">';
                str1 += board.menu_nm;
                str1 += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
                str1 += '</button>';
              }
              else {
                str1 += '<button type="button" class="optionButton" value="">';
                str1 += '게시판을 선택해 주세요.';
                str1 += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
                str1 += '</button>';
              }
            }
          }
          for (var i = 0; i < menuData[0].submenuList.length; i++) {
            if(boardInfo.auth === false || board.auth === false) {
              if(menuData[0].submenuList[i].id !== 'BA' && menuData[0].submenuList[i].id !== 'BN') {
                
                if(menuData[0].submenuList[i].id == boardInfo.kind || menuData[0].submenuList[i].id == board.kind) {
                  str += '<li class="item selectedItem">';
                }
                else {
                  str += '<li class="item">';
                }
                str += '<button type="button" name="kind" class="option" value="' + menuData[0].submenuList[i].id + '">' + menuData[0].submenuList[i].name + '</button>';
                str += '</li>';
              }
            }
            else {
              if(menuData[0].submenuList[i].id !== 'BA') {
                if(menuData[0].submenuList[i].id == boardInfo.kind || menuData[0].submenuList[i].id == board.kind) {
                  str += '<li class="item selectedItem">';
                }
                else {
                  str += '<li class="item">';
                }
                str += '<button type="button" name="kind" class="option" value="' + menuData[0].submenuList[i].id + '">' + menuData[0].submenuList[i].name + '</button>';
                str += '</li>';
              }
            }
          }
          $(".kindSelect").html(str1);
          $(".select_option .kindList").html(str);
          initTypeBox($(".kindSelect .optionButton").attr("value"), board.type);
        },
        error : function(error) {
          alert("menu error");
        }
      });
      
      function initTypeBox(boardKind, boardType) {
        var str = '';
        var str1 = '';
        if(board == "0") {
          console.log("s");
          if(boardInfo.auth === true) {
            console.log(boardType);
            if(!boardType) {
            str += '<button type="button" class="optionButton" value="N">';
            }
            else {
              str += '<button type="button" class="optionButton" value="' + boardType + '">';
            }
            if(boardType === 'Y') {
              str += '공지';
            }
            else if(boardType === 'M' && boardKind === 'BN') {
              str += '필독';
            }
            else {
              str += '일반';
            }
            str += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
            str += '</button>';
            if(boardType === 'N' || !boardType) {
              str1 += '<li class="item selectedItem">';
            }
            else {
              str1 += '<li class="item">';
            }
            str1 += '<button type="button" class="option" value="N">일반</button>';
            str1 += '</li>';
            if(boardType === 'Y') {
              str1 += '<li class="item selectedItem">';
            }
            else {
              str1 += '<li class="item">';
            }
            str1 += '<button type="button" class="option" value="Y">공지</button>';
            str1 += '</li>';
            if(boardKind === 'BN') {
              if(boardType === 'M') {
                str1 += '<li class="item selectedItem">';
              }
              else {
                str1 += '<li class="item">';
              }
              str1 += '<button type="button" class="option" value="M">필독</button>';
              str1 += '</li>';
            }
          }
          else {
            str += '<button type="button" disabled="disabled" class="optionButton" value="N">';
            str += '일반';
            str += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
            str += '</button>';
          }
        }
        else {
          if(board.auth === true) {
            str += '<button type="button" class="optionButton" value="' + boardType + '">';
            if(boardType === 'Y') {
              str += '공지';
            }
            else if(boardType === 'M' && boardKind === 'BN') {
              str += '필독';
            }
            else {
              str += '일반';
            }
            str += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
            str += '</button>';
            if(board.auth === true) {
              if(boardType === 'N') {
                str1 += '<li class="item selectedItem">';
              }
              else {
                str1 += '<li class="item">';
              }
              str1 += '<button type="button" class="option" value="N">일반</button>';
              str1 += '</li>';
              if(boardType === 'Y') {
                str1 += '<li class="item selectedItem">';
              }
              else {
                str1 += '<li class="item">';
              }
              str1 += '<button type="button" class="option" value="Y">공지</button>';
              str1 += '</li>';
              if(boardKind === 'BN') {
                if(boardType === 'M') {
                  str1 += '<li class="item selectedItem">';
                }
                else {
                  str1 += '<li class="item">';
                }
                str1 += '<button type="button" class="option" value="M">필독</button>';
                str1 += '</li>';
              }
            }
          }
          else {
            str += '<button type="button" disabled="disabled" class="optionButton" value="N">';
            str += '일반';
            str += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
            str += '</button>';
          }
        }
        $(".typeSelect").html(str);
        $(".writing_option_select_type .option_list").html(str1);
      }
      
      console.log(board);
      if(board) {
        $(".writingContent_smartEditor textarea").val(board.content); 
        $(".textarea_input").val(board.title);
      }
      
      
      $(".writing_toolArea a").on("click", function(e) {
        
        e.preventDefault();
        e.stopPropagation();
        
        var title = $(".textarea_input").val();
        var content = editor.getMarkdown();
        console.log(content);
        if(!title) {
          alert("제목을 입력하세요.");
          return;
        } else if(!content) {
          alert("내용을 입력하세요.");
          return;
        }
        
        var data = {};
        if(board == 0) {
          data["title"] = title;
          data["content"] = content;
          data["id"] = id;
          data["kind"] = $(".kindSelect .optionButton").attr("value");
          data["type"] = $(".typeSelect .optionButton").attr("value");
        }
        else {
          board.content = content;
          board.title = title;
          board.kind = $(".kindSelect .optionButton").attr("value");
          board.type = $(".typeSelect .optionButton").attr("value");
          if(location.pathname != '/board/writing') {
            board.upd_seq = board.upd_seq + 1;
          }
          data = board; 
        }
        console.log(data);
        
        
        if(confirm("등록하시겠습니까?")) {
          var url = "/board/regPost";
          
          if(board) {
            url = "/board/modifyPost"; 
          }
          
	        $.ajax({
	          url: url,
	          method: 'post',
	          data: data,
	          dataType: 'text',
	          beforeSend: function(xhr) {
	            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	          },
	          success: function(res) {
	            if(res.substring(0, 6) === '/board') {
  	            opener.location.href = res;
  	            self.close();
	            }
	            else if(res === 'ok'){
                opener.location.reload();
                self.close();
	            }
	            else {
	              alert(res);            
	            }
	          },
	          error: function() {
	            alert("등록에 실패했습니다.");
	          }
	        });
        }
        
        
      });
      
      $(document).on("click", ".optionButton", function() {
        $(this).parent().next().toggleClass("btn_toggle");
        $(this).children("img").toggleClass("btn_img");
      });
      
      $(document).on("click", ".option_list .item .option", function() {
        $(this).closest("ul").children(".item").removeClass("selectedItem");
        $(this).parent().addClass("selectedItem");
        $(this).closest(".select_option").removeClass("btn_toggle");
        $(this).closest("div").prev().children(".optionButton").contents()[0].textContent = $(this).contents()[0].textContent;
        $(this).closest("div").prev().children(".optionButton").attr("value", $(this).attr("value"));
        
        if($(".kindSelect .optionButton").attr("value") == $(this).attr("value")) {
          initTypeBox($(".kindSelect .optionButton").attr("value"), "N");
        }
        else {
          initTypeBox($(".kindSelect .optionButton").attr("value"), $(this).attr("value"));
        }
      });
      
    });
    
    
  </script>
</body>
</html>
