<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page session="false" %>
<html lang="ko">
<head>
  <link rel="stylesheet" href="/resources/css/styles.css" />
<!--   <link rel="stylesheet" href="/node_modules/codemirror/lib/codemirror.css" /> -->
  <link rel="stylesheet" href="/node_modules/@toast-ui/editor/dist/toastui-editor.css" />
  <style type="text/css">
    body {
      height: auto;
    }
    
    #editor {
/*     border : 1px solid; */
    width : 100%;
/*     height: 500px; */
    margin : 0 auto;
    }
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
          <div class="menu_list">
            <div class="menu_list_name">
              <a href="#" class="menu_list_btn">게시판</a>
            </div>
            <div class="menu_sublist">
              <a href="/board/list?page=1&userDisplay=15&kind=BN" class="menu_sublistItem">공지글</a>
              <a href="/board/list?page=1&userDisplay=15&kind=BA" class="menu_sublistItem">전체게시판</a>
              <a href="/board/list?page=1&userDisplay=15&kind=BF" class="menu_sublistItem">자유게시판</a>
              <a href="/board/list?page=1&userDisplay=15&kind=BQ" class="menu_sublistItem">질문게시판</a>
            </div>
          </div>
          <div class="menu_list">
            <div class="menu_list_name">
              <a href="/board/list?page=1&userDisplay=10" class="menu_list_btn">자료실</a>
            </div>
            <div class="menu_sublist">
              <a href="#" class="menu_sublistItem">웹하드</a>
            </div>
          </div>
          <div class="menu_list">
            <div class="menu_list_name">
              <a href="/board/list?page=1&userDisplay=10" class="menu_list_btn">다른서비스</a>
            </div>
            <div class="menu_sublist">
              <a href="#" class="menu_sublistItem">코로나</a>
              <a href="#" class="menu_sublistItem">도서정보</a>
            </div>
          </div>
          <div class="menu_list">
            <div class="menu_list_name">
              <a href="/board/list?page=1&userDisplay=10" class="menu_list_btn">관리자기능</a>
            </div>
            <div class="menu_sublist">
              <a href="#" class="menu_sublistItem">매뉴관리</a>
              <a href="#" class="menu_sublistItem">회원관리</a>
            </div>
          </div>
        </div>
      </div>
      <div class="navbar_userInfo">
      <sec:authorize access="isAnonymous()">
        <a href="/common/login" class="loginButton">로그인</a>
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
                  <a href="#" class="loginButton logout">로그아웃</a>
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                </form>
              </div>
              <div class="userInfo_auth"><sec:authentication property="principal.member.authGrpNm"/></div>
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
                  <sec:authorize access="hasAnyRole('ADMIN', 'MANAGER')">
                  <c:choose>
                  <c:when test="${empty kind}">
                  <button type="button" class="optionButton" value="">
                    게시판을 선택해 주세요.
                    <img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>
                  </button>
                  </c:when>
                  <c:otherwise>
                  <button type="button" class="optionButton" value="${kind}">
                    ${kindNm.kind_nm}
                    <img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>
                  </button>
                  </c:otherwise>
                  </c:choose>                             
                  </sec:authorize>
                  <sec:authorize access="hasRole('MEMBER')">
                  <c:choose>
                  <c:when test="${kind eq 'BN'}">
                  <button type="button" class="optionButton" value="">
                    게시판을 선택해 주세요.
                    <img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>
                  </button>
                  </c:when>
                  <c:otherwise>
                  <button type="button" class="optionButton" value="${kind}">
                    ${kindNm.kind_nm}
                    <img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>
                  </button>
                  </c:otherwise>
                  </c:choose>
                  </sec:authorize>
                </div>
                <div class="select_option">
                  <ul class="option_list">
                    <li class="item">
                      <button type="button" class="option" value="${kind}">자유게시판1</button>
                    </li>
                    <li class="item">
                      <button type="button" class="option">자유게시판2</button>
                    </li>
                  </ul>
                </div>
              </div>
              <div class="writing_option_select_type">
                <div class="typeSelect">
                  <button type="button" disabled="disabled" class="optionButton">
                    일반
                    <img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>
                  </button>
                </div>
                <div class="select_option" style>
                  <ul class="option_list">
                    <li class="item">
                      <button type="button" class="option">공지</button>
                    </li>
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
  <script type="text/javascript" src="/resources/js/board.js"></script>
  <script type="text/javascript" src="/resources/js/navbar.js"></script>
  <script>
    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue="${_csrf.token}";
    var board = ${board != null and board != ""? board : "0"};
    var id = $("#tempUsername").text();
    var auth = $("#tempAuthorities").text().substring(6, $("#tempAuthorities").text().length - 1);
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
          console.log(menuData);
          for (var i = 0; i < menuData[0].submenuList.length; i++) {
            if(auth !== "MANAGER" && auth !== "ADMIN") {
              if(menuData[0].submenuList[i].id !== 'BA' && menuData[0].submenuList[i].id !== 'BN') {
                
                str += '<li class="item">';
                str += '<button type="button" class="option" value="' + menuData[0].submenuList[i].id + '">' + menuData[0].submenuList[i].name + '</button>';
                str += '</li>';
              }
              
            }
            else {
              if(menuData[0].submenuList[i].id !== 'BA') {
                
                str += '<li class="item">';
                str += '<button type="button" class="option" value="' + menuData[0].submenuList[i].id + '">' + menuData[0].submenuList[i].name + '</button>';
                str += '</li>';
              }
            }
          }
          $(".select_option .option_list").html(str);
        },
        error : function(error) {
          alert("menu error");
        }
      });
      
//       <ul class="option_list">
//       <li class="item">
//         <button type="button" class="option" value="${kind}">자유게시판1</button>
//       </li>
      
      console.log(board);
      if(board) {
//         $(".kind_button_val").html(board.menu_nm + " 〉");
//         $(".nick_box span").html(board.id);
//         $(".cnt").html("조회 " + board.cnt);
//         $("#refreshReplyCnt").html("댓글 " + board.replyCnt);
        $(".writingContent_smartEditor textarea").val(board.content); 
        $(".textarea_input").val(board.title);
      }
      
      
      $(".writing_toolArea a").on("click", function(e) {
        
        e.preventDefault();
        e.stopPropagation();
        
        var title = $(".textarea_input").val();
//         console.log(title);
//         var content = $(".writingContent_smartEditor textarea").val();
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
          data["type"] = "N";
        }
        else {
          board.content = content;
          board.title = title;
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
          
	        $.post({
	          url: url,
	          data: data,
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
	              alert('fail');
	              location.href = '/exception/error';	              
	            }
	          },
	          error: function() {
	            alert("등록에 실패했습니다.");
	          }
	        });
        }
        
        
      });
      
      $(".optionButton").on("click", function() {
        $(this).parent().next().toggleClass("btn_toggle");
      });
      
      $(document).on("click", ".option_list .item .option", function() {
        $(".select_option .option_list .item").removeClass("selectedItem");
        $(this).parent().addClass("selectedItem");
        $(this).closest(".select_option").removeClass("btn_toggle");
        $(this).closest("div").prev().children(".optionButton").contents()[0].textContent = $(this).contents()[0].textContent;
        $(this).closest("div").prev().children(".optionButton").attr("value", $(this).attr("value"));
      });
      
    });
    
    
  </script>
</body>
</html>
