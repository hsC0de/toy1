package com.cafe24.domain.common;

import lombok.Data;

@Data
public class FileDTO {

    private String groupKey;
    private long seq;
    private String realName;
    private String fileName;
    private String path;
    private long length;
    private String type;
    private String userId;
}
