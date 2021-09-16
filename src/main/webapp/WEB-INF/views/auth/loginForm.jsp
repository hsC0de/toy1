<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
  <link rel="stylesheet" href="/resources/css/styles.css" />
<style>
    
    body {
      
      background-color: #F5F6F7;
    }
    #container {
      width: 461px;
      margin: 0 auto;
    }
    .id_area {
      box-sizing: border-box;
      width: 461px;
      height: 46px;
      border: 1px solid #dadada;
      padding:10px;
      margin-bottom: 10px;
      background-color: #fff;
    }
    #id {
      font-size: 15px;
      border: none;
      width: 100%;
      vertical-align: middle;
      margin-top: 4px;
    }
    
    .pw_area {
      box-sizing: border-box;
      width: 461px;
      height: 46px;
      border: 1px solid #dadada;
      padding:10px;
      margin-bottom: 10px;
      background-color: #fff;
    }
    
    #password {
      font-size: 15px;
      border: none;
      width: 100%;
      vertical-align: middle;
      margin-top: 4px;
    }
    
    #loginButton {
      box-sizing: border-box;
      width: 461px;
      height: 46px;
      border: 1px solid #3D96C2;
      background-color: #3D96C2;
      padding:10px;
      margin-bottom: 10px;
      color: #fff;
      text-align: center;
      vertical-align: middle;
      font-size: 17px;
      font-weight: 700;
    }
    
    .login_form {
      width: 461px;
      display: flex;
      flex-direction: column;
      align-items: center;
      position: relative;
    }
    
    .login_tools {
      width: 100%;
      display:flex;
      justify-content: space-between;
    }
    
    .checkbox input {
      margin-right: 10px;
    }
    
    .mainLogo {
      width: 461px;
    }
    
    .authenticationErrorMsg {
      display: block;
      color: tomato;
      margin-bottom: 10px;
      position: relative;
      left: -74px;
    }
    
  </style>
	<script type="text/javascript" src="/node_modules/jquery/dist/jquery.min.js"></script>
	<script>
	  $(function() {
	    $("input[name='username']").focus();
	    
	  });
	</script>
</head>
<body>
	
<%--     <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
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
</body>
</html>