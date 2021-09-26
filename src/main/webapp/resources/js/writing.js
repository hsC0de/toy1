var id = $("#tempUsername").text();
var editor;
document.addEventListener("DOMContentLoaded", function() {

  editor = new toastui.Editor({
    el : document.querySelector("#editor"),
    height : "500px",
    initialEditType : "markdown",
    initialValue : board.content,
    previewStyle : "vertical",
  });
});

$(function() {

  $.ajax({
    url : '/menu/menuList',
    method : 'get',
    data : {
      upid : 'B'
    },
    dataType : 'json',
    success : function(menuData) {
      var str = '';
      var str1 = '';
      console.log(menuData);
      if (board == "0") {
        console.log("s");
        if (boardInfo.auth === false) {
          if (boardInfo.kind !== 'BA' && boardInfo.kind !== 'BN') {
            str1 += '<button type="button" class="optionButton" value="' + boardInfo.kind + '">';
            str1 += boardInfo.kind_nm;
            str1 += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
            str1 += '</button>';
          } else {
            str1 += '<button type="button" class="optionButton" value="">';
            str1 += '게시판을 선택해 주세요.';
            str1 += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
            str1 += '</button>';
          }

        } else {
          if (boardInfo.kind !== 'BA') {
            str1 += '<button type="button" class="optionButton" value="' + boardInfo.kind + '">';
            str1 += boardInfo.kind_nm;
            str1 += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
            str1 += '</button>';
          } else {
            str1 += '<button type="button" class="optionButton" value="">';
            str1 += '게시판을 선택해 주세요.';
            str1 += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
            str1 += '</button>';
          }
        }
      } else {
        if (board.auth === false) {
          console.log(board.kind);
          if (board.kind !== 'BA' && board.kind !== 'BN') {
            str1 += '<button type="button" class="optionButton" value="' + board.kind + '">';
            str1 += board.menu_nm;
            str1 += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
            str1 += '</button>';
          } else {
            str1 += '<button type="button" class="optionButton" value="">';
            str1 += '게시판을 선택해 주세요.';
            str1 += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
            str1 += '</button>';
          }

        } else {
          if (board.kind !== 'BA') {
            str1 += '<button type="button" class="optionButton" value="' + board.kind + '">';
            str1 += board.menu_nm;
            str1 += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
            str1 += '</button>';
          } else {
            str1 += '<button type="button" class="optionButton" value="">';
            str1 += '게시판을 선택해 주세요.';
            str1 += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
            str1 += '</button>';
          }
        }
      }
      for (var i = 0; i < menuData[0].submenuList.length; i++) {
        if (boardInfo.auth === false || board.auth === false) {
          if (menuData[0].submenuList[i].id !== 'BA' && menuData[0].submenuList[i].id !== 'BN') {

            if (menuData[0].submenuList[i].id == boardInfo.kind || menuData[0].submenuList[i].id == board.kind) {
              str += '<li class="item selectedItem">';
            } else {
              str += '<li class="item">';
            }
            str += '<button type="button" name="kind" class="option" value="' + menuData[0].submenuList[i].id + '">'
                + menuData[0].submenuList[i].name + '</button>';
            str += '</li>';
          }
        } else {
          if (menuData[0].submenuList[i].id !== 'BA') {
            if (menuData[0].submenuList[i].id == boardInfo.kind || menuData[0].submenuList[i].id == board.kind) {
              str += '<li class="item selectedItem">';
            } else {
              str += '<li class="item">';
            }
            str += '<button type="button" name="kind" class="option" value="' + menuData[0].submenuList[i].id + '">'
                + menuData[0].submenuList[i].name + '</button>';
            str += '</li>';
          }
        }
      }
      $(".kindSelect").html(str1);
      $(".select_option .kindList").html(str);
      initTypeBox($(".kindSelect .optionButton").attr("value"), board.type);
    },
    error : function(error) {
      alert("menu error");
    }
  });

  function initTypeBox(boardKind, boardType) {
    var str = '';
    var str1 = '';
    if (board == "0") {
      console.log("s");
      if (boardInfo.auth === true) {
        console.log(boardType);
        if (!boardType) {
          str += '<button type="button" class="optionButton" value="N">';
        } else {
          str += '<button type="button" class="optionButton" value="' + boardType + '">';
        }
        if (boardType === 'Y') {
          str += '공지';
        } else if (boardType === 'M' && boardKind === 'BN') {
          str += '필독';
        } else {
          str += '일반';
        }
        str += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
        str += '</button>';
        if (boardType === 'N' || !boardType) {
          str1 += '<li class="item selectedItem">';
        } else {
          str1 += '<li class="item">';
        }
        str1 += '<button type="button" class="option" value="N">일반</button>';
        str1 += '</li>';
        if (boardType === 'Y') {
          str1 += '<li class="item selectedItem">';
        } else {
          str1 += '<li class="item">';
        }
        str1 += '<button type="button" class="option" value="Y">공지</button>';
        str1 += '</li>';
        if (boardKind === 'BN') {
          if (boardType === 'M') {
            str1 += '<li class="item selectedItem">';
          } else {
            str1 += '<li class="item">';
          }
          str1 += '<button type="button" class="option" value="M">필독</button>';
          str1 += '</li>';
        }
      } else {
        str += '<button type="button" disabled="disabled" class="optionButton" value="N">';
        str += '일반';
        str += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
        str += '</button>';
      }
    } else {
      if (board.auth === true) {
        str += '<button type="button" class="optionButton" value="' + boardType + '">';
        if (boardType === 'Y') {
          str += '공지';
        } else if (boardType === 'M' && boardKind === 'BN') {
          str += '필독';
        } else {
          str += '일반';
        }
        str += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
        str += '</button>';
        if (board.auth === true) {
          if (boardType === 'N') {
            str1 += '<li class="item selectedItem">';
          } else {
            str1 += '<li class="item">';
          }
          str1 += '<button type="button" class="option" value="N">일반</button>';
          str1 += '</li>';
          if (boardType === 'Y') {
            str1 += '<li class="item selectedItem">';
          } else {
            str1 += '<li class="item">';
          }
          str1 += '<button type="button" class="option" value="Y">공지</button>';
          str1 += '</li>';
          if (boardKind === 'BN') {
            if (boardType === 'M') {
              str1 += '<li class="item selectedItem">';
            } else {
              str1 += '<li class="item">';
            }
            str1 += '<button type="button" class="option" value="M">필독</button>';
            str1 += '</li>';
          }
        }
      } else {
        str += '<button type="button" disabled="disabled" class="optionButton" value="N">';
        str += '일반';
        str += '<img src="/node_modules/bootstrap-icons/icons/chevron-compact-down.svg"/>';
        str += '</button>';
      }
    }
    $(".typeSelect").html(str);
    $(".writing_option_select_type .option_list").html(str1);
  }

  console.log(board);
  if (board) {
    $(".writingContent_smartEditor textarea").val(board.content);
    $(".textarea_input").val(board.title);
  }

  $(".writing_toolArea a").on("click", function(e) {

    e.preventDefault();
    e.stopPropagation();

    var title = $(".textarea_input").val();
    var content = editor.getMarkdown();
    console.log(content);
    if (!title) {
      alert("제목을 입력하세요.");
      return;
    } else if (!content) {
      alert("내용을 입력하세요.");
      return;
    }

    var data = {};
    if (board == 0) {
      data["title"] = title;
      data["content"] = content;
      data["id"] = id;
      data["kind"] = $(".kindSelect .optionButton").attr("value");
      data["type"] = $(".typeSelect .optionButton").attr("value");
    } else {
      board["preContent"] = board.content;
      board.content = content;
      board.title = title;
      board.kind = $(".kindSelect .optionButton").attr("value");
      board.type = $(".typeSelect .optionButton").attr("value");
      if (location.pathname != '/board/writing') {
        board.upd_seq = board.upd_seq + 1;
      }
      data = board;
    }
    console.log(data);

    if (confirm("등록하시겠습니까?")) {
      var url = "/board/regPost";

      if (board) {
        url = "/board/modifyPost";
      }

      $.ajax({
        url : url,
        method : 'post',
        data : data,
        dataType : 'text',
        beforeSend : function(xhr) {
          xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        },
        success : function(res) {
          if (res.substring(0, 6) === '/board') {
            opener.location.href = res;
            self.close();
          } else if (res === 'ok') {
            opener.location.reload();
            self.close();
          } else {
            if (res.indexOf("Access Denied") != -1) {
              location.href = "/common/login";
            } else {
              location.href = "/exception/error";
            }
          }
        },
        error : function() {
          alert("등록에 실패했습니다.");
        }
      });
    }

  });

  $(document).on("click", ".optionButton", function() {
    $(this).parent().next().toggleClass("btn_toggle");
    $(this).children("img").toggleClass("btn_img");
  });

  $(document)
      .on(
          "click",
          ".option_list .item .option",
          function() {
            $(this).closest("ul").children(".item").removeClass("selectedItem");
            $(this).parent().addClass("selectedItem");
            $(this).closest(".select_option").removeClass("btn_toggle");
            $(this).closest("div").prev().children(".optionButton").contents()[0].textContent = $(this).contents()[0].textContent;
            $(this).closest("div").prev().children(".optionButton").attr("value", $(this).attr("value"));

            if ($(".kindSelect .optionButton").attr("value") == $(this).attr("value")) {
              initTypeBox($(".kindSelect .optionButton").attr("value"), "N");
            } else {
              initTypeBox($(".kindSelect .optionButton").attr("value"), $(this).attr("value"));
            }
          });

});
