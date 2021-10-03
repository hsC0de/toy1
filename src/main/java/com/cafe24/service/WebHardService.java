package com.cafe24.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
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
    public void createFolder(String statement, Map<String, Object> condition, Authentication authentication) {
        
        String id = "";
        List<Map<String, Object>> existName = new ArrayList<>();
        existName = dao.selectList("file.existFolderName", condition);
        

        log.info("" + existName);
        
        if(!ObjectUtils.isEmpty(existName)) {
            
            for(int i = 0; i < existName.size(); i++) {
                condition.put("realName", (String) condition.get("folderName") + " (" + (i + 1) + ")");
                if("/".equals((String) condition.get("webPath"))) {
                    condition.put("folderPath", (String) condition.get("webPath") + (String) condition.get("folderName") + " (" + (i + 1) + ")");
                }
                else {
                    condition.put("folderPath", (String) condition.get("webPath") + "/" + (String) condition.get("folderName") + " (" + (i + 1) + ")");
                }
            }
        } else {
            condition.put("realName", (String) condition.get("folderName"));
            if("/".equals((String) condition.get("webPath"))) {
                condition.put("folderPath", (String) condition.get("webPath") + (String) condition.get("folderName"));
            }
            else {
                condition.put("folderPath", (String) condition.get("webPath") + "/" + (String) condition.get("folderName"));                
            }
        }
        
        log.info("" + condition);
        
        if(authentication != null) {
            UserDetails userVo = (UserDetails) authentication.getPrincipal();
            id = userVo.getUsername();
            condition.put("userId", id);
        }
        dao.insert(statement, condition);
    }
    
    @Transactional
    public List<FileDTO> upload(MultipartFile[] uploadFile, Authentication authentication, String intersection, String webPath) {
        List<FileDTO> resultList = new ArrayList<>();
        String id = "";
        if(authentication != null) {
            UserDetails userVo = (UserDetails) authentication.getPrincipal();
            id = userVo.getUsername();
        }
        
//        log.info(intersection);
        if("board".equals(intersection)) {
            String sGroupKey = dao.selectStr("board.selectFileGroupKey", null);
            resultList = fileService.upload(uploadFile, sGroupKey, id, webPath);
        }
        else if("file".equals(intersection)) {
            String sGroupKey = null;
            resultList = fileService.upload(uploadFile, sGroupKey, id, webPath);
        }
        return resultList;
    }
    
    @Transactional
    public Map<String, Object> getDownloadFile(String statement, Map<String, Object> condition) {
        Map<String, Object> resultMap = dao.selectOne(statement, condition);
        return resultMap;
    }
}
