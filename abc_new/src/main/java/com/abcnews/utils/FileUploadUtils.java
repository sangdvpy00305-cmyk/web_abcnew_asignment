package com.abcnews.utils;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

/**
 * Utility class để xử lý upload file
 */
public class FileUploadUtils {
    
    // Các định dạng ảnh được phép
    private static final List<String> ALLOWED_IMAGE_TYPES = Arrays.asList(
        "image/jpeg", "image/jpg", "image/png", "image/gif"
    );
    
    // Kích thước file tối đa (5MB)
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
    
    /**
     * Upload ảnh tin tức
     */
    public static String uploadNewsImage(HttpServletRequest request, Part imagePart) 
            throws ServletException, IOException {
        
        if (imagePart == null || imagePart.getSize() == 0) {
            return null; // Không có file được upload
        }
        
        // Kiểm tra kích thước file
        if (imagePart.getSize() > MAX_FILE_SIZE) {
            throw new ServletException("File quá lớn! Kích thước tối đa cho phép là 5MB.");
        }
        
        // Kiểm tra định dạng file
        String contentType = imagePart.getContentType();
        if (!ALLOWED_IMAGE_TYPES.contains(contentType)) {
            throw new ServletException("Định dạng file không được hỗ trợ! Chỉ chấp nhận: JPG, PNG, GIF.");
        }
        
        // Lấy tên file gốc
        String originalFileName = getFileName(imagePart);
        if (originalFileName == null || originalFileName.isEmpty()) {
            throw new ServletException("Tên file không hợp lệ!");
        }
        
        // Tạo tên file unique
        String fileExtension = getFileExtension(originalFileName);
        String uniqueFileName = UUID.randomUUID().toString() + "_" + System.currentTimeMillis() + fileExtension;
        
        // Đường dẫn lưu file
        String uploadPath = "uploads" + File.separator + "news";
        String realPath = request.getServletContext().getRealPath("/") + uploadPath;
        
        // Tạo thư mục nếu chưa tồn tại
        File uploadDir = new File(realPath);
        if (!uploadDir.exists()) {
            boolean created = uploadDir.mkdirs();
            System.out.println("📁 Created upload directory: " + realPath + " - Success: " + created);
        }
        
        // Lưu file
        String fullPath = realPath + File.separator + uniqueFileName;
        System.out.println("📁 Saving file to: " + fullPath);
        imagePart.write(fullPath);
        
        // Trả về đường dẫn relative để lưu vào database
        String relativePath = "/uploads/news/" + uniqueFileName;
        System.out.println("📁 Returning relative path: " + relativePath);
        return relativePath;
    }
    
    /**
     * Xóa ảnh cũ khi cập nhật
     */
    public static boolean deleteOldImage(HttpServletRequest request, String imagePath) {
        if (imagePath == null || imagePath.isEmpty()) {
            return true;
        }
        
        try {
            String realPath = request.getServletContext().getRealPath(imagePath);
            File file = new File(realPath);
            if (file.exists()) {
                return file.delete();
            }
            return true;
        } catch (Exception e) {
            System.err.println("Lỗi xóa file cũ: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Lấy tên file từ Part
     */
    private static String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition != null) {
            for (String content : contentDisposition.split(";")) {
                if (content.trim().startsWith("filename")) {
                    String fileName = content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
                    return fileName;
                }
            }
        }
        return null;
    }
    
    /**
     * Lấy phần mở rộng của file
     */
    private static String getFileExtension(String fileName) {
        if (fileName != null && fileName.lastIndexOf('.') > 0) {
            return fileName.substring(fileName.lastIndexOf('.'));
        }
        return "";
    }
    
    /**
     * Kiểm tra file có phải là ảnh không
     */
    public static boolean isValidImageFile(Part part) {
        if (part == null || part.getSize() == 0) {
            return false;
        }
        
        String contentType = part.getContentType();
        return ALLOWED_IMAGE_TYPES.contains(contentType);
    }
    
    /**
     * Format kích thước file để hiển thị
     */
    public static String formatFileSize(long size) {
        if (size < 1024) {
            return size + " B";
        } else if (size < 1024 * 1024) {
            return String.format("%.1f KB", size / 1024.0);
        } else {
            return String.format("%.1f MB", size / (1024.0 * 1024.0));
        }
    }
}