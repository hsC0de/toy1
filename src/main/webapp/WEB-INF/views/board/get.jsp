<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html lang="ko">
<head>
  <link rel="stylesheet" href="/resources/css/styles.css" />
  <link rel="stylesheet" href="/node_modules/@toast-ui/editor/dist/toastui-editor-viewer.css" />
  <style>
    .get_tools {
      display: flex;
      justify-content: space-between;
      margin: 10px 0;
      align-items: center;
    }
    
    .modify_tools {
      display: flex;
      justify-content: flex-end;
      align-items: center;
    }
    
    .list_tools {
      display: flex;
      justify-content: flex-end;
      align-items: center;
    }
    
    .btn_board_modify {
      margin-right: 10px;
    }
    
    .btn_get_next {
      margin-right: 10px;
    }
    
    .btn_get_pre {
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
      cursor: pointer;
    }
    
    .get_btn img {
      width: 12px;
      margin-right: 4px;
    }
    
    #viewer {
      margin: 26px 0 0 0;
    }
    
    .get_contents_container {
      padding: 30px;
      border: 1px solid #dadada;
      border-radius: 6px;
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
      align-items: center;
      font-size: 13px;
      position: relative;
    }
    
    .contents_tools a {
      display: flex;
      margin-right: 10px;
    }
    
    .contents_comments_button {
      align-items: center;
    }
    
    .contents_comments_button img {
      display: block;
      margin-right: 4px;
      width: 15px;
    }
    
    .contents_comments_button span {
      display: block;
    }
    
    .contents_comments_writer {
      border: 2px solid #dadada;
      border-radius: 6px;
      padding: 10px;
      
    }
    
    .contents_comments_inbox_text {
      display: block;
    }
    
    .register_box {
      text-align: right;
    }
    
    .register_box a {
      display: inline-block;
      font-size: 14px;
      color: #cccccc;
      
    }
    
    .comments_refresh_button {
      border-radius: 50%;
      width: 25px;
      height: 25px;
      border:none;
      cursor: pointer;
    }
    
    .comments_refresh_button img {
      width: 14px;
    }
    
    .contents_comments_header {
      margin: 18px 0;
      display: flex;
    }
    
    .contents_comments_tab_list {
      display: flex;
      margin: 0 10px;
      font-size: 14px;
    }
    
    .contents_comments_tab_list li:first-child {
      margin-right: 10px;
    }
    
    .contents_comments_inbox_text {
      width: 100%;
      border: none;
      resize: none;
    }
    
    .contents_comments_inbox_text:focus {
      outline: none;
    }
    
    .contents_comments_inbox_text::placeholder {
      color: #dadada;
      font-size: 13px;
    }
    
    
    .contents_comments_inbox {
      margin-bottom: 10px;
    }
    
    .contents_comments_name {
      margin-bottom: 10px;
      display: inline-block;
      font-size: 14px;
    
    }
    
    .contents_kind_button {
      font-size: 13px;
      color: #3D96C2;
      display: flex;
      align-items: center;
      margin-bottom: 10px;
    }
    
    .contents_kind_button span {
      font-size: 13px;
      display: inline-block;
/*       margin-left: 7px; */
    }
    
    .contents_title {
      margin-bottom: 10px;
    }
    
    .contents_title span {
      font-size: 26px;
      font-weight: 400;
    }
    
    .profile_info {
      margin-bottom: 10px;
      font-size: 13px;
      font-weight: 500;
    }
    
    .contents_info {
      margin-bottom: 20px;
    }
    .article_info {
      color: #bbbbbb;
      font-size: 12px;
    }
    
    .contents_comments_title {
      font-size: 18px;
      
    }
    
    .contents_comments_list {
      margin-bottom: 20px;
    }
    
    .comments_area div {
      margin-bottom: 10px;
    }
    
    .commentsItem_id_box {
      font-size: 15px;
      font-weight: 500;
      
    }
    
    .comment_nickname {
      display: inline-block;
      margin-right: 5px;
    }
    
    .commentsItem_text_box {
      font-size: 14px;
    }
    
    .commentsItem_info_box {
      font-size: 12px;
      color: bbbbbb;
    }
    
    .commentsItem_info_box span {
      display: inline-block;
      margin-right: 10px;
    }
    
    .get_user_contents {
      margin-top: 97px;
    }
    
    .toast_url_copy_successful {
      position: absolute;
      top: 40px;
      right: 6px;
      width: 358px;
      background-color: #6F6F6F;
      border-radius: 7px;
      padding: 10px 14px 9px;
      font-size: 15px;
      color: #ffffff;
    }
    
    .comments_tab_item {
      padding-top:2px;
    }
    
    .get_tool_write {
      display: flex;
    }
    
    
  </style>
  <script src="/node_modules/jquery/dist/jquery.min.js"></script>
  <script type="text/javascript" src="/resources/js/reply.js"></script>
  <script type="text/javascript" src="/resources/js/board.js"></script>
  <script type="text/javascript" src="/resources/js/navbar.js"></script>
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
	    <main class="article">
	      <div class="get">
	        <div class="get_tools">
            <div class="modify_tools">
              <div class="get_btn btn_board_modify">
                <span>수정</span>
              </div>
              <div class="get_btn btn_board_delete">
                <span>삭제</span>
              </div>
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
		                  <img src="/node_modules/bootstrap-icons/icons/chat-dots.svg"/><span id="refreshReplyCnt">댓글 </span>
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
		              <a href="#" class="user_contents_list">id님의 게시글 더보기 〉</a>
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
	                  </div>
		              </li>
		              <li id="#" class="commentsItem commentItem-repl"></li>
		            </ul>
		            <div class="contents_comments_writer">
		              <div class="contents_comments_inbox">
		                <span class="contents_comments_name">정해성</span>
		                <textarea placeholder="댓글을 남겨보세요" rows="1" class="contents_comments_inbox_text" 
		                cols="80" style="overflow: hidden; overflow-wrap: break-word; height:1rem;"></textarea>
		              </div>
		              <div class="contents_comments_tools">
		                <div class="register_box">
		                  <a href="#" role="button" class="btn_register">등록</a>
		                </div>
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
              <div class="modify_tools">
                <div class="get_btn btn_board_modify">
                  <span>수정</span>
                </div>
                <div class="get_btn btn_board_delete">
                  <span>삭제</span>
                </div>
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
  
  <script type="text/javascript" src="/resources/js/navbar.js"></script>
  <script type="text/javascript" src="/node_modules/@toast-ui/editor/dist/toastui-editor-viewer.js"></script>
  <script>
   
    
    autosize($(".contents_comments_inbox_text"));
    
    var board = ${board};
    
    function getReplyList(rno) {
      
//       $.getJSON("/reply/getReplyList?bno=" + board.bno , function(data) {
      $.ajax({
        url: "/reply/getReplyList",
        method: "get",
        data: {
          bno : board.bno,
          rno : rno
        },
        dataType: "json",
        error: function(error) {
          alert(error);
        },
        success: function(data) {
          
	        var str = "";
	        console.log(data);
	        for(var i = 0; i < data.length; i++) {
	          str += '<li id="#" class="commentsItem">';
	          str += '<div class="comments_area">';
	          str += '<div class="commentsItem_id_box">';
	          str += '<a id="#" href="#" role="button" aria-haspopup="true" aria-expanded="false" class="comment_nickname">' + data[i].id + '</a>';
	          str += '<span class="commentsItem_info_box">' + replyService.displayGap(data[i].gap, data[i].reg_date) + '</span>'
	          str += '</div>';
	          str += '<div class="commentsItem_text_box">';
	          str += '<p class="comments_text_view">';
	          str += '<span class="text_comment">' + newlineReplacement(data[i].comments) + '</span>';
	          str += '</p>';
	          str += '</div>';
	          str += '<div class="commentsItem_info_box">';
	          str += '<span class="commentsItem_info_date">' + replyService.displayTime1(data[i].reg_date) + '</span>';
	          str += '<a href="#" role="button" class="comment_info_button">답글쓰기</a>';
	          str += '</div>';
	          str += '</div>';
	          str += '</li>';
	        }
	        $(".contents_comments_list").html(str);
        }
      });
    }
    
    function newlineReplacement(text){
      return text.replace(/(?:\r\n|\r|\n)/g, '<br/>').replace(/ /g, "&nbsp;");
    }
    
    function printContent() {
      $("body").append('<iframe name="print_iframe" id="print_iframe" width="0" height="0" style="display:none;"></iframe>');
      var print_contents = $(".get_contents_container_box").html();
      var print_head = $("head").html();
      $("#print_iframe").contents().find("head").html(print_head);
      $("#print_iframe").contents().find("body").html(print_contents);
      $("#print_iframe").focus();
      frames["print_iframe"].focus();
      frames["print_iframe"].print();
    }
    

    
    window.addEventListener('beforeunload', () => {
      var sp = $(".tab").offset().top;
      $(window).scrollTop(sp); 
    });
    
    $(function() {
      
      var sp = $(".tab").offset().top;
      $(window).scrollTop(sp); 
      
      console.log(board);
     
      $(".kind_button_val").html(board.menu_nm + " 〉");
      $(".contents_title span").html(board.title);
      $(".nick_box span").html(board.id);
      $(".cnt").html("조회 " + board.cnt);
      $("#refreshReplyCnt").html("댓글 " + board.replyCnt);
//       $(".text_content").html(newlineReplacement(board.content));
      const viewer = new toastui.Editor({
        el: document.querySelector('#viewer'),
        initialValue: board.content
      });
      
//       var date = board.reg_date;
//       date = replyService.displayTime1(date);
//       date = date.substring(0, 10).replaceAll("/", ".") + "." + date.substring(10, 16);

      $(".date").text(board.reg_date);
      
      $(".contents_kind_button").on("click", function(e) {
        e.preventDefault();
        e.stopPropagation();
        location.href = "/board/list?page=1&userDisplay=10&kind=" + board.kind;
      });
      
//       $(document).on("click", ".contents_comments_button", function(e) {
      $(".contents_comments_button").on("click", function(e) {  
        e.preventDefault();
        e.stopPropagation();
        var sp = $(".get_contents_comments").offset().top;
        console.log(sp);
        $(window).scrollTop(Number(sp) - 20);
      });
      
      $(".btn_top").on("click", function(e) {
        
        e.preventDefault();
        e.stopPropagation();
        var sp = $(".get").offset().top;
        console.log(sp);
        $(window).scrollTop(Number(sp));
      });
      
      $(".btn_register").on("click", function(e) {
        e.preventDefault();
        
        var comments = $(".contents_comments_inbox_text").val();
        
        console.log(comments);
        
        if(!comments) {
          alert("내용을 입력하세요.");
          return;
        }
        
        if(confirm("등록하시겠습니까?")) {
          
          $.post({
            url: "/reply/regReply",
            data: { id: "asdf"
                  , comments: comments
                  , bno: board.bno },
            dataType: "json",
            success: function(res) {
              alert("등록되었습니다.");
              $(".contents_comments_inbox_text").val("").height(17);
              getReplyList(sortState);
              $("#refreshReplyCnt").html("댓글 " + res.REPLYCNT);
            },
            error: function() {
              alert("등록에 실패했습니다.");
            }
          });
        }
      });
      
      
      var sortState = '';
      getReplyList(sortState);
      
      $(".contents_url_info").on("click", function(e) {
        
        e.preventDefault();
        e.stopPropagation();
        var copyText = $("#copyUrl");
        copyText.attr("value", location.href);
        copyText.select();
        document.execCommand('copy');
        $(".toast_url_copy_successful").fadeIn(400).delay(4000).fadeOut(500);
      });
      
      $(".layer_button").on("click", function(e) {

        e.preventDefault();
        e.stopPropagation();
        $("iframe").remove("#print_iframe");
        printContent();
      });
      
      $(".comments_refresh_button").on("click", function() {
        
        getReplyList(sortState);
      });
      
      
      $(".tab_item_button").on("click", function(e) {
        
        e.preventDefault();
        e.stopPropagation();
        var sort = $(this).text();
        console.log(sort);
        
        if(sort === "등록순") {

          sortState = '';
	        getReplyList(sortState);
        }
        else if(sort === "최신순") {
          sortState = 'desc';
          getReplyList(sortState);
        }
      });
      
      $(".btn_get_next").on("click", function() {
        
        if(board.nextContent) {
          
          location.href = "/board/get?bno=" + board.nextContent + "&" + board.paging.listLink.substring(1, board.paging.listLink.length);
        }
      });
      
      $(".btn_get_pre").on("click", function() {
        
        if(board.preContent) {
          
          location.href = "/board/get?bno=" + board.preContent + "&" + board.paging.listLink.substring(1, board.paging.listLink.length);
        }
      });

      if(!board.nextContent) {
        $(".btn_get_next").css("display", "none");
      }
      else if(!board.preContent) {
        $(".btn_get_pre").css("display", "none");
      }
      
      $(".btn_board_list").on("click", function() {
        
        location.href = "/board/list" + board.paging.listLink;
      });
      
      $(".btn_board_modify").on("click", function() {
        
        window.open("/board/modify/" + board.bno + board.paging.listLink);
      });
      
      $(".btn_board_delete").on("click", function() {
        
        if(confirm("정말 삭제하시겠습니까?")) {
          
          location.href = "/board/delete/" + board.bno + board.paging.listLink;
        }
      });
      
    });

  </script>
</body>
</html>
