package com.cafe24.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cafe24.service.MenuService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("menu")
public class MenuContoller {

    private final MenuService menuService;
    
    @GetMapping("menuList")
    public List<Map<String, Object>> menuList(Model model) {
        List<Map<String, Object>> resultList = new ArrayList<>();
        resultList = menuService.getMenuList("menu.getMenuList", null);
        
        return resultList;
    }
}
