<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html lang="ko">
<head>
  <link rel="stylesheet" href="/resources/css/styles.css" />
  <style>
    .get_tools {
      display: flex;
      justify-content: flex-end;
      margin: 10px 0;
      align-items: center;
    }
    
    .get_tools div {
    }
    
    .btn_get_next {
      margin-right: 10px;
    }
    
    .get_tools span {
      display: inline-block;
      
    }
    
    .get_tools_bottom {
      display: flex;
      justify-content: space-between;
    }
    
    .get_tool_list {
      display: flex;
    }
    
    .get_tool_list .btn_board_list {
      margin-right: 10px;
    }
    
    .get_btn {
      background-color: #EFF0F2;
      padding: 8px;
      font-size: 14px;
      font-weight: 500;
      border-radius: 4px;
      display: flex;
      align-items: center;
    }
    
    .get_btn img {
      width: 12px;
      margin-right: 4px;
    }
    
    .text_view {
      margin: 26px 0;
    }
    
    .get_contents_container {
      padding: 30px;
      border: 1px solid #dadada;
      border-radius: 3px;
    }
    
    hr {
      background-color: #dadada;
      border: 0px;
      height: 1px;
    }
    
    .contents_info {
      display: flex;
      justify-content: space-between;
    }
    
    .contents_tools {
      display: flex;
      
    }
    
    .contents_comments_writer {
      border: 1px solid #dadada;
      border-radius: 3px;
      
    }
    
    .contents_comments_inbox_text {
      display: block;
    }
    
    .register_box {
      text-align: right;
    }
    
    .register_box a {
      display: block;
      margin: 10px;
      font-size: 14px;
      color: #888888;
      
    }
    
  </style>
  <script src="/node_modules/jquery/dist/jquery.min.js"></script>
  <script type="text/javascript" src="/resources/js/reply.js"></script>
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
	      <div class="get">
	        <div class="get_tools">
	          <div class="get_btn btn_get_next">
	            <img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>
              <span>다음글</span>
	          </div>
	          <div class="get_btn btn_board_list">
	            <span>목록</span>
	          </div>
	        </div>
	        <div class="get_contents_container">
	          <div class="get_contents_header">
	            <div class="contents_kind">
	              ${board.menu_nm}
	            </div>
	            <div class="contents_title">
	              ${board.title}
	            </div>
	            <div class="contents_info">
	              <div class="profile_area">
	                <div class="profile_info">
	                  <div class="nick_box">
	                    ${board.id}
	                  </div>
	                </div>
	                <div class="article_info">
	                  <span class="date">${board.reg_date}</span>
	                  <span class="cnt">조회 ${board.cnt}</span>
	                </div>
	              </div>
	              <div class="contents_tools">
	                <a href="#" role="button" class="contents_comments_button">
	                  댓글 ${board.replyCnt}
	                </a>
			            <a href="#" class="contents_url_info">
			              URL 복사
			            </a>
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
	              <p class="text_view">
	                <span class="text_content">${board.content}</span>
	              </p>
	            </div>
	            <div class="get_user_contents">
	            </div>
	            <div class="contents_main_tools">
		            <div class="contents_like">
		            </div>
		            <div class="contents_comments_info">
		            </div>
	            </div>
	          </div>
	          <hr />
	          <div class="get_contents_comments">
	            <div class="contents_comments_header">
		            <div class="contents_comments_title">
		              <span>댓글</span>
		            </div>
		            <ul class="contents_comments_tab_list">
		              <li class="comments_tab_item">
		              </li>
		              <li class="comments_tab_item">
		              </li>
		            </ul>
		            <button type="button" class="comments_refresh_button"><img src=""/></button>
	            </div>
	            <ul class="contents_comments_list">
	              <li id="#" class="commentsItem">
	                <div class="comments_area">
	                  <div class="commentsItem_id_box">
	                    <a id="#" href="#" role="button" aria-haspopup="true" aria-expanded="false" class="comment_nickname">삐리리</a>
	                  </div>
	                  <div class="commentsItem_text_box">
	                    <p class="comments_text_view">
	                      <span class="text_comment"></span>
	                    </p>
	                  </div>
	                  <div class="commentsItem_info_box">
	                    <span class="commentsItem_info_date">
	                      2020.20.20
	                    </span>
	                    <a href="#" role="button" class="comment_info_button">답글쓰기</a>
	                  </div>
                  </div>
	              </li>
	              <li id="#" class="commentsItem commentItem-repl">
	            </ul>
	            <div class="contents_comments_writer">
	              <div class="contents_comments_inbox">
	                <span class="contents_comments_name">정해성</span>
	                <textarea placeholder="댓글을 남겨보세요" rows="1" class="contents_comments_inbox_text" style="overflow: hidden; overflow-wrap: break-word; height: 17px;">
	                </textarea>
	              </div>
	              <div class="contents_comments_tools">
	                <div class="register_box">
	                  <a href="#" role="button" class="btn_register">등록</a>
	                </div>
	              </div>
	            </div>
	          </div>
	        </div>
	        <div class="get_tools_bottom">
	          <div class="get_tool_write">
			        <div class="board_new">
			          <span><img src="/node_modules/bootstrap-icons/icons/pencil-square.svg"/>글쓰기</span>
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
                ${board.menu_nm}
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
	                      <a href="#" role="button" class="member">끄아앙</a>
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
  
  
  
  
  <script>
    
    $(function() {
     
      
    });
    
  </script>
</body>
</html>
