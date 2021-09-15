<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
  <link rel="stylesheet" href="/resources/css/styles.css" />
  <style>
    body {
      
      background-color: #F5F6F7;
    }
    
    #container {
      width: 490px;
      margin: 0 auto;
    }
    .id_area {
      box-sizing: border-box;
      width: 300px;
      height: 40px;
      border: 1px solid #dadada;
      padding: 3px 10px;
      background-color: #fff;
    }
    #id {
      border: none;
      width: 100%;
      height: 100%;
    }
    
    #id:focus {
      outline: none;
    }
    
    .pw_area {
      box-sizing: border-box;
      width: 300px;
      height: 40px;
      border: 1px solid #dadada;
      padding: 3px 10px;
      background-color: #fff;
    }
    
    #password,
    #passwordCheck {
      border: none;
      width: 100%;
      height: 100%;
    }
    
    #password:focus{
      outline:none;
    }
    
    #passwordCheck:focus {
      outline: none;
    } 
    
    #id_check:hover {
      cursor:pointer;
    }
    
    .id_area_container {
      display: flex;
      align-items: center;
      margin-bottom: 10px;
      position: relative;
    }
    
    .pw_area_container {
      display: flex;
      align-items: center;
      margin-bottom: 10px;
    }
    
    .btn_id_check {
/*       border: 1px solid rgba(0, 0, 0, 0.7); */
      border-radius: 3px;
      padding: 6px;
      font-size: 14px;
      background-color: #3D96C2;
      color: #fff;
      position: absolute;
      left: 360px;
      width: 65px;
      text-align: center;
      
    }
    
    .register_form {
      display: flex;
    }
    
    .input_name {
      margin-right: 5px;
     
    }
    .input_name div {
      display:flex;
      font-size: 14px;
      height: 30px;
      width:100%;
      text-align: right;
      align-items: center;
      justify-content: flex-end;
    }
    
    .input_name span {
      display:block;
      vertical-align: middle;
    }
    .input_name span:last-child {
      color: red;
      padding-left: 5px; 
    }
    .register_form {
      width: 490px;
      padding-bottom: 40px;
      border: none;
      background-color: #F5F6F7;
      
    }
    
    .input_area {
      align: right;
      display:flex;
      flex-direction: column;
      align-items: flex-end;
    }
    #submitButton {
      border-radius: 3px;
      padding: 6px;
      font-size: 14px;
      background-color: #3D96C2;
      text-align: center;
      color: #fff;
      border: none;
      
    }
    
    .id_info,
    .password_info {
      color: red;
      font-size: 14px;
    }
    
    .mainLogo {
      width: 490px;
      margin-bottom: 10px;
    }
  </style>
	<script type="text/javascript" src="/node_modules/jquery/dist/jquery.min.js"></script>
	<script>
	  $(function() {
	    var csrfHeaderName = "${_csrf.headerName}";
	    var csrfTokenValue="${_csrf.token}";
	    var idCheck;
	    $("#submitButton").on("click", function(e) {
	      e.preventDefault();
	      
	      var password = $("#password").val();
	      
	      var passwordCheck = $("#passwordCheck").val();
	      
	      console.log(idCheck + "dd");
	      if(idCheck === "false") {
	        
	        alert("아이디를 확인해 주세요.");
	        return;
	      }
	      
	      if(password !== passwordCheck || password < 2) {
	        
	        alert("비밀번호를 확인해 주세요.");
	        return;
	      }
	      
	      $("#registerForm").submit();
	      
	      
	      
	    });
	    
	    $("#id").on("keyup", function() {
	      
	      idCheck = "false";
	      var id = $("#id").val();
	      
	      if(!id) {
          $(".id_info").html("").css("margin-bottom", "0");
	      }
	    });
	    
	    $("#passwordCheck").on("keyup", function() {
	      
	      var password = $("#password").val();
	      
	      var passwordCheck = $(this).val();
	      $(".password_info").html("");
	      
	      if(!password && !passwordCheck) {

	        $(".password_info").html("").css("margin-bottom", "0");
          $(".password_label").css("color", "#000");
          return;
        }
	      
	      if(password != passwordCheck){
	        
	        $(".password_label").css("color", "red");
	        $(".password_info").append("<span> ※ 비밀번호가 일치하지 않습니다.</span>");
          $(".password_info").css({ "color": "red",
                                    "margin-bottom": "10px"});
	        
	      }
	      else {
	        
	        $(".password_label").css("color", "#000");
          $(".password_info").append("<span> ※ 비밀번호가 일치합니다.</span>");
          $(".password_info").css({"color": "blue",
                                   "margin-bottom": "10px"});
	      }
	      
	    });
	    
	    $("#password").on("keyup", function() {
        
        var password = $(this).val();
        
        var passwordCheck = $("#passwordCheck").val();
        $(".password_info").html("");
        
        if(!password && !passwordCheck) {

          $(".password_info").html("").css("margin-bottom", "0");
          $(".password_label").css("color", "#000");
          return;
        }
        
        if(password != passwordCheck){
          
          $(".password_label").css("color", "red");
          $(".password_info").append("<span> ※ 비밀번호가 일치하지 않습니다.</span>");
          $(".password_info").css({"color": "red",
                                   "margin-bottom": "10px"});
          
        }
        else {
          
          $(".password_label").css("color", "#000");
          $(".password_info").append("<span> ※ 비밀번호가 일치합니다.</span>");
          $(".password_info").css({"color": "blue",
                                   "margin-bottom": "10px"});   
        }
        
      });
	    
	    $("#id_check").on("click", function() {
	      
	      $('.id_info').html("");
	      
	      var id = $("#id").val();
	      if(id.length < 2 || id.length > 20) {
	        $(".id_info").append("<span> ※ id는 2자리 이상 입력해 주세요.</span>");
	        $(".id_info").css({"margin-bottom": "10px", "color": "red"});
	        idCheck = "false";
	        return;
	      }
	      
	      $.ajax({
	        url: "/common/idCheck",
	        beforeSend: function(xhr) {
	          xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	        },
	        data: {id: id},
	        dataType: "json",
	        method: "post",
	        success: function(res) {
	          
	          $(".id_info").append("<span> ※ " + res.result + "</span>");
	          $(".id_info").css("margin-bottom", "10px");
	          $(".id_info").css("color", "red");
	          idCheck = res.check;
	          
	          if(idCheck !== "false") {
	            
	            $(".id_info").css("color", "blue");
	          }
	          
	        },
	        error: function() {
	          alert("error");
	        }
	        
	      });
	    });
	  });
	</script>
