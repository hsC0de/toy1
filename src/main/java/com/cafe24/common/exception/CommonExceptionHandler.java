package com.cafe24.common.exception;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@ControllerAdvice("com.cafe24")
public class CommonExceptionHandler {

    @ExceptionHandler(Exception.class)
    public String handlerException(Exception ex) throws Exception{
        log.error("Exception :: " + ex.getMessage());
        log.error("toString :: " + ex.toString());
        if (ex instanceof AccessDeniedException
                || ex instanceof AuthenticationException) {
            throw ex;
        }
        return "error/commonException";
    }
}
