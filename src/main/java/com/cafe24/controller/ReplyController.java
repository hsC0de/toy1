package com.cafe24.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe24.service.ReplyService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("reply")
@RequiredArgsConstructor
public class ReplyController {

    private final ReplyService replyService;
    
    @GetMapping("getReplyList")
    @ResponseBody
    public List<Map<String, Object>> getReplyList(@RequestParam Map<String, Object> map) {
        List<Map<String, Object>> resultList = new ArrayList<>();
//        Map<String, Object> map = new HashMap<>();
//        map.put("bno", bno);
        
        resultList = replyService.getReplyList("reply.getReplyList", map);
        
        return resultList;
    }
    
    @PostMapping("regReply")
    @ResponseBody
    public Map<String, Object> regReply(@RequestParam Map<String, Object> map) {
        Map<String, Object> resultMap = new HashMap<>();
        replyService.regReply("reply.insertReply", map);
        resultMap = replyService.getRelpyCnt("reply.getRelpyCnt", map);
        return resultMap;
    }
}
