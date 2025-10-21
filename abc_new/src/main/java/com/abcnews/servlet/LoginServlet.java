package com.abcnews.servlet;

import com.abcnews.dao.UserDAO;
import com.abcnews.model.User;
import com.abcnews.utils.Base64Utils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra cookie "Remember Me"
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("abcnews_user".equals(cookie.getName())) {
                    String encoded = cookie.getValue();
                    String decodedText = Base64Utils.decode(encoded);
                    
                    if (decodedText != null) {
                        String[] userInfo = decodedText.split(",");
                        
                        // Kiểm tra xem mảng có đúng 2 phần tử (username và password) hay không
                        if (userInfo.length == 2) {
                            // Gán username và password vào form để tự động điền
                            request.setAttribute("rememberedUsername", userInfo[0]);
                            request.setAttribute("rememberedPassword", userInfo[1]);
                            request.setAttribute("rememberMe", true);
                        }
                    }
                    break;
                }
            }
        }
        
        // Hiển thị trang đăng nhập
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe"); // Lấy giá trị checkbox "Ghi nhớ đăng nhập"
        
        try {
            System.out.println("🔍 Đang thử đăng nhập với username: " + username);
            
            // Kiểm tra đăng nhập
            User user = userDAO.login(username, password);
            
            if (user != null) {
                System.out.println("✅ Đăng nhập thành công cho user: " + user.getFullname() + " (Role: " + user.getRole() + ")");
                // Đăng nhập thành công
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("username", user.getFullname());
                session.setAttribute("userId", user.getId());
                
                // Set role as String
                String roleString = user.isAdmin() ? "admin" : "reporter";
                session.setAttribute("role", roleString);
                
                System.out.println("🔧 Session ID: " + session.getId());
                System.out.println("🔧 User in session: " + session.getAttribute("user"));
                System.out.println("🔧 Role in session: " + session.getAttribute("role"));
                System.out.println("🔧 User isAdmin: " + user.isAdmin() + ", isReporter: " + user.isReporter());
                
                // Xử lý Remember Me
                if ("on".equals(rememberMe) || "1".equals(rememberMe)) {
                    // Tạo cookie lưu thông tin đăng nhập
                    String userInfo = username + "," + password;
                    String encodedUserInfo = Base64Utils.encode(userInfo);
                    
                    if (encodedUserInfo != null) {
                        Cookie cookie = new Cookie("abcnews_user", encodedUserInfo);
                        cookie.setMaxAge(7 * 24 * 60 * 60); // Hiệu lực 7 ngày
                        cookie.setPath("/"); // Hiệu lực toàn ứng dụng
                        cookie.setHttpOnly(true); // Bảo mật: chỉ truy cập qua HTTP, không qua JavaScript
                        response.addCookie(cookie);
                        
                        System.out.println("✅ Đã lưu cookie Remember Me cho user: " + username);
                    }
                } else {
                    // Xóa cookie nếu không chọn Remember Me
                    Cookie cookie = new Cookie("abcnews_user", "");
                    cookie.setMaxAge(0); // Xóa cookie
                    cookie.setPath("/");
                    response.addCookie(cookie);
                }
                
                // Chuyển hướng theo role
                if (user.isAdmin()) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else if (user.isReporter()) {
                    response.sendRedirect(request.getContextPath() + "/reporter/dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/home");
                }
            } else {
                System.out.println("❌ Đăng nhập thất bại cho username: " + username);
                
                // Đăng nhập thất bại - Xóa cookie cũ nếu có
                Cookie cookie = new Cookie("abcnews_user", "");
                cookie.setMaxAge(0); // Xóa cookie
                cookie.setPath("/");
                response.addCookie(cookie);
                
                // Xóa session cũ
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.removeAttribute("user");
                    session.removeAttribute("username");
                    session.removeAttribute("userId");
                    session.removeAttribute("role");
                }
                
                request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
                request.setAttribute("username", username);
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.setAttribute("username", username);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}