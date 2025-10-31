package com.abcnews.utils;

import com.abcnews.dao.NewsletterDAO;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

public class AutoNewsletterService {
    
    private static final Logger logger = Logger.getLogger(AutoNewsletterService.class.getName());
    private static NewsletterDAO newsletterDAO = new NewsletterDAO();
    
    /**
     * Gửi thông báo tin tức mới đến tất cả subscriber
     * Đảm bảo lỗi gửi email không ảnh hưởng đến việc đăng tin
     */
    public static void sendNotificationToAllSubscribers() {
        int successCount = 0;
        int failCount = 0;
        List<String> activeEmails = null;
        
        try {
            logger.info("📧 Bắt đầu quá trình gửi email newsletter tự động");
            
            // Lấy danh sách email đã đăng ký và active
            activeEmails = newsletterDAO.getActiveEmailList();
            
            if (activeEmails == null || activeEmails.isEmpty()) {
                logger.info("📧 Không có subscriber nào để gửi email newsletter");
                return;
            }
            
            logger.info("📧 Tìm thấy " + activeEmails.size() + " subscriber active, bắt đầu gửi email...");
            
            // Gửi email đến từng subscriber
            for (String email : activeEmails) {
                try {
                    if (email == null || email.trim().isEmpty()) {
                        logger.warning("📧 Bỏ qua email trống hoặc null");
                        failCount++;
                        continue;
                    }
                    
                    EmailService.sendNewNewsEmail(email.trim());
                    successCount++;
                    logger.fine("📧 Gửi email thành công đến: " + email);
                    
                } catch (Exception emailException) {
                    failCount++;
                    logger.warning("📧 Lỗi gửi email đến " + email + ": " + emailException.getMessage());
                    
                    // Log chi tiết lỗi nếu cần debug
                    if (logger.isLoggable(Level.FINE)) {
                        logger.log(Level.FINE, "Chi tiết lỗi gửi email đến " + email, emailException);
                    }
                }
            }
            
        } catch (Exception daoException) {
            // Lỗi khi lấy danh sách subscriber từ database
            logger.severe("📧 Lỗi nghiêm trọng khi lấy danh sách subscriber: " + daoException.getMessage());
            logger.log(Level.SEVERE, "Chi tiết lỗi DAO", daoException);
            
        } catch (Throwable unexpectedException) {
            // Bắt tất cả lỗi không mong muốn khác
            logger.severe("📧 Lỗi không mong muốn trong AutoNewsletterService: " + unexpectedException.getMessage());
            logger.log(Level.SEVERE, "Chi tiết lỗi không mong muốn", unexpectedException);
            
        } finally {
            // Luôn log kết quả cuối cùng
            int totalAttempted = successCount + failCount;
            
            if (totalAttempted > 0) {
                logger.info("📧 === KẾT QUẢ GỬI EMAIL NEWSLETTER ===");
                logger.info("📧 Tổng số email cần gửi: " + (activeEmails != null ? activeEmails.size() : "N/A"));
                logger.info("📧 Số email gửi thành công: " + successCount);
                logger.info("📧 Số email gửi thất bại: " + failCount);
                logger.info("📧 Tỷ lệ thành công: " + String.format("%.1f%%", (double)successCount / totalAttempted * 100));
                logger.info("📧 === HẾT KẾT QUẢ ===");
                
                // Log cảnh báo nếu tỷ lệ thất bại cao
                if (failCount > 0 && (double)failCount / totalAttempted > 0.5) {
                    logger.warning("📧 CẢNH BÁO: Tỷ lệ gửi email thất bại cao (" + failCount + "/" + totalAttempted + "). Cần kiểm tra cấu hình email!");
                }
            } else {
                logger.info("📧 Không có email nào được gửi (có thể do không có subscriber hoặc lỗi hệ thống)");
            }
        }
    }
}