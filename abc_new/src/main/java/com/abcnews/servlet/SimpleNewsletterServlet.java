package com.abcnews.servlet;

import com.abcnews.utils.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Pattern;

@WebServlet("/simple-newsletter")
public class SimpleNewsletterServlet extends HttpServlet {
    
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(HttpServletResponse.SC_OK);
        
        try {
            String email = request.getParameter("email");
            String action = request.getParameter("action");
            
            System.out.println("📧 SimpleNewsletter - Processing: " + action + " for " + email);
            
            // Validation
            if (email == null || email.trim().isEmpty()) {
                response.getWriter().print("error_empty_email");
                return;
            }
            
            if (!"subscribe".equals(action)) {
                response.getWriter().print("error_invalid_action");
                return;
            }
            
            email = email.trim().toLowerCase();
            
            // Validate email format
            if (!isValidEmail(email)) {
                response.getWriter().print("error_invalid_email");
                return;
            }
            
            // Process subscription
            String result = subscribeEmail(email);
            response.getWriter().print(result);
            
        } catch (Exception e) {
            System.err.println("❌ SimpleNewsletter error: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().print("error");
        }
    }
    
    private boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        
        email = email.trim();
        
        if (email.length() > 255) {
            return false;
        }
        
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            return false;
        }
        
        String[] parts = email.split("@");
        if (parts.length != 2) {
            return false;
        }
        
        String domain = parts[1];
        return domain.contains(".") && domain.length() > 3;
    }
    
    private String subscribeEmail(String email) {
        Connection conn = null;
        PreparedStatement checkStmt = null;
        PreparedStatement insertStmt = null;
        PreparedStatement updateStmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            
            // Kiểm tra email đã tồn tại chưa
            String checkSql = "SELECT Enabled, IsActive FROM NEWSLETTERS WHERE Email = ?";
            checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, email);
            rs = checkStmt.executeQuery();
            
            if (rs.next()) {
                // Email đã tồn tại
                int enabled = rs.getInt("Enabled");
                int isActive = rs.getInt("IsActive");
                
                if (enabled == 1 && isActive == 1) {
                    System.out.println("📧 Email already subscribed: " + email);
                    return "error_already_subscribed";
                } else {
                    // Kích hoạt lại
                    String updateSql = "UPDATE NEWSLETTERS SET Enabled = 1, IsActive = 1 WHERE Email = ?";
                    updateStmt = conn.prepareStatement(updateSql);
                    updateStmt.setString(1, email);
                    int updated = updateStmt.executeUpdate();
                    
                    if (updated > 0) {
                        System.out.println("📧 Reactivated subscription: " + email);
                        return "success";
                    } else {
                        return "error";
                    }
                }
            } else {
                // Email chưa tồn tại, thêm mới với UUID
                String insertSql = "INSERT INTO NEWSLETTERS (Id, Email, SubscribedAt, IsActive, Enabled) VALUES (NEWID(), ?, GETDATE(), 1, 1)";
                insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setString(1, email);
                int inserted = insertStmt.executeUpdate();
                
                if (inserted > 0) {
                    System.out.println("📧 New subscription added: " + email);
                    return "success";
                } else {
                    return "error";
                }
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Database error: " + e.getMessage());
            e.printStackTrace();
            return "error";
        } finally {
            // Đóng resources
            try {
                if (rs != null) rs.close();
                if (checkStmt != null) checkStmt.close();
                if (insertStmt != null) insertStmt.close();
                if (updateStmt != null) updateStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("❌ Error closing resources: " + e.getMessage());
            }
        }
    }
}