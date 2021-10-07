package com.cafe24.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cafe24.service.BusLocationService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("api")
@RequiredArgsConstructor
public class BusLocationController {

    private final BusLocationService busLocationService;
    
    @GetMapping("busLocation")
    public String busLocation() {
        return "api/busLocation";
    }
}
