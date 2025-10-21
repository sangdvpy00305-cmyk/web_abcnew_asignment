package com.abcnews.servlet;

import com.abcnews.dao.CategoryDAO;
import com.abcnews.model.Category;
import com.abcnews.utils.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/test/categories")
public class TestCategoryServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>Test Category</title></head><body>");
        out.println("<h1>Test Category DAO</h1>");
        
        try {
            // Test database connection
            out.println("<h2>1. Test Database Connection</h2>");
            boolean connected = DatabaseConnection.testConnection();
            out.println("<p>Database connected: " + connected + "</p>");
            
            // Test CategoryDAO
            out.println("<h2>2. Test CategoryDAO</h2>");
            CategoryDAO dao = new CategoryDAO();
            
            // Test get all categories
            out.println("<h3>Get All Categories:</h3>");
            List<Category> categories = dao.getAllCategories();
            out.println("<p>Found " + categories.size() + " categories:</p>");
            out.println("<ul>");
            for (Category cat : categories) {
                out.println("<li>" + cat.getId() + " - " + cat.getName() + "</li>");
            }
            out.println("</ul>");
            
            // Test add category
            out.println("<h3>Test Add Category:</h3>");
            Category testCat = new Category();
            testCat.setId("TEST_" + System.currentTimeMillis());
            testCat.setName("Test Category " + System.currentTimeMillis());
            
            boolean added = dao.addCategory(testCat);
            out.println("<p>Add result: " + added + "</p>");
            
            if (added) {
                // Test get by ID
                out.println("<h3>Test Get By ID:</h3>");
                Category retrieved = dao.getCategoryById(testCat.getId());
                out.println("<p>Retrieved: " + (retrieved != null ? retrieved.getName() : "null") + "</p>");
                
                // Test delete
                out.println("<h3>Test Delete:</h3>");
                boolean deleted = dao.deleteCategory(testCat.getId());
                out.println("<p>Delete result: " + deleted + "</p>");
            }
            
        } catch (Exception e) {
            out.println("<h2 style='color: red;'>ERROR:</h2>");
            out.println("<pre>");
            e.printStackTrace(out);
            out.println("</pre>");
        }
        
        out.println("<p><a href='" + request.getContextPath() + "/admin/categories'>Go to Category Management</a></p>");
        out.println("</body></html>");
    }
}