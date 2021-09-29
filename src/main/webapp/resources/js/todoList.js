function getTodoList() {

  $
      .ajax({
        url : "/getTodoList",
        method : "get",
        dataType : "json",
        success : function(res) {

          console.log(res);
          var str = "";
          for (var i = 0; i < res.length; i++) {
            str += '<div class="toDo_listItem_container">';
            if (res[i].done === 'Y') {
              str += '<li class="toDo_listItem activeList">';
              str += '<input type="checkbox" class="toDoCheckbox" value="' + res[i].num + '" checked id="done'
                  + res[i].num + '"><label for="done' + res[i].num + '">';
            } else {
              str += '<li class="toDo_listItem">';
              str += '<input type="checkbox" class="toDoCheckbox" value="' + res[i].num + '" id="done' + res[i].num
                  + '"><label for="done' + res[i].num + '">';
            }
            str += '<div class="listContent">';
            str += '<span style="word-break:break-all;" class="toDo_listContent">' + res[i].do_list + '</span>';
            str += '</div>';
            str += '</label>';
            str += '<div class="listDeleteButton_container">';
            str += '<a href="' + res[i].num + '" class="listDeleteBtn"></a>';
            str += '<object class="object" type="image/svg+xml" data="/node_modules/bootstrap-icons/icons/trash.svg"></object>';
            str += '</div>';
            str += '</li>';
            str += '</div>';
          }
          $(".toDo_listItems").html(str);

        },
        error : function(error) {
          alert("fail get TodoList");
        }
      });
}

function getTodoListManager() {
  $
      .ajax({
        url : "/getTodoListManager",
        method : "get",
        dataType : "json",
        success : function(res) {

          console.log(res);
          var str = "";
          for (var i = 0; i < res.length; i++) {
            str += '<div class="toDo_listItem_container">';
            if (res[i].done === 'Y') {
              str += '<li class="toDo_listItem1 activeList">';
              str += '<input type="checkbox" class="toDoCheckbox" value="' + res[i].num + '" checked id="done'
                  + res[i].num + '"><label for="done' + res[i].num + '">';
            } else {
              str += '<li class="toDo_listItem1">';
              str += '<input type="checkbox" class="toDoCheckbox" value="' + res[i].num + '" id="done' + res[i].num
                  + '"><label for="done' + res[i].num + '">';
            }
            str += '<div class="listContent">';
            str += '<span style="word-break:break-all;" class="toDo_listContent">' + res[i].do_list + '</span>';
            str += '</div>';
            str += '</label>';
            str += '<div class="listDeleteButton_container">';
            str += '<a href="' + res[i].num + '" class="listDeleteBtn1"></a>';
            str += '<object class="object" type="image/svg+xml" data="/node_modules/bootstrap-icons/icons/trash.svg"></object>';
            str += '</div>';
            str += '</li>';
            str += '</div>';
          }
          $(".getToDoList1").html(str);

        },
        error : function(error) {
          alert("fail get TodoList");
        }
      });
}

function regTodoList(url, content) {
  // var content = $(".inputList").val();

  if (!content) {
    alert("값을 입력하세요");
    return;
  }
  var data = {
    "do_list" : content
  }

  $.ajax({
    url : url,
    method : "post",
    beforeSend : function(xhr) {
      xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
    },
    data : data,
    success : function(res, textStatus, xhr) {
      if (url === "/regTodoList" && xhr.getResponseHeader('redirectLogin') !== 'true') {
        $(".inputList").val("");
        $(".inputList").focus();
        getTodoList();
      } else if (url === "/regTodoListManager" && xhr.getResponseHeader('redirectLogin') !== 'true') {
        $(".inputList1").val("");
        $(".inputList1").focus();
        getTodoListManager();
      } else {
        if (xhr.getResponseHeader('redirectUrl').indexOf("login") != -1) {
          location.href = xhr.getResponseHeader('redirectUrl');
        } else {
          alert("권한이 없습니다.");
          $(".inputList1").focus();
        }
      }
    },
    error : function(error) {
      alert(error.status);
    }
  });
}

$(".toDoList_input input").on("keydown", function(e) {

  if (e.keyCode === 13) {
    var url = "/regTodoList";
    var content = $(".inputList").val();

    if ($(this).attr("class") === "inputList1") {
      url = "/regTodoListManager";
      content = $(".inputList1").val();
    }

    regTodoList(url, content);
  }
});

$(".registerButton_container a").on("click", function(e) {
  e.preventDefault();
  e.stopPropagation();
  var url = "/regTodoList";
  var content = $(".inputList").val();

  if ($(this).attr("class") === "listRegisterBtn1") {
    url = "/regTodoListManager";
    content = $(".inputList1").val();
  }

  regTodoList(url, content);
});

$(document).on("click", ".listDeleteButton_container a", function(e) {
  e.preventDefault();
  e.stopPropagation();
  var url = "/deleteTodoList";

  if ($(this).attr("class").indexOf("listDeleteBtn1") != -1) {
    url = "/deleteTodoListManager";
  }
  var num = $(this).attr("href");
  $.ajax({
    url : url,
    beforeSend : function(xhr) {
      xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
    },
    method : "post",
    data : {
      num : num
    },
    success : function(res, textStatus, xhr) {
      if (url === "/deleteTodoList" && xhr.getResponseHeader('redirectLogin') !== 'true') {
        getTodoList();
      } else if (url === "/deleteTodoListManager" && xhr.getResponseHeader('redirectLogin') !== 'true') {
        getTodoListManager();
      } else {
        if (xhr.getResponseHeader('redirectUrl').indexOf("login") != -1) {
          location.href = xhr.getResponseHeader('redirectUrl');
        } else {
          alert("권한이 없습니다.");
        }
      }
    },
    error : function(error) {
      alert(error.status);
    }
  });
});
$(document).on("click", ".toDo_listItem_container li", function(e) {
  e.preventDefault();
  e.stopPropagation();
  var num = $(this).children("input").val();
  var url = "/doneTodoList";
  var done;
  var li = $(this);
  if (li.attr("class").indexOf("toDo_listItem1") != -1) {
    url = "/doneTodoListManager";
  }

  if (li.children("input").prop("checked") === false) {
    done = 'Y';
  } else if (li.children("input").prop("checked") === true) {
    done = 'N';
  }

  $.ajax({
    url : url,
    beforeSend : function(xhr) {
      xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
    },
    method : "post",
    data : {
      done : done,
      num : num
    },
    success : function(res, textStatus, xhr) {
      if (xhr.getResponseHeader('redirectUrl')) {
        if (xhr.getResponseHeader('redirectUrl').indexOf("login") != -1) {
          location.href = xhr.getResponseHeader('redirectUrl');
        } else {
          alert("권한이 없습니다.");
        }
      } else {
        if (done == 'Y') {
          li.children("input").prop("checked", true);
          li.addClass("activeList");
        } else if (done == 'N') {
          li.children("input").prop("checked", false);
          li.removeClass("activeList");
        }
      }
    },
    error : function(error) {
      alert(error.status);
    }
  });
});

$(document).on("click", ".toDoList_toggleBtn", function(e) {
  e.preventDefault();
  e.stopPropagation();

  $(".toDoList_Container").toggleClass("btn_toggle");
});

getTodoList();
getTodoListManager();