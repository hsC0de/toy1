package com.cafe24.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
    public String list(PageDTO map, Model model) {
        List<Map<String, Object>> resultList = new ArrayList<>();

        Map<String, Object> toMap = new ObjectMapper().convertValue(map, Map.class);
        resultList = boardService.boardList("board.getBoardList", toMap);
        Map<String, Object> paging = boardService.getTotal("board.getTotal", toMap);
        
        model.addAttribute("list", resultList);
        model.addAttribute("paging", paging);
        return "board/list";
    }
    
    @GetMapping("get")
    public String get(PageDTO map, Model model) throws JsonProcessingException {
        Map<String, Object> resultMap = new HashMap<>();
        Map<String, Object> toMap = new ObjectMapper().convertValue(map, Map.class);
        resultMap = boardService.get("board.getBoardContent", toMap);
        resultMap.put("paging", toMap);
        String json = new ObjectMapper().writeValueAsString(resultMap);
        
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
    
    @GetMapping("modify/{bno}")
    public String modify(@PathVariable("bno") long bno, Model model) throws JsonProcessingException {
        Map<String, Object> map = new HashMap<>();
        map.put("bno", bno);
        Map<String, Object> resultMap = new HashMap<>();
        resultMap = boardService.get("board.getBoardContent", map);
        String json = new ObjectMapper().writeValueAsString(resultMap);
        
        model.addAttribute("board", json);
        
        return "board/writing";
    }
    
    @PostMapping("modifyPost")
    @ResponseBody
    public String modifyPost(@RequestParam Map<String, Object> map) {
        boardService.modifyPost("board.updatePost", map);
        return "ok";
    }
    
    @GetMapping("delete/{bno}")
    public String delete(@PathVariable("bno") long bno, PageDTO pageMap, Model model) {
        Map<String, Object> map = new HashMap<>();
        map.put("bno", bno);
        boardService.delete("board.delete", map);
        return "redirect:/board/list" + pageMap.getListLink();
    }
    
    
}
