package com.cafe24.common.view;

import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class DownloadZipView extends AbstractView {

    public DownloadZipView() {
        log.info("DownloadView 생성자 == ");
        setContentType("application/download; charset=utf-8");
    }
    
    @Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        log.info("DownloadView.renderMergedOutputModel ==");
        List<Map<String, Object>> list = (List<Map<String, Object>>) model.get("downloadFile");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = sdf.format(date);
        String zipName = str;
        
        ServletOutputStream out = response.getOutputStream();
        ZipOutputStream zos = new ZipOutputStream(out);
        zos.setEncoding("EUC-KR");
        
        response.setContentType("application/zip");
        response.addHeader("Content-Disposition", "attachment; filename=" + zipName + ".zip");
                
        for(int i = 0; i < list.size(); i++) {
            String fileName = (String) list.get(i).get("realName");
            ZipEntry ze = new ZipEntry(fileName);
            zos.putNextEntry(ze);
            File file = (File) list.get(i).get("model");
            FileInputStream fin = new FileInputStream(file);
            IOUtils.copy(fin, zos);
            zos.closeEntry();
            fin.close();
        }
        zos.finish();

        
    }
}
