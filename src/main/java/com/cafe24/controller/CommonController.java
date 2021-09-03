package com.cafe24.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe24.service.CommonService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("common")
public class CommonController {

    private final CommonService commonService;
    
    @GetMapping("accessError")
    public String accessError(Authentication auth, Model model) {
        log.info("access Denied: " + auth);
        model.addAttribute("msg", "Access Denied");
        return "auth/accessError";
    }
    
    @GetMapping("login")
    public String login(String error, String logout, Model model) {
        log.info("error: " + error);
        log.info("logout: " + logout);
        return "auth/loginForm";
    }
    
    @GetMapping("signUp")
    public String signUp() {
        return "auth/registForm";
    }
    

    @PostMapping(value="idCheck", produces="application/json; charset=utf8")
    @ResponseBody
    public Map idCheck(@RequestParam Map<String, Object> map) {
        Map resultMap = new HashMap();
        resultMap = commonService.idCheck("common.existMembers", map);
        return resultMap;
    }
    
    @PostMapping("joinMember")
    @ResponseBody
    public String joinMember(@RequestParam Map<String, Object> map) {
        String message = "";
        message = commonService.joinMember("common.insertMemberInfo", map);
        return message;
    }
    
    
    
    
}
