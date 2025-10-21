package com.abcnews.model;

import java.sql.Date;

public class User {
    private String id;
    private String password;
    private String fullname;
    private Date birthday;
    private Integer gender; // BIT trong SQL Server -> Integer (0/1)
    private String mobile;
    private String email;
    private Integer role; // BIT trong SQL Server -> Integer (1 = quản trị, 0 = phóng viên)
    
    // Additional fields for profile
    private String username; // Alias for id
    private String fullName; // Alias for fullname
    private String phone; // Alias for mobile
    private String bio; // Biography/description
    private String avatar; // Avatar image URL
    
    public User() {}
    
    public User(String id, String password, String fullname, Date birthday, 
                Integer gender, String mobile, String email, Integer role) {
        this.id = id;
        this.password = password;
        this.fullname = fullname;
        this.birthday = birthday;
        this.gender = gender;
        this.mobile = mobile;
        this.email = email;
        this.role = role;
    }
    
    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }
    
    public Date getBirthday() { return birthday; }
    public void setBirthday(Date birthday) { this.birthday = birthday; }
    
    public Integer getGender() { return gender; }
    public void setGender(Integer gender) { this.gender = gender; }
    
    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public Integer getRole() { return role; }
    public void setRole(Integer role) { this.role = role; }
    
    // Additional getters and setters
    public String getUsername() { return id; } // Username is same as id
    public void setUsername(String username) { this.id = username; }
    
    public String getFullName() { return fullname; }
    public void setFullName(String fullName) { this.fullname = fullName; }
    
    public String getPhone() { return mobile; }
    public void setPhone(String phone) { this.mobile = phone; }
    
    public String getBio() { return bio; }
    public void setBio(String bio) { this.bio = bio; }
    
    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; }
    
    // Phương thức tiện ích
    public boolean isAdmin() { 
        System.out.println("🔍 User.isAdmin() - role: " + role + ", result: " + (role != null && role == 1));
        return role != null && role == 1; 
    }
    
    public boolean isReporter() { 
        System.out.println("🔍 User.isReporter() - role: " + role + ", result: " + (role != null && role == 0));
        return role != null && role == 0; 
    }
    
    public boolean isMale() { return gender != null && gender == 1; }
    public boolean isFemale() { return gender != null && gender == 0; }
    
    // Debug method
    public String getDebugInfo() {
        return String.format("User{id='%s', fullname='%s', role=%d, isAdmin=%b, isReporter=%b}", 
            id, fullname, role, isAdmin(), isReporter());
    }
}