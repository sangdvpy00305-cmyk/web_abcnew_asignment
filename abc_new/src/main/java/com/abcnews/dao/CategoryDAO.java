package com.abcnews.dao;

import com.abcnews.model.Category;
import com.abcnews.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    
    // Lấy tất cả danh mục
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT Id, Name FROM CATEGORIES ORDER BY Name";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getString("Id"));
                category.setName(rs.getString("Name"));
                categories.add(category);
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi lấy danh sách danh mục: " + e.getMessage());
            e.printStackTrace();
        }
        return categories;
    }
    
    // Lấy danh mục theo ID
    public Category getCategoryById(String id) {
        String sql = "SELECT Id, Name FROM CATEGORIES WHERE Id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Category category = new Category();
                category.setId(rs.getString("Id"));
                category.setName(rs.getString("Name"));
                return category;
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi lấy danh mục: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    // Thêm danh mục mới
    public boolean addCategory(Category category) {
        String sql = "INSERT INTO CATEGORIES (Id, Name) VALUES (?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, category.getId());
            stmt.setString(2, category.getName());
            
            int result = stmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Lỗi thêm danh mục: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Cập nhật danh mục
    public boolean updateCategory(Category category) {
        String sql = "UPDATE CATEGORIES SET Name = ? WHERE Id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, category.getName());
            stmt.setString(2, category.getId());
            
            int result = stmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Lỗi cập nhật danh mục: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Xóa danh mục
    public boolean deleteCategory(String id) {
        String sql = "DELETE FROM CATEGORIES WHERE Id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, id);
            
            int result = stmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Lỗi xóa danh mục: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Kiểm tra ID danh mục đã tồn tại
    public boolean isCategoryExists(String id) {
        String sql = "SELECT COUNT(*) FROM CATEGORIES WHERE Id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi kiểm tra danh mục: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    // Đếm số tin tức trong danh mục
    public int countNewsByCategory(String categoryId) {
        String sql = "SELECT COUNT(*) FROM NEWS WHERE CategoryId = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, categoryId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi đếm tin tức: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }
}