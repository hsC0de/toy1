<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html lang="ko">
<head>
  <link rel="stylesheet" href="/resources/css/styles.css" />
  <script src="/node_modules/jquery/dist/jquery.min.js"></script>
  <script src="/resources/js/board.js"></script>
  <script type="text/javascript" src="/resources/js/reply.js"></script>
	<meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>Board</title>
	
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
    <main class="article">
      <div class="board">
        <div class="board_title">
          <span>00게시판</span>
        </div>
        <div class="board_option">
          <ul>
            <li>
              <select>
                <option value="5">5개씩</option>
                <option value="10">10개씩</option>
                <option value="15" selected>15개씩</option>
                <option value="20">20개씩</option>
                <option value="30">30개씩</option>
                <option value="40">40개씩</option>
                <option value="50">50개씩</option>
              </select>
            </li>
          </ul>
        </div>
        <table class="board_table">
          <thead>
            <tr>
              <th>
                 
              </th>
	            <th>
	              제목
	            </th>
	            <th>
	              작성자
              </th>
              <th>
                작성일
              </th>
              <th>
                조회
              </th>
              <th>
                좋아요<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>
              </th>
            </tr>
          </thead>
          <tbody>
            
          </tbody>
          
        </table>
        <div class="get_tools_bottom">
	        <div class="board_new">
	          <span><img src="/node_modules/bootstrap-icons/icons/pencil-square.svg"/>글쓰기</span>
	        </div>
	        <div class="board_footer">
	          <div class="board_footer_paging">
	          </div>
	          <div class="board_footer_searching">
	          </div>
	        </div>
        </div>
      </div>
    </main>
    
  </div>
  
  
  
  
  <script>
    
    $(function() {
      var str = "";
      $.getJSON("/board/boardList", function(data) {
        console.log(data);
	      for(var i = 0; i < data.length; i++) {
		      str += '<tr>';
		      str += '<td>' + data[i].bno + '</td>';
		      str += '<td>';
		      str += '<a class="getBoardList" href="/board/get/?bno=' + data[i].bno + '" />';
		      str += data[i].title;
		      str += '</a><span class="getBoardListReplyCnt">[' + data[i].replyCnt + ']</span>';
		      str += '</td>';
		      str += '<td>' + data[i].id + '</td>';
		      str += '<td>' + replyService.displayTime(data[i].reg_date) + '</td>';
		      str += '<td>' + data[i].cnt + '</td>';                             
		      str += '<td>' + data[i].good + '</td>';
		      str += '</tr>';

	      }
				$("tbody").html(str);
      }).fail(function(xhr, status, err) {
        alert(err);
      });
      
      
    

    });
    
  </script>
</body>
</html>
