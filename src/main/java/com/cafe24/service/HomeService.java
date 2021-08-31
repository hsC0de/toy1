package com.cafe24.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe24.repository.CommonDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class HomeService {

    public final CommonDao dao;
    
    @Transactional
    public void regTodoList(String statement, Map<String, Object> condition) {
        dao.insert(statement, condition);
    }
    
    public List<Map<String, Object>> getTodoList(String statement, Map<String, Object> condition) {
        return dao.selectList(statement, condition);
    }
    
    @Transactional
    public void deleteTodoList(String statement, Map<String, Object> condition) {
        dao.update(statement, condition);
    }
    
    @Transactional
    public void doneTodoList(String statement, Map<String, Object> condition) {
        dao.update(statement, condition);
    }
}
