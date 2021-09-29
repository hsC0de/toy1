package com.cafe24.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe24.domain.AuthVO;
import com.cafe24.domain.PageDTO;
import com.cafe24.service.BoardService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("board")
@RequiredArgsConstructor
public class BoardController {

    private final BoardService boardService;
    
    @GetMapping("list")
    public String list(PageDTO map, String sortLike, Model model, Authentication authentication) {
        Map<String, List<Map<String, Object>>> resultMap = new HashMap<>();

        Map<String, Object> toMap = new ObjectMapper().convertValue(map, Map.class);
        if(sortLike != null) {
            toMap.put("sortLike", sortLike);
            model.addAttribute("sortLike", sortLike);
        }
        resultMap = boardService.boardList("board.getBoardList", toMap);
        Map<String, Object> paging = boardService.getTotal("board.getTotal", toMap);
        Map<String, Object> kind_nm = boardService.getMenuNm("board.getMenuNm", toMap);
        
        model.addAttribute("list", resultMap);
        model.addAttribute("paging", paging);
        model.addAttribute("kind", map.getKind());
        model.addAttribute("kind_nm", kind_nm);
        model.addAttribute("userDisplay", map.getUserDisplay());
        return "board/list";
    }
    
    @GetMapping("dashBoard")
    @ResponseBody
    public List<Map<String, Object>> getDashBoard(@RequestParam String kind) {
        List<Map<String, Object>> resultList = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        map.put("kind", kind);
        resultList = boardService.getDashBoard("board.getDashBoard", map);
        return resultList;
    }
    
    @GetMapping("get")
    public String get(PageDTO map, Model model, Authentication authentication) throws JsonProcessingException {
        String result = "board/get";
        Map<String, Object> resultMap = new HashMap<>();
        Map<String, Object> toMap = new ObjectMapper().convertValue(map, Map.class);
        resultMap = boardService.get("board.getBoardContent", toMap, authentication);
        if(resultMap == null) {
            result = "redirect:/error/commonException";
        }
        resultMap.put("paging", toMap);
        String json = new ObjectMapper().writeValueAsString(resultMap);
        model.addAttribute("boardHtml", resultMap);
        model.addAttribute("board", json);
        return result;
    }
    
    @PreAuthorize("isAuthenticated()")
    @GetMapping("writing")
    public String writing(@RequestParam Map<String, Object> map, Model model, Authentication authentication) throws JsonProcessingException {
        String json = new ObjectMapper().writeValueAsString(boardService.writing(map, authentication));
        log.info(json);
        model.addAttribute("boardInfo", json);
        return "board/writing";
    }
    
    @PreAuthorize("isAuthenticated()")
    @PostMapping(value="regPost", produces=MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public String regPost(@RequestParam Map<String, Object> map, Authentication authentication) {
        log.info("" + map);
        String result = "";
        Map<String, Object> resultMap = new HashMap<>();
        String userAuth = "";
        boolean auth = false;
        
        if(authentication != null) {
            UserDetails userVo = (UserDetails) authentication.getPrincipal();
            Collection<? extends GrantedAuthority> auths = userVo.getAuthorities();
            userAuth = auths.toArray()[0].toString();
            userAuth = AuthVO.sortAuthName(userAuth.toString());
        }
        
        if("매니저".equals(userAuth) || "관리자".equals(userAuth)) {
            auth = true;
        }
        
        if(!"BN".equals(map.get("kind")) && "N".equals(map.get("type"))) {
            resultMap = boardService.regPost("board.insertPost", map);
            result = "/board/get?bno=" + resultMap.get("bno") + "&page=1&userDisplay=10&kind=" + resultMap.get("kind");
        }
        else {
            if(auth) {
                resultMap = boardService.regPost("board.insertPost", map);
                result = "/board/get?bno=" + resultMap.get("bno") + "&page=1&userDisplay=10&kind=" + resultMap.get("kind");
            }
            else {
                result = "권한이 없습니다.";
            }
        }
        
        return result;
    }
    
    @PreAuthorize("isAuthenticated() and principal.username == #id")
    @GetMapping("modify/{bno}")
    public String modify(@PathVariable("bno") long bno, @RequestParam String kind, String id, Model model, Authentication authentication) throws JsonProcessingException {
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> resultMap = new HashMap<>();
        map.put("bno", bno);
        map.put("kind", kind);
        resultMap = boardService.get("board.getBoardContent", map, authentication);
        String json = new ObjectMapper().writeValueAsString(resultMap);
        model.addAttribute("board", json);
        
        return "board/writing";
    }
    
    @PreAuthorize("isAuthenticated() and principal.username == #id")
    @PostMapping(value="modifyPost", produces=MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public String modifyPost(@RequestParam Map<String, Object> map, @RequestParam("id") String id, Authentication authentication) {
        log.info(id);
//        boardService.modifyPost("board.updatePost", map);
        String result = "";
        String userAuth = "";
        boolean auth = false;
        
        if(authentication != null) {
            UserDetails userVo = (UserDetails) authentication.getPrincipal();
            Collection<? extends GrantedAuthority> auths = userVo.getAuthorities();
            userAuth = auths.toArray()[0].toString();
            userAuth = AuthVO.sortAuthName(userAuth.toString());
        }
        
        if("매니저".equals(userAuth) || "관리자".equals(userAuth)) {
            auth = true;
        }
        
        if(!"BN".equals(map.get("kind")) && "N".equals(map.get("type"))) {
            boardService.modifyPost("board.updatePost", map);
            result = "ok";
        }
        else {
            if(auth) {
                boardService.modifyPost("board.updatePost", map);
                result = "ok";
            }
            else {
                result = "권한이 없습니다.";
            }
        }
        
        return result;
    }
    
    @PreAuthorize("isAuthenticated() and principal.username == #id")
    @GetMapping("delete/{bno}")
    public String delete(@PathVariable("bno") long bno, String id, PageDTO pageMap, Model model) {
        Map<String, Object> map = new HashMap<>();
        map.put("bno", bno);
        boardService.delete("board.delete", map);
        return "redirect:/board/list" + pageMap.getListLink();
    }
    
    @PreAuthorize("isAuthenticated() and principal.username == #id")
    @PostMapping("like")
    @ResponseBody
    public Map<String, Object> like(@RequestParam Map<String, Object> map, @RequestParam("id") String id) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap = boardService.like("board.insertLike", map);
        return resultMap;
    }
    
    @PreAuthorize("isAuthenticated() and principal.username == #id")
    @PostMapping("deleteLike")
    @ResponseBody
    public Map<String, Object> deleteLike(@RequestParam Map<String, Object> map, @RequestParam("id") String id) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap = boardService.deleteLike("board.deleteLike", map);
        return resultMap;
    }
}
