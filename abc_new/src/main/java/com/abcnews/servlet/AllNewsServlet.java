package com.abcnews.servlet;

import com.abcnews.dao.*;
import com.abcnews.model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/all-news")
public class AllNewsServlet extends HttpServlet {
    private NewsDAO newsDAO = new NewsDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Lấy parameters cho phân trang
            String pageStr = request.getParameter("page");
            int page = 1;
            int pageSize = 12; // 12 tin mỗi trang
            
            try {
                if (pageStr != null) {
                    page = Integer.parseInt(pageStr);
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
            
            // Lấy tất cả tin tức đã duyệt
            List<News> allNews = newsDAO.getApprovedNews();
            
            // Tính toán phân trang
            int totalNews = allNews.size();
            int totalPages = (int) Math.ceil((double) totalNews / pageSize);
            int startIndex = (page - 1) * pageSize;
            int endIndex = Math.min(startIndex + pageSize, totalNews);
            
            List<News> pagedNews = totalNews > 0 ? allNews.subList(startIndex, endIndex) : allNews;
            
            // Lấy danh sách danh mục cho menu
            List<Category> categories = categoryDAO.getAllCategories();
            
            // Đặt dữ liệu vào request
            request.setAttribute("allNews", pagedNews);
            request.setAttribute("categories", categories);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalNews", totalNews);
            request.setAttribute("pageTitle", "Tất cả tin tức - ABC News");
            
            // Forward đến trang JSP
            request.getRequestDispatcher("/views/docgia/all-news.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/views/docgia/all-news.jsp").forward(request, response);
        }
    }
}