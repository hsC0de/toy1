package com.cafe24.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.cafe24.common.util.FileService;
import com.cafe24.domain.common.FileDTO;
import com.cafe24.repository.CommonDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class WebHardService {

    public final CommonDao dao;
    public final FileService fileService;
    
    public List<Map<String, Object>> getFileList(String statement, Map<String, Object> condition) {
        List<Map<String, Object>> resultList = new ArrayList<>();
        resultList = dao.selectList(statement, condition);
        return resultList;
    }
    
    @Transactional
    public List<FileDTO> upload(MultipartFile[] uploadFile, Authentication authentication, String intersection) {
        List<FileDTO> resultList = new ArrayList<>();
        String id = "";
        if(authentication != null) {
            UserDetails userVo = (UserDetails) authentication.getPrincipal();
            id = userVo.getUsername();
        }
        
//        log.info(intersection);
        if("board".equals(intersection)) {
            String sGroupKey = dao.selectStr("board.selectFileGroupKey", null);
            resultList = fileService.upload(uploadFile, sGroupKey, id);
        }
        else if("file".equals(intersection)) {
            String sGroupKey = null;
            resultList = fileService.upload(uploadFile, sGroupKey, id);
        }
        return resultList;
    }
}
