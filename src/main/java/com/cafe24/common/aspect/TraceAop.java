package com.cafe24.common.aspect;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

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
}
