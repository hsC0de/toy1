package com.cafe24.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cafe24.service.WebHardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("file")
@RequiredArgsConstructor
public class WebHardController {

    private final WebHardService webhardService;
    
    @GetMapping("webhard")
    public String webhard(Model model, Authentication authentication) {
        return "file/webhard";
    }
}
