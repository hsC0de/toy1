package com.cafe24.domain;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public enum AuthVO {

    ROLE_MEMBER("회원"), ROLE_MANAGER("매니저"), ROLE_ADMIN("관리자");
    
    private final String authName;
    
    public static String sortAuthName(String auth) {
        String returnName = null;
        for(AuthVO vo : AuthVO.values()) {
            if(auth.equals(vo.name())) {
                returnName = vo.getAuthName();
            }
        }
        return returnName;
    }
}
