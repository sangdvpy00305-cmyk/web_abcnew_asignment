package com.abcnews.dao;

import com.abcnews.model.User;
import com.abcnews.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    
    // Đăng nhập
    public User login(String id, String password) {
        String sql = "SELECT * FROM USERS WHERE Id = ? AND Password = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, id);
            stmt.setString(2, password);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi đăng nhập: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Lỗi đóng kết nối: " + e.getMessage());
            }
        }
        return null;
    }
    
    // Lấy tất cả người dùng
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM USERS ORDER BY Fullname";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi lấy danh sách người dùng: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Lỗi đóng kết nối: " + e.getMessage());
            }
        }
        return users;
    }
    
    // Lấy người dùng theo ID
    public User getUserById(String id) {
        String sql = "SELECT * FROM USERS WHERE Id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, id);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi lấy người dùng: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Lỗi đóng kết nối: " + e.getMessage());
            }
        }
        return null;
    }
    
    // Thêm người dùng mới
    public boolean addUser(User user) {
        String sql = "INSERT INTO USERS (Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            int result = DatabaseConnection.executeUpdate(sql, 
                user.getUsername(), user.getPassword(), user.getFullname(), 
                user.getBirthday(), user.getGender(), user.getMobile(), 
                user.getEmail(), user.getRole());
            return result > 0;
        } catch (Exception e) {
            System.err.println("Lỗi thêm người dùng: " + e.getMessage());
            return false;
        }
    }
    
    // Cập nhật người dùng
    public boolean updateUser(User user) {
        String sql = "UPDATE USERS SET Password = ?, Fullname = ?, Birthday = ?, Gender = ?, Mobile = ?, Email = ?, Role = ? WHERE Id = ?";
        try {
            int result = DatabaseConnection.executeUpdate(sql, 
                user.getPassword(), user.getFullname(), user.getBirthday(), 
                user.getGender(), user.getMobile(), user.getEmail(), 
                user.getRole(), user.getId());
            return result > 0;
        } catch (Exception e) {
            System.err.println("Lỗi cập nhật người dùng: " + e.getMessage());
            return false;
        }
    }
    
    // Cập nhật người dùng không thay đổi password
    public boolean updateUserWithoutPassword(User user) {
        String sql = "UPDATE USERS SET Fullname = ?, Birthday = ?, Gender = ?, Mobile = ?, Email = ?, Role = ? WHERE Id = ?";
        try {
            int result = DatabaseConnection.executeUpdate(sql, 
                user.getFullname(), user.getBirthday(), 
                user.getGender(), user.getMobile(), 
                user.getEmail(), user.getRole(), 
                user.getId());
            return result > 0;
        } catch (Exception e) {
            System.err.println("Lỗi cập nhật người dùng: " + e.getMessage());
            return false;
        }
    }
    
    // Kiểm tra username đã tồn tại
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM USERS WHERE Id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            System.err.println("Lỗi kiểm tra username: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Lỗi đóng kết nối: " + e.getMessage());
            }
        }
        return false;
    }
    
    // Xóa người dùng
    public boolean deleteUser(String id) {
        String sql = "DELETE FROM USERS WHERE Id = ?";
        try {
            int result = DatabaseConnection.executeUpdate(sql, id);
            return result > 0;
        } catch (Exception e) {
            System.err.println("Lỗi xóa người dùng: " + e.getMessage());
            return false;
        }
    }
    
    // Kiểm tra ID đã tồn tại
    public boolean isUserExists(String id) {
        String sql = "SELECT COUNT(*) FROM USERS WHERE Id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, id);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi kiểm tra người dùng: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Lỗi đóng kết nối: " + e.getMessage());
            }
        }
        return false;
    }
    
    // Lấy người dùng theo username và password (cho đổi mật khẩu)
    public User getUserByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM USERS WHERE Id = ? AND Password = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi xác thực người dùng: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Lỗi đóng kết nối: " + e.getMessage());
            }
        }
        return null;
    }
    
    // Cập nhật mật khẩu
    public boolean updatePassword(String userId, String newPassword) {
        String sql = "UPDATE USERS SET Password = ? WHERE Id = ?";
        try {
            int result = DatabaseConnection.executeUpdate(sql, newPassword, userId);
            return result > 0;
        } catch (Exception e) {
            System.err.println("Lỗi cập nhật mật khẩu: " + e.getMessage());
            return false;
        }
    }
    
    // Cập nhật thông tin profile (không bao gồm mật khẩu)
    public boolean updateProfile(User user) {
        String sql = "UPDATE USERS SET Fullname = ?, Email = ?, Mobile = ?, Bio = ?, Avatar = ? WHERE Id = ?";
        try {
            int result = DatabaseConnection.executeUpdate(sql, 
                user.getFullName(), user.getEmail(), user.getPhone(), 
                user.getBio(), user.getAvatar(), user.getId());
            return result > 0;
        } catch (Exception e) {
            System.err.println("Lỗi cập nhật profile: " + e.getMessage());
            return false;
        }
    }
    
    // Map ResultSet to User object
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getString("Id"));
        user.setPassword(rs.getString("Password"));
        user.setFullname(rs.getString("Fullname"));
        user.setBirthday(rs.getDate("Birthday"));
        
        // Handle BIT field which can be Boolean or Integer
        Object gender = rs.getObject("Gender");
        if (gender instanceof Boolean) {
            user.setGender(((Boolean) gender) ? 1 : 0);
        } else if (gender instanceof Integer) {
            user.setGender((Integer) gender);
        } else {
            user.setGender(null);
        }
        
        user.setMobile(rs.getString("Mobile"));
        user.setEmail(rs.getString("Email"));
        
        // Handle BIT field which can be Boolean or Integer
        Object role = rs.getObject("Role");
        if (role instanceof Boolean) {
            user.setRole(((Boolean) role) ? 1 : 0);
        } else if (role instanceof Integer) {
            user.setRole((Integer) role);
        } else {
            user.setRole(null);
        }
        
        return user;
    }
}