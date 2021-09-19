package com.cafe24.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
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
    
    public Map<String, List<Map<String, Object>>> boardList(String statement, Map<String, Object> condition) {
        Map<String, List<Map<String, Object>>> resultMap = new HashMap<>();
        List<Map<String, Object>> resultList = new ArrayList<>();
        resultList = dao.selectList(statement, condition);
        resultMap.put("boardList", resultList);
        resultMap.put("noticeBoardList", dao.selectList("board.getNoticeBoardList", condition));
        log.info("" + !("BA".equals(condition.get("kind"))));
        if(!("BA".equals(condition.get("kind"))) && !("BN".equals(condition.get("kind")))) {
            resultMap.put("boardNoticeList", dao.selectList("board.getBoardNoticeList", condition));
        }
        
        return resultMap;
    }
    
    public Map<String, Object> getTotal(String statement, Map<String, Object> condition) {
        Map<String, Object> resultMap = new HashMap<>();
        int total = dao.selectInt(statement, condition);
        int startPage = (int) condition.get("page") % 10 != 0? (int) condition.get("page") / 10 * 10 + 1 : ((int) condition.get("page") - 1) / 10 * 10 + 1;
        int realEnd = (int) (Math.ceil((total * 1.0) / (int) condition.get("userDisplay")));
        int endPage = 0;
        
        boolean ep = (int) condition.get("page") % 10 != 0? (int) condition.get("page") / 10 == realEnd / 10 : false;
        boolean next = false;
        
        if(ep) {
            endPage = realEnd;
        }
        else if((int) condition.get("page") % 10 == 0 && (int) condition.get("page") == realEnd){
            endPage = (int) condition.get("page") / 10 * 10;
            next = false;
        }
        else if((int) condition.get("page") % 10 == 0 && (int) condition.get("page") != realEnd){
            endPage = ((int) condition.get("page") / 10) * 10;
            next = true;
        }
        else if((int) condition.get("page") % 10 != 0 && (int) condition.get("page") / 10 - Math.ceil((realEnd * 1.0) / 10) == -1) {
            endPage = ((int) condition.get("page") / 10 + 1) * 10;
            next = false;
        }
        else {
            endPage = ((int) condition.get("page") / 10 + 1) * 10;
            next = true;
        }
        boolean prev = startPage != 1;
        
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
    public Map<String, Object> regPost(String statement, Map<String, Object> condition) {
        Map<String, Object> resultMap = new HashMap<>();
        int result = dao.insert(statement, condition);
        if(result == 1) {
            resultMap = dao.selectOne("board.getPostBno", condition);
        }
        return resultMap;
    }
    
    @Transactional
    public int modifyPost(String statement, Map<String, Object> condition) {
        
        int result = dao.update(statement, condition);
        if(result == 1) {
            dao.insert("board.insertModifyHst", condition);
        }
        
        return result;
    }
    
    public Map<String, Object> writing (Map<String, Object> condition, Authentication authentication) {
        
        Map<String, Object> resultMap = new HashMap<>();
        resultMap = dao.selectOne("board.getMenuNm", condition);
        UserDetails userVo = (UserDetails) authentication.getPrincipal();
        boolean auth = false;
        Collection<? extends GrantedAuthority> auths = userVo.getAuthorities();
        List<String> list = auths.stream().filter(x -> x.toString().equals("ROLE_MANAGER") || x.toString().equals("ROLE_ADMIN")).map(x -> x.toString()).collect(Collectors.toList());
        if(list.size() >= 1) {
            auth = true;
        }
        resultMap.put("auth", auth);
        return resultMap;
    }
    
    @Transactional
    public int delete(String statement, Map<String, Object> condition) {
        return dao.update(statement, condition);
    }
    
    @Transactional
    public Map<String, Object> get(String statement, Map<String, Object> condition, Authentication authentication) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap = dao.selectOne(statement, condition);
        boolean auth = false;
        boolean existLike = false;
        if(authentication != null) {
            UserDetails userVo = (UserDetails) authentication.getPrincipal();
            Collection<? extends GrantedAuthority> auths = userVo.getAuthorities();
            List<String> list = auths.stream().filter(x -> x.toString().equals("ROLE_MANAGER") || x.toString().equals("ROLE_ADMIN")).map(x -> x.toString()).collect(Collectors.toList());
            if(list.size() >= 1) {
                auth = true;
            }
//            System.out.println(userVo.getUsername());
            condition.put("id", (String) userVo.getUsername());
            if(dao.selectInt("board.existLike", condition) == 1) {
                existLike = true;
            }
        }
        
        resultMap.put("existLike", existLike);
        resultMap.put("auth", auth);
        return resultMap;
    }
    
    public Map<String, Object> getMenuNm(String statement, Map<String, Object> condition) {
        return dao.selectOne(statement, condition);
    }
    
    @Transactional
    public Map<String, Object> like(String statement, Map<String, Object> condition) {
        Map<String, Object> resultMap = new HashMap<>();
        boolean existLike = false;
        if(dao.insert(statement, condition) == 1) {
            resultMap = dao.selectOne("board.getLikeCnt", condition);
            if(dao.selectInt("board.existLike", condition) == 1) {
                existLike = true;
            }
        }
        resultMap.put("existLike", existLike);
        return resultMap;
    }
    
    @Transactional
    public Map<String, Object> deleteLike(String statement, Map<String, Object> condition) {
        Map<String, Object> resultMap = new HashMap<>();
        boolean existLike = false;
        if(dao.delete(statement, condition) == 1) {
            resultMap = dao.selectOne("board.getLikeCnt", condition);
            if(dao.selectInt("board.existLike", condition) == 1) {
                existLike = true;
            }
        }
        resultMap.put("existLike", existLike);
        return resultMap;
    }
}
