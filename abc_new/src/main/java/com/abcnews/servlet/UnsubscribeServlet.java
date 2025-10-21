package com.abcnews.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/unsubscribe")
public class UnsubscribeServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Forward to unsubscribe page
        request.getRequestDispatcher("/views/docgia/unsubscribe.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Redirect to newsletter servlet for processing
        String email = request.getParameter("email");
        if (email != null && !email.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/newsletter?action=unsubscribe&email=" + 
                                java.net.URLEncoder.encode(email.trim(), "UTF-8"));
        } else {
            response.sendRedirect(request.getContextPath() + "/unsubscribe?error=empty_email");
        }
    }
}