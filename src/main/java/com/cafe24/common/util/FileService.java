package com.cafe24.common.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.cafe24.domain.common.FileDTO;
import com.cafe24.repository.CommonDao;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
public class FileService {
    
    public final CommonDao dao;
    
    private String getFolder() {
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        
        Date date = new Date();
        
        String str = sdf.format(date);
        
        return str.replace("-", File.separator);
    }

    @Transactional
    public List<FileDTO> upload(MultipartFile[] uploadFile, String sGroupKey, String id) {
        List<FileDTO> resultList = new ArrayList<>();
        
        String sPath = "";
        sPath = File.separator + "jhseong112" + File.separator + "tomcat" + File.separator + "webapps" + File.separator + "NAS";
        String uploadFolder = getFolder();
        
        File uploadPath = new File(sPath, uploadFolder);
        
        if(uploadPath.exists() == false) {
            uploadPath.mkdirs();
        }
        
        int cnt = 0;
        for(MultipartFile file : uploadFile) {
            cnt++;
            FileDTO fileDto = new FileDTO();
            try {
                if(sGroupKey != null) {
                    fileDto.setGroupKey(sGroupKey);
                    fileDto.setSeq(cnt);
                }
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
}
