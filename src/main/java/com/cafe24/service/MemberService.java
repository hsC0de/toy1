package com.cafe24.service;

import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe24.repository.CommonDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class MemberService {

    private final CommonDao commonDao;
    
    @Transactional
    public int joinMember(String statement, Map<String, Object> condition) {
        
        
        
        int result = commonDao.insert(statement, condition);
        return result;
    }
}
