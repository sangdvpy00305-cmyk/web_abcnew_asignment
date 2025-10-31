package com.abcnews.servlet;

import com.abcnews.utils.NewsletterUtils;
import com.abcnews.utils.NewsletterUtils.NewsletterResult;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/newsletter")
public class NewsletterServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Setup response
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        
        try {
            String email = request.getParameter("email");
            String action = request.getParameter("action");
            
            System.out.println("📧 Newsletter - Processing: " + action + " for " + email);
            
            // Basic validation
            if (email == null || email.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_OK); // 200 thay vì 400
                response.getWriter().print("error_empty_email");
                return;
            }
            
            if (!"subscribe".equals(action)) {
                response.setStatus(HttpServletResponse.SC_OK); // 200 thay vì 400
                response.getWriter().print("error_invalid_action");
                return;
            }
            
            // Process subscription
            NewsletterResult result = NewsletterUtils.subscribeNewsletter(email.trim());
            
            // Always return 200 OK for AJAX requests
            response.setStatus(HttpServletResponse.SC_OK);
            
            if (result.isSuccess()) {
                if ("ALREADY_SUBSCRIBED".equals(result.getErrorCode())) {
                    response.getWriter().print("error_already_subscribed");
                } else {
                    response.getWriter().print("success");
                }
            } else {
                if ("INVALID_EMAIL".equals(result.getErrorCode())) {
                    response.getWriter().print("error_invalid_email");
                } else {
                    System.err.println("❌ Newsletter subscription failed: " + result.getMessage());
                    response.getWriter().print("error");
                }
            }
            
        } catch (Exception e) {
            System.err.println("❌ Newsletter servlet error: " + e.getMessage());
            e.printStackTrace();
            
            // Return 200 OK with error message instead of 500
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().print("error");
        }
    }
}