<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
  <link rel="stylesheet" href="/resources/css/styles.css" />
  <link rel="stylesheet" href="/resources/css/screens/registForm.css" />
	<script type="text/javascript" src="/node_modules/jquery/dist/jquery.min.js"></script>
</head>
<body>
  <div class="wrap">
    <div id="container">
	    <div id="header">
      <a href="/">
        <img src="/resources/img/cxooxc-logo-black1.png" class="mainLogo">
      </a>
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
						    
	              <div class="email_area_container">
                  <div class="input_name">
                    <div>
                      <span>
                        이메일
                      </span><span>*</span>
                    </div>
                  </div>
                  <div class="email_area">
                    <input type="email" name="email" id="email"/>
                  </div>
                </div>
                <div class="email_info"></div>
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
  <script type="text/javascript" src="/resources/js/registForm.js"></script>
</body>
</html>