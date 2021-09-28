package com.cafe24.service;

import org.springframework.stereotype.Service;

import com.cafe24.repository.CommonDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class WebHardService {

    public final CommonDao dao;
}
