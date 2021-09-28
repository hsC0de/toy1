$(function() {

  var idCheck;

  $("#id").focus();
  $("#submitButton")
      .on(
          "click",
          function(e) {
            e.preventDefault();

            var password = $("#password").val();

            var email = $("#email").val();

            var passwordCheck = $("#passwordCheck").val();

            console.log(idCheck + "dd");
            if (idCheck === "false") {
              alert("아이디를 확인해 주세요.");
              $("#id").focus();
              return;
            }

            var re = new RegExp(
                /^[\w]+@[\w]+\.(com|co.kr|net|org|biz|info|or.kr|ne.kr|re.kr|go.kr|pe.kr|ac.kr|es.kr|ms.kr)$/);

            if (!re.test(email)) {
              alert("이메일 주소가 올바르지 않습니다. asdf@asdf.(com|co.kr|net|org|biz|info|or.kr|ne.kr|re.kr|go.kr|pe.kr|ac.kr|es.kr|ms.kr)");
              $("#email").focus();
              return;
            }

            if (password !== passwordCheck || password < 2) {
              alert("비밀번호를 확인해 주세요.");
              $("#password").fucus();
              return;
            }

            $("#registerForm").submit();

          });

  $("#id").on("keyup", function() {

    idCheck = "false";
    var id = $("#id").val();

    if (!id) {
      $(".id_info").html("").css("margin-bottom", "0");
    }
  });

  $("#email").on("keyup", function() {

    var email = $(this).val();

    $(".email_info").html("");

    if (!email) {
      $(".email_info").html("").css("margin-bottom", "0");
    }

    var re = new RegExp(/^[\w]+@[\w]+\.(com|co.kr|net|org|biz|info|or.kr|ne.kr|re.kr|go.kr|pe.kr|ac.kr|es.kr|ms.kr)$/);

    if (!re.test(email)) {
      $(".email_info").append("<span> ※ 이메일 주소가 올바르지 않습니다. </span>");
      $(".email_info").css({
        "color" : "red",
        "margin-bottom" : "10px"
      });
    } else {
      $(".email_info").append("<span> ※ 올바른 주소입니다.</span>");
      $(".email_info").css({
        "color" : "blue",
        "margin-bottom" : "10px"
      });
    }

  });

  $("#passwordCheck").on("keyup", function() {

    var password = $("#password").val();

    var passwordCheck = $(this).val();
    $(".password_info").html("");

    if (!password && !passwordCheck) {

      $(".password_info").html("").css("margin-bottom", "0");
      $(".password_label").css("color", "#000");
      return;
    }

    if (password != passwordCheck) {

      $(".password_label").css("color", "red");
      $(".password_info").append("<span> ※ 비밀번호가 일치하지 않습니다.</span>");
      $(".password_info").css({
        "color" : "red",
        "margin-bottom" : "10px"
      });

    } else {

      $(".password_label").css("color", "#000");
      $(".password_info").append("<span> ※ 비밀번호가 일치합니다.</span>");
      $(".password_info").css({
        "color" : "blue",
        "margin-bottom" : "10px"
      });
    }

  });

  $("#password").on("keyup", function() {

    var password = $(this).val();

    var passwordCheck = $("#passwordCheck").val();
    $(".password_info").html("");

    if (!password && !passwordCheck) {

      $(".password_info").html("").css("margin-bottom", "0");
      $(".password_label").css("color", "#000");
      return;
    }

    if (password != passwordCheck) {

      $(".password_label").css("color", "red");
      $(".password_info").append("<span> ※ 비밀번호가 일치하지 않습니다.</span>");
      $(".password_info").css({
        "color" : "red",
        "margin-bottom" : "10px"
      });

    } else {

      $(".password_label").css("color", "#000");
      $(".password_info").append("<span> ※ 비밀번호가 일치합니다.</span>");
      $(".password_info").css({
        "color" : "blue",
        "margin-bottom" : "10px"
      });
    }

  });

  $("#id_check").on("click", function() {

    $('.id_info').html("");

    var id = $("#id").val();
    if (id.length < 2 || id.length > 20) {
      $(".id_info").append("<span> ※ id는 2자리 이상 입력해 주세요.</span>");
      $(".id_info").css({
        "margin-bottom" : "10px",
        "color" : "red"
      });
      idCheck = "false";
      return;
    }

    $.ajax({
      url : "/common/idCheck",
      beforeSend : function(xhr) {
        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
      },
      data : {
        id : id
      },
      dataType : "json",
      method : "post",
      success : function(res) {

        $(".id_info").append("<span> ※ " + res.result + "</span>");
        $(".id_info").css("margin-bottom", "10px");
        $(".id_info").css("color", "red");
        idCheck = res.check;

        if (idCheck !== "false") {

          $(".id_info").css("color", "blue");
        }

      },
      error : function(error) {
        console.log(error);
        alert(error.status);
      }

    });
  });
});
