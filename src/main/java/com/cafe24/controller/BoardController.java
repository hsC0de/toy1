package com.cafe24.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe24.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("board")
@RequiredArgsConstructor
public class BoardController {

    private final BoardService boardService;
    
    @GetMapping("list")
    public String list() {
        return "board/board";
    }
    
    @GetMapping("writing")
    public String writing() {
        return "board/writing";
    }
    
    @PostMapping("regPost")
    @ResponseBody
    public String regPost(@RequestParam Map<String, Object> map) {
        int result = boardService.regPost("board.insertPost", map);
        return "등록되었슈";
    }
}
