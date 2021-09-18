<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
  <link rel="stylesheet" href="/resources/css/styles.css" />
  <link rel="stylesheet" href="/resources/css/screens/loginForm.css" />
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
    <div id="login_container">
      <div class="content">
        <form id="loginForm" name="loginform" method="post" action="/login">
          <fieldset class="login_form">
            <div class="id_area">
              <c:choose>
              <c:when test="${not empty loginidname}">
                <input type="text" name="username" id="id" placeholder="아이디" minlength="2" maxlength="20" value="${loginidname}"/>
              </c:when>
              <c:otherwise>
                <input type="text" name="username" id="id" placeholder="아이디" minlength="2" maxlength="20"/>
              </c:otherwise>
              </c:choose>
              
            </div>
            <div class="pw_area">
              <input type="password" name="password" id="password" placeholder="비밀번호" minlength="2" maxlength="16"/>
            </div>
            <input type="submit" id="loginButton" value="로그인"/>
            <span class="authenticationErrorMsg">
            <c:if test="${not empty loginFailMsg}">
              ※ ${loginFailMsg}
            </c:if>
            </span>
            <div class="login_tools">
	            <div class="checkbox">
			          <input id="rememberMe" name="remember-me" type="checkbox"><label for="rememberMe">로그인 상태 유지</label>
	            </div>
	            <div>
                <a href="/common/signUp">회원가입</a>
              </div>
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
  <script type="text/javascript">
      $("#id").focus();
  </script>
</body>
</html>