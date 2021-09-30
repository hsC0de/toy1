package com.cafe24.controller;

import java.util.ArrayList;
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
    @PostMapping("upload")
    @ResponseBody
    public String upload(MultipartFile[] uploadFile, Authentication authentication, HttpServletRequest req) {
        String uri = req.getHeader("Referer");
        log.info(uri);
        String intersection = "board";
        if(!uri.contains("/board")) {
            intersection = "file";
        }
//        log.info("" + uploadFile);
        webhardService.upload(uploadFile, authentication, intersection);
        
        return "ok";
    }
}
