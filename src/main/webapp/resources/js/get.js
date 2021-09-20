//import autosize from "/resources/js/util/autoSize.js";

var sortState = '';

function openWritingPage(boardKind) {
  $(".board_new span").on("click", function() {

    window.open("/board/writing?kind=" + boardKind, function() {
      window.scrollTop(0);
    });
  });
}

var id = $("#tempUsername").text();
autosize($(".contents_comments_inbox_text"));
var boardKind = board.kind;

openWritingPage(boardKind);
function newlineReplacement(text) {
  return text.replace(/(?:\r\n|\r|\n)/g, '<br/>').replace(/ /g, "&nbsp;");
}

function printContent() {
  $("body")
      .append('<iframe name="print_iframe" id="print_iframe" width="0" height="0" style="display:none;"></iframe>');
  var print_contents = $(".get_contents_container_box").html();
  var print_head = $("head").html();
  $("#print_iframe").contents().find("head").html(print_head);
  $("#print_iframe").contents().find("body").html(print_contents);
  $("#print_iframe").focus();
  frames["print_iframe"].focus();
  frames["print_iframe"].print();
}
// window.addEventListener('beforeunload', () => {
// var sp = $(".tab").offset().top;
// $(window).scrollTop(sp);
// });

$(function() {
  function getReplyList(rno) {

    $
        .ajax({
          url : "/reply/getReplyList",
          method : "get",
          data : {
            bno : board.bno,
            rno : rno
          },
          dataType : "json",
          error : function(error) {
            alert(error);
          },
          success : function(data) {

            var str = "";
            console.log(data);
            if (data.length > 0) {
              str += '<hr />';
              str += '<div class="contents_comments_header">';
              str += '<div class="contents_comments_title">';
              str += '<span>댓글</span>';
              str += '</div>';
              str += '<ul class="contents_comments_tab_list">';
              str += '<li class="comments_tab_item">';
              str += '<a href="#" class="tab_item_button">등록순</a>';
              str += '</li>';
              str += '<li class="comments_tab_item">';
              str += '<a href="#" class="tab_item_button">최신순</a>';
              str += '</li>';
              str += '</ul>';
              str += '<button type="button" class="comments_refresh_button"><img src="/node_modules/bootstrap-icons/icons/arrow-clockwise.svg"/></button>';
              str += '</div>';
              str += '<ul class="contents_comments_list">';

              for (var i = 0; i < data.length; i++) {
                str += '<li id="#" class="commentsItem" data-rno="' + data[i].rno + '">';
                str += '<div class="comments_area">';
                str += '<div class="commentsItem_id_box">';
                str += '<a id="#" href="#" role="button" aria-haspopup="true" aria-expanded="false" class="comment_nickname">'
                    + data[i].id + '</a>';
                str += '<span class="commentsItem_info_box">' + replyService.displayGap(data[i].gap, data[i].reg_date)
                    + '</span>'
                str += '</div>';
                str += '<div class="commentsItem_text_box">';
                str += '<p class="comments_text_view">';
                str += '<span class="text_comment">' + newlineReplacement(data[i].comments) + '</span>';
                str += '</p>';
                str += '</div>';
                str += '<div class="commentsItem_info_box">';
                str += '<span class="commentsItem_info_date">' + data[i].reg_date + '</span>';
                str += '<a href="#" role="button" class="comment_info_button">답글쓰기</a>';
                str += '</div>';
                str += '<div class="comment_list_tool">';
                str += '<a href=# class="comment_list_tool_button">';
                str += '<svg xmlns="/node_modules/bootstrap-icons/icons/three-dots-vertical.svg" width="16" height="16" fill="currentColor" class="bi bi-three-dots-vertical" viewBox="0 0 16 16">';
                str += '<path d="M9.5 13a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"></path>';
                str += '</svg>';
                str += '</a>';
                str += '<div class="comment_more">';
                str += '<ul>';
                str += '<li class="more_item">';
                str += '<a href="#" class="more_btn">신고</a>';
                str += '</li>';
                str += '</ul>';
                str += '</div>';
                str += '</div>';
                str += '</div>';
                str += '</li>';

              }
              str += '</ul>';
            } else if (id) {
              str += '<hr />';
              str += '<div class="contents_comments_header">';
              str += '<div class="contents_comments_title">';
              str += '<span>댓글</span>';
              str += '</div>';
              str += '</div>';
            }

            $(".get_contents_comments").html(str);

            for (var i = 0; i < $(".comment_nickname").length; i++) {
              var listItem = $(".comment_nickname")[i];
              var moreObj = $(".comment_more").eq(i);
              var name = listItem.innerText;
              var strA = '';
              strA += '<li class="more_item">';
              strA += '<a href="#" class="more_btn">수정</a>';
              strA += '</li>';
              strA += '<li class="more_item">';
              strA += '<a href="#" class="more_btn">삭제</a>';
              strA += '</li>';
              if (id === name) {
                listItem.closest(".commentsItem").classList.add('commentsItemMineBg');
                moreObj.children('ul').html(strA);
              }
            }
          }
        });
  }

  if (board.kind == 'BN' && board.type != 'N') {
    $(".contents_title div").addClass("noticeBoardBox1");
    if (board.type == 'M') {
      $(".noticeBoardBox1").text("필독");
    } else {
      $(".noticeBoardBox1").text("공지");
    }
  } else if (board.type == "Y") {
    $(".contents_title div").addClass("noticeBox1");
    $(".noticeBox1").text("공지");
  }

  $(".kind_button_val").html(board.menu_nm + " 〉");
  $(".contents_title span").html(board.title);
  $(".nick_box span").html(board.id);
  $(".cnt").html("조회 " + board.cnt);
  $(".refreshReplyCnt").html("댓글 " + board.replyCnt);
  $(".refreshLikeCnt").html("좋아요 " + board.like);
  $(".user_contents_list span").text(board.id);
  // $(".text_content").html(newlineReplacement(board.content));
  console.log(board);

  if (board.existLike) {
    $(".contents_like_button img").attr("src", "/resources/img/ico-post-like-on-f-53535.svg");
  }

  const viewer = new toastui.Editor({
    el : document.querySelector('#viewer'),
    initialValue : board.content
  });

  $(".date").text(board.reg_date);

  $(document).on("click", ".comment_list_tool_button", function(e) {
    e.preventDefault();
    e.stopPropagation();

    $(".commentsItem .comments_area .comment_list_tool .comment_more").not($(this).next()).removeClass('btn_toggle');
    $(this).next('.comment_more').toggleClass("btn_toggle");
  });

  $(document).on("click", ".more_btn", function(e) {
    e.preventDefault();
    e.stopPropagation();

    var objText = $(this).text();
    var rno = $(this).closest('.commentsItem').data("rno");
    // console.log(rno);
    if (objText == '삭제') {
      if (confirm("댓글을 삭제하시겠습니까?")) {
        $.ajax({
          url : '/reply/deleteReply',
          method : 'post',
          beforeSend : function(xhr) {
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
          },
          data : {
            bno : board.bno,
            rno : rno,
            id : id
          },
          success : function(res) {
            getReplyList(sortState);
            $(".refreshReplyCnt").html("댓글 " + res.REPLYCNT);
          },
          error : function(error) {
            alert(error.status);
          }
        });
      }
    } else if (objText == '수정') {

    } else if (objText == '신고') {
      alert("신고하시겠습니까? 구현 안했습니다.");
    }
  });

  $(".contents_kind_button").on("click", function(e) {
    e.preventDefault();
    e.stopPropagation();
    location.href = "/board/list?page=1&userDisplay=15&kind=" + board.kind;
  });

  $(".contents_comments_button").on("click", function(e) {
    e.preventDefault();
    e.stopPropagation();
    var sp = $(".get_contents_comments").offset().top;
    console.log(sp);
    $(window).scrollTop(Number(sp));
  });

  $(".contents_comments_button1").on("click", function(e) {
    e.preventDefault();
    e.stopPropagation();
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
    if (!comments) {
      alert("내용을 입력하세요.");
      return;
    }
    if (confirm("등록하시겠습니까?")) {
      $.post({
        url : "/reply/regReply",
        data : {
          id : id,
          comments : comments,
          bno : board.bno
        },
        dataType : "json",
        beforeSend : function(xhr) {
          xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        },
        success : function(res) {
          alert("등록되었습니다.");
          $(".contents_comments_inbox_text").val("").height(17);
          getReplyList(sortState);
          $(".refreshReplyCnt").html("댓글 " + res.REPLYCNT);
        },
        error : function() {
          alert("등록에 실패했습니다.");
        }
      });
    }
  });
  // console.log(id);
  $(document).on("click", ".contents_like_button", function(e) {
    e.preventDefault();
    e.stopPropagation();

    var url = "/board/like";
    if (!id) {
      if (confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")) {
        location.href = "/common/login";
        return;
      } else {
        return;
      }
    }

    if (board.existLike) {
      url = "/board/deleteLike";
    }

    $.ajax({
      url : url,
      method : "post",
      data : {
        bno : board.bno,
        id : id
      },
      beforeSend : function(xhr) {
        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
      },
      dataType : 'json',
      success : function(res) {

        if (res.existLike) {
          $(".contents_like_button img").attr("src", "/resources/img/ico-post-like-on-f-53535.svg");
        } else {
          $(".contents_like_button img").attr("src", "/resources/img/ico-post-like-f-53535.svg");
        }

        $(".refreshLikeCnt").html("좋아요 " + res.cnt);

        board.existLike = !board.existLike;

      },
      error : function(error) {
        alert("잘못된 요청입니다.");
      }
    });
  });

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

  $(document).on("click", ".comments_refresh_button", function() {
    getReplyList(sortState);
  });

  $(document).on("click", ".tab_item_button", function(e) {
    e.preventDefault();
    e.stopPropagation();
    var sort = $(this).text();
    console.log(sort);

    if (sort === "등록순") {

      sortState = '';
      getReplyList(sortState);
    } else if (sort === "최신순") {
      sortState = 'desc';
      getReplyList(sortState);
    }
  });

  $(".btn_get_next").on(
      "click",
      function() {
        if (board.nextContent) {
          location.href = "/board/get?bno=" + board.nextContent + "&"
              + board.paging.listLink.substring(1, board.paging.listLink.length);
        }
      });

  $(".btn_get_pre").on(
      "click",
      function() {
        if (board.preContent) {
          location.href = "/board/get?bno=" + board.preContent + "&"
              + board.paging.listLink.substring(1, board.paging.listLink.length);
        }
      });

  if (!board.nextContent) {
    $(".btn_get_next").css("display", "none");
  }
  if (!board.preContent) {
    $(".btn_get_pre").css("display", "none");
  }

  $(".btn_board_list").on("click", function() {

    location.href = "/board/list" + board.paging.listLink;
  });

  $(".btn_board_modify").on("click", function() {

    window.open("/board/modify/" + board.bno + board.paging.listLink + "&id=" + board.id);
  });

  $(".btn_board_delete").on("click", function() {

    if (confirm("정말 삭제하시겠습니까?")) {

      location.href = "/board/delete/" + board.bno + board.paging.listLink + "&id=" + board.id;
    }
  });

});