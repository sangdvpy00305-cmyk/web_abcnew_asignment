package com.abcnews.servlet;

import com.abcnews.dao.NewsDAO;
import com.abcnews.dao.CategoryDAO;
import com.abcnews.model.News;
import com.abcnews.model.Category;
import com.abcnews.model.User;

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
import java.sql.Timestamp;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/reporter/news/*")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ReporterNewsServlet extends HttpServlet {
    private NewsDAO newsDAO = new NewsDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền phóng viên
        User currentUser = checkReporterPermission(request, response);
        if (currentUser == null) return;
        
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // Hiển thị danh sách tin tức của phóng viên
                showMyNewsList(request, response, currentUser);
            } else if (pathInfo.equals("/add")) {
                // Hiển thị form thêm tin tức
                loadFormData(request);
                request.getRequestDispatcher("/views/phongvien/news-add.jsp").forward(request, response);
            } else if (pathInfo.startsWith("/edit/")) {
                // Hiển thị form sửa tin tức
                String newsId = pathInfo.substring(6);
                showEditForm(request, response, newsId, currentUser);
            } else if (pathInfo.startsWith("/view/")) {
                // Xem chi tiết tin tức
                String newsId = pathInfo.substring(6);
                viewNewsDetail(request, response, newsId, currentUser);
            } else if (pathInfo.startsWith("/delete/")) {
                // Xóa tin tức
                String newsId = pathInfo.substring(8);
                deleteNews(request, response, newsId, currentUser);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            showMyNewsList(request, response, currentUser);
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
            if (pathInfo != null && pathInfo.equals("/add")) {
                // Thêm tin tức mới
                addNews(request, response, currentUser);
            } else if (pathInfo != null && pathInfo.startsWith("/edit/")) {
                // Cập nhật tin tức
                String newsId = pathInfo.substring(6);
                updateNews(request, response, newsId, currentUser);
            } else if (pathInfo != null && pathInfo.startsWith("/delete/")) {
                // Xóa tin tức (POST method)
                String newsId = pathInfo.substring(8);
                deleteNews(request, response, newsId, currentUser);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            showMyNewsList(request, response, currentUser);
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
    
    private void loadFormData(HttpServletRequest request) {
        // Load categories cho form
        List<Category> categories = categoryDAO.getAllCategories();
        System.out.println("📋 Loaded " + (categories != null ? categories.size() : 0) + " categories");
        request.setAttribute("categories", categories);
    }
    
    private void showMyNewsList(HttpServletRequest request, HttpServletResponse response, User currentUser) 
            throws ServletException, IOException {
        
        // Lấy parameters cho tìm kiếm và phân trang
        String search = request.getParameter("search");
        String status = request.getParameter("status");
        String category = request.getParameter("category");
        String pageStr = request.getParameter("page");
        
        int page = 1;
        int pageSize = 10;
        
        try {
            if (pageStr != null) {
                page = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }
        
        // Lấy tất cả tin tức và lọc theo tác giả
        List<News> allNews = newsDAO.getAllNews();
        List<News> myNews = allNews.stream()
            .filter(news -> currentUser.getId().equals(news.getAuthor()))
            .collect(Collectors.toList());
        
        // Áp dụng bộ lọc
        if (search != null && !search.trim().isEmpty()) {
            myNews = myNews.stream()
                .filter(news -> news.getTitle().toLowerCase().contains(search.toLowerCase()) ||
                               (news.getContent() != null && news.getContent().toLowerCase().contains(search.toLowerCase())))
                .collect(Collectors.toList());
        }
        
        if (status != null && !status.isEmpty()) {
            int statusInt = Integer.parseInt(status);
            myNews = myNews.stream()
                .filter(news -> news.getHome() != null && news.getHome() == statusInt)
                .collect(Collectors.toList());
        }
        
        if (category != null && !category.isEmpty()) {
            myNews = myNews.stream()
                .filter(news -> category.equals(news.getCategoryId()))
                .collect(Collectors.toList());
        }
        
        // Tính toán phân trang
        int totalNews = myNews.size();
        int totalPages = (int) Math.ceil((double) totalNews / pageSize);
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalNews);
        
        List<News> pagedNews = myNews.subList(startIndex, endIndex);
        
        // Load categories cho filter
        List<Category> categories = categoryDAO.getAllCategories();
        
        // Set attributes
        request.setAttribute("myNews", pagedNews);
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalNews", totalNews);
        
        request.getRequestDispatcher("/views/phongvien/news-list.jsp").forward(request, response);
    }
    
    private void addNews(HttpServletRequest request, HttpServletResponse response, User currentUser) 
            throws ServletException, IOException {
        
        String title = request.getParameter("title");
        String summary = request.getParameter("summary");
        String content = request.getParameter("content");
        String categoryId = request.getParameter("categoryId");
        String action = request.getParameter("action");
        String requestPublish = request.getParameter("requestPublish");
        
        // Debug log
        System.out.println("📝 Adding news - Title: " + title);
        System.out.println("📝 Adding news - Summary: " + summary);
        System.out.println("📝 Adding news - Content: " + content);
        System.out.println("📝 Adding news - CategoryId: " + categoryId);
        System.out.println("📝 Adding news - Action: " + action);
        
        // Validate
        if (title == null || title.trim().isEmpty()) {
            System.out.println("❌ Validation failed: Title is empty");
            request.setAttribute("error", "Vui lòng nhập tiêu đề tin tức!");
            loadFormData(request);
            request.getRequestDispatcher("/views/phongvien/news-add.jsp").forward(request, response);
            return;
        }
        
        if (content == null || content.trim().isEmpty()) {
            System.out.println("❌ Validation failed: Content is empty");
            request.setAttribute("error", "Vui lòng nhập nội dung tin tức!");
            loadFormData(request);
            request.getRequestDispatcher("/views/phongvien/news-add.jsp").forward(request, response);
            return;
        }
        
        if (categoryId == null || categoryId.trim().isEmpty()) {
            System.out.println("❌ Validation failed: CategoryId is empty");
            request.setAttribute("error", "Vui lòng chọn danh mục!");
            loadFormData(request);
            request.getRequestDispatcher("/views/phongvien/news-add.jsp").forward(request, response);
            return;
        }
        
        try {
            // Handle file upload - theo mẫu tham khảo
            String imageUrl = null;
            Part imagePart = request.getPart("imageFile");
            if (imagePart != null && imagePart.getSize() > 0) {
                try {
                    // Lấy tên file gốc
                    String originalFileName = imagePart.getSubmittedFileName();
                    if (originalFileName != null && !originalFileName.isEmpty()) {
                        // Tạo đường dẫn lưu file
                        String uploadPath = "uploads" + java.io.File.separator + "news";
                        String realPath = request.getServletContext().getRealPath("/") + uploadPath;
                        
                        System.out.println("📁 Upload path: " + realPath);
                        
                        // Tạo thư mục nếu chưa tồn tại
                        java.io.File uploadDir = new java.io.File(realPath);
                        if (!uploadDir.exists()) {
                            boolean created = uploadDir.mkdirs();
                            System.out.println("📁 Created directory: " + created);
                        }
                        
                        // Tạo tên file unique
                        String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                        String uniqueFileName = System.currentTimeMillis() + "_" + originalFileName.replaceAll("[^a-zA-Z0-9.]", "_");
                        
                        // Lưu file
                        String fullPath = realPath + java.io.File.separator + uniqueFileName;
                        System.out.println("📁 Full path: " + fullPath);
                        imagePart.write(fullPath);
                        
                        // Đường dẫn để lưu vào database
                        imageUrl = "/uploads/news/" + uniqueFileName;
                        
                        System.out.println("📁 Image uploaded: " + imageUrl);
                    }
                } catch (Exception e) {
                    System.out.println("❌ Image upload failed: " + e.getMessage());
                    request.setAttribute("error", "Lỗi upload ảnh: " + e.getMessage());
                    loadFormData(request);
                    request.getRequestDispatcher("/views/phongvien/news-add.jsp").forward(request, response);
                    return;
                }
            }
            
            News news = new News();
            // Generate ID automatically - sẽ được tạo trong NewsDAO nếu null
            news.setId(null);
            news.setTitle(title.trim());
            news.setContent(content.trim());
            news.setSummary(summary != null ? summary.trim() : "");
            news.setImage(imageUrl);
            news.setPostedDate(new java.sql.Date(System.currentTimeMillis()));
            news.setAuthor(currentUser.getId());
            news.setAuthorName(currentUser.getFullname() != null ? currentUser.getFullname() : currentUser.getUsername());
            news.setViewCount(0);
            news.setCategoryId(categoryId);
            
            // Set status - 0 for pending approval
            news.setHome(0);
            news.setApprovalStatus(0); // Reset approval status to pending
            
            System.out.println("📝 Calling newsDAO.addNews()...");
            boolean success = newsDAO.addNews(news);
            System.out.println("📝 Add news result: " + success);
            
            if (success) {
                String message = "";
                if ("submit".equals(action) || "1".equals(requestPublish)) {
                    message = "Tin tức đã được gửi để duyệt! Email sẽ được gửi khi admin duyệt bài.";
                } else {
                    message = "Tin tức đã được lưu thành công!";
                }
                System.out.println("✅ Success! Redirecting with message: " + message);
                response.sendRedirect(request.getContextPath() + "/reporter/news?success=" + java.net.URLEncoder.encode(message, "UTF-8"));
                return;
            } else {
                System.out.println("❌ Failed to add news to database");
                request.setAttribute("error", "Lỗi khi thêm tin tức! Vui lòng kiểm tra lại thông tin.");
                loadFormData(request);
                request.getRequestDispatcher("/views/phongvien/news-add.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            loadFormData(request);
            request.getRequestDispatcher("/views/phongvien/news-add.jsp").forward(request, response);
        }
    }
    
    private void deleteNews(HttpServletRequest request, HttpServletResponse response, String newsId, User currentUser) 
            throws ServletException, IOException {
        
        try {
            News news = newsDAO.getNewsById(newsId);
            if (news == null || !news.getAuthor().equals(currentUser.getId())) {
                request.setAttribute("error", "Không tìm thấy tin tức hoặc bạn không có quyền xóa!");
                showMyNewsList(request, response, currentUser);
                return;
            }
            
            // Only allow deletion if news is not published
            if (news.getHome() != null && news.getHome() == 1) {
                request.setAttribute("error", "Không thể xóa tin tức đã được xuất bản!");
                showMyNewsList(request, response, currentUser);
                return;
            }
            
            boolean success = newsDAO.deleteNews(newsId);
            if (success) {
                request.setAttribute("message", "Xóa tin tức thành công!");
            } else {
                request.setAttribute("error", "Lỗi khi xóa tin tức!");
            }
            
            response.sendRedirect(request.getContextPath() + "/reporter/news?message=deleted");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            showMyNewsList(request, response, currentUser);
        }
    }
    


 
    private void showEditForm(HttpServletRequest request, HttpServletResponse response, String newsId, User currentUser) 
            throws ServletException, IOException {
        
        News news = newsDAO.getNewsById(newsId);
        if (news == null || !news.getAuthor().equals(currentUser.getId())) {
            request.setAttribute("error", "Không tìm thấy tin tức hoặc bạn không có quyền sửa!");
            showMyNewsList(request, response, currentUser);
            return;
        }
        
        // Load categories cho form
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.setAttribute("news", news);
        request.setAttribute("isEdit", true);
        
        request.getRequestDispatcher("/views/phongvien/news-edit.jsp").forward(request, response);
    }
    
    private void viewNewsDetail(HttpServletRequest request, HttpServletResponse response, String newsId, User currentUser) 
            throws ServletException, IOException {
        
        News news = newsDAO.getNewsById(newsId);
        if (news == null || !news.getAuthor().equals(currentUser.getId())) {
            request.setAttribute("error", "Không tìm thấy tin tức hoặc bạn không có quyền xem!");
            showMyNewsList(request, response, currentUser);
            return;
        }
        
        request.setAttribute("news", news);
        request.getRequestDispatcher("/views/phongvien/news-detail.jsp").forward(request, response);
    }
    
    private void updateNews(HttpServletRequest request, HttpServletResponse response, String newsId, User currentUser) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền sở hữu
        News existingNews = newsDAO.getNewsById(newsId);
        if (existingNews == null || !existingNews.getAuthor().equals(currentUser.getId())) {
            request.setAttribute("error", "Không tìm thấy tin tức hoặc bạn không có quyền sửa!");
            showMyNewsList(request, response, currentUser);
            return;
        }
        
        String title = request.getParameter("title");
        String summary = request.getParameter("summary");
        String content = request.getParameter("content");
        String categoryId = request.getParameter("categoryId");
        String action = request.getParameter("action");
        String requestPublish = request.getParameter("requestPublish");
        
        // Debug log
        System.out.println("📝 Updating news - ID: " + newsId);
        System.out.println("📝 Updating news - Title: " + title);
        
        // Validate
        if (title == null || title.trim().isEmpty() ||
            content == null || content.trim().isEmpty() ||
            categoryId == null || categoryId.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc!");
            showEditForm(request, response, newsId, currentUser);
            return;
        }
        
        try {
            // Handle file upload - theo mẫu tham khảo
            String imageUrl = existingNews.getImage(); // Keep existing image by default
            Part imagePart = request.getPart("imageFile");
            if (imagePart != null && imagePart.getSize() > 0) {
                try {
                    // Lấy tên file gốc
                    String originalFileName = imagePart.getSubmittedFileName();
                    if (originalFileName != null && !originalFileName.isEmpty()) {
                        // Tạo đường dẫn lưu file
                        String uploadPath = "uploads" + java.io.File.separator + "news";
                        String realPath = request.getServletContext().getRealPath("/") + uploadPath;
                        
                        System.out.println("📁 Upload path: " + realPath);
                        
                        // Tạo thư mục nếu chưa tồn tại
                        java.io.File uploadDir = new java.io.File(realPath);
                        if (!uploadDir.exists()) {
                            boolean created = uploadDir.mkdirs();
                            System.out.println("📁 Created directory: " + created);
                        }
                        
                        // Tạo tên file unique
                        String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                        String uniqueFileName = System.currentTimeMillis() + "_" + originalFileName.replaceAll("[^a-zA-Z0-9.]", "_");
                        
                        // Lưu file
                        String fullPath = realPath + java.io.File.separator + uniqueFileName;
                        System.out.println("📁 Full path: " + fullPath);
                        imagePart.write(fullPath);
                        
                        // Đường dẫn để lưu vào database
                        imageUrl = "/uploads/news/" + uniqueFileName;
                        
                        System.out.println("📁 Image updated: " + imageUrl);
                    }
                } catch (Exception e) {
                    System.out.println("❌ Image upload failed: " + e.getMessage());
                    request.setAttribute("error", "Lỗi upload ảnh: " + e.getMessage());
                    showEditForm(request, response, newsId, currentUser);
                    return;
                }
            }
            
            // Update news object
            existingNews.setTitle(title.trim());
            existingNews.setContent(content.trim());
            existingNews.setSummary(summary != null ? summary.trim() : "");
            existingNews.setImage(imageUrl);
            existingNews.setCategoryId(categoryId);
            
            // Set status - 0 for pending approval and reset approval status
            existingNews.setHome(0);
            existingNews.setApprovalStatus(0); // Reset approval status to pending when edited
            
            boolean success = newsDAO.updateNews(existingNews);
            if (success) {
                if ("submit".equals(action) || "1".equals(requestPublish)) {
                    request.setAttribute("message", "Tin tức đã được cập nhật và gửi để duyệt!");
                } else {
                    request.setAttribute("message", "Tin tức đã được cập nhật!");
                }
                response.sendRedirect(request.getContextPath() + "/reporter/news?message=updated");
                return;
            } else {
                request.setAttribute("error", "Lỗi khi cập nhật tin tức!");
                showEditForm(request, response, newsId, currentUser);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            showEditForm(request, response, newsId, currentUser);
        }
    }}