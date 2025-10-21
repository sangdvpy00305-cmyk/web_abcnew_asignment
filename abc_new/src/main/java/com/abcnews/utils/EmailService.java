package com.abcnews.utils;

import java.util.Properties;
import java.util.Date;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailService {
    
    // ===== CẤU HÌNH EMAIL CỦA BẠN - ĐIỀN VÀO ĐÂY =====
    private static final String FROM_EMAIL = "sangdvpy00305@gmail.com";  // Thay bằng email của bạn
    private static final String FROM_PASSWORD = "jvto ubse zkkv ibed";   // Thay bằng App Password của bạn
    private static final String FROM_NAME = "ABC News";
    
    // SMTP Settings cho Gmail
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    
    // Email configuration properties
    private static Properties emailConfig;
    
    static {
        emailConfig = new Properties();
        try {
            InputStream input = EmailService.class.getClassLoader().getResourceAsStream("email.properties");
            if (input != null) {
                emailConfig.load(input);
            } else {
                // Default configuration if file not found
                emailConfig.setProperty("email.username", FROM_EMAIL);
                emailConfig.setProperty("email.password", FROM_PASSWORD);
                emailConfig.setProperty("email.from.address", FROM_EMAIL);
                emailConfig.setProperty("email.from.name", FROM_NAME);
                emailConfig.setProperty("smtp.host", SMTP_HOST);
                emailConfig.setProperty("smtp.port", SMTP_PORT);
                emailConfig.setProperty("smtp.auth", "true");
                emailConfig.setProperty("smtp.starttls.enable", "true");
            }
        } catch (Exception e) {
            System.err.println("Lỗi load email config: " + e.getMessage());
            // Set default values
            emailConfig.setProperty("email.username", FROM_EMAIL);
            emailConfig.setProperty("email.password", FROM_PASSWORD);
            emailConfig.setProperty("email.from.address", FROM_EMAIL);
            emailConfig.setProperty("email.from.name", FROM_NAME);
            emailConfig.setProperty("smtp.host", SMTP_HOST);
            emailConfig.setProperty("smtp.port", SMTP_PORT);
            emailConfig.setProperty("smtp.auth", "true");
            emailConfig.setProperty("smtp.starttls.enable", "true");
        }
    }
    
    /**
     * Gửi email xác nhận đăng ký newsletter
     */
    public static boolean sendWelcomeEmail(String toEmail) {
        String subject = "Chào mừng bạn đến với ABC News!";
        
        String htmlContent = buildWelcomeEmailContent(toEmail);
        
        return sendEmail(toEmail, subject, htmlContent, true);
    }
    
    /**
     * Gửi newsletter với nội dung tin tức
     */
    public static boolean sendNewsletterEmail(String toEmail, String subject, String content) {
        String htmlContent = buildNewsletterContent(toEmail, subject, content);
        
        return sendEmail(toEmail, subject, htmlContent, true);
    }
    
    /**
     * Gửi email thông báo hủy đăng ký
     */
    public static boolean sendUnsubscribeConfirmation(String toEmail) {
        String subject = "Xác nhận hủy đăng ký - ABC News";
        String htmlContent = buildUnsubscribeContent(toEmail);
        
        return sendEmail(toEmail, subject, htmlContent, true);
    }
    
    /**
     * Gửi email cơ bản
     */
    public static boolean sendEmail(String toEmail, String subject, String content, boolean isHtml) {
        try {
            // Kiểm tra cấu hình
            String username = emailConfig.getProperty("email.username");
            String password = emailConfig.getProperty("email.password");
            
            if (username == null || password == null || 
                username.equals("your-email@gmail.com") || 
                password.equals("your-app-password")) {
                System.err.println("⚠️ CẢNH BÁO: Chưa cấu hình email! Vui lòng cập nhật file email.properties");
                return false;
            }
            
            // Tạo properties cho SMTP
            Properties props = new Properties();
            props.put("mail.smtp.host", emailConfig.getProperty("smtp.host", "smtp.gmail.com"));
            props.put("mail.smtp.port", emailConfig.getProperty("smtp.port", "587"));
            props.put("mail.smtp.auth", emailConfig.getProperty("smtp.auth", "true"));
            props.put("mail.smtp.starttls.enable", emailConfig.getProperty("smtp.starttls.enable", "true"));
            
            // Tạo session với authentication
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });
            
            // Tạo message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(
                emailConfig.getProperty("email.from.address", username),
                emailConfig.getProperty("email.from.name", "ABC News")
            ));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setSentDate(new Date());
            
            if (isHtml) {
                message.setContent(content, "text/html; charset=utf-8");
            } else {
                message.setText(content);
            }
            
            // Gửi email
            Transport.send(message);
            System.out.println("✅ Đã gửi email thành công đến: " + toEmail);
            return true;
            
        } catch (Exception e) {
            System.err.println("❌ Lỗi gửi email đến " + toEmail + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Tạo nội dung email chào mừng
     */
    private static String buildWelcomeEmailContent(String email) {
        String unsubscribeUrl = "http://localhost:8080/abc_new/unsubscribe?email=" + 
                               URLEncoder.encode(email, StandardCharsets.UTF_8);
        
        return "<!DOCTYPE html>" +
            "<html>" +
            "<head>" +
                "<meta charset=\"UTF-8\">" +
                "<style>" +
                    "body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }" +
                    ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
                    ".header { background: linear-gradient(135deg, #c41e3a, #a01729); color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }" +
                    ".content { background: white; padding: 30px; border: 1px solid #ddd; }" +
                    ".footer { background: #f8f9fa; padding: 20px; text-align: center; border-radius: 0 0 10px 10px; font-size: 12px; color: #666; }" +
                    ".button { display: inline-block; background: #c41e3a; color: white; padding: 12px 24px; text-decoration: none; border-radius: 5px; margin: 10px 0; }" +
                    ".logo { font-size: 2rem; font-weight: bold; margin-bottom: 10px; }" +
                "</style>" +
            "</head>" +
            "<body>" +
                "<div class=\"container\">" +
                    "<div class=\"header\">" +
                        "<div class=\"logo\">📰 ABC NEWS</div>" +
                        "<h2>Chào mừng bạn đến với ABC News!</h2>" +
                    "</div>" +
                    "<div class=\"content\">" +
                        "<h3>Xin chào!</h3>" +
                        "<p>Cảm ơn bạn đã đăng ký nhận tin tức từ <strong>ABC News</strong>!</p>" +
                        "<p>Từ bây giờ, bạn sẽ nhận được:</p>" +
                        "<ul>" +
                            "<li>📰 Tin tức mới nhất hàng ngày</li>" +
                            "<li>🔥 Tin nóng và sự kiện quan trọng</li>" +
                            "<li>📊 Phân tích chuyên sâu</li>" +
                            "<li>🎯 Nội dung được cá nhân hóa</li>" +
                        "</ul>" +
                        "<p>Email đăng ký: <strong>" + email + "</strong></p>" +
                        "<p>Chúng tôi cam kết:</p>" +
                        "<ul>" +
                            "<li>✅ Chỉ gửi nội dung chất lượng cao</li>" +
                            "<li>✅ Không spam, không bán thông tin</li>" +
                            "<li>✅ Bạn có thể hủy đăng ký bất cứ lúc nào</li>" +
                        "</ul>" +
                        "<div style=\"text-align: center; margin: 30px 0;\">" +
                            "<a href=\"http://localhost:8080/abc_new/home\" class=\"button\">" +
                                "🏠 Truy cập ABC News ngay" +
                            "</a>" +
                        "</div>" +
                        "<p>Cảm ơn bạn đã tin tưởng ABC News!</p>" +
                        "<p><strong>Đội ngũ ABC News</strong></p>" +
                    "</div>" +
                    "<div class=\"footer\">" +
                        "<p>Bạn nhận được email này vì đã đăng ký newsletter tại ABC News.</p>" +
                        "<p><a href=\"" + unsubscribeUrl + "\">Hủy đăng ký</a> | " +
                           "<a href=\"http://localhost:8080/abc_new/home\">Trang chủ</a></p>" +
                        "<p>&copy; 2024 ABC News. All rights reserved.</p>" +
                    "</div>" +
                "</div>" +
            "</body>" +
            "</html>";
    }
    
    /**
     * Tạo nội dung newsletter
     */
    private static String buildNewsletterContent(String email, String subject, String content) {
        String unsubscribeUrl = "http://localhost:8080/abc_new/unsubscribe?email=" + 
                               URLEncoder.encode(email, StandardCharsets.UTF_8);
        
        return "<!DOCTYPE html>" +
            "<html>" +
            "<head>" +
                "<meta charset=\"UTF-8\">" +
                "<style>" +
                    "body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }" +
                    ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
                    ".header { background: linear-gradient(135deg, #c41e3a, #a01729); color: white; padding: 20px; text-align: center; border-radius: 10px 10px 0 0; }" +
                    ".content { background: white; padding: 30px; border: 1px solid #ddd; }" +
                    ".footer { background: #f8f9fa; padding: 20px; text-align: center; border-radius: 0 0 10px 10px; font-size: 12px; color: #666; }" +
                    ".logo { font-size: 1.5rem; font-weight: bold; }" +
                "</style>" +
            "</head>" +
            "<body>" +
                "<div class=\"container\">" +
                    "<div class=\"header\">" +
                        "<div class=\"logo\">📰 ABC NEWS</div>" +
                        "<h3>" + subject + "</h3>" +
                    "</div>" +
                    "<div class=\"content\">" +
                        content +
                    "</div>" +
                    "<div class=\"footer\">" +
                        "<p>Bạn nhận được email này vì đã đăng ký newsletter tại ABC News.</p>" +
                        "<p><a href=\"" + unsubscribeUrl + "\">Hủy đăng ký</a> | " +
                           "<a href=\"http://localhost:8080/abc_new/home\">Trang chủ</a></p>" +
                        "<p>&copy; 2024 ABC News. All rights reserved.</p>" +
                    "</div>" +
                "</div>" +
            "</body>" +
            "</html>";
    }
    
    /**
     * Tạo nội dung email hủy đăng ký
     */
    private static String buildUnsubscribeContent(String email) {
        return "<!DOCTYPE html>" +
            "<html>" +
            "<head>" +
                "<meta charset=\"UTF-8\">" +
                "<style>" +
                    "body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }" +
                    ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
                    ".header { background: #6c757d; color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }" +
                    ".content { background: white; padding: 30px; border: 1px solid #ddd; }" +
                    ".footer { background: #f8f9fa; padding: 20px; text-align: center; border-radius: 0 0 10px 10px; font-size: 12px; color: #666; }" +
                    ".logo { font-size: 2rem; font-weight: bold; margin-bottom: 10px; }" +
                "</style>" +
            "</head>" +
            "<body>" +
                "<div class=\"container\">" +
                    "<div class=\"header\">" +
                        "<div class=\"logo\">📰 ABC NEWS</div>" +
                        "<h2>Xác nhận hủy đăng ký</h2>" +
                    "</div>" +
                    "<div class=\"content\">" +
                        "<h3>Chúng tôi rất tiếc!</h3>" +
                        "<p>Email <strong>" + email + "</strong> đã được hủy khỏi danh sách nhận tin tức ABC News.</p>" +
                        "<p>Bạn sẽ không còn nhận được email newsletter từ chúng tôi nữa.</p>" +
                        "<p>Nếu bạn thay đổi ý định, có thể đăng ký lại bất cứ lúc nào tại " +
                           "<a href=\"http://localhost:8080/abc_new/home\">trang chủ ABC News</a>.</p>" +
                        "<p>Cảm ơn bạn đã đồng hành cùng ABC News!</p>" +
                        "<p><strong>Đội ngũ ABC News</strong></p>" +
                    "</div>" +
                    "<div class=\"footer\">" +
                        "<p><a href=\"http://localhost:8080/abc_new/home\">Quay lại ABC News</a></p>" +
                        "<p>&copy; 2024 ABC News. All rights reserved.</p>" +
                    "</div>" +
                "</div>" +
            "</body>" +
            "</html>";
    }
    
    /**
     * Kiểm tra cấu hình email
     */
    public static boolean isEmailConfigured() {
        String username = emailConfig.getProperty("email.username");
        String password = emailConfig.getProperty("email.password");
        
        return username != null && password != null && 
               !username.equals("your-email@gmail.com") && 
               !password.equals("your-app-password");
    }
    
    /**
     * Lấy thông tin cấu hình email (để debug)
     */
    public static String getEmailConfigInfo() {
        return "SMTP Host: " + emailConfig.getProperty("smtp.host") + 
               ", Port: " + emailConfig.getProperty("smtp.port") +
               ", Username: " + emailConfig.getProperty("email.username") +
               ", Configured: " + isEmailConfigured();
    }
}