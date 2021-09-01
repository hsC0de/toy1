package com.cafe24.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageDTO {

    private long bno;
    private int page;
    private int userDisplay;
    private String kind;
    
    private int offset;
    
    public PageDTO(int page, int userDisplay) {
        
        int offset = (page - 1) * userDisplay;
        
        this.offset = offset;
        this.page = page;
        this.userDisplay = userDisplay;
    }
    
    
    
    public String getListLink() {
        UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
                                                           .queryParam("page", this.page)
                                                           .queryParam("userDisplay", this.userDisplay)
                                                           .queryParam("kind", this.kind);
        return builder.toUriString();
    }
}
