package com.abcnews.servlet;

import com.abcnews.dao.*;
import com.abcnews.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private NewsDAO newsDAO = new NewsDAO();
    private UserDAO userDAO = new UserDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private NewsletterDAO newsletterDAO = new NewsletterDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền admin
        HttpSession session = request.getSession(false);
        System.out.println("🔍 AdminDashboard - Session: " + (session != null ? session.getId() : "null"));
        
        if (session == null || session.getAttribute("user") == null) {
            System.out.println("❌ AdminDashboard - No session or user, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        System.out.println("🔍 AdminDashboard - User: " + user.getFullname() + ", isAdmin: " + user.isAdmin());
        
        if (!user.isAdmin()) {
            System.out.println("❌ AdminDashboard - User is not admin, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        System.out.println("✅ AdminDashboard - Access granted");
        
        try {
            // Lấy thống kê
            int totalNews = newsDAO.getAllNews().size();
            int totalUsers = userDAO.getAllUsers().size();
            int totalCategories = categoryDAO.getAllCategories().size();
            int totalSubscribers = newsletterDAO.countActiveSubscribers();
            
            // Đặt dữ liệu vào request
            request.setAttribute("totalNews", totalNews);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalCategories", totalCategories);
            request.setAttribute("totalSubscribers", totalSubscribers);
            
            // Forward đến trang JSP
            request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
        }
    }
}