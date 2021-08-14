package com.cafe24.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cafe24.service.MemberService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class HomeController {
    
    private final MemberService memberService;
    
    
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		return "home";
	}
	
	@GetMapping("login")
	public String login() {
	    return "auth/loginForm";
	}
	
	@GetMapping("signUp")
	public String signUp() {
	    return "home/registForm";
	}
	
	@PostMapping("joinMember")
	public String joinMember(@RequestParam Map<String, Object> map) {
        memberService.joinMember("common.insertMemberInfo", map);
        return "ok";
	}
}
