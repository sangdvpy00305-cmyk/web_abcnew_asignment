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
import java.lang.reflect.InvocationTargetException;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

// @WebServlet({"/admin/users", "/admin/users/index", "/admin/users/edit/*", 
//              "/admin/users/create", "/admin/users/update", "/admin/users/delete", 
//              "/admin/users/reset"})
// DISABLED - Using AdminUserServlet instead
public class AdminUserServletNew extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền admin
        if (!checkAdminPermission(request, response)) return;
        
        // Tạo form object để bind dữ liệu
        User form = new User();
        String message = null;
        String error = null;
        
        try {
            // Sử dụng BeanUtils để populate form từ request parameters
            BeanUtils.populate(form, request.getParameterMap());
        } catch (IllegalAccessException | InvocationTargetException e) {
            throw new ServletException("Lỗi bind dữ liệu form: " + e.getMessage(), e);
        }
        
        UserDAO dao = new UserDAO();
        String path = request.getServletPath();
        
        try {
            if (path.contains("edit")) {
                // /admin/users/edit/{id}
                String pathInfo = request.getPathInfo();
                if (pathInfo != null && pathInfo.length() > 1) {
                    String id = pathInfo.substring(1); // Bỏ dấu / đầu
                    User user = dao.getUserById(id);
                    if (user != null) {
                        form = user;
                        // Không hiển thị password trong form edit
                        form.setPassword("");
                    } else {
                        error = "Không tìm thấy người dùng với ID: " + id;
                    }
                }
                
            } else if (path.contains("create")) {
                // Thêm mới người dùng
                if (isValidUserForm(form, true)) {
                    // Kiểm tra username đã tồn tại
                    if (dao.isUsernameExists(form.getUsername())) {
                        error = "❌ Tên đăng nhập đã tồn tại!";
                    } else {
                        boolean success = dao.addUser(form);
                        if (success) {
                            message = "✅ Thêm người dùng thành công!";
                            form = new User(); // Reset form
                        } else {
                            error = "❌ Lỗi thêm người dùng!";
                        }
                    }
                } else {
                    error = "❌ Vui lòng điền đầy đủ thông tin bắt buộc!";
                }
                
            } else if (path.contains("update")) {
                // Cập nhật người dùng
                if (isValidUserForm(form, false)) {
                    boolean success;
                    if (form.getPassword() != null && !form.getPassword().trim().isEmpty()) {
                        // Cập nhật cả password
                        success = dao.updateUser(form);
                    } else {
                        // Chỉ cập nhật thông tin, không đổi password
                        success = dao.updateUserWithoutPassword(form);
                    }
                    
                    if (success) {
                        message = "✅ Cập nhật người dùng thành công!";
                    } else {
                        error = "❌ Lỗi cập nhật người dùng!";
                    }
                } else {
                    error = "❌ Thông tin người dùng không hợp lệ!";
                }
                
            } else if (path.contains("delete")) {
                // Xóa người dùng
                if (form.getUsername() != null) {
                    // Không cho phép xóa chính mình
                    HttpSession session = request.getSession();
                    String currentUserId = (String) session.getAttribute("userId");
                    
                    if (form.getUsername().equals(currentUserId)) {
                        error = "❌ Không thể xóa tài khoản của chính mình!";
                    } else {
                        boolean success = dao.deleteUser(form.getUsername());
                        if (success) {
                            message = "✅ Xóa người dùng thành công!";
                            form = new User(); // Reset form
                        } else {
                            error = "❌ Lỗi xóa người dùng! Có thể người dùng đang có dữ liệu liên quan.";
                        }
                    }
                } else {
                    error = "❌ ID người dùng không hợp lệ!";
                }
                
            } else if (path.contains("reset") || path.contains("index") || path.equals("/admin/users")) {
                // Reset form hoặc hiển thị danh sách
                form = new User();
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            error = "❌ Lỗi hệ thống: " + e.getMessage();
        }
        
        // Set attributes cho JSP
        request.setAttribute("item", form);
        request.setAttribute("message", message);
        request.setAttribute("error", error);
        
        // Lấy danh sách tất cả người dùng
        try {
            List<User> users = dao.getAllUsers();
            request.setAttribute("list", users);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "❌ Lỗi tải danh sách người dùng: " + e.getMessage());
        }
        
        // Forward đến JSP
        request.getRequestDispatcher("/views/admin/user-manage.jsp").forward(request, response);
    }
    
    /**
     * Kiểm tra tính hợp lệ của form user
     */
    private boolean isValidUserForm(User user, boolean isCreate) {
        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            return false;
        }
        if (user.getFullname() == null || user.getFullname().trim().isEmpty()) {
            return false;
        }
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            return false;
        }
        if (user.getRole() == null) {
            return false;
        }
        
        // Khi tạo mới, password bắt buộc
        if (isCreate && (user.getPassword() == null || user.getPassword().trim().isEmpty())) {
            return false;
        }
        
        return true;
    }
    
    /**
     * Kiểm tra quyền admin
     */
    private boolean checkAdminPermission(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (!"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        return true;
    }
}