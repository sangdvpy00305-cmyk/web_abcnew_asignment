package com.abcnews.servlet;

import com.abcnews.dao.NewsDAO;
import com.abcnews.dao.CategoryDAO;
import com.abcnews.dao.UserDAO;
import com.abcnews.model.News;
import com.abcnews.model.Category;
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

@WebServlet({"/admin/news", "/admin/news/*", "/admin/news/approve", "/admin/news/reject"})
public class AdminNewsServlet extends HttpServlet {
    private NewsDAO newsDAO = new NewsDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền admin
        if (!checkAdminPermission(request, response)) return;
        
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // Hiển thị danh sách tin tức
                showNewsList(request, response);
            } else if (pathInfo.equals("/add")) {
                // Hiển thị form thêm tin tức
                loadFormData(request);
                request.getRequestDispatcher("/views/admin/news-add.jsp").forward(request, response);
            } else if (pathInfo.startsWith("/edit/")) {
                // Hiển thị form sửa tin tức
                String newsId = pathInfo.substring(6);
                News news = newsDAO.getNewsById(newsId);
                if (news != null) {
                    request.setAttribute("news", news);
                    loadFormData(request);
                    request.getRequestDispatcher("/views/admin/news-edit.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Không tìm thấy tin tức!");
                    showNewsList(request, response);
                }
            } else if (pathInfo.startsWith("/delete/")) {
                // Xóa tin tức
                String newsId = pathInfo.substring(8);
                boolean success = newsDAO.deleteNews(newsId);
                if (success) {
                    request.setAttribute("success", "Xóa tin tức thành công!");
                } else {
                    request.setAttribute("error", "Lỗi khi xóa tin tức!");
                }
                showNewsList(request, response);
            } else if (pathInfo.startsWith("/view/")) {
                // Xem chi tiết tin tức
                String newsId = pathInfo.substring(6);
                News news = newsDAO.getNewsById(newsId);
                if (news != null) {
                    // Tăng lượt xem
                    newsDAO.incrementViewCount(newsId);
                    request.setAttribute("news", news);
                    request.getRequestDispatcher("/views/admin/news-view.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Không tìm thấy tin tức!");
                    showNewsList(request, response);
                }
            } else if (pathInfo.startsWith("/approve/")) {
                // Duyệt tin tức
                String newsId = pathInfo.substring(9);
                approveNews(request, response, newsId);
            } else if (pathInfo.startsWith("/reject/")) {
                // Từ chối tin tức
                String newsId = pathInfo.substring(8);
                rejectNews(request, response, newsId);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            showNewsList(request, response);
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
                // Thêm tin tức mới
                addNews(request, response);
            } else if (pathInfo != null && pathInfo.startsWith("/edit/")) {
                // Cập nhật tin tức
                String newsId = pathInfo.substring(6);
                updateNews(request, response, newsId);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            showNewsList(request, response);
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
    
    private void loadFormData(HttpServletRequest request) {
        // Load categories và users cho form
        List<Category> categories = categoryDAO.getAllCategories();
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("categories", categories);
        request.setAttribute("users", users);
    }
    
    private void showNewsList(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy parameters tìm kiếm và lọc
        String search = request.getParameter("search");
        String categoryFilter = request.getParameter("category");
        String statusFilter = request.getParameter("status");
        
        List<News> newsList = newsDAO.getAllNews();
        List<Category> categories = categoryDAO.getAllCategories();
        
        // Áp dụng bộ lọc
        if (newsList != null) {
            // Lọc theo từ khóa tìm kiếm
            if (search != null && !search.trim().isEmpty()) {
                newsList = newsList.stream()
                    .filter(news -> news.getTitle().toLowerCase().contains(search.toLowerCase()) ||
                                   (news.getContent() != null && news.getContent().toLowerCase().contains(search.toLowerCase())))
                    .collect(java.util.stream.Collectors.toList());
            }
            
            // Lọc theo danh mục
            if (categoryFilter != null && !categoryFilter.trim().isEmpty()) {
                newsList = newsList.stream()
                    .filter(news -> categoryFilter.equals(news.getCategoryId()))
                    .collect(java.util.stream.Collectors.toList());
            }
            
            // Lọc theo trạng thái
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                int status = Integer.parseInt(statusFilter);
                newsList = newsList.stream()
                    .filter(news -> news.getHome() != null && news.getHome() == status)
                    .collect(java.util.stream.Collectors.toList());
            }
        }
        
        System.out.println("📰 AdminNewsServlet - Filtered news: " + (newsList != null ? newsList.size() : 0));
        
        request.setAttribute("newsList", newsList);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/views/admin/news-list.jsp").forward(request, response);
    }
    
    private void addNews(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String summary = request.getParameter("summary");
        String image = request.getParameter("image");
        String author = request.getParameter("author");
        String categoryId = request.getParameter("categoryId");
        String homeStr = request.getParameter("home");
        
        // Validate
        if (id == null || id.trim().isEmpty() || 
            title == null || title.trim().isEmpty() ||
            content == null || content.trim().isEmpty() ||
            author == null || author.trim().isEmpty() ||
            categoryId == null || categoryId.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc!");
            loadFormData(request);
            request.getRequestDispatcher("/views/admin/news-add.jsp").forward(request, response);
            return;
        }
        
        try {
            News news = new News();
            news.setId(id.trim());
            news.setTitle(title.trim());
            news.setContent(content.trim());
            news.setSummary(summary != null ? summary.trim() : "");
            news.setImage(image);
            news.setPostedDate(new Date(System.currentTimeMillis()));
            news.setAuthor(author);
            news.setViewCount(0);
            news.setCategoryId(categoryId);
            news.setHome(homeStr != null ? 1 : 0);
            
            boolean success = newsDAO.addNews(news);
            if (success) {
                request.setAttribute("success", "Thêm tin tức thành công!");
                showNewsList(request, response);
            } else {
                request.setAttribute("error", "Lỗi khi thêm tin tức!");
                loadFormData(request);
                request.getRequestDispatcher("/views/admin/news-add.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi dữ liệu: " + e.getMessage());
            loadFormData(request);
            request.getRequestDispatcher("/views/admin/news-add.jsp").forward(request, response);
        }
    }
    
    private void updateNews(HttpServletRequest request, HttpServletResponse response, String newsId) 
            throws ServletException, IOException {
        
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String summary = request.getParameter("summary");
        String image = request.getParameter("image");
        String author = request.getParameter("author");
        String categoryId = request.getParameter("categoryId");
        String homeStr = request.getParameter("home");
        
        try {
            News news = newsDAO.getNewsById(newsId);
            if (news == null) {
                request.setAttribute("error", "Không tìm thấy tin tức!");
                showNewsList(request, response);
                return;
            }
            
            // Cập nhật thông tin
            if (title != null && !title.trim().isEmpty()) {
                news.setTitle(title.trim());
            }
            if (content != null && !content.trim().isEmpty()) {
                news.setContent(content.trim());
            }
            news.setSummary(summary != null ? summary.trim() : "");
            news.setImage(image);
            if (author != null && !author.trim().isEmpty()) {
                news.setAuthor(author);
            }
            if (categoryId != null && !categoryId.trim().isEmpty()) {
                news.setCategoryId(categoryId);
            }
            news.setHome(homeStr != null ? 1 : 0);
            
            boolean success = newsDAO.updateNews(news);
            if (success) {
                request.setAttribute("success", "Cập nhật tin tức thành công!");
            } else {
                request.setAttribute("error", "Lỗi khi cập nhật tin tức!");
            }
            showNewsList(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi dữ liệu: " + e.getMessage());
            showNewsList(request, response);
        }
    }
    
    private void approveNews(HttpServletRequest request, HttpServletResponse response, String newsId) 
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");
            
            boolean success = newsDAO.updateNewsApprovalStatus(newsId, 1, currentUser.getId(), null);
            
            if (success) {
                request.setAttribute("success", "✅ Đã duyệt tin tức thành công!");
            } else {
                request.setAttribute("error", "❌ Lỗi khi duyệt tin tức!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "❌ Lỗi hệ thống: " + e.getMessage());
        }
        showNewsList(request, response);
    }
    
    private void rejectNews(HttpServletRequest request, HttpServletResponse response, String newsId) 
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");
            String rejectReason = request.getParameter("reason");
            
            String note = rejectReason != null && !rejectReason.trim().isEmpty() 
                ? rejectReason.trim() 
                : "Từ chối bởi " + currentUser.getFullname();
            
            boolean success = newsDAO.updateNewsApprovalStatus(newsId, 2, currentUser.getId(), note);
            
            if (success) {
                request.setAttribute("success", "⚠️ Đã từ chối tin tức!");
            } else {
                request.setAttribute("error", "❌ Lỗi khi từ chối tin tức!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "❌ Lỗi hệ thống: " + e.getMessage());
        }
        showNewsList(request, response);
    }
}   