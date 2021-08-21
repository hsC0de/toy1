package com.cafe24.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe24.repository.CommonDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class CommonService {

    public final CommonDao dao;
    public final BCryptPasswordEncoder passwordEncoder;
    
    
    public Map<String, Object> idCheck(String statement, Map<String, Object> condition) {

        Map<String, Object> resultMap = new HashMap<>();
        int cnt = dao.selectInt(statement, condition);
        
        if(cnt > 0) {
            resultMap.put("result", "이미 사용중인 id입니다.");
            resultMap.put("check", "false");
        }
        else {
            resultMap.put("result", "사용 가능한 id입니다.");
            resultMap.put("check", "true");
        }
        return resultMap;
    }
    
    @Transactional
    public String joinMember(String statement, Map<String, Object> condition) {
        
        String result = "";
       
        int cnt = dao.selectInt("common.existMembers", condition);
        
        if(cnt > 0) {
            result = "이미 사용중인 id입니다.";
        }
        else {
            String password = (String) condition.get("password");
            String ps = passwordEncoder.encode(password);
            condition.put("password", ps);
            dao.insert(statement, condition);
            result = "가입되었습니다.";
        }
        return result;
    }
}
