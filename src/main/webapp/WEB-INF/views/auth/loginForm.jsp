<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//   session.invalidate();
  System.out.println("SESSION ID [" + (session == null? null : session.getId()) + "]");
  String oripath = (String) request.getParameter("oripath");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .id_area {
      box-sizing: border-box;
      width: 461px;
      height: 46px;
      border: 1px solid rgba(0, 0, 0, 0.8);
      padding:10px;
      margin-bottom: 10px;
    }
    #id {
      font-size: 15px;
      border: none;
      width: 100%;
    }
    
    .pw_area {
      box-sizing: border-box;
      width: 461px;
      height: 46px;
      border: 1px solid rgba(0, 0, 0, 0.5);
      padding:10px;
      margin-bottom: 10px;
    }
    
    #password {
      font-size: 15px;
      border: none;
      width: 100%;
    }
    
    #loginButton {
      box-sizing: border-box;
      width: 461px;
      height: 46px;
      border: 1px solid #03C75A;
      background: #03C75A;
      padding:10px;
      margin-bottom: 10px;
      color: #fff;
      text-align: center;
      vertical-align: middle;
      font-size: 17px;
      font-weight: 700;
    }
  </style>
	<script type="text/javascript" src="/node_modules/jquery/dist/jquery.min.js"></script>
	<script>
	
	</script>
</head>
<body>
	
<%--     <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
  <div class="wrap">
    <div id="header">
      <img src="#" class="mainLogo">
    </div>
    <div id="container">
      <div class="content">
        <form id="loginForm" name="loginform" method="post" action="/login">
          <fieldset class="login_form">
            <div class="id_area">
              <input type="text" name="id" id="id" placeholder="아이디" minlength="2" maxlength="20"/>
            </div>
            <div class="pw_area">
              <input type="password" name="password" id="password" placeholder="비밀번호" minlength="2" maxlength="16"/>
            </div>
              <input type="submit" id="loginButton" value="로그인"/>
              <div class="checkbox">
        <label>
          <input name="remember-me" type="checkbox" value="Remember Me">Remember Me
          
      <a href="/signUp">Sign up</a>
        </label>
      </div>
          </fieldset>
        </form>
      </div>
    </div>
    <div id="footer">
    </div>
  
  </div>
</body>
</html>