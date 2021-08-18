package com.cafe24.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe24.repository.CommonDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ReplyService {

    public final CommonDao dao;
    
    public List<Map<String, Object>> getReplyList(String statement, Map<String, Object> condition) {
        
        List<Map<String, Object>> resultList = dao.selectList(statement, condition);
        
        return resultList;
    }
    
    @Transactional
    public String regReply(String statement, Map<String, Object> condition) {
        dao.insert(statement, condition);
        return "ok";
    }
}
