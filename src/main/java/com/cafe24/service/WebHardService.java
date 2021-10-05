package com.cafe24.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;

import com.cafe24.domain.common.FileDTO;
import com.cafe24.repository.CommonDao;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class WebHardService {

    public final CommonDao dao;
    
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
        if(authentication != null) {
            UserDetails userVo = (UserDetails) authentication.getPrincipal();
            id = userVo.getUsername();
            condition.put("userId", id);
        }
        dao.insert(statement, condition);
    }
    
    public String getFolder() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = sdf.format(date);
        return str.replace("-", File.separator);
    }
    
    @Transactional
    public List<FileDTO> upload(MultipartFile[] uploadFile, Authentication authentication, String webPath) {
        List<FileDTO> resultList = new ArrayList<>();
        String id = "";
        if(authentication != null) {
            UserDetails userVo = (UserDetails) authentication.getPrincipal();
            id = userVo.getUsername();
        }
        
        String sPath = "";
        sPath = File.separator + "jhseong112" + File.separator + "tomcat" + File.separator + "webapps" + File.separator + "NAS";
        String uploadFolder = getFolder();
        
        File uploadPath = new File(sPath, uploadFolder);
        
        if(uploadPath.exists() == false) {
            uploadPath.mkdirs();
        }
        for(MultipartFile file : uploadFile) {
            FileDTO fileDto = new FileDTO();
            try {
                fileDto.setWebPath(webPath);
                String uploadFileName = "" + Calendar.getInstance().getTimeInMillis();
                fileDto.setRealName(file.getOriginalFilename());
                fileDto.setFileName(uploadFileName);
                fileDto.setPath(uploadFolder);
                fileDto.setLength(file.getSize());
                fileDto.setType(file.getContentType());
                fileDto.setUserId(id);
                
                File saveFile = new File(uploadPath, uploadFileName);
                resultList.add(fileDto);
                
                Map toMap = new ObjectMapper().convertValue(fileDto, Map.class);
                int result = dao.insert("file.insertFileInfo", toMap);
                if(result == 1) {
                    file.transferTo(saveFile);
                };
            } catch (Exception e) {
                log.info(e.getMessage());
            }
        }
        return resultList;
    }
    
    @Transactional
    public Map<String, Object> getDownloadFile(String statement, Map<String, Object> condition) {
        Map<String, Object> resultMap = dao.selectOne(statement, condition);
        return resultMap;
    }
    
    @Transactional
    public List<Map<String, Object>> getdownloadZipFile(String statement, Map<String, Object> condition) {
        List<Map<String, Object>> resultList = dao.selectList(statement, condition);
        return resultList;
    }
    
    @Transactional
    public void deleteFile(String statement, Map<String, Object> condition) {
        List<Map<String, Object>> fileList = dao.selectList("file.getFileInfoList", condition);
        String path = "";
        if(!ObjectUtils.isEmpty(fileList)) {
            for(Map<String, Object> fileMap : fileList) {
                File file;
                path = File.separator + "jhseong112" + File.separator + "tomcat" + File.separator + "webapps" + File.separator + "NAS" + File.separator;
                path += fileMap.get("filePath") + File.separator + fileMap.get("serverName");
                file = new File(path);
                if(file.exists()) {
                    file.delete();
                }
            }
            int result = dao.delete(statement, condition);
        }
    }
}
