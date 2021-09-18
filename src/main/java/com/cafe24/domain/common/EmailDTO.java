package com.cafe24.domain.common;

import lombok.Data;

@Data
public class EmailDTO {

    private String name;
    private String email;
    
    private String website;
    private String comments;
    
    private String from;
    private String AddrRecipient;
}
