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
                <a href="/board/list?page=1&userDisplay=5">게시판</a>
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
              <select onchange="userDisplay(this.value)">
                <option value="5" <c:out value="${paging.userDisplay eq '5'? 'selected':'' }"/>>5개씩</option>
                <option value="10" <c:out value="${paging.userDisplay eq '10'? 'selected':'' }"/>>10개씩</option>
                <option value="15" <c:out value="${paging.userDisplay eq '15'? 'selected':'' }"/>>15개씩</option>
                <option value="20" <c:out value="${paging.userDisplay eq '20'? 'selected':'' }"/>>20개씩</option>
                <option value="30" <c:out value="${paging.userDisplay eq '30'? 'selected':'' }"/>>30개씩</option>
                <option value="40" <c:out value="${paging.userDisplay eq '40'? 'selected':'' }"/>>40개씩</option>
                <option value="50" <c:out value="${paging.userDisplay eq '50'? 'selected':'' }"/>>50개씩</option>
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
            <c:forEach items="${list}" var="board">
            <tr>
              <td><c:out value="${board.bno}" /></td>
              <td>
                <a class="getBoardList" href='/board/get?bno=<c:out value="${board.bno}"/>'><c:out value="${board.title}" />
                  <span class="getBoardListReplyCnt">[<c:out value="${board.replyCnt}" />]</span>
                </a>
              </td>
              <td><c:out value="${board.id}" /></td>
              <td><c:out value="${board.reg_date}" /></td>
              <td><c:out value="${board.cnt}" /></td>
              <td><c:out value="${board.good}" /></td>
            </tr>
            </c:forEach>
          </tbody>
          
        </table>
        <div class="get_tools_bottom">
	        <div class="board_new">
	          <span><img src="/node_modules/bootstrap-icons/icons/pencil-square.svg"/>글쓰기</span>
	        </div>
	        <div class="board_footer">
	          <div class="board_footer_paging">
              <ul class="pagination">
              <c:if test="${paging.prev}">
               <li class="paginate_button previous">
                 <a href="/board/list?page=${paging.endPage}&userDisplay=${paging.userDisplay}">&lt; 이전</a>
               </li>
              </c:if>
              
              <c:forEach var="num" begin="${paging.startPage}" end="${paging.endPage}">
               <li class="paginate_button ${paging.page == num? 'active':''}">
                 <a href="/board/list?page=${num}&userDisplay=${paging.userDisplay}">${num}</a>
               </li>
              </c:forEach>
              
              <c:if test="${paging.next}">
               <li class="paginate_button next">
                 <a href="/board/list?page=${paging.startPage}&userDisplay=${paging.userDisplay}">다음 &gt;</a>
               </li>
              </c:if>
              </ul>
	          </div>
<!--             if(paging.prev) { -->
<!--             strPage += '<ul class="pagination">'; -->
<!--             strPage += '<li class="paginate_button previous">'; -->
<!--             strPage += '<a href="' + paging.startPage - 10 + '">&lt; 이전</a>'; -->
<!--             strPage += '</li>'; -->
<!--           } -->
<!--           for(var i = 1; i <= paging.endPage; i++) { -->
<!--             strPage += '<li class="paginate_button">'; // ' + paging.page == page? "active" : "" + ' -->
<!--             strPage += '<a href="/board/list?page="' + i + '>' + i + '</a>'; -->
<!--             strPage += '</li>'; -->
<!--           } -->
<!--           if(paging.next) { -->
<!--             strPage += '<ul class="pagination">'; -->
<!--             strPage += '<li class="paginate_button previous">'; -->
<!--             strPage += '<a href="' + paging.startPage + 10 + '">다음 &gt;</a>'; -->
<!--             strPage += '</li>'; -->
<!--           } -->
            
            
	          <div class="board_footer_searching">
	          </div>
	        </div>
        </div>
      </div>
    </main>
    
  </div>
  
  
  
  
  <script>

    function userDisplay(val) {
      console.log(val);
      if(val) location.href = '/board/list?page=${paging.page}&userDisplay=' + val;
    }
		
    $(function() {
      console.log(${paging.startPage});
    });
    
  </script>
</body>
</html>
