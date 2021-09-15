package com.cafe24.service;

import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe24.repository.CommonDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class HomeService {

    public final CommonDao dao;
    
    @Transactional
    public void regTodoList(String statement, Map<String, Object> condition) {
        dao.insert(statement, condition);
    }
    
    public List<Map<String, Object>> getTodoList(String statement, Map<String, Object> condition) {
        return dao.selectList(statement, condition);
    }
    
    @Transactional
    public void deleteTodoList(String statement, Map<String, Object> condition) {
        dao.update(statement, condition);
    }
    
    @Transactional
    public void doneTodoList(String statement, Map<String, Object> condition) {
        dao.update(statement, condition);
    }
    
    public void emailMe(Map<String, Object> map) {
        final String username = System.getProperty("emailid");
        final String password = System.getProperty("emailpw");
        
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "mw-002.cafe24.com");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");
        
        Session session = Session.getInstance(prop,
            new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            }
        );
        
        String content = "";
        content += "" + map.get("comments");
        content += "\n\n\n";
        content += "" + map.get("name");
        content += "\n";
        content += "" + map.get("email");
        content += "\n";
        content += "" + map.get("website");
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("cxooxc@mw-002.cafe24.com"));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse("jhseong112@naver.com"));
            
            message.setSubject("cxooxc_portfolio 문의 메일");
            message.setText(content);
            
            Transport.send(message);
                    
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
