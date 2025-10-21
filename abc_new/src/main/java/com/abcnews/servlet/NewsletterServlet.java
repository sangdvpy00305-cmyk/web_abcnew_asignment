package com.abcnews.servlet;

import com.abcnews.dao.NewsletterDAO;
import com.abcnews.model.Newsletter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/newsletter")
public class NewsletterServlet extends HttpServlet {
    private NewsletterDAO newsletterDAO = new NewsletterDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        
        String email = request.getParameter("email");
        String action = request.getParameter("action");
        
        // Validate email
        if (email == null || email.trim().isEmpty()) {
            response.getWriter().write("error_empty_email");
            return;
        }
        
        email = email.trim().toLowerCase();
        
        // Validate email format
        if (!isValidEmail(email)) {
            response.getWriter().write("error_invalid_email");
            return;
        }
        
        try {
            if ("subscribe".equals(action)) {
                // Check if email already exists
                Newsletter existing = newsletterDAO.getByEmail(email);
                if (existing != null) {
                    if (existing.getIsActive() == 1) {
                        response.getWriter().write("error_already_subscribed");
                        return;
                    } else {
                        // Reactivate subscription
                        boolean success = newsletterDAO.reactivateSubscription(email);
                        if (success) {
                            response.getWriter().write("success");
                        } else {
                            response.getWriter().write("error");
                        }
                        return;
                    }
                }
                
                // Create new subscription
                Newsletter newsletter = new Newsletter();
                newsletter.setId(String.valueOf(System.currentTimeMillis()));
                newsletter.setEmail(email);
                newsletter.setSubscribedAt(new Timestamp(System.currentTimeMillis()));
                newsletter.setIsActive(1);
                
                boolean success = newsletterDAO.addNewsletter(newsletter);
                if (success) {
                    response.getWriter().write("success");
                } else {
                    response.getWriter().write("error");
                }
                
            } else if ("unsubscribe".equals(action)) {
                boolean success = newsletterDAO.unsubscribe(email);
                if (success) {
                    // Redirect to unsubscribe page with success message
                    response.sendRedirect(request.getContextPath() + "/views/docgia/unsubscribe.jsp?success=true&email=" + 
                                        java.net.URLEncoder.encode(email, "UTF-8"));
                    return;
                } else {
                    // Redirect to unsubscribe page with error message
                    response.sendRedirect(request.getContextPath() + "/views/docgia/unsubscribe.jsp?error=true&email=" + 
                                        java.net.URLEncoder.encode(email, "UTF-8"));
                    return;
                }
            } else {
                response.getWriter().write("error_invalid_action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String email = request.getParameter("email");
        String token = request.getParameter("token");
        
        if ("unsubscribe".equals(action) && email != null) {
            // Handle unsubscribe from email link
            try {
                boolean success = newsletterDAO.unsubscribe(email);
                
                response.setContentType("text/html");
                response.setCharacterEncoding("UTF-8");
                
                if (success) {
                    response.getWriter().write(
                        "<html><body style='font-family: Arial; text-align: center; padding: 50px;'>" +
                        "<h2>✅ Hủy đăng ký thành công!</h2>" +
                        "<p>Email <strong>" + email + "</strong> đã được hủy khỏi danh sách nhận tin.</p>" +
                        "<p><a href='" + request.getContextPath() + "/home'>Quay lại trang chủ</a></p>" +
                        "</body></html>"
                    );
                } else {
                    response.getWriter().write(
                        "<html><body style='font-family: Arial; text-align: center; padding: 50px;'>" +
                        "<h2>❌ Có lỗi xảy ra!</h2>" +
                        "<p>Không thể hủy đăng ký. Vui lòng thử lại sau.</p>" +
                        "<p><a href='" + request.getContextPath() + "/home'>Quay lại trang chủ</a></p>" +
                        "</body></html>"
                    );
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
    
    private boolean isValidEmail(String email) {
        return email != null && email.matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }
}