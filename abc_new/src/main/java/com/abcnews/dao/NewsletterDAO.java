package com.abcnews.dao;

import com.abcnews.model.Newsletter;
import com.abcnews.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NewsletterDAO {
    
    // Lấy tất cả email đăng ký
    public List<Newsletter> getAllNewsletters() {
        List<Newsletter> newsletters = new ArrayList<>();
        String sql = "SELECT Email, Enabled FROM NEWSLETTERS ORDER BY Email";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Newsletter newsletter = new Newsletter();
                newsletter.setEmail(rs.getString("Email"));
                newsletter.setEnabled(rs.getInt("Enabled"));
                newsletters.add(newsletter);
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi lấy danh sách newsletter: " + e.getMessage());
            e.printStackTrace();
        }
        return newsletters;
    }
    
    // Lấy danh sách email đã kích hoạt
    public List<Newsletter> getActiveNewsletters() {
        List<Newsletter> newsletters = new ArrayList<>();
        String sql = "SELECT Email, Enabled FROM NEWSLETTERS WHERE Enabled = 1 ORDER BY Email";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Newsletter newsletter = new Newsletter();
                newsletter.setEmail(rs.getString("Email"));
                newsletter.setEnabled(rs.getInt("Enabled"));
                newsletters.add(newsletter);
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi lấy newsletter đã kích hoạt: " + e.getMessage());
            e.printStackTrace();
        }
        return newsletters;
    }
    
    // Lấy newsletter theo email
    public Newsletter getNewsletterByEmail(String email) {
        String sql = "SELECT Email, Enabled FROM NEWSLETTERS WHERE Email = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Newsletter newsletter = new Newsletter();
                newsletter.setEmail(rs.getString("Email"));
                newsletter.setEnabled(rs.getInt("Enabled"));
                return newsletter;
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi lấy newsletter: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    // Alias method for servlet compatibility
    public Newsletter getByEmail(String email) {
        return getNewsletterByEmail(email);
    }
    
    // Kích hoạt lại đăng ký
    public boolean reactivateSubscription(String email) {
        return updateNewsletterStatus(email, 1);
    }
    
    // Đăng ký newsletter
    public boolean subscribe(String email) {
        // Kiểm tra email đã tồn tại chưa
        if (isEmailExists(email)) {
            // Nếu đã tồn tại, kích hoạt lại
            return updateNewsletterStatus(email, 1);
        } else {
            // Nếu chưa tồn tại, thêm mới
            return addNewsletter(new Newsletter(email, 1));
        }
    }
    
    // Hủy đăng ký newsletter
    public boolean unsubscribe(String email) {
        return updateNewsletterStatus(email, 0);
    }
    
    // Thêm newsletter mới
    public boolean addNewsletter(Newsletter newsletter) {
        String sql = "INSERT INTO NEWSLETTERS (Email, Enabled) VALUES (?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, newsletter.getEmail());
            stmt.setInt(2, newsletter.getEnabled() != null ? newsletter.getEnabled() : 1);
            
            int result = stmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Lỗi thêm newsletter: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Cập nhật trạng thái newsletter
    public boolean updateNewsletterStatus(String email, Integer enabled) {
        String sql = "UPDATE NEWSLETTERS SET Enabled = ? WHERE Email = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, enabled);
            stmt.setString(2, email);
            
            int result = stmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Lỗi cập nhật newsletter: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Xóa newsletter
    public boolean deleteNewsletter(String email) {
        String sql = "DELETE FROM NEWSLETTERS WHERE Email = ?";
        try {
            int result = DatabaseConnection.executeUpdate(sql, email);
            return result > 0;
        } catch (Exception e) {
            System.err.println("Lỗi xóa newsletter: " + e.getMessage());
            return false;
        }
    }
    
    // Kiểm tra email đã tồn tại
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM NEWSLETTERS WHERE Email = ?";
        try (ResultSet rs = DatabaseConnection.executeQuery(sql, email)) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi kiểm tra email: " + e.getMessage());
        }
        return false;
    }
    
    // Đếm số lượng email đã đăng ký
    public int countActiveSubscribers() {
        String sql = "SELECT COUNT(*) FROM NEWSLETTERS WHERE Enabled = 1";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi đếm active subscribers: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }
    
    // Lấy danh sách email để gửi newsletter
    public List<String> getActiveEmailList() {
        List<String> emails = new ArrayList<>();
        String sql = "SELECT Email FROM NEWSLETTERS WHERE Enabled = 1";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                emails.add(rs.getString("Email"));
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi lấy danh sách email: " + e.getMessage());
            e.printStackTrace();
        }
        return emails;
    }
    

    
    // Lấy số subscribers đang hoạt động (cho admin)
    public int getActiveSubscribers() {
        String sql = "SELECT COUNT(*) FROM NEWSLETTERS WHERE Enabled = 1";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi đếm active subscribers: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }
    
    // Lấy tổng số subscribers (cho admin)
    public int getTotalSubscribers() {
        String sql = "SELECT COUNT(*) FROM NEWSLETTERS";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi đếm tổng subscribers: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }
}