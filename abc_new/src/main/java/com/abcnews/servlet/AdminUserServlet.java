package com.abcnews.servlet;

import com.abcnews.dao.UserDAO;
import com.abcnews.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/admin/users/*")
public class AdminUserServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền admin
        if (!checkAdminPermission(request, response)) return;
        
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // Hiển thị danh sách người dùng
                showUserList(request, response);
            } else if (pathInfo.equals("/add")) {
                // Hiển thị form thêm người dùng
                request.getRequestDispatcher("/views/admin/user-add.jsp").forward(request, response);
            } else if (pathInfo.startsWith("/edit/")) {
                // Hiển thị form sửa người dùng
                String userId = pathInfo.substring(6);
                User user = userDAO.getUserById(userId);
                if (user != null) {
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("/views/admin/user-edit.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Không tìm thấy người dùng!");
                    showUserList(request, response);
                }
            } else if (pathInfo.startsWith("/delete/")) {
                // Xóa người dùng
                String userId = pathInfo.substring(8);
                boolean success = userDAO.deleteUser(userId);
                if (success) {
                    request.setAttribute("success", "Xóa người dùng thành công!");
                } else {
                    request.setAttribute("error", "Lỗi khi xóa người dùng!");
                }
                showUserList(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            showUserList(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền admin
        if (!checkAdminPermission(request, response)) return;
        
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo != null && pathInfo.equals("/add")) {
                // Thêm người dùng mới
                addUser(request, response);
            } else if (pathInfo != null && pathInfo.startsWith("/edit/")) {
                // Cập nhật người dùng
                String userId = pathInfo.substring(6);
                updateUser(request, response, userId);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            showUserList(request, response);
        }
    }
    
    private boolean checkAdminPermission(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        
        User user = (User) session.getAttribute("user");
        if (!user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        return true;
    }
    
    private void showUserList(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/views/admin/user-list.jsp").forward(request, response);
    }
    
    private void addUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        String password = request.getParameter("password");
        String fullname = request.getParameter("fullname");
        String birthdayStr = request.getParameter("birthday");
        String genderStr = request.getParameter("gender");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");
        String roleStr = request.getParameter("role");
        
        // Validate
        if (id == null || id.trim().isEmpty() || 
            password == null || password.trim().isEmpty() ||
            fullname == null || fullname.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc!");
            request.getRequestDispatcher("/views/admin/user-add.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra ID đã tồn tại
        if (userDAO.isUserExists(id)) {
            request.setAttribute("error", "ID người dùng đã tồn tại!");
            request.getRequestDispatcher("/views/admin/user-add.jsp").forward(request, response);
            return;
        }
        
        try {
            User user = new User();
            user.setId(id.trim());
            user.setPassword(password);
            user.setFullname(fullname.trim());
            
            if (birthdayStr != null && !birthdayStr.trim().isEmpty()) {
                user.setBirthday(Date.valueOf(birthdayStr));
            }
            
            if (genderStr != null && !genderStr.trim().isEmpty()) {
                user.setGender(Integer.parseInt(genderStr));
            }
            
            user.setMobile(mobile);
            user.setEmail(email);
            
            if (roleStr != null && !roleStr.trim().isEmpty()) {
                user.setRole(Integer.parseInt(roleStr));
            }
            
            boolean success = userDAO.addUser(user);
            if (success) {
                request.setAttribute("success", "Thêm người dùng thành công!");
                showUserList(request, response);
            } else {
                request.setAttribute("error", "Lỗi khi thêm người dùng!");
                request.getRequestDispatcher("/views/admin/user-add.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/user-add.jsp").forward(request, response);
        }
    }
    
    private void updateUser(HttpServletRequest request, HttpServletResponse response, String userId) 
            throws ServletException, IOException {
        
        String password = request.getParameter("password");
        String fullname = request.getParameter("fullname");
        String birthdayStr = request.getParameter("birthday");
        String genderStr = request.getParameter("gender");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");
        String roleStr = request.getParameter("role");
        
        try {
            User user = userDAO.getUserById(userId);
            if (user == null) {
                request.setAttribute("error", "Không tìm thấy người dùng!");
                showUserList(request, response);
                return;
            }
            
            // Cập nhật thông tin
            if (password != null && !password.trim().isEmpty()) {
                user.setPassword(password);
            }
            if (fullname != null && !fullname.trim().isEmpty()) {
                user.setFullname(fullname.trim());
            }
            if (birthdayStr != null && !birthdayStr.trim().isEmpty()) {
                user.setBirthday(Date.valueOf(birthdayStr));
            }
            if (genderStr != null && !genderStr.trim().isEmpty()) {
                user.setGender(Integer.parseInt(genderStr));
            }
            user.setMobile(mobile);
            user.setEmail(email);
            if (roleStr != null && !roleStr.trim().isEmpty()) {
                user.setRole(Integer.parseInt(roleStr));
            }
            
            boolean success = userDAO.updateUser(user);
            if (success) {
                request.setAttribute("success", "Cập nhật người dùng thành công!");
            } else {
                request.setAttribute("error", "Lỗi khi cập nhật người dùng!");
            }
            showUserList(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi dữ liệu: " + e.getMessage());
            showUserList(request, response);
        }
    }
}