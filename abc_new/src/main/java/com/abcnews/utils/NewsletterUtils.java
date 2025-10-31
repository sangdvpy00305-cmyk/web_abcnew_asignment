package com.abcnews.utils;

import com.abcnews.dao.NewsletterDAO;
import com.abcnews.model.Newsletter;

import java.sql.Timestamp;
import java.util.List;
import java.util.regex.Pattern;

/**
 * NewsletterUtils - Utility class để quản lý newsletter
 */
public class NewsletterUtils {
    
    private static final NewsletterDAO newsletterDAO = new NewsletterDAO();
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    
    /**
     * Đăng ký newsletter với validation
     */
    public static NewsletterResult subscribeNewsletter(String email) {
        NewsletterResult result = new NewsletterResult();
        
        try {
            System.out.println("📧 NewsletterUtils - Starting subscription for: " + email);
            
            // Validate email
            if (!isValidEmail(email)) {
                System.out.println("❌ NewsletterUtils - Invalid email format: " + email);
                result.setSuccess(false);
                result.setMessage("Email không hợp lệ");
                result.setErrorCode("INVALID_EMAIL");
                return result;
            }
            
            email = email.trim().toLowerCase();
            System.out.println("📧 NewsletterUtils - Normalized email: " + email);
            
            // Kiểm tra email đã tồn tại
            Newsletter existing = newsletterDAO.getByEmail(email);
            System.out.println("📧 NewsletterUtils - Existing newsletter: " + (existing != null ? "found" : "not found"));
            
            if (existing != null) {
                System.out.println("📧 NewsletterUtils - Existing enabled status: " + existing.getEnabled());
                if (existing.getEnabled() != null && existing.getEnabled() == 1) {
                    result.setSuccess(true); // Thay đổi thành success thay vì error
                    result.setMessage("Email đã được đăng ký trước đó");
                    result.setErrorCode("ALREADY_SUBSCRIBED");
                    return result;
                } else {
                    // Kích hoạt lại subscription
                    System.out.println("📧 NewsletterUtils - Reactivating subscription for: " + email);
                    boolean success = newsletterDAO.reactivateSubscription(email);
                    result.setSuccess(success);
                    result.setMessage(success ? "Đã kích hoạt lại đăng ký thành công" : "Lỗi kích hoạt lại đăng ký");
                    result.setErrorCode(success ? "SUCCESS" : "REACTIVATION_FAILED");
                    return result;
                }
            }
            
            // Tạo newsletter mới
            System.out.println("📧 NewsletterUtils - Creating new newsletter for: " + email);
            Newsletter newsletter = new Newsletter();
            newsletter.setId(String.valueOf(System.currentTimeMillis()));
            newsletter.setEmail(email);
            newsletter.setSubscribedAt(new Timestamp(System.currentTimeMillis()));
            newsletter.setEnabled(1);
            
            boolean success = newsletterDAO.addNewsletter(newsletter);
            System.out.println("📧 NewsletterUtils - Add newsletter result: " + success);
            
            result.setSuccess(success);
            result.setMessage(success ? "Đăng ký newsletter thành công" : "Lỗi đăng ký newsletter");
            result.setErrorCode(success ? "SUCCESS" : "SUBSCRIPTION_FAILED");
            
        } catch (Exception e) {
            System.err.println("❌ NewsletterUtils - Exception: " + e.getMessage());
            e.printStackTrace();
            result.setSuccess(false);
            result.setMessage("Lỗi hệ thống: " + e.getMessage());
            result.setErrorCode("SYSTEM_ERROR");
        }
        
        return result;
    }
    
    /**
     * Hủy đăng ký newsletter
     */
    public static NewsletterResult unsubscribeNewsletter(String email) {
        NewsletterResult result = new NewsletterResult();
        
        try {
            if (!isValidEmail(email)) {
                result.setSuccess(false);
                result.setMessage("Email không hợp lệ");
                result.setErrorCode("INVALID_EMAIL");
                return result;
            }
            
            email = email.trim().toLowerCase();
            boolean success = newsletterDAO.unsubscribe(email);
            result.setSuccess(success);
            result.setMessage(success ? "Hủy đăng ký thành công" : "Lỗi hủy đăng ký");
            result.setErrorCode(success ? "SUCCESS" : "UNSUBSCRIBE_FAILED");
            
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("Lỗi hệ thống: " + e.getMessage());
            result.setErrorCode("SYSTEM_ERROR");
        }
        
        return result;
    }
    
    /**
     * Lấy danh sách email active để gửi newsletter
     */
    public static List<String> getActiveEmailList() {
        try {
            return newsletterDAO.getActiveEmailList();
        } catch (Exception e) {
            System.err.println("Lỗi lấy danh sách email: " + e.getMessage());
            return null;
        }
    }
    
    /**
     * Validate email format
     */
    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        
        email = email.trim();
        
        // Kiểm tra độ dài
        if (email.length() > 255) {
            return false;
        }
        
        // Kiểm tra format cơ bản
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            return false;
        }
        
        // Kiểm tra có ít nhất một dấu chấm sau @
        String[] parts = email.split("@");
        if (parts.length != 2) {
            return false;
        }
        
        String domain = parts[1];
        return domain.contains(".") && domain.length() > 3;
    }
    
    /**
     * Inner class để trả về kết quả
     */
    public static class NewsletterResult {
        private boolean success;
        private String message;
        private String errorCode;
        
        public boolean isSuccess() { return success; }
        public void setSuccess(boolean success) { this.success = success; }
        
        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }
        
        public String getErrorCode() { return errorCode; }
        public void setErrorCode(String errorCode) { this.errorCode = errorCode; }
    }
} 