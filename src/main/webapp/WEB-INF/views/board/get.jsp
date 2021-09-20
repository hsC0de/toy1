<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page session="false" %>
<html lang="ko">
<head>
  <link rel="stylesheet" href="/resources/css/styles.css" />
  <link rel="stylesheet" href="/node_modules/@toast-ui/editor/dist/toastui-editor-viewer.css" />
  <script type="text/javascript" src="/node_modules/jquery/dist/jquery.min.js"></script>
	<meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>Get</title>
</head>
<body>
  <div id="wrap">
    <div id="container">
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
	      <div class="get">
	        <div class="get_tools">
            <div class="modify_tools">
              <sec:authentication property="principal" var="pinfo"/>
              <sec:authorize access="isAuthenticated()">
              <c:if test="${pinfo.username eq boardHtml.id}">
              <div class="get_btn btn_board_modify">
                <span>수정</span>
              </div>
              <div class="get_btn btn_board_delete">
                <span>삭제</span>
              </div>
              </c:if>
              </sec:authorize>
            </div>
            <div class="list_tools">
              <div class="get_btn btn_get_pre">
                <img src="/node_modules/bootstrap-icons/icons/chevron-compact-up.svg"/>
                <span>이전글</span>
              </div>
  	          <div class="get_btn btn_get_next">
  	            <img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>
                <span>다음글</span>
  	          </div>
  	          <div class="get_btn btn_board_list">
  	            <span>목록</span>
  	          </div>
            </div>
	        </div>
	        <div class="get_contents_container_box">
		        <div class="get_contents_container">
		          <div class="get_contents_header">
		            <div class="contents_kind">
		              <a href="#" class="contents_kind_button"> <span class="kind_button_val">〉</span></a>
		            </div>
		            <div class="contents_title">
                  <div class=""></div>
		              <span></span>
		            </div>
		            <div class="contents_info">
		              <div class="profile_area">
		                <div class="profile_info">
		                  <div class="nick_box">
		                    <span></span>
		                  </div>
		                </div>
		                <div class="article_info">
		                  <span class="date"></span>
		                  <span class="cnt">조회 </span>
		                </div>
		              </div>
		              <div class="contents_tools">
		                <a href="#" role="button" class="contents_comments_button">
		                  <img src="/node_modules/bootstrap-icons/icons/chat-dots.svg"/><span class="refreshReplyCnt">댓글 </span>
		                </a>
				            <a href="#" class="contents_url_info">
				              URL 복사
				            </a>
				            <input type="text" id="copyUrl" style="position: absolute; left: -9999px;"/>
				            <div class="toast_url_copy_successful" style="display: none;">
				              URL이 복사되었습니다. 원하는 곳에 붙여 넣으세요.
				            </div>
				            <div class="contents_print">
				              <a id="articleTool" href="#" role="button" title="더보기" class="button_more">
				              </a>
				              <div id="articleTool" role="menu" class="layerMore">
				                <ul class="layer_list">
				                  <li class="layer_item">
				                    <a href="#" role="button" class="layer_button">인쇄하기</a>
				                  </li>
				                </ul>
				              </div>
				            </div>
		              </div>
		            </div>
		          </div>
	            <hr />
		          <div class="get_contents_article">
		            <div class="contents_mainText">
                   <div id="viewer" style="word-break:break-all;">
                   </div>
