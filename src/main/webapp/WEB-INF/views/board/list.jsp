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
	<title>Board</title>
	
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
    <main class="article">
      <div class="board">
        <div class="board_title">
          <span>${kind_nm.kind_nm}</span>
        </div>
        <div class="board_option">
          <ul>
            <li>
              <select onchange="getUserDisplay(this.value)">
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
                <a href="#" class="sort_likes">좋아요<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/></a>
              </th>
            </tr>
          </thead>
          <tbody>
            <c:if test="${paging.page eq 1}">
            <c:forEach items="${list.noticeBoardList}" var="board">
            <tr class="noticeList">
              <td class="noticeTd">
                <c:choose>
                <c:when test="${kind ne 'BA'}">
                  <c:choose>
                  <c:when test="${board.kind eq 'BN' and board.type ne 'N'}">
                    <c:choose>
                    <c:when test="${board.type eq 'Y'}">
                    <div class="noticeBoardBox">공지</div>
                    </c:when>
                    <c:otherwise>
                    <div class="noticeBoardBox">필독</div>
                    </c:otherwise>
                    </c:choose>
                  </c:when>
                  <c:when test="${board.kind ne 'BN' and board.type ne 'N'}">
                    <c:choose>
                    <c:when test="${board.type eq 'Y'}">
                    <div class="noticeBoardBox">공지</div>
                    </c:when>
                    <c:otherwise>
                    <div class="noticeBoardBox">필독</div>
                    </c:otherwise>
                    </c:choose>
                  </c:when>
                  <c:otherwise>
                  <c:out value="${board.bno}" />
                  </c:otherwise>
                  </c:choose>
                </c:when>
                <c:otherwise>
                  <c:choose>
                  <c:when test="${board.kind eq 'BN' and board.type ne 'N'}">
                    <c:choose>
                    <c:when test="${board.type eq 'Y'}">
                    <div class="noticeBoardBox">공지</div>
                    </c:when>
                    <c:otherwise>
                    <div class="noticeBoardBox">필독</div>
                    </c:otherwise>
                    </c:choose>
                  </c:when>
                  <c:otherwise>
                  <a class="moveBoardKind" href="/board/list?page=1&userDisplay=15&kind=${board.kind}"><c:out value="${board.menu_nm}"/></a>
                  </c:otherwise>
                  </c:choose>
                </c:otherwise>
                </c:choose>
              </td>
              <td>
                <a class="getBoardList" href='/board/get?bno=<c:out value="${board.bno}"/>&page=${paging.page}&userDisplay=<c:out value="${paging.userDisplay}&kind=${board.kind}"/>' >
                  <span>${board.title}</span>
                  <span class="getBoardListReplyCnt">[<c:out value="${board.replyCnt}" />]</span>
                </a>
              </td>
              <td><c:out value="${board.id}" /></td>
              <td><c:out value="${board.reg_date}" /></td>
              <td><c:out value="${board.cnt}" /></td>
              <td><c:out value="${board.good}" /></td>
            </tr>
            </c:forEach>
            <c:forEach items="${list.boardNoticeList}" var="board">
            <tr class="noticeList">
              <td class="noticeTd">
                <c:choose>
                <c:when test="${kind ne 'BA'}">
                  <c:choose>
                  <c:when test="${board.kind ne 'BN' and board.type eq 'Y'}">
                    <div class="noticeBox">공지</div>
                  </c:when>
                  </c:choose>
                </c:when>
                </c:choose>
              </td>
              <td>
                <a class="getBoardList" href='/board/get?bno=<c:out value="${board.bno}"/>&page=${paging.page}&userDisplay=<c:out value="${paging.userDisplay}&kind=${board.kind}"/>' >
                  <span>${board.title}</span>
                  <span class="getBoardListReplyCnt">[<c:out value="${board.replyCnt}" />]</span>
                </a>
              </td>
              <td><c:out value="${board.id}" /></td>
              <td><c:out value="${board.reg_date}" /></td>
              <td><c:out value="${board.cnt}" /></td>
              <td><c:out value="${board.good}" /></td>
            </tr>
            </c:forEach>
            </c:if>
            <c:forEach items="${list.boardList}" var="board">
            <tr>
              <td>
                <c:choose>
                <c:when test="${kind ne 'BA'}">
                  <c:out value="${board.bno}" />
                </c:when>
                <c:otherwise>
                  <a class="moveBoardKind" href="/board/list?page=1&userDisplay=15&kind=${board.kind}"><c:out value="${board.menu_nm}"/></a>
                </c:otherwise>
                </c:choose>
              </td>
              <td>
                <a class="getBoardList" href='/board/get?bno=<c:out value="${board.bno}"/>&page=${paging.page}&userDisplay=<c:out value="${paging.userDisplay}&kind=${kind}"/>' >
                  <span>${board.title}</span>
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
        <div class="list_tools_bottom">
	        <div class="board_new">
            <c:choose>
            <c:when test="${kind ne 'BN' and kind ne 'BA'}">
            <span><img src="/node_modules/bootstrap-icons/icons/pencil-square.svg"/>글쓰기</span>
            </c:when>
            <c:otherwise>
            <sec:authorize access="hasAnyRole('ADMIN', 'MANAGER')">
            <c:if test="${kind ne 'BA'}">
              <span><img src="/node_modules/bootstrap-icons/icons/pencil-square.svg"/>글쓰기</span>
            </c:if>              
            </sec:authorize>
            </c:otherwise>
            </c:choose>
	        </div>
	        <div class="board_footer">
	          <div class="board_footer_paging">
              <ul class="pagination">
              <c:if test="${paging.prev}">
               <li class="paginate_button previous">
                 <a href="/board/list?page=${paging.startPage - 1}&userDisplay=${paging.userDisplay}&kind=${kind}">〈 이전</a>
               </li>
               <div class="paginate_border previous_border"></div>
              </c:if>
              
              <c:forEach var="num" begin="${paging.startPage}" end="${paging.endPage}">
               <li class="paginate_button ${paging.page == num? 'active':''}">
                 <a href="/board/list?page=${num}&userDisplay=${paging.userDisplay}&kind=${kind}">${num}</a>
               </li>
              </c:forEach>
              
              <c:if test="${paging.next}">
               <div class="paginate_border"></div>
               <li class="paginate_button next">
                 <a href="/board/list?page=${paging.startPage + 10}&userDisplay=${paging.userDisplay}&kind=${kind}">다음 〉</a>
               </li>
              </c:if>
              </ul>
	          </div>
	          <div class="board_footer_searching">
	          </div>
	        </div>
        </div>
      </div>
    </main>
    
  </div>
  <script type="text/javascript">
    var boardKind = "${kind}";
    var userDisplay = "${userDisplay}";
    var sortLike = ${sortLike != null and !empty sortLike? sortLike : '0'};
  
    function getUserDisplay(val) {
      console.log(val);
      if(val) location.href = '/board/list?page=1&userDisplay=' + val + '&kind=${kind}';
    }
  </script>
  <script type="text/javascript" src="/resources/js/reply.js"></script>
  <script type="text/javascript" src="/resources/js/list.js"></script>
  <script type="text/javascript" src="/resources/js/navbar.js"></script>
</body>
</html>
