<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page session="false" %>
<html lang="ko">
<head>
  <link rel="stylesheet" href="/resources/css/styles.css" />
  <script src="/node_modules/jquery/dist/jquery.min.js"></script>
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
    <div>
      <section class="section">
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
  <sec:authorize access="isAuthenticated()">
  <div id="tempAuthorities" style="display:none"><sec:authentication property="principal.authorities"/></div>
  </sec:authorize>
  <script type="text/javascript" src="/resources/js/navbar.js"></script>
  <script type="text/javascript">
    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue="${_csrf.token}";
    var auth = $("#tempAuthorities").text().substring(6, $("#tempAuthorities").text().length - 1);
    console.log(auth);
    
    $(document).on("click", ".emailSubmitBtn", function(e) {
      e.preventDefault();
      e.stopPropagation();
      var formData = new FormData();
      formData = $(".emailForm").serialize();
      var name = $("input[name='name']").val();
      var comment = $("textarea[name='comments']").val();
      var email = $("input[type='email']").val();
      if(!name) {
        $("input[name='name']").focus();
        
        return;
      }
      else if(!email) {
        $("input[type='email']").focus();
      }
      else if(!comment) {
        $("textarea[name='comments']").focus();
        return;
      }
      var re = new RegExp(/^[\w]+@[\w]+\.(com|co.kr|net|org|biz|info|or.kr|ne.kr|re.kr|go.kr|pe.kr|ac.kr|es.kr|ms.kr)$/);
      console.log(re.test($("input[type='email']").val()));
      if(!re.test($("input[type='email']").val())) {
        alert("이메일 주소가 올바르지 않습니다.asdf@asdf.(com|co.kr|net|org|biz|info|or.kr|ne.kr|re.kr|go.kr|pe.kr|ac.kr|es.kr|ms.kr)");
        $("input[type='email']").focus();
        return;
      }
      if(confirm("등록하시겠습니까?")) {
        $.ajax({
          url: $(".emailForm").attr("action"),
          method: 'post',
          beforeSend: function(xhr) {
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
          },
          data: formData,
          success: function() {
            $("input[name='name']").val("");
            $("textarea[name='comments']").val("");
            $("input[type='email']").val("");
            $("input[name='website']").val("");
            alert("등록되었습니다.");
          },
          error: function(error) {
            alert(error.status);
          }
        });
      }
    });
    
    function getTodoList() {
      
      $.ajax({
        url: "/getTodoList",
        method: "get",
        dataType: "json",
        success: function(res) {
          
          console.log(res);
          var str = "";
          for(var i = 0; i < res.length; i++) {
            str += '<div class="toDo_listItem_container">';
            if(res[i].done === 'Y') {
              str += '<li class="toDo_listItem activeList">';
              str += '<input type="checkbox" class="toDoCheckbox" value="' + res[i].num + '" checked id="done' + res[i].num + '"><label for="done' + res[i].num + '">';
            }
            else {
              str += '<li class="toDo_listItem">';
              str += '<input type="checkbox" class="toDoCheckbox" value="' + res[i].num + '" id="done' + res[i].num + '"><label for="done' + res[i].num + '">';
            }
            str += '<div class="listContent">';
            str += '<span style="word-break:break-all;" class="toDo_listContent">' + res[i].do_list + '</span>';
            str += '</div>';
            str += '</label>';
            str += '<div class="listDeleteButton_container">';
            str += '<a href="' + res[i].num + '" class="listDeleteBtn"></a>';
            str += '<object class="object" type="image/svg+xml" data="/node_modules/bootstrap-icons/icons/trash.svg"></object>';
            str += '</div>';
            str += '</li>';
            str += '</div>';
          }
          $(".toDo_listItems").html(str);
          
        },
        error: function(error) {
          alert("fail get TodoList"); 
        }
      });
    }
    
    function getTodoListManager() {
      $.ajax({
        url: "/getTodoListManager",
        method: "get",
        dataType: "json",
        success: function(res) {
          
          console.log(res);
          var str = "";
          for(var i = 0; i < res.length; i++) {
            str += '<div class="toDo_listItem_container">';
            if(res[i].done === 'Y') {
              str += '<li class="toDo_listItem1 activeList">';
              str += '<input type="checkbox" class="toDoCheckbox" value="' + res[i].num + '" checked id="done' + res[i].num + '"><label for="done' + res[i].num + '">';
            }
            else {
              str += '<li class="toDo_listItem1">';
              str += '<input type="checkbox" class="toDoCheckbox" value="' + res[i].num + '" id="done' + res[i].num + '"><label for="done' + res[i].num + '">';
            }
            str += '<div class="listContent">';
            str += '<span style="word-break:break-all;" class="toDo_listContent">' + res[i].do_list + '</span>';
            str += '</div>';
            str += '</label>';
            str += '<div class="listDeleteButton_container">';
            str += '<a href="' + res[i].num + '" class="listDeleteBtn1"></a>';
            str += '<object class="object" type="image/svg+xml" data="/node_modules/bootstrap-icons/icons/trash.svg"></object>';
            str += '</div>';
            str += '</li>';
            str += '</div>';
          }
          $(".getToDoList1").html(str);
          
        },
        error: function(error) {
          alert("fail get TodoList"); 
        }
      });
    }
    function doneTodoList(done, num, url) {
      $.ajax({
        url: url,
        beforeSend: function(xhr) {
          xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        },
        method: "post",
        data: {
          done: done,
          num: num
        },
        success: function(res, textStatus, xhr) {
          if(xhr.getResponseHeader('redirectUrl')) {
            if(xhr.getResponseHeader('redirectUrl').indexOf("login") != -1) {
              location.href = xhr.getResponseHeader('redirectUrl');
            }
            else {
              alert("권한이 없습니다.");
            }            
          }
        },
        error: function(error) {
          alert(error.status);
        }
      });
    }
    
    function regTodoList(url, content) {
//       var content = $(".inputList").val();
      
      if(!content) {
        alert("값을 입력하세요");
        return;
      }
      var data = {"do_list" : content}
      
      $.ajax({
        url: url,
        method: "post",
        beforeSend: function(xhr) {
          xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        },
        data: data,
        success: function(res, textStatus, xhr) {
          if(url === "/regTodoList" && xhr.getResponseHeader('redirectLogin') !== 'true'){
            $(".inputList").val("");
            $(".inputList").focus();
            getTodoList();
          }
          else if(url === "/regTodoListManager" && xhr.getResponseHeader('redirectLogin') !== 'true') {
            $(".inputList1").val("");
            $(".inputList1").focus();
            getTodoListManager();
          }
          else {
            if(xhr.getResponseHeader('redirectUrl').indexOf("login") != -1) {
              location.href = xhr.getResponseHeader('redirectUrl');
            }
            else {
              alert("권한이 없습니다.");
            }
          }
        },
        error: function(error) {
          alert(error.status);
        }
      });
    }

    $(".toDoList_input input").on("keydown", function(e) {
      
      if(e.keyCode === 13) {
        var url = "/regTodoList";
        var content = $(".inputList").val();
        
        if($(this).attr("class") === "inputList1") {
          url = "/regTodoListManager";
          content = $(".inputList1").val();
        }
        
        regTodoList(url, content);
      }
    });
    
    
    $(".registerButton_container a").on("click", function(e) {
      e.preventDefault();
      e.stopPropagation();
      var url = "/regTodoList";
      var content = $(".inputList").val();
      
      if($(this).attr("class") === "listRegisterBtn1") {
        url = "/regTodoListManager";
        content = $(".inputList1").val();
      }
      
      regTodoList(url, content);
    });
    
    $(document).on("click", ".listDeleteButton_container a", function(e) {
      e.preventDefault();
      e.stopPropagation();
      var url = "/deleteTodoList";
      
      if($(this).attr("class").indexOf("listDeleteBtn1") != -1) {
        if(!auth) {
          location.href = "/common/login";
          return;
        }
        else if(auth !== "MANAGER" && auth !== "ADMIN") {
          alert("권한이 없습니다.");
          return;
        }
        url = "/deleteTodoListManager";
      }
      var num = $(this).attr("href");
      $.ajax({
        url: url,
        beforeSend: function(xhr) {
          xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        },
        method: "post",
        data: {
          num: num
        },
        success: function(res, textStatus, xhr) {
          if(url === "/deleteTodoList" && xhr.getResponseHeader('redirectLogin') !== 'true'){
            getTodoList();
          }
          else if(url === "/deleteTodoListManager" && xhr.getResponseHeader('redirectLogin') !== 'true') {
            getTodoListManager();
          }
          else {
            if(xhr.getResponseHeader('redirectUrl').indexOf("login") != -1) {
              location.href = xhr.getResponseHeader('redirectUrl');
            }
            else {
              alert("권한이 없습니다.");
            }
          }
        },
        error: function(error) {
          alert(error.status);
        }
      });
    });
    $(document).on("click", ".toDo_listItem_container li", function(e) {
      e.preventDefault();
      e.stopPropagation();
      var num = $(this).children("input").val();
      var url = "/doneTodoList";
      if($(this).attr("class").indexOf("toDo_listItem1") != -1) {
        if(!auth) {
          location.href = "/common/login";
          return;
        }
        else if(auth !== "MANAGER" && auth !== "ADMIN") {
          alert("권한이 없습니다.");
          return;
        }
        url = "/doneTodoListManager";
      }
      
      if($(this).children("input").prop("checked") === false) {
        $(this).children("input").prop("checked", true);
        $(this).addClass("activeList");
        doneTodoList('Y', num, url);
      }
      else if($(this).children("input").prop("checked") === true){
        $(this).children("input").prop("checked", false);
        $(this).removeClass("activeList");
        doneTodoList('N', num, url);
      }
    });
    
    getTodoList();
    getTodoListManager();
  </script>
</body>
</html>
