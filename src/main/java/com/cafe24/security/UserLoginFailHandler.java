package com.cafe24.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class UserLoginFailHandler implements AuthenticationFailureHandler{
    
    private String loginidname;

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException exception) throws IOException, ServletException {
        
        String username = request.getParameter(loginidname);
        
        if(exception instanceof AuthenticationServiceException) {
            request.setAttribute("loginFailMsg", "아이디 또는 비밀번호가 일치하지 않습니다.");
        }
        else if(exception instanceof BadCredentialsException) {
            request.setAttribute("loginFailMsg", "아이디 또는 비밀번호가 일치하지 않습니다.");
        }
        else if(exception instanceof LockedException) {
            request.setAttribute("loginFailMsg", "계정에 문제가 있습니다. 관리자에게 문의하세요.");
        }
        else if(exception instanceof DisabledException) {
            request.setAttribute("loginFailMsg", "휴면계정 입니다.");
        }
        else if(exception instanceof AccountExpiredException) {
            request.setAttribute("loginFailMsg", "만료된 계정입니다.");
        }
        else if(exception instanceof CredentialsExpiredException) {
            request.setAttribute("loginFailMsg", "비밀번호를 변경해주세요.");
        }
        
        request.setAttribute("loginidname", username);
        request.getRequestDispatcher("/common/login").forward(request, response);


    }
}
