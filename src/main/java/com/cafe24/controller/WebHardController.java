package com.cafe24.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
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
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

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
    
    @PreAuthorize("isAuthenticated()")
    @PostMapping("downloadZipFile")
    public ModelAndView downloadZipFile(@RequestParam String dataMap, Authentication authentication) throws Exception {
        
        Gson gson = new Gson();
        JsonArray jsonObj = JsonParser.parseString(dataMap).getAsJsonArray();
        
        List<String> list = gson.fromJson(jsonObj, new TypeToken<List<String>>() {}.getType());
        Map<String, Object> map = new HashMap<>();
        map.put("dataMap", list);
        log.info("" + map);
        List<Map<String, Object>> fileList = webhardService.getdownloadZipFile("file.getFileInfoList", map);
        Map<String, Object> fileMap = new HashMap<>();
        List<Map<String, Object>> dataList = new ArrayList<>();
        for(int i = 0; i < fileList.size(); i++) {
            fileMap = fileList.get(i);
            String path = "";
            if(fileMap != null) {
                path = File.separator + "jhseong112" + File.separator + "tomcat" + File.separator + "webapps" + File.separator + "NAS" + File.separator;
                path += fileMap.get("filePath") + File.separator + fileMap.get("serverName");
            }
            File downloadFile = new File(path);
            Map<String, Object> data = new HashMap<>();
            data.put("model", downloadFile);
            data.put("realName", fileMap.get("realName"));
            if(authentication != null) {
                UserDetails userVo = (UserDetails) authentication.getPrincipal();
                data.put("id", (String) userVo.getUsername());
            }
            dataList.add(data);
        }
        return new ModelAndView("downloadZipView", "downloadFile", dataList);
    }
}
