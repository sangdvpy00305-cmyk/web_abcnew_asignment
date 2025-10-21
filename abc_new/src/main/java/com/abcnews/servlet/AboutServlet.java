package com.abcnews.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/about")
public class AboutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set page title
        request.setAttribute("pageTitle", "Về chúng tôi - ABC News");
        
        // Forward to JSP
        request.getRequestDispatcher("/views/docgia/about.jsp").forward(request, response);
    }
}