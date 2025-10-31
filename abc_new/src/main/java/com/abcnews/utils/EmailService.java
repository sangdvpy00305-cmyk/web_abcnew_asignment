package com.abcnews.utils;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailService {
    
    // Email gửi đi - THAY BẰNG EMAIL CỦA BẠN
    private static final String FROM_EMAIL = "sangdvpy00305@gmail.com";
    private static final String FROM_PASSWORD = "jvto ubse zkkv ibed";
    
    /**
     * Gửi email thông báo có tin mới với template đẹp
     */
    public static void sendNewNewsEmail(String toEmail) {
        try {
            String subject = "🔥 Tin tức mới từ ABC News";
            String htmlContent = createNewNewsEmailTemplate();
            
            boolean success = sendHtmlEmail(toEmail, subject, htmlContent);
            if (success) {
                System.out.println("✅ Đã gửi email thông báo tin mới đến: " + toEmail);
            } else {
                System.err.println("❌ Lỗi gửi email thông báo tin mới đến: " + toEmail);
            }
            
        } catch (Exception e) {
            System.err.println("❌ Lỗi gửi email thông báo: " + e.getMessage());
        }
    }
    
    /**
     * Tạo template HTML cho email thông báo tin mới
     */
    private static String createNewNewsEmailTemplate() {
        return "<!DOCTYPE html>" +
            "<html>" +
            "<head>" +
            "<meta charset='UTF-8'>" +
            "<meta name='viewport' content='width=device-width, initial-scale=1.0'>" +
            "<title>ABC News - Tin tức mới</title>" +
            "</head>" +
            "<body style='font-family: Arial, sans-serif; line-height: 1.6; margin: 0; padding: 0; background-color: #f4f4f4;'>" +
            "<div style='max-width: 600px; margin: 0 auto; background-color: white; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1);'>" +
            
            "<!-- Header -->" +
            "<div style='text-align: center; padding: 20px 0; border-bottom: 2px solid #dc3545;'>" +
            "<h1 style='color: #dc3545; margin: 0; font-size: 28px;'>" +
            "<span style='font-size: 32px;'>📰</span> ABC News" +
            "</h1>" +
            "<p style='color: #666; margin: 5px 0 0 0;'>Trang tin tức hàng đầu Việt Nam</p>" +
            "</div>" +
            
            "<!-- Content -->" +
            "<div style='padding: 30px 0;'>" +
            "<h2 style='color: #333; text-align: center; margin-bottom: 20px;'>" +
            "🔥 Có tin tức mới đã được đăng!" +
            "</h2>" +
            "<p style='color: #555; font-size: 16px; text-align: center; margin-bottom: 30px;'>" +
            "Chúng tôi vừa đăng tải những tin tức mới nhất. Hãy truy cập ngay để không bỏ lỡ thông tin quan trọng!" +
            "</p>" +
            
            "<!-- CTA Button -->" +
            "<div style='text-align: center; margin: 30px 0;'>" +
            "<a href='http://localhost:7070/abc-new/home' " +
            "style='display: inline-block; background-color: #dc3545; color: white; padding: 15px 30px; " +
            "text-decoration: none; border-radius: 5px; font-weight: bold; font-size: 16px;'>" +
            "📖 Đọc tin tức ngay" +
            "</a>" +
            "</div>" +
            "</div>" +
            
            "<!-- Footer -->" +
            "<div style='border-top: 1px solid #eee; padding-top: 20px; text-align: center; color: #666; font-size: 14px;'>" +
            "<p>Bạn nhận được email này vì đã đăng ký nhận tin tức từ ABC News.</p>" +
            "<p>" +
            "<a href='http://localhost:7070/abc-new/newsletter?action=unsubscribe&email={{EMAIL}}' " +
            "style='color: #dc3545; text-decoration: none;'>Hủy đăng ký</a> | " +
            "<a href='http://localhost:7070/abc-new/home' style='color: #dc3545; text-decoration: none;'>Trang chủ</a>" +
            "</p>" +
            "<p style='margin-top: 15px; color: #999;'>" +
            "&copy; 2024 ABC News. All rights reserved." +
            "</p>" +
            "</div>" +
            
            "</div>" +
            "</body>" +
            "</html>";
    }
    
    /**
     * Gửi email newsletter với tiêu đề và nội dung tùy chỉnh
     */
    public static boolean sendNewsletterEmail(String toEmail, String subject, String content) {
        try {
            String htmlContent = createNewsletterTemplate(subject, content, toEmail);
            return sendHtmlEmail(toEmail, subject, htmlContent);
            
        } catch (Exception e) {
            System.err.println("❌ Lỗi gửi newsletter đến " + toEmail + ": " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Gửi email HTML chung
     */
    private static boolean sendHtmlEmail(String toEmail, String subject, String htmlContent) {
        try {
            // Cấu hình SMTP
            Properties props = new Properties();
            props.setProperty("mail.smtp.auth", "true");
            props.setProperty("mail.smtp.starttls.enable", "true");
            props.setProperty("mail.smtp.host", "smtp.gmail.com");
            props.setProperty("mail.smtp.port", "587");
            props.setProperty("mail.smtp.ssl.trust", "smtp.gmail.com");
            
            // Tạo session
            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(FROM_EMAIL, FROM_PASSWORD);
                }
            });
            
            // Tạo email
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "ABC News"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            
            // Replace placeholder với email thực
            htmlContent = htmlContent.replace("{{EMAIL}}", toEmail);
            
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            // Gửi email
            Transport.send(message);
            return true;
            
        } catch (Exception e) {
            System.err.println("❌ Lỗi gửi email HTML: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Tạo template HTML cho newsletter tùy chỉnh
     */
    private static String createNewsletterTemplate(String subject, String content, String email) {
        return "<!DOCTYPE html>" +
            "<html>" +
            "<head>" +
            "<meta charset='UTF-8'>" +
            "<meta name='viewport' content='width=device-width, initial-scale=1.0'>" +
            "<title>" + subject + "</title>" +
            "</head>" +
            "<body style='font-family: Arial, sans-serif; line-height: 1.6; margin: 0; padding: 0; background-color: #f4f4f4;'>" +
            "<div style='max-width: 600px; margin: 0 auto; background-color: white; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1);'>" +
            
            "<!-- Header -->" +
            "<div style='text-align: center; padding: 20px 0; border-bottom: 2px solid #28a745;'>" +
            "<h1 style='color: #28a745; margin: 0; font-size: 28px;'>" +
            "<span style='font-size: 32px;'>📧</span> ABC News Newsletter" +
            "</h1>" +
            "</div>" +
            
            "<!-- Content -->" +
            "<div style='padding: 30px 0;'>" +
            "<h2 style='color: #333; margin-bottom: 20px;'>" + subject + "</h2>" +
            "<div style='color: #555; font-size: 16px; line-height: 1.8;'>" +
            content.replace("\n", "<br>") +
            "</div>" +
            "</div>" +
            
            "<!-- Footer -->" +
            "<div style='border-top: 1px solid #eee; padding-top: 20px; text-align: center; color: #666; font-size: 14px;'>" +
            "<p>Bạn nhận được email này vì đã đăng ký newsletter của ABC News.</p>" +
            "<p>" +
            "<a href='http://localhost:7070/abc-new/newsletter?action=unsubscribe&email=" + email + "' " +
            "style='color: #28a745; text-decoration: none;'>Hủy đăng ký</a> | " +
            "<a href='http://localhost:7070/abc-new/home' style='color: #28a745; text-decoration: none;'>Trang chủ</a>" +
            "</p>" +
            "<p style='margin-top: 15px; color: #999;'>" +
            "&copy; 2024 ABC News. All rights reserved." +
            "</p>" +
            "</div>" +
            
            "</div>" +
            "</body>" +
            "</html>";
    }
}