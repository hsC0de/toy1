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
public class BoardService {

    public final CommonDao dao;
    
    @Transactional
    public int regPost(String statement, Map<String, Object> condition) {
//        condition.put("grp_key", dao.selectStr("board.selectFileGroupKey", null));
        int result = 0;
//        Map resultMap = new HashMap();
//        System.out.println(condition);
//        if(dao.insert("board.insertFileGroupKey", null) == 1) {
//            log.info("=========================================");
            result = dao.insert(statement, condition);
//        }
        
        return result;
    }
}
