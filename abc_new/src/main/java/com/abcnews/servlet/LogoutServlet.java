package com.abcnews.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        handleLogout(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        handleLogout(request, response);
    }
    
    private void handleLogout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // 1. Xóa session
            HttpSession session = request.getSession(false);
            if (session != null) {
                String username = (String) session.getAttribute("username");
                session.invalidate(); // Xóa toàn bộ session
                System.out.println("✅ Đã xóa session cho user: " + username);
            }
            
            // 2. Xóa cookie Remember Me
            Cookie cookie = new Cookie("abcnews_user", "");
            cookie.setMaxAge(0); // Xóa cookie ngay lập tức
            cookie.setPath("/"); // Đảm bảo xóa đúng path
            response.addCookie(cookie);
            System.out.println("✅ Đã xóa cookie Remember Me");
            
            // 3. Thông báo đăng xuất thành công
            request.setAttribute("success", "Đăng xuất thành công! Hẹn gặp lại bạn.");
            
            // 4. Chuyển về trang đăng nhập
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            
            // Nếu có lỗi, vẫn chuyển về trang đăng nhập
            request.setAttribute("error", "Có lỗi xảy ra khi đăng xuất: " + e.getMessage());
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}