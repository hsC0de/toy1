package com.cafe24.common.exception;

import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@ControllerAdvice("com.cafe24")
public class CommonExceptionHandler {

    @ExceptionHandler(Exception.class)
    public String handlerException(Exception ex) {
        log.error("Exception :: " + ex.getMessage());
        log.error("toString :: " + ex.toString());

        return "error/commonException";
    }
}
