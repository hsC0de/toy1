package com.cafe24.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
    
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
            HttpServletResponse response, Authentication authentication)
            throws ServletException, IOException {
        
        String uri = "/";
        RequestCache requestCache = new HttpSessionRequestCache();
        SavedRequest savedRequest = requestCache.getRequest(request, response);
        String prevPage = (String) request.getSession().getAttribute("prevPage");
//        String requestFile = (String) request.getSession().getAttribute("requestFile");
        if(prevPage != null) {
            request.getSession().removeAttribute("prevPage");
        }

        if (savedRequest != null && !savedRequest.getRedirectUrl().contains("/file/download")) {
            uri = savedRequest.getRedirectUrl();
            
            // 세션에 저장된 객체를 다 사용한 뒤에는 지워줘서 메모리 누수 방지
            requestCache.removeRequest(request, response);

        } else if(prevPage != null && !"".equals(prevPage)) {
            uri = prevPage;
        }

        // 세션 Attribute 확인
//        Enumeration<String> list = request.getSession().getAttributeNames();
//        while (list.hasMoreElements()) {
//            System.out.println(list.nextElement());
//        }

//        SavedRequest save = (SavedRequest) request.getSession()
//                .getAttribute("SPRING_SECURITY_SAVED_REQUEST");
//        if (save != null) {
//            String uri = save.getRedirectUrl();
//            System.out.println(uri);
//        }
        
        response.sendRedirect(uri);
    }
}
