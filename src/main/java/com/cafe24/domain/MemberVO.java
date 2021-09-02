package com.cafe24.domain;

import lombok.Data;

@Data
public class MemberVO {

    private String id;
    private String password;
    
    private String joinDate;
    private String authGrpNm;
}
