package com.cafe24.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe24.domain.BoardVO;
import com.cafe24.repository.BoardDao;
import com.cafe24.repository.CommonDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class BoardService {

    public final CommonDao dao;
    public final BoardDao boardDao;
    
    public List<BoardVO> boardList(String statement, Map<String, Object> condition) {
        List<BoardVO> resultList = new ArrayList<>();
        resultList = boardDao.getBoardList(statement, condition);
        return resultList;
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
