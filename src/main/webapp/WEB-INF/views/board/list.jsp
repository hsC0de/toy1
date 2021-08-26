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
              <select onchange="if(this.value) javascript:getBoardList(this.value, 1);">
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
  
		function getBoardList(userDisplay, page) {
		  
		  var str = "";
      
		  
//       $.getJSON("/board/boardList?userDisplay=" + userDisplay + "&page=" + page, function(data) {
      $.ajax({
        url: "/board/boardList",
        method: "get",
        data: {
                page: page,
                userDisplay: userDisplay
              },
        dataType: "json",
        success: function(res) {
          var data = res.list;
          for(var i = 0; i < data.length; i++) {
            var date = data[i].reg_date;
            var gap = data[i].gap;
            str += '<tr>';
            str += '<td>' + data[i].bno + '</td>';
            str += '<td>';
            str += '<a class="getBoardList" href="/board/get?bno=' + data[i].bno + '" />';
            str += data[i].title;
            str += '</a><span class="getBoardListReplyCnt">[' + data[i].replyCnt + ']</span>';
            str += '</td>';
            str += '<td>' + data[i].id + '</td>';
            str += '<td>' + replyService.displayTime(date, gap) + '</td>'; 
            str += '<td>' + data[i].cnt + '</td>';                             
            str += '<td>' + data[i].good + '</td>';
            str += '</tr>';
          }
          $("tbody").html(str);
          
          var paging = res.paging;
          console.log(paging);
          console.log(paging.endPage);
          var strPage = "";
          if(paging.prev) {
            strPage += '<ul class="pagination">';
            strPage += '<li class="paginate_button previous">';
            strPage += '<a href="' + paging.startPage - 10 + '">&lt; 이전</a>';
            strPage += '</li>';
          }
          for(var i = 1; i <= paging.endPage; i++) {
            strPage += '<li class="paginate_button">'; // ' + paging.page == page? "active" : "" + '
            strPage += '<a href="/board/list?page="' + i + '>' + i + '</a>';
            strPage += '</li>';
          }
          if(paging.next) {
            strPage += '<ul class="pagination">';
            strPage += '<li class="paginate_button previous">';
            strPage += '<a href="' + paging.startPage + 10 + '">다음 &gt;</a>';
            strPage += '</li>';
          }
          
          $(".board_footer_paging").html(strPage);
          
//           <ul class="pagination">
//           <c:if test="${pageMaker.prev}">
//             <li class="paginate_button previous">
//               <a href="${pageMaker.startPage - 1}">Previous</a>
//             </li>
//           </c:if>
          
//           <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
//             <li class="paginate_button ${pageMaker.cri.pageNum == num? 'active':''}">
//               <a href="${num}">${num}</a>
//             </li>
//           </c:forEach>
          
//           <c:if test="${pageMaker.next}">
//             <li class="paginate_button next">
//               <a href="${pageMaker.endPage + 1}">Next</a>
//             </li>
//           </c:if>
//         </ul>
        
        
        },
        error: function(xhr, status, err) {
          alert(err);
        }
      });
		}
		
    $(function() {
      
      getBoardList(15, 1);
    });
    
  </script>
</body>
</html>
