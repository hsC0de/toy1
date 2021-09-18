package com.cafe24.common.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Component;

import com.cafe24.domain.common.EmailDTO;

@Component
public class EmailService {

    public void sendEmail(EmailDTO emailObject) {
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
        content += "" + emailObject.getComments();
        content += "\n\n\n";
        content += "" + emailObject.getName();
        content += "\n";
        content += "" + emailObject.getEmail();
        content += "\n";
        content += "" + emailObject.getWebsite();
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("cxooxc@mw-002.cafe24.com"));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(emailObject.getAddrRecipient()));
            
            message.setSubject("cxooxc_portfolio 문의 메일");
            message.setText(content);
            
            Transport.send(message);
                    
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
