package com.abcnews.model;

import java.sql.Date;

public class News {
    private String id;
    private String title;
    private String content;
    private String summary;
    private String image;
    private Date postedDate;
    private String author;
    private int viewCount;
    private String categoryId;
    private Integer home; // BIT trong SQL Server -> Integer (0/1)
    
    // Các trường duyệt bài
    private Integer approvalStatus; // 0=Chờ duyệt, 1=Đã duyệt, 2=Từ chối
    private String approvalNote;    // Ghi chú khi duyệt/từ chối
    private Date approvedAt;        // Thời gian duyệt
    private String approvedBy;      // Người duyệt
    
    // Thuộc tính bổ sung để join với bảng khác
    private String authorName;
    private String categoryName;
    private String approvedByName;
    
    public News() {}
    
    public News(String id, String title, String content, String summary, String image, 
                Date postedDate, String author, int viewCount, 
                String categoryId, Integer home) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.summary = summary;
        this.image = image;
        this.postedDate = postedDate;
        this.author = author;
        this.viewCount = viewCount;
        this.categoryId = categoryId;
        this.home = home;
    }
    
    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }
    
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    
    public Date getPostedDate() { return postedDate; }
    public void setPostedDate(Date postedDate) { this.postedDate = postedDate; }
    
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    
    public int getViewCount() { return viewCount; }
    public void setViewCount(int viewCount) { this.viewCount = viewCount; }
    
    public String getCategoryId() { return categoryId; }
    public void setCategoryId(String categoryId) { this.categoryId = categoryId; }
    
    public Integer getHome() { return home; }
    public void setHome(Integer home) { this.home = home; }
    
    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }
    
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    
    public String getApprovedByName() { return approvedByName; }
    public void setApprovedByName(String approvedByName) { this.approvedByName = approvedByName; }
    
    // Getters and Setters cho approval fields
    public Integer getApprovalStatus() { return approvalStatus; }
    public void setApprovalStatus(Integer approvalStatus) { this.approvalStatus = approvalStatus; }
    
    public String getApprovalNote() { return approvalNote; }
    public void setApprovalNote(String approvalNote) { this.approvalNote = approvalNote; }
    
    public Date getApprovedAt() { return approvedAt; }
    public void setApprovedAt(Date approvedAt) { this.approvedAt = approvedAt; }
    
    public String getApprovedBy() { return approvedBy; }
    public void setApprovedBy(String approvedBy) { this.approvedBy = approvedBy; }
    
    // Phương thức tiện ích
    public boolean isHomePage() { return home != null && home == 1; }
    
    public boolean isApproved() { return approvalStatus != null && approvalStatus == 1; }
    public boolean isPending() { return approvalStatus == null || approvalStatus == 0; }
    public boolean isRejected() { return approvalStatus != null && approvalStatus == 2; }
    
    public String getApprovalStatusText() {
        if (approvalStatus == null || approvalStatus == 0) return "Chờ duyệt";
        if (approvalStatus == 1) return "Đã duyệt";
        if (approvalStatus == 2) return "Từ chối";
        return "Không xác định";
    }
}