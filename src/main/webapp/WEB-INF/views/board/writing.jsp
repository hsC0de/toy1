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
	<title>Board</title>
</head>
<body>
  <div id="wrap">
    <header class="container">
	    <div class="navbar">
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
	                  <li>전체게시판</li>
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
	        <a href="#"><img/></a>
	      </div>
	    </div>
	    <div class="front-img">
	      <a href="#">
	        <img src="http://placehold.it/861x150" />
	      </a>
	    </div>
	  </header>
    <section class="container">
      <div class="writingWrap">
        <div class="writing_Header">
          <span>00게시판</span>
	        <div class="writing_toolArea">
	          <a href="#" role="button" class="">
	            <span class="button_txt">등록</span>
	          </a>
	        </div>
        </div>
        <div class="writingContent">
          <div class="writingContent_Title" style="width:861px;">
            <div class="row" style="display: flex;">
              <div class="kindSelect" style="width: 70%; height: 40px; background: yellow; display:inline-block;"></div>
              <div class="typeSelect" style="width: 30%; height: 40px; background: tomato; display:inline-block;"></div>
            </div>
            <div class="row" >
              <textarea placeholder="제목을 입력해 주세요." class="textarea_input" style="height: 40px; width:100%;"></textarea>
            </div>
          </div>
          <div class="writingContent_smartEditor">
            <textarea placeholder="내용을 입력해 주세요." class="textarea_input" style="height: 520px; width:100%;"></textarea> 
          </div>
        </div>
      </div>
    </section>
    
  </div>
  <script>
    $(function() {
      
      $(".writing_toolArea a").on("click", function(e) {
        
        e.preventDefault();
        e.stopPropagation();
        
        var title = $(".row textarea").val();
        console.log(title);
        var content = $(".writingContent_smartEditor textarea").val();
        if(!title) {
          alert("제목을 입력하세요.");
          return;
        } else if(!content) {
          alert("내용을 입력하세요.");
          return;
        }
        
        if(confirm("등록하시겠습니까?")) {
          
	        $.post({
	          url: "/board/regPost",
	          data: { id: "USER00"
	                , title: title
	                , content: content
	                , type: "N"
	                , kind: "A" },
	          success: function(res) {
	            alert(res);
	            opener.location.reload();
	            self.close();
	          },
	          error: function() {
	            alert("등록에 실패했습니다.");
	          }
	        });
        }
        
        
      });
    });
  </script>
</body>
</html>
