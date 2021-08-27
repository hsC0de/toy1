package com.cafe24.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe24.repository.CommonDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class BoardService {

    public final CommonDao dao;
    
    public List<Map<String, Object>> boardList(String statement, Map<String, Object> condition) {
        List<Map<String, Object>> resultList = new ArrayList<>();
        resultList = dao.selectList(statement, condition);
        return resultList;
    }
    
    public Map<String, Object> getTotal(String statement, Map<String, Object> condition) {
        
        Map<String, Object> resultMap = new HashMap<>();
        int total = dao.selectInt(statement, condition);
        int startPage = (int) condition.get("offset") + 1;
        int realEnd = (int) (Math.ceil((total * 1.0) / (int) condition.get("userDisplay")));
        int endPage = 0; 
        
        if(realEnd < 11) {
            endPage = realEnd;
        }
        else {
            endPage = 10;
        }
        boolean prev = startPage > 10;
        boolean next = realEnd > endPage;
        
        resultMap.put("total", total);
        resultMap.put("startPage", startPage);
        resultMap.put("realEnd", realEnd);
        resultMap.put("endPage", endPage);
        resultMap.put("prev", prev);
        resultMap.put("next", next);
        resultMap.put("page", (int) condition.get("page"));
        resultMap.put("userDisplay", (int) condition.get("userDisplay"));
        return resultMap;
    }
    
    @Transactional
    public int regPost(String statement, Map<String, Object> condition) {
        int result = dao.insert(statement, condition);
        
        return result;
    }
    
    public Map<String, Object> get(String statement, Map<String, Object> condition) {
        
        Map<String, Object> resultMap = new HashMap<>();
        resultMap = dao.selectOne(statement, condition);
        return resultMap;
    }
}
