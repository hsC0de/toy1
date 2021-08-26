package com.cafe24.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe24.domain.PageDTO;
import com.cafe24.service.BoardService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

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
    
    @GetMapping("boardList")
    @ResponseBody
    public Map<String, Object> boardList(PageDTO map) {
        Map<String, Object> resultMap = new HashMap<>();
        List<Map<String, Object>> resultList = new ArrayList<>();
        Map<String, Object> toMap = new ObjectMapper().convertValue(map, Map.class);
        resultList = boardService.boardList("board.getBoardList", toMap);
        Map<String, Object> paging = boardService.getTotal("board.getTotal", toMap);
        resultMap.put("list", resultList);
        resultMap.put("paging", paging);
        return resultMap;
    }
    
    @GetMapping("get")
    public String get(@RequestParam("bno") Long bno, Model model) throws JsonProcessingException {
        Map<String, Object> map = new HashMap<>();
        map.put("bno", bno);
        map = boardService.get("board.getBoardContent", map);
        
        String json = new ObjectMapper().writeValueAsString(map);
        
        model.addAttribute("board", json);
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
