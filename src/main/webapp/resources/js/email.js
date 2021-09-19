$(document).on("click", ".emailSubmitBtn", function(e) {
  e.preventDefault();
  e.stopPropagation();
  var formData = new FormData();
  formData = $(".emailForm").serialize();
  var name = $("input[name='name']").val();
  var comment = $("textarea[name='comments']").val();
  var email = $("input[type='email']").val();
  if (!name) {
    $("input[name='name']").focus();

    return;
  } else if (!email) {
    $("input[type='email']").focus();
  } else if (!comment) {
    $("textarea[name='comments']").focus();
    return;
  }
  var re = new RegExp(/^[\w]+@[\w]+\.(com|co.kr|net|org|biz|info|or.kr|ne.kr|re.kr|go.kr|pe.kr|ac.kr|es.kr|ms.kr)$/);
  console.log(re.test($("input[type='email']").val()));
  if (!re.test($("input[type='email']").val())) {
    alert("이메일 주소가 올바르지 않습니다.asdf@asdf.(com|co.kr|net|org|biz|info|or.kr|ne.kr|re.kr|go.kr|pe.kr|ac.kr|es.kr|ms.kr)");
    $("input[type='email']").focus();
    return;
  }
  if (confirm("등록하시겠습니까?")) {
    $.ajax({
      url : $(".emailForm").attr("action"),
      method : 'post',
      beforeSend : function(xhr) {
        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
      },
      data : formData,
      dataType : 'text',
      success : function(res) {
        $("input[name='name']").val("");
        $("textarea[name='comments']").val("");
        $("input[type='email']").val("");
        $("input[name='website']").val("");
        alert(res);
      },
      error : function(error) {
        alert(error.status);
      }
    });
  }
});