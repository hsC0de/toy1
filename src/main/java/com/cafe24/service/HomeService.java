package com.cafe24.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe24.common.util.EmailService;
import com.cafe24.domain.common.EmailDTO;
import com.cafe24.repository.CommonDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class HomeService {

    public final CommonDao dao;
    public final EmailService emailService;
    
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
    
    public void emailMe(EmailDTO email) {
        email.setAddrRecipient("jhseong112@naver.com");
        emailService.sendEmail(email);
    }
}
