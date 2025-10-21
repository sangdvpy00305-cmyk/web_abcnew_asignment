package com.abcnews.model;

import java.sql.Timestamp;

public class Newsletter {
    private String id;
    private String email;
    private Integer enabled; // BIT trong SQL Server -> Integer (0/1)
    private Integer isActive; // Alias for enabled
    private Timestamp subscribedAt;
    private Timestamp lastSentAt;
    
    public Newsletter() {}
    
    public Newsletter(String email, Integer enabled) {
        this.email = email;
        this.enabled = enabled;
        this.isActive = enabled;
    }
    
    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public Integer getEnabled() { return enabled; }
    public void setEnabled(Integer enabled) { 
        this.enabled = enabled; 
        this.isActive = enabled;
    }
    
    public Integer getIsActive() { return isActive != null ? isActive : enabled; }
    public void setIsActive(Integer isActive) { 
        this.isActive = isActive;
        this.enabled = isActive;
    }
    
    public Timestamp getSubscribedAt() { return subscribedAt; }
    public void setSubscribedAt(Timestamp subscribedAt) { this.subscribedAt = subscribedAt; }
    
    public Timestamp getLastSentAt() { return lastSentAt; }
    public void setLastSentAt(Timestamp lastSentAt) { this.lastSentAt = lastSentAt; }
    
    // Phương thức tiện ích
    public boolean isEnabled() { return (enabled != null && enabled == 1) || (isActive != null && isActive == 1); }
    
    @Override
    public String toString() {
        return "Newsletter{id='" + id + "', email='" + email + "', enabled=" + enabled + ", subscribedAt=" + subscribedAt + "}";
    }
}