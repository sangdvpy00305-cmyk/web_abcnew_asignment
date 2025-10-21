package com.abcnews.servlet;

import com.abcnews.dao.UserDAO;
import com.abcnews.dao.NewsDAO;
import com.abcnews.model.User;
import com.abcnews.model.News;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;

@WebServlet("/reporter/profile/*")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ReporterProfileServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private NewsDAO newsDAO = new NewsDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền phóng viên
        User currentUser = checkReporterPermission(request, response);
        if (currentUser == null) return;
        
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // Hiển thị trang hồ sơ
                showProfile(request, response, currentUser);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            showProfile(request, response, currentUser);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền phóng viên
        User currentUser = checkReporterPermission(request, response);
        if (currentUser == null) return;
        
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo != null && pathInfo.equals("/update")) {
                // Cập nhật thông tin cá nhân
                updateProfile(request, response, currentUser);
            } else if (pathInfo != null && pathInfo.equals("/change-password")) {
                // Đổi mật khẩu
                changePassword(request, response, currentUser);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            showProfile(request, response, currentUser);
        }
    }
    
    private User checkReporterPermission(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return null;
        }
        
        User user = (User) session.getAttribute("user");
        if (!user.isReporter()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return null;
        }
        return user;
    }
    
    private void showProfile(HttpServletRequest request, HttpServletResponse response, User currentUser) 
            throws ServletException, IOException {
        
        // Lấy thông tin user mới nhất từ database
        User user = userDAO.getUserById(currentUser.getId());
        if (user == null) {
            user = currentUser;
        }
        
        // Tính toán thống kê
        Map<String, Integer> userStats = calculateUserStats(currentUser.getId());
        
        // Lấy hoạt động gần đây (có thể implement sau)
        // List<Activity> recentActivities = getRecentActivities(currentUser.getId());
        
        request.setAttribute("user", user);
        request.setAttribute("userStats", userStats);
        // request.setAttribute("recentActivities", recentActivities);
        
        request.getRequestDispatcher("/views/phongvien/profile.jsp").forward(request, response);
    }
    
    private void updateProfile(HttpServletRequest request, HttpServletResponse response, User currentUser) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String bio = request.getParameter("bio");
        
        // Validate
        if (email == null || email.trim().isEmpty() ||
            fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Email và họ tên không được để trống!");
            showProfile(request, response, currentUser);
            return;
        }
        
        // Validate email format
        if (!isValidEmail(email)) {
            request.setAttribute("error", "Email không hợp lệ!");
            showProfile(request, response, currentUser);
            return;
        }
        
        try {
            // Handle avatar upload
            String avatarUrl = null;
            Part avatarPart = request.getPart("avatarFile");
            if (avatarPart != null && avatarPart.getSize() > 0) {
                avatarUrl = saveUploadedFile(avatarPart, request, "avatars");
            }
            
            // Get current user data
            User user = userDAO.getUserById(currentUser.getId());
            if (user == null) {
                request.setAttribute("error", "Không tìm thấy thông tin người dùng!");
                showProfile(request, response, currentUser);
                return;
            }
            
            // Update user information
            user.setEmail(email.trim());
            user.setFullName(fullName.trim());
            user.setPhone(phone != null ? phone.trim() : null);
            user.setBio(bio != null ? bio.trim() : null);
            
            if (avatarUrl != null) {
                user.setAvatar(avatarUrl);
            }
            
            boolean success = userDAO.updateProfile(user);
            if (success) {
                // Update session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                
                request.setAttribute("message", "Cập nhật thông tin thành công!");
            } else {
                request.setAttribute("error", "Lỗi khi cập nhật thông tin!");
            }
            
            showProfile(request, response, user);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            showProfile(request, response, currentUser);
        }
    }
    
    private void changePassword(HttpServletRequest request, HttpServletResponse response, User currentUser) 
            throws ServletException, IOException {
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate
        if (currentPassword == null || currentPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            showProfile(request, response, currentUser);
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            showProfile(request, response, currentUser);
            return;
        }
        
        if (newPassword.length() < 6) {
            request.setAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự!");
            showProfile(request, response, currentUser);
            return;
        }
        
        try {
            // Verify current password
            User user = userDAO.getUserByUsernameAndPassword(currentUser.getUsername(), currentPassword);
            if (user == null) {
                request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
                showProfile(request, response, currentUser);
                return;
            }
            
            // Update password
            boolean success = userDAO.updatePassword(currentUser.getId(), newPassword);
            if (success) {
                request.setAttribute("message", "Đổi mật khẩu thành công!");
            } else {
                request.setAttribute("error", "Lỗi khi đổi mật khẩu!");
            }
            
            showProfile(request, response, currentUser);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            showProfile(request, response, currentUser);
        }
    }
    
    private Map<String, Integer> calculateUserStats(String userId) {
        Map<String, Integer> stats = new HashMap<>();
        
        try {
            // Lấy tất cả tin tức của user
            List<News> allNews = newsDAO.getAllNews();
            List<News> userNews = allNews.stream()
                .filter(news -> userId.equals(news.getAuthor()))
                .collect(Collectors.toList());
            
            // Tính toán thống kê
            int totalNews = userNews.size();
            int publishedNews = (int) userNews.stream()
                .filter(news -> news.getHome() != null && news.getHome() == 1)
                .count();
            int draftNews = totalNews - publishedNews;
            int totalViews = userNews.stream()
                .mapToInt(News::getViewCount)
                .sum();
            
            stats.put("totalNews", totalNews);
            stats.put("publishedNews", publishedNews);
            stats.put("draftNews", draftNews);
            stats.put("totalViews", totalViews);
            
        } catch (Exception e) {
            e.printStackTrace();
            // Return default values on error
            stats.put("totalNews", 0);
            stats.put("publishedNews", 0);
            stats.put("draftNews", 0);
            stats.put("totalViews", 0);
        }
        
        return stats;
    }
    
    private String saveUploadedFile(Part filePart, HttpServletRequest request, String subFolder) throws IOException {
        String fileName = getFileName(filePart);
        if (fileName == null || fileName.isEmpty()) {
            return null;
        }
        
        // Validate file type
        String contentType = filePart.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            throw new IOException("Chỉ chấp nhận file hình ảnh!");
        }
        
        // Create unique filename
        String fileExtension = fileName.substring(fileName.lastIndexOf("."));
        String uniqueFileName = System.currentTimeMillis() + "_" + fileName.replaceAll("[^a-zA-Z0-9.]", "_");
        
        // Create upload directory if not exists
        String uploadPath = request.getServletContext().getRealPath("/") + "uploads" + File.separator + subFolder;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        // Save file
        String filePath = uploadPath + File.separator + uniqueFileName;
        filePart.write(filePath);
        
        // Return relative URL
        return "/uploads/" + subFolder + "/" + uniqueFileName;
    }
    
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition != null) {
            for (String content : contentDisposition.split(";")) {
                if (content.trim().startsWith("filename")) {
                    return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
                }
            }
        }
        return null;
    }
    
    private boolean isValidEmail(String email) {
        return email != null && email.matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }
}