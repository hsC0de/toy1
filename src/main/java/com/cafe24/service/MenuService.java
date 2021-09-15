package com.cafe24.service;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.cafe24.repository.CommonDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class MenuService {

    public final CommonDao dao;
    
    public List<Map<String, Object>> getMenuList(String statement, Map<String, Object> condition, Authentication authentication) {
        Map<String, Object> map = new HashMap<>();
        if(authentication != null) {
            UserDetails userVo = (UserDetails) authentication.getPrincipal();
            Collection<? extends GrantedAuthority> auths = userVo.getAuthorities();
            List<String> list = auths.stream().map(x -> x.toString()).collect(Collectors.toList());
            map.put("menu_auth", list.get(0));
        }
        else {
            map.put("menu_auth", "guest");
        }
        
        log.info("" + map);
        List<Map<String, Object>> resultList = dao.selectList(statement, map);
        return resultList;
    }
}
