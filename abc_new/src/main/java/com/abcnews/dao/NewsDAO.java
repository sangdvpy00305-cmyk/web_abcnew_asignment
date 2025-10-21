package com.abcnews.dao;

import com.abcnews.model.News;
import com.abcnews.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NewsDAO {
    
    // Lấy tất cả tin tức với thông tin tác giả và danh mục (cho admin)
    public List<News> getAllNews() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT n.*, u.Fullname as AuthorName, c.Name as CategoryName, " +
                    "approver.Fullname as ApprovedByName " +
                    "FROM NEWS n " +
                    "LEFT JOIN USERS u ON n.Author = u.Id " +
                    "LEFT JOIN CATEGORIES c ON n.CategoryId = c.Id " +
                    "LEFT JOIN USERS approver ON n.ApprovedBy = approver.Id " +
                    "ORDER BY n.PostedDate DESC";
        
        try (ResultSet rs = DatabaseConnection.executeQuery(sql)) {
            while (rs.next()) {
                newsList.add(mapResultSetToNews(rs));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi lấy danh sách tin tức: " + e.getMessage());
        }
        return newsList;
    }
    
    // Lấy chỉ tin tức đã duyệt (cho độc giả)
    public List<News> getApprovedNews() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT n.*, u.Fullname as AuthorName, c.Name as CategoryName " +
                    "FROM NEWS n " +
                    "LEFT JOIN USERS u ON n.Author = u.Id " +
                    "LEFT JOIN CATEGORIES c ON n.CategoryId = c.Id " +
                    "WHERE n.ApprovalStatus = 1 " +
                    "ORDER BY n.PostedDate DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                newsList.add(mapResultSetToNews(rs));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi lấy tin tức đã duyệt: " + e.getMessage());
        }
        return newsList;
    }
    
    // Lấy tin tức trang chủ (đã duyệt và được đánh dấu Home = 1)
    public List<News> getHomePageNews() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT n.*, u.Fullname as AuthorName, c.Name as CategoryName " +
                    "FROM NEWS n " +
                    "LEFT JOIN USERS u ON n.Author = u.Id " +
                    "LEFT JOIN CATEGORIES c ON n.CategoryId = c.Id " +
                    "WHERE n.ApprovalStatus = 1 AND n.Home = 1 " +
                    "ORDER BY n.PostedDate DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                newsList.add(mapResultSetToNews(rs));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi lấy tin tức trang chủ: " + e.getMessage());
        }
        return newsList;
    }
    
    // Lấy tin tức xem nhiều nhất (đã duyệt)
    public List<News> getMostViewedNews(int limit) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT TOP " + limit + " n.*, u.Fullname as AuthorName, c.Name as CategoryName " +
                    "FROM NEWS n " +
                    "LEFT JOIN USERS u ON n.Author = u.Id " +
                    "LEFT JOIN CATEGORIES c ON n.CategoryId = c.Id " +
                    "WHERE n.ApprovalStatus = 1 " +
                    "ORDER BY n.ViewCount DESC, n.PostedDate DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                newsList.add(mapResultSetToNews(rs));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi lấy tin tức xem nhiều nhất: " + e.getMessage());
        }
        return newsList;
    }
    
    // Lấy tin tức mới nhất với giới hạn (chỉ đã duyệt)
    public List<News> getLatestNews(int limit) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT " + (limit > 0 ? "TOP " + limit + " " : "") +
                    "n.*, u.Fullname as AuthorName, c.Name as CategoryName " +
                    "FROM NEWS n " +
                    "LEFT JOIN USERS u ON n.Author = u.Id " +
                    "LEFT JOIN CATEGORIES c ON n.CategoryId = c.Id " +
                    "WHERE n.ApprovalStatus = 1 " +
                    "ORDER BY n.PostedDate DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                newsList.add(mapResultSetToNews(rs));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi lấy tin tức mới nhất: " + e.getMessage());
        }
        return newsList;
    }
    
    // Lấy tin tức theo danh mục với giới hạn (chỉ đã duyệt)
    public List<News> getNewsByCategory(String categoryId, int limit) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT " + (limit > 0 ? "TOP " + limit + " " : "") +
                    "n.*, u.Fullname as AuthorName, c.Name as CategoryName " +
                    "FROM NEWS n " +
                    "LEFT JOIN USERS u ON n.Author = u.Id " +
                    "LEFT JOIN CATEGORIES c ON n.CategoryId = c.Id " +
                    "WHERE n.CategoryId = ? AND n.ApprovalStatus = 1 " +
                    "ORDER BY n.PostedDate DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, categoryId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                newsList.add(mapResultSetToNews(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi lấy tin tức theo danh mục: " + e.getMessage());
        }
        return newsList;
    }
    
    // Lấy tin tức theo danh mục (không giới hạn)
    public List<News> getNewsByCategory(String categoryId) {
        return getNewsByCategory(categoryId, 0); // 0 means no limit
    }
    
    // Tăng số lượt xem
    public boolean incrementViewCount(String newsId) {
        String sql = "UPDATE NEWS SET ViewCount = ViewCount + 1 WHERE Id = ?";
        try {
            int result = DatabaseConnection.executeUpdate(sql, newsId);
            return result > 0;
        } catch (Exception e) {
            System.err.println("Lỗi tăng view count: " + e.getMessage());
            return false;
        }
    }
    
    // Tìm kiếm tin tức theo từ khóa với phân trang (chỉ đã duyệt)
    public List<News> searchNews(String keyword, int page, int pageSize) {
        List<News> newsList = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        
        String sql = "SELECT n.*, u.Fullname as AuthorName, c.Name as CategoryName " +
                    "FROM NEWS n " +
                    "LEFT JOIN USERS u ON n.Author = u.Id " +
                    "LEFT JOIN CATEGORIES c ON n.CategoryId = c.Id " +
                    "WHERE n.ApprovalStatus = 1 AND " +
                    "(n.Title LIKE ? OR n.Content LIKE ? OR u.Fullname LIKE ? OR c.Name LIKE ?) " +
                    "ORDER BY n.PostedDate DESC " +
                    "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        String searchPattern = "%" + keyword + "%";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            stmt.setString(4, searchPattern);
            stmt.setInt(5, offset);
            stmt.setInt(6, pageSize);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                newsList.add(mapResultSetToNews(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi tìm kiếm tin tức: " + e.getMessage());
        }
        return newsList;
    }
    
    // Tìm kiếm tin tức đơn giản (backward compatibility)
    public List<News> searchNews(String keyword) {
        return searchNews(keyword, 1, 1000); // Return first 1000 results
    }
    
    // Đếm số kết quả tìm kiếm
    public int countSearchResults(String keyword) {
        String sql = "SELECT COUNT(*) FROM NEWS n " +
                    "LEFT JOIN USERS u ON n.Author = u.Id " +
                    "LEFT JOIN CATEGORIES c ON n.CategoryId = c.Id " +
                    "WHERE n.ApprovalStatus = 1 AND " +
                    "(n.Title LIKE ? OR n.Content LIKE ? OR u.Fullname LIKE ? OR c.Name LIKE ?)";
        
        String searchPattern = "%" + keyword + "%";
        
        try (ResultSet rs = DatabaseConnection.executeQuery(sql, searchPattern, searchPattern, searchPattern, searchPattern)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi đếm kết quả tìm kiếm: " + e.getMessage());
        }
        return 0;
    }
    
    // Lấy tin tức theo ID (cho admin - không kiểm tra approval)
    public News getNewsById(String id) {
        String sql = "SELECT n.*, u.Fullname as AuthorName, c.Name as CategoryName, " +
                    "approver.Fullname as ApprovedByName " +
                    "FROM NEWS n " +
                    "LEFT JOIN USERS u ON n.Author = u.Id " +
                    "LEFT JOIN CATEGORIES c ON n.CategoryId = c.Id " +
                    "LEFT JOIN USERS approver ON n.ApprovedBy = approver.Id " +
                    "WHERE n.Id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToNews(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi lấy tin tức: " + e.getMessage());
        }
        return null;
    }
    
    // Lấy tin tức theo ID cho độc giả (chỉ đã duyệt)
    public News getApprovedNewsById(String id) {
        String sql = "SELECT n.*, u.Fullname as AuthorName, c.Name as CategoryName " +
                    "FROM NEWS n " +
                    "LEFT JOIN USERS u ON n.Author = u.Id " +
                    "LEFT JOIN CATEGORIES c ON n.CategoryId = c.Id " +
                    "WHERE n.Id = ? AND n.ApprovalStatus = 1";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToNews(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi lấy tin tức đã duyệt: " + e.getMessage());
        }
        return null;
    }
    
    // Thêm tin tức mới
    public boolean addNews(News news) {
        String sql = "INSERT INTO NEWS (Id, Title, Content, Summary, Image, PostedDate, Author, ViewCount, CategoryId, Home, ApprovalStatus) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try {
            // Tạo ID tự động nếu chưa có
            if (news.getId() == null || news.getId().isEmpty()) {
                news.setId("NEWS" + System.currentTimeMillis());
            }
            
            // Debug log
            System.out.println("🔍 NewsDAO.addNews() - Preparing to insert:");
            System.out.println("  ID: " + news.getId());
            System.out.println("  Title: " + news.getTitle());
            System.out.println("  Content length: " + (news.getContent() != null ? news.getContent().length() : "null"));
            System.out.println("  Image: " + news.getImage());
            System.out.println("  Author: " + news.getAuthor());
            System.out.println("  CategoryId: " + news.getCategoryId());
            System.out.println("  Home: " + news.getHome());
            System.out.println("  ApprovalStatus: " + news.getApprovalStatus());
            
            int result = DatabaseConnection.executeUpdate(sql, 
                news.getId(), news.getTitle(), news.getContent(), news.getSummary(), news.getImage(),
                news.getPostedDate(), news.getAuthor(), news.getViewCount(),
                news.getCategoryId(), news.getHome(), news.getApprovalStatus());
                
            System.out.println("🔍 Insert result: " + result);
            return result > 0;
        } catch (Exception e) {
            System.err.println("❌ Lỗi thêm tin tức: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Cập nhật tin tức (đặt lại trạng thái chờ duyệt)
    public boolean updateNews(News news) {
        String sql = "UPDATE NEWS SET Title = ?, Content = ?, Summary = ?, Image = ?, PostedDate = ?, " +
                    "Author = ?, CategoryId = ?, Home = ?, ApprovalStatus = ?, ApprovalNote = NULL, " +
                    "ApprovedAt = NULL, ApprovedBy = NULL WHERE Id = ?";
        
        try {
            int result = DatabaseConnection.executeUpdate(sql, 
                news.getTitle(), news.getContent(), news.getSummary(), news.getImage(), news.getPostedDate(),
                news.getAuthor(), news.getCategoryId(), news.getHome(), news.getApprovalStatus(), news.getId());
            return result > 0;
        } catch (Exception e) {
            System.err.println("Lỗi cập nhật tin tức: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Xóa tin tức
    public boolean deleteNews(String id) {
        String sql = "DELETE FROM NEWS WHERE Id = ?";
        try {
            int result = DatabaseConnection.executeUpdate(sql, id);
            return result > 0;
        } catch (Exception e) {
            System.err.println("Lỗi xóa tin tức: " + e.getMessage());
            return false;
        }
    }
    
    // === APPROVAL WORKFLOW METHODS ===
    
    // Lấy tin tức chờ duyệt
    public List<News> getPendingNews() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT n.*, u.Fullname as AuthorName, c.Name as CategoryName " +
                    "FROM NEWS n " +
                    "LEFT JOIN USERS u ON n.Author = u.Id " +
                    "LEFT JOIN CATEGORIES c ON n.CategoryId = c.Id " +
                    "WHERE n.ApprovalStatus = 0 OR n.ApprovalStatus IS NULL " +
                    "ORDER BY n.PostedDate DESC";
        
        try (ResultSet rs = DatabaseConnection.executeQuery(sql)) {
            while (rs.next()) {
                newsList.add(mapResultSetToNews(rs));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi lấy tin tức chờ duyệt: " + e.getMessage());
        }
        return newsList;
    }
    
    // Đếm tin tức chờ duyệt
    public int countPendingNews() {
        String sql = "SELECT COUNT(*) FROM NEWS WHERE ApprovalStatus = 0 OR ApprovalStatus IS NULL";
        try (ResultSet rs = DatabaseConnection.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi đếm tin tức chờ duyệt: " + e.getMessage());
        }
        return 0;
    }
    
    // Cập nhật trạng thái duyệt tin tức
    public boolean updateNewsApprovalStatus(String newsId, int approvalStatus, String approvedBy, String approvalNote) {
        String sql = "UPDATE NEWS SET ApprovalStatus = ?, ApprovedBy = ?, ApprovedAt = ?, ApprovalNote = ? WHERE Id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, approvalStatus);
            stmt.setString(2, approvedBy);
            
            if (approvalStatus == 1) { // Approved
                stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
                stmt.setString(4, null); // Clear approval note
            } else if (approvalStatus == 2) { // Rejected
                stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
                stmt.setString(4, approvalNote);
            } else { // Pending
                stmt.setTimestamp(3, null);
                stmt.setString(4, null);
            }
            
            stmt.setString(5, newsId);
            
            int rowsAffected = stmt.executeUpdate();
            System.out.println("✅ Updated approval status for news " + newsId + ": " + approvalStatus);
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ Lỗi cập nhật trạng thái duyệt: " + e.getMessage());
            return false;
        }
    }
    
    // Map ResultSet to News object
    private News mapResultSetToNews(ResultSet rs) throws SQLException {
        News news = new News();
        news.setId(rs.getString("Id"));
        news.setTitle(rs.getString("Title"));
        news.setContent(rs.getString("Content"));
        news.setSummary(rs.getString("Summary"));
        news.setImage(rs.getString("Image"));
        news.setPostedDate(rs.getDate("PostedDate"));
        news.setAuthor(rs.getString("Author"));
        news.setViewCount(rs.getInt("ViewCount"));
        news.setCategoryId(rs.getString("CategoryId"));
        
        // Handle BIT field which can be Boolean or Integer
        Object home = rs.getObject("Home");
        if (home instanceof Boolean) {
            news.setHome(((Boolean) home) ? 1 : 0);
        } else if (home instanceof Integer) {
            news.setHome((Integer) home);
        } else {
            news.setHome(0);
        }
        
        // Thông tin join
        news.setAuthorName(rs.getString("AuthorName"));
        news.setCategoryName(rs.getString("CategoryName"));
        
        // Approval fields (có thể null nếu chưa có cột trong DB)
        try {
            news.setApprovalStatus(rs.getObject("ApprovalStatus") != null ? rs.getInt("ApprovalStatus") : 1);
            news.setApprovalNote(rs.getString("ApprovalNote"));
            news.setApprovedAt(rs.getDate("ApprovedAt"));
            news.setApprovedBy(rs.getString("ApprovedBy"));
            news.setApprovedByName(rs.getString("ApprovedByName"));
        } catch (SQLException e) {
            // Nếu cột chưa tồn tại, set default
            news.setApprovalStatus(1); // Mặc định là đã duyệt
        }
        
        return news;
    }
}