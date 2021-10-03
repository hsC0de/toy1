package com.cafe24.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.cafe24.service.WebHardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("file")
@RequiredArgsConstructor
public class WebHardController {

    private final WebHardService webhardService;
    
    @GetMapping("webhard")
    public String webhard(Model model, Authentication authentication) {
        return "file/webhard";
    }
    
    @GetMapping("getFileList")
    @ResponseBody
    public List<Map<String, Object>> getFileList(@RequestParam Map<String, Object> map) {
        List<Map<String, Object>> resultList = new ArrayList<>();
        resultList = webhardService.getFileList("file.getFileList", map);
        return resultList;
    }
    
    @PreAuthorize("isAuthenticated()")
    @PostMapping("createFolder")
    @ResponseBody
    public String createFolder(@RequestParam Map<String, Object> map, Authentication authentication) {
        
        webhardService.createFolder("file.insertFolder", map, authentication);
        
        return "ok";
    }
    
    @PreAuthorize("isAuthenticated()")
    @PostMapping("upload")
    @ResponseBody
    public String upload(MultipartFile[] uploadFile, String webPath, Authentication authentication, HttpServletRequest req) {
        String uri = req.getHeader("Referer");
        String intersection = "board";
        if(!uri.contains("/board")) {
            intersection = "file";
        }
        webhardService.upload(uploadFile, authentication, intersection, webPath);
        
        return "ok";
    }
    
    @PreAuthorize("isAuthenticated()")
    @GetMapping("downloadFile")
    public ModelAndView downloadFile(@RequestParam Map<String, Object> map) throws Exception {
        Map<String, Object> fileMap = webhardService.getDownloadFile("file.getFileInfo", map);
        String path = "";
        if(fileMap != null) {
            path = File.separator + "jhseong112" + File.separator + "tomcat" + File.separator + "webapps" + File.separator + "NAS" + File.separator;
            path += fileMap.get("filePath") + File.separator + fileMap.get("serverName");
        }
        File downloadFile = new File(path);
        Map<String, Object> data = new HashMap<>();
        data.put("model", downloadFile);
        data.put("realName", fileMap.get("realName"));
        return new ModelAndView("downloadView", "downloadFile", data);
    }
}
