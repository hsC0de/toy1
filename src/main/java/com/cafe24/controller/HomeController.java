package com.cafe24.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe24.domain.common.EmailDTO;
import com.cafe24.service.HomeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class HomeController {
    
    private final HomeService homeService;
    
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, Authentication authentication) {
		return "home";
	}
	
	@PostMapping("regTodoList")
	@ResponseBody
	public void regTodoList(@RequestParam Map<String, Object> map) {
	    homeService.regTodoList("home.insertTodoList", map);
	}
	
	@PreAuthorize("hasAnyRole('ADMIN','MANAGER')")
	@PostMapping("regTodoListManager")
    @ResponseBody
    public void regTodoListManager(@RequestParam Map<String, Object> map) {
        homeService.regTodoList("home.insertTodoListManager", map);
    }
	
	@GetMapping("getTodoList")
	@ResponseBody
	public List<Map<String, Object>> getTodoList() {
	    List<Map<String, Object>> resultList = new ArrayList<>();
	    resultList = homeService.getTodoList("home.getTodoList", null);
	    
	    return resultList;
	}
	
	@GetMapping("getTodoListManager")
    @ResponseBody
    public List<Map<String, Object>> getTodoListManager() {
        List<Map<String, Object>> resultList = new ArrayList<>();
        resultList = homeService.getTodoList("home.getTodoListManager", null);
        
        return resultList;
    }
	
	@PostMapping("deleteTodoList")
	@ResponseBody
	public void deleteTodoList(@RequestParam Map<String, Object> map) {
	    homeService.deleteTodoList("home.deleteTodoList", map);
	}
	
	@PreAuthorize("hasAnyRole('ADMIN','MANAGER')")
	@PostMapping("deleteTodoListManager")
    @ResponseBody
    public void deleteTodoListManager(@RequestParam Map<String, Object> map) {
        homeService.deleteTodoList("home.deleteTodoListManager", map);
    }
	
	@PostMapping("doneTodoList")
    @ResponseBody
    public void doneTodoList(@RequestParam Map<String, Object> map) {
        homeService.doneTodoList("home.doneTodoList", map);
    }
	
	@PreAuthorize("hasAnyRole('ADMIN','MANAGER')")
	@PostMapping("doneTodoListManager")
    @ResponseBody
    public void doneTodoListManager(@RequestParam Map<String, Object> map) {
        homeService.doneTodoList("home.doneTodoListManager", map);
    }
	
	@PostMapping(value="emailMe", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public String emailMe(EmailDTO email) {
	    homeService.emailMe(email);
	    return "등록되었습니다.";
	}
}
