package com.cafe24.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.cafe24.domain.MemberVO;
import com.cafe24.repository.CommonDao;
import com.cafe24.security.domain.CustomUser;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private CommonDao dao;
    
    @Override
    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
        log.warn("Load user by UserName: " + userName);
        
        MemberVO vo = dao.selectMember("common.getUserInfo", userName);
        
        log.warn("queried by member mapper: " + vo);
        return vo == null ? null : new CustomUser(vo);
    }
}
