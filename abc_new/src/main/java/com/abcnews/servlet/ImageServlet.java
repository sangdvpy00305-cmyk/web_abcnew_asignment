package com.abcnews.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/uploads/*")
public class ImageServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Lấy đường dẫn file
        String filePath = request.getServletContext().getRealPath("/uploads" + pathInfo);
        File file = new File(filePath);
        
        System.out.println("🖼️ ImageServlet - Requested path: " + pathInfo);
        System.out.println("🖼️ ImageServlet - Full file path: " + filePath);
        System.out.println("🖼️ ImageServlet - File exists: " + file.exists());
        
        if (!file.exists() || !file.isFile()) {
            System.out.println("❌ ImageServlet - File not found: " + filePath);
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Xác định content type
        String contentType = getServletContext().getMimeType(file.getName());
        if (contentType == null) {
            // Xác định content type dựa trên extension
            String fileName = file.getName().toLowerCase();
            if (fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")) {
                contentType = "image/jpeg";
            } else if (fileName.endsWith(".png")) {
                contentType = "image/png";
            } else if (fileName.endsWith(".gif")) {
                contentType = "image/gif";
            } else if (fileName.endsWith(".webp")) {
                contentType = "image/webp";
            } else {
                contentType = "application/octet-stream";
            }
        }
        
        response.setContentType(contentType);
        response.setContentLength((int) file.length());
        
        // Set cache headers for better performance
        response.setHeader("Cache-Control", "public, max-age=3600");
        response.setDateHeader("Expires", System.currentTimeMillis() + 3600000);
        
        // Gửi file
        try (FileInputStream in = new FileInputStream(file);
             OutputStream out = response.getOutputStream()) {
            
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
            System.out.println("✅ ImageServlet - Successfully served: " + pathInfo);
        } catch (Exception e) {
            System.err.println("❌ ImageServlet - Error serving file: " + e.getMessage());
            e.printStackTrace();
        }
    }
}