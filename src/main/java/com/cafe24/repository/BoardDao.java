package com.cafe24.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.cafe24.domain.BoardVO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BoardDao {

    final SqlSessionTemplate dao;
    
    public List<BoardVO> getBoardList(String statement, Map<String, Object> condition) {
        return dao.selectList(statement, condition);
    }
}
