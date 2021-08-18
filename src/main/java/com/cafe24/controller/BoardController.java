package com.cafe24.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
        return "board/list";
    }
    
    @GetMapping(value="boardList", produces= MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<Map<String, Object>> boardList() {
        List<Map<String, Object>> resultList = new ArrayList<>();
        resultList = boardService.boardList("board.getBoardList", null);
        return resultList;
    }
    
    @GetMapping("get")
    public String get(@RequestParam("bno") Long bno, Model model) {
        Map<String, Object> map = new HashMap<>();
        map.put("bno", bno);
        map = boardService.get("board.getBoardContent", map);
        model.addAttribute("board", map);
        return "board/get";
    }
    
    @GetMapping("writing")
    public String writing() {
        return "board/writing";
    }
    
    @PostMapping("regPost")
    @ResponseBody
    public String regPost(@RequestParam Map<String, Object> map) {
        boardService.regPost("board.insertPost", map);
        return "ok";
    }
    
    
}
