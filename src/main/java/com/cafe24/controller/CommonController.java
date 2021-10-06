package com.cafe24.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
    public String accessError(Authentication auth, Model model, HttpServletResponse res, HttpServletRequest req) {
        log.info("access Denied: " + auth);
        model.addAttribute("msg", "Access Denied");
        res.setHeader("redirectLogin", "true");
        res.setHeader("redirectUrl", req.getRequestURI());
        return "auth/accessError";
    }
    
    @GetMapping("login")
    public String login(Model model, HttpServletResponse res, HttpServletRequest req) {
        String uri = req.getHeader("Referer");
//        log.info("" + req.getRequestURI());
        if(!uri.contains("/login")) {
            String referrer = req.getHeader("Referer");
            req.getSession().setAttribute("prevPage", referrer);
//            req.getSession().setAttribute("requestFile", req.getRequestURI());
        }
        res.setHeader("redirectLogin", "true");
        res.setHeader("redirectUrl", req.getRequestURI());
        return "auth/loginForm";
    }
    
    @PostMapping("login")
    public String login(HttpServletResponse res, HttpServletRequest req) {
        String uri = req.getHeader("Referer");
        if(!uri.contains("/login")) {
            String referrer = req.getHeader("Referer");
            req.getSession().setAttribute("prevPage", referrer);
        }
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
    public String joinMember(@RequestParam Map<String, Object> map, Model model) {
        String message = "";
        message = commonService.joinMember("common.insertMemberInfo", map);
        model.addAttribute("result", message);
        return "home";
    }
    
    
    
    
}
