package com.cafe24.common.aspect;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.cafe24.domain.AuthVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Aspect
@Component
public class TraceAop {

    @Pointcut("execution(public * com.cafe24.controller..*(..))")
    public void pointCutMethod() {
    }

    @Around("pointCutMethod()")
    public Object trace(ProceedingJoinPoint joinPoint) throws Throwable {

        HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();
        HttpServletResponse res = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getResponse();
        log.info("=======================================================================");
        log.info("profiler == Before || " + joinPoint.getSignature().toShortString());
        log.info("== 이 시스템은 " + System.getProperty("spring.profiles.active") + "입니다.");
        String addr = req.getRemoteAddr();
        log.info("== 서비스 요청 ip는 " + "입니다.");
        log.info("=======================================================================");
        
        Map<String, Object> map = new HashMap<>();
        Object result = new Object();
        result = joinPoint.proceed();

        req.setAttribute("ServerInfo", System.getProperty("spring.profiles.active"));
        map.put("SERVICE", req.getServletPath().replace("/", ""));
        map.put("ACCESS_IP", addr);
        map.put("REQ_QUERY", req.getQueryString());
        System.out.println(map);

        return result;
        
    }
    
    @Around("execution(public * com.cafe24.controller..*(..)) && args(.., model, authentication) ")
    public Object authCheck(ProceedingJoinPoint joinPoint, Model model, Authentication authentication) throws Throwable {
        String userAuth = "";
        Object result = new Object();
        boolean auth = false;
        
        if(authentication != null) {
            UserDetails userVo = (UserDetails) authentication.getPrincipal();
            Collection<? extends GrantedAuthority> auths = userVo.getAuthorities();
            userAuth = auths.toArray()[0].toString();
            userAuth = AuthVO.sortAuthName(userAuth.toString());
            model.addAttribute("authName", userAuth);           
            if("매니저".equals(userAuth) || "관리자".equals(userAuth)) {
                auth = true;
            }
            model.addAttribute("auth", auth);
        }
        
        result = joinPoint.proceed();
        return result;
    }
}
