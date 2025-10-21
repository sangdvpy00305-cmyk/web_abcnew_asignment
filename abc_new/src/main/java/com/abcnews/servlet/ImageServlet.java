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
        System.out.println("🖼️ ImageServlet - Request URI: " + request.getRequestURI());
        System.out.println("🖼️ ImageServlet - pathInfo: " + pathInfo);
        
        if (pathInfo == null || pathInfo.equals("/")) {
            System.out.println("❌ ImageServlet - No path info");
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Lấy đường dẫn file
        String filePath = request.getServletContext().getRealPath("/uploads" + pathInfo);
        System.out.println("🖼️ ImageServlet - filePath: " + filePath);
        
        File file = new File(filePath);
        System.out.println("🖼️ ImageServlet - file exists: " + file.exists() + ", isFile: " + file.isFile());
        
        if (!file.exists() || !file.isFile()) {
            System.out.println("❌ ImageServlet - File not found: " + filePath);
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Xác định content type
        String contentType = getServletContext().getMimeType(file.getName());
        if (contentType == null) {
            contentType = "application/octet-stream";
        }
        System.out.println("🖼️ ImageServlet - contentType: " + contentType);
        
        response.setContentType(contentType);
        response.setContentLength((int) file.length());
        
        // Gửi file
        try (FileInputStream in = new FileInputStream(file);
             OutputStream out = response.getOutputStream()) {
            
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
            System.out.println("✅ ImageServlet - File served successfully");
        } catch (Exception e) {
            System.out.println("❌ ImageServlet - Error serving file: " + e.getMessage());
            e.printStackTrace();
        }
    }
}