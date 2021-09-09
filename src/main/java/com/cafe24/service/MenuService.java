package com.cafe24.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.cafe24.repository.CommonDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class MenuService {

    public final CommonDao dao;
    
    public List<Map<String, Object>> getMenuList(String statement, Map<String, Object> condition) {
        List<Map<String, Object>> resultList = dao.selectList(statement, condition);
        return resultList;
    }
}