<!-- 		              <p class="text_view"> -->
<!-- 		                <span class="text_content" style="word-break:break-all;"></span> -->
<!-- 		              </p> -->
		            </div>
		            <div class="get_user_contents">
		              <a href="#" class="user_contents_list"><span></span>님의 게시글 더보기 〉</a>
		            </div>
		            <div class="contents_main_tools">
			            <div class="contents_like">
                    <a href="#" role="button" class="contents_like_button">
                      <img src="/resources/img/ico-post-like-f-53535.svg"/>
                      <span class="refreshLikeCnt">좋아요 0</span>
                    </a>
			            </div>
			            <div class="contents_tools">
                    <a href="#" role="button" class="contents_comments_button1">
                      <img src="/node_modules/bootstrap-icons/icons/chat-dots.svg"/><span class="refreshReplyCnt">댓글 0</span>
                    </a>
			            </div>
		            </div>
		          </div>
		          <div class="get_contents_comments">
  		          <hr />
		            <div class="contents_comments_header">
			            <div class="contents_comments_title">
			              <span>댓글</span>
			            </div>
			            <ul class="contents_comments_tab_list">
			              <li class="comments_tab_item">
			                <a href="#" class="tab_item_button">등록순</a>
			              </li>
			              <li class="comments_tab_item">
	                    <a href="#" class="tab_item_button">최신순</a>
			              </li>
			            </ul>
			            <button type="button" class="comments_refresh_button"><img src="/node_modules/bootstrap-icons/icons/arrow-clockwise.svg"/></button>
		            </div>
		            <ul class="contents_comments_list">
		              <li id="#" class="commentsItem">
		                <div class="comments_area">
		                  <div class="commentsItem_id_box">
		                    <a id="#" href="#" role="button" aria-haspopup="true" aria-expanded="false" class="comment_nickname"></a>
		                  </div>
		                  <div class="commentsItem_text_box">
		                    <p class="comments_text_view">
		                      <span class="text_comment"></span>
		                    </p>
		                  </div>
		                  <div class="commentsItem_info_box">
		                    <span class="commentsItem_info_date">
		                    </span>
		                    <a href="#" role="button" class="comment_info_button">답글쓰기</a>
		                  </div>
                      <div class="comment_list_tool">
                        <a href=# class="comment_list_tool_button">
                          <svg xmlns="/node_modules/bootstrap-icons/icons/three-dots-vertical.svg" width="16" height="16" fill="currentColor" class="bi bi-three-dots-vertical" viewBox="0 0 16 16">
                            <path d="M9.5 13a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"></path>
                          </svg>
                        </a>
                        <div class="comment_more">
                          <ul>
                            <li class="more_item">
                              <a href="#" class="more_btn">신고</a>
                            </li>
                          </ul>
                        </div>
                      </div>
	                  </div>
		              </li>
		              <li id="#" class="commentsItem commentItem-repl"></li>
		            </ul>
		          </div>
              <sec:authorize access="isAuthenticated()">
		          <div class="contents_comments_writer">
		            <div class="contents_comments_inbox">
		              <span class="contents_comments_name"><sec:authentication property='principal.username'/></span>
		              <textarea placeholder="댓글을 남겨보세요" rows="1" class="contents_comments_inbox_text" 
		              cols="80" style="overflow: hidden; overflow-wrap: break-word; height:1rem;"></textarea>
		            </div>
		            <div class="contents_comments_tools">
		              <div class="register_box">
		                <a href="#" role="button" class="btn_register">등록</a>
		              </div>
		            </div>
		          </div>
              </sec:authorize>
		        </div>
	        </div>
	        <div class="get_tools_bottom">
	          <div class="get_tool_write">
			        <div class="board_new">
			          <span><img src="/node_modules/bootstrap-icons/icons/pencil-square.svg"/>글쓰기</span>
			        </div>
              <div class="modify_tools">
                <sec:authorize access="isAuthenticated()">
                <c:if test="${pinfo.username eq boardHtml.id}">
                <div class="get_btn btn_board_modify">
                  <span>수정</span>
                </div>
                <div class="get_btn btn_board_delete">
                  <span>삭제</span>
                </div>
                </c:if>
                </sec:authorize>
              </div>
	          </div>
            <div class="get_tool_list">
              <div class="get_btn btn_board_list">
                <span>목록</span>
              </div>
              <div class="get_btn btn_top">
                <img src="/node_modules/bootstrap-icons/icons/caret-up-fill.svg"/><span>TOP</span>
              </div>
            </div>		        
	        </div>
	        <div class="relatedArticles">
	          <div class="article_board_title">
	            <strong class="title">
                
              </strong>
	            <span class="text"> 글</span>
	          </div>
	          <div class="relatedArticlesTabContainer">
	            <div class="relatedArticlesTabContainer_tab">
	              <div class="tab_content">
	                <ul class="relatedArticlesList">
	                  <li class="list_item">
	                    <div class="tit_area">
	                      <a href="#" target="_self" class="tit">
	                        <span>제목!!!</span>
	                      </a>
	                    </div>
	                    <div class="member_area">
	                      <a href="#" role="button" class="member">아이디</a>
	                    </div>
	                    <div class="date_area">
	                      2020.20.20
	                    </div>
	                  </li>
	                </ul>
	              </div>
	            </div>
	          </div>
	        </div>
	        <div class="board_footer">
	          <div class="board_footer_paging">
	          </div>
	          <div class="board_footer_searching">
	          </div>
	        </div>
	      </div>
	    </main>
    </div> 
  </div>
  <sec:authorize access="isAuthenticated()">
  <div id="tempUsername" style="display:none"><sec:authentication property='principal.username'/></div>
  </sec:authorize>
  <script type="text/javascript">
    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue="${_csrf.token}";
    var board = ${board};
  </script>
  <script type="text/javascript" src="/resources/js/reply.js"></script>
  <script type="text/javascript" src="/resources/js/util/autoSize.js"></script>
  <script type="text/javascript" src="/resources/js/get.js"></script>
  <script type="text/javascript" src="/resources/js/navbar.js"></script>
  <script type="text/javascript" src="/node_modules/@toast-ui/editor/dist/toastui-editor-viewer.js"></script>
</body>
</html>
