<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html lang="ko">
<head>
  <link rel="stylesheet" href="/resources/css/styles.css" />
  <script src="/node_modules/jquery/dist/jquery.min.js"></script>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>Main</title>
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
              <a href="/board/list?page=1&userDisplay=10&kind=BN" class="menu_sublistItem">공지글</a>
              <a href="/board/list?page=1&userDisplay=10&kind=BA" class="menu_sublistItem">전체게시판</a>
  	   	      <a href="/board/list?page=1&userDisplay=10&kind=BF" class="menu_sublistItem">자유게시판</a>
  	 		      <a href="/board/list?page=1&userDisplay=10&kind=BQ" class="menu_sublistItem">질문게시판</a>
  	 	      </div>
	        </div>
          <div class="menu_list">
            <div class="menu_list_name">
              <a href="/board/list?page=1&userDisplay=10" class="menu_list_btn">게시판</a>
            </div>
            <div class="menu_sublist">
              <a href="#" class="menu_sublistItem">공지글</a>
              <a href="#" class="menu_sublistItem">자유게시판</a>
              <a href="#" class="menu_sublistItem">질문게시판</a>
            </div>
          </div>
          <div class="menu_list">
            <div class="menu_list_name">
              <a href="/board/list?page=1&userDisplay=10" class="menu_list_btn">게시판</a>
            </div>
            <div class="menu_sublist">
              <a href="#" class="menu_sublistItem">공지글</a>
              <a href="#" class="menu_sublistItem">자유게시판</a>
              <a href="#" class="menu_sublistItem">질문게시판</a>
            </div>
          </div>
	      </div>
      </div>
      <div class="navbar_userInfo">
        <img src="/resources/img/logoMain1.jpg" class="profileImg"/>
        <a href="/common/login" style="color: #000;">Login</a>
        <div class="divider"></div>
        <a href="/common/signUp" style="color: #000;">Sign up</a>
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
        <hr />
        <div>
          <form action="/">
            <ul>
              <li>
                <ul>
                  <li>
                    <span>이름</span>
                  </li>
                  <li>
                    <input type="text" name="name">
                  </li>
                </ul>
              </li>
            </ul>
            <ul>
              <li>
                <ul>
                  <li>
                    <span>이메일</span>
                  </li>
                  <li>
                    <input type="text" name="email">
                  </li>
                </ul>
              </li>
            </ul>
            <ul>
              <li>
                <ul>
                  <li>
                    <span>회사</span>
                  </li>
                  <li>
                    <input type="text" name="company">
                  </li>
                </ul>
              </li>
            </ul>
            <ul>
              <li>
                <textarea rows="6" cols="50" name="comments"></textarea>
              </li>
            </ul>
            <ul>
              <li>
                <input type="submit" >
              </li>
            </ul>
            
          </form>
        </div>
      </section>
      
    </div>
  </div>
  
  <script type="text/javascript" src="/resources/js/navbar.js"></script>
  <script type="text/javascript">
  
    function getTodoList() {
      
      $.ajax({
        url: "/getTodoList",
        method: "get",
        dataType: "json",
        success: function(res) {
          
          console.log(res);
          var str = "";
          //<input type="checkbox" id="hobby1" name="hobby1" value="1"><label for="hobby1">독서</label>
          for(var i = 0; i < res.length; i++) {
            str += '<div class="toDo_listItem_container">';
            if(res[i].done === 'Y') {
              str += '<li class="toDo_listItem activeList">';
              str += '<input type="checkbox" value="' + res[i].num + '" checked id="done' + res[i].num + '"><label for="done' + res[i].num + '">';
            }
            else {
              str += '<li class="toDo_listItem">';
              str += '<input type="checkbox" value="' + res[i].num + '" id="done' + res[i].num + '"><label for="done' + res[i].num + '">';
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
    
    function doneTodoList(done, num) {
      $.ajax({
        url: "/doneTodoList",
        method: "post",
        data: {
          done: done,
          num: num
        },
        success: function() {
        },
        error: function() {
          alert("error");
        }
      });
    }
    
    function regTodoList() {
      var content = $(".inputList").val();
      var data = {"do_list" : content}
      
      if(!content) {
        alert("값을 입력하세요");
        return;
      }
      
      $.ajax({
        url: "/regTodoList",
        method: "post",
        data: data,
        success: function(res) {
          $(".inputList").val("");
          $(".inputList").focus();
          getTodoList();
          
        },
        error: function(error) {
          alert("fail");
        }
      });
    }

    $(".inputList").on("keydown", function(e) {
      
      if(e.keyCode === 13) {
        regTodoList();
      }
    });
    
    
    $(".listRegisterBtn").on("click", function(e) {
      e.preventDefault();
      e.stopPropagation();
      
      regTodoList();
    });
    
    $(document).on("click", ".listDeleteBtn", function(e) {
      e.preventDefault();
      e.stopPropagation();
      
      var num = $(this).attr("href");
      $.ajax({
        url: "/deleteTodoList",
        method: "post",
        data: {
          num: num
        },
        success: function(res) {
          getTodoList();
        },
        error: function(error) {
          alert("fail");
        }
      });
    });
    
    $(document).on("click", ".toDo_listItem", function(e) {
      e.preventDefault();
      e.stopPropagation();
      
      var num = $(this).children("input").val();
      
      if($(this).children("input").prop("checked") === false) {
        $(this).children("input").prop("checked", true);
        $(this).addClass("activeList");
        doneTodoList('Y', num);
      }
      else if($(this).children("input").prop("checked") === true){
        $(this).children("input").prop("checked", false);
        $(this).removeClass("activeList");
        doneTodoList('N', num);
      }
    });
    
    getTodoList();
  </script>
</body>
</html>
