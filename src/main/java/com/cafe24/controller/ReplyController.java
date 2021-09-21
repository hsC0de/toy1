package com.cafe24.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cafe24.service.ReplyService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@RequestMapping("reply")
@RequiredArgsConstructor
public class ReplyController {

    private final ReplyService replyService;
    
    @GetMapping("getReplyList")
    public List<Map<String, Object>> getReplyList(@RequestParam Map<String, Object> map) {
        List<Map<String, Object>> resultList = new ArrayList<>();
//        Map<String, Object> map = new HashMap<>();
//        map.put("bno", bno);
        
        resultList = replyService.getReplyList("reply.getReplyList", map);
        
        return resultList;
    }
    
    @PreAuthorize("isAuthenticated() and principal.username == #id")
    @PostMapping("regReply")
    public Map<String, Object> regReply(@RequestParam Map<String, Object> map, String id) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap = replyService.regReply("reply.insertReply", map);
        return resultMap;
    }
    
    @PreAuthorize("isAuthenticated() and principal.username == #id")
    @PostMapping("modifyReply")
    public void modifyReply(@RequestParam Map<String, Object> map, String id) {
        Map<String, Object> resultMap = new HashMap<>();
        replyService.modifyReply("reply.modifyReply", map);
    }
    
    @PreAuthorize("isAuthenticated() and principal.username == #id")
    @PostMapping("deleteReply")
    public Map<String, Object> deleteReply(@RequestParam Map<String, Object> map, String id) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap = replyService.deleteReply("reply.deleteReply", map);
        return resultMap;
    }
    
}