</head>
<body>
  <div class="wrap">
    <div id="container">
	    <div id="header">
	      <img src="/resources/img/cxooxc-logo-black1.png" class="mainLogo">
	    </div>
	    <div id="register_container">
		    <div class="content">
					<form id="registerForm" name="registerForm" method="post" action="/common/joinMember">
					  <fieldset class="register_form">
					    <div class="input_area">
						    <div class="id_area_container">
						      <div class="input_name">
			              <div>
			                <span>
			                  아이디
			                </span><span>*</span>
			              </div>
	                </div>
								  <div class="id_area">
									  <input type="text" name="id" id="id" minlength="2" maxlength="20"/>
								  </div>
								  <div id="id_check" class="btn_id_check"><span>중복확인</span></div>
								  
						    </div>
						    
	              <div class="id_info"></div>
		            <div class="pw_area_container">
		              <div class="input_name">
	                  <div>
	                    <span>
	                      비밀번호
	                    </span><span>*</span>
	                  </div>
	                </div>
								  <div class="pw_area">
									  <input type="password" name="password" id="password" minlength="2" maxlength="16"/>
								  </div>
							  </div>
							  <div class="pw_area_container">
							    <div class="input_name">
	                  <div class="password_label">
	                    <span>
	                      비밀번호 확인
	                    </span><span>*</span>
	                  </div>
	                </div>
	                <div class="pw_area">
	                  <input type="password" name="passwordCheck" id="passwordCheck" minlength="2" maxlength="16"/>
	                </div>
	                
	              </div>
	              <div class="password_info"></div>
								  <input type="submit" id="submitButton" value="제출"/>
					    </div>
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					  </fieldset>
					</form>
		    </div>
	    </div>
	    <div id="footer">
	    </div>
    </div>
  </div>
</body>
</html>