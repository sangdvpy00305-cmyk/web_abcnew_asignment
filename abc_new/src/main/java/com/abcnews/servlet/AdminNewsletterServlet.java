package com.abcnews.servlet;

import com.abcnews.dao.NewsletterDAO;
import com.abcnews.model.Newsletter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/newsletters")
public class AdminNewsletterServlet extends HttpServlet {
    
    private NewsletterDAO newsletterDAO;
    
    @Override
    public void init() throws ServletException {
        newsletterDAO = new NewsletterDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền admin
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (!"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            if ("delete".equals(action)) {
                handleDelete(request, response);
            } else {
                showNewsletterList(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            showNewsletterList(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền admin
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (!"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            if ("toggle".equals(action)) {
                handleToggleStatus(request, response);
            } else if ("delete".equals(action)) {
                handleDelete(request, response);
            } else {
                showNewsletterList(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            showNewsletterList(request, response);
        }
    }
    
    /**
     * Hiển thị danh sách newsletter
     */
    private void showNewsletterList(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Lấy danh sách tất cả newsletter
            List<Newsletter> newsletters = newsletterDAO.getAllNewsletters();
            
            // Thống kê
            int totalSubscribers = newsletterDAO.getTotalSubscribers();
            int activeSubscribers = newsletterDAO.getActiveSubscribers();
            
            // Set attributes
            request.setAttribute("newsletters", newsletters);
            request.setAttribute("totalSubscribers", totalSubscribers);
            request.setAttribute("activeSubscribers", activeSubscribers);
            
            // Forward to JSP
            request.getRequestDispatcher("/views/admin/newsletter-list.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể tải danh sách newsletter: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/newsletter-list.jsp").forward(request, response);
        }
    }
    
    /**
     * Xử lý bật/tắt trạng thái newsletter
     */
    private void handleToggleStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String statusStr = request.getParameter("status");
        
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email không hợp lệ!");
            showNewsletterList(request, response);
            return;
        }
        
        try {
            int newStatus = "1".equals(statusStr) ? 1 : 0;
            boolean success = newsletterDAO.updateNewsletterStatus(email.trim(), newStatus);
            
            if (success) {
                String statusText = newStatus == 1 ? "kích hoạt" : "vô hiệu hóa";
                request.setAttribute("message", "Đã " + statusText + " newsletter cho email: " + email);
            } else {
                request.setAttribute("error", "Không thể cập nhật trạng thái newsletter!");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cập nhật trạng thái: " + e.getMessage());
        }
        
        showNewsletterList(request, response);
    }
    
    /**
     * Xử lý xóa newsletter
     */
    private void handleDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email không hợp lệ!");
            showNewsletterList(request, response);
            return;
        }
        
        try {
            boolean success = newsletterDAO.deleteNewsletter(email.trim());
            
            if (success) {
                request.setAttribute("message", "Đã xóa newsletter cho email: " + email);
            } else {
                request.setAttribute("error", "Không thể xóa newsletter!");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xóa newsletter: " + e.getMessage());
        }
        
        showNewsletterList(request, response);
    }
}