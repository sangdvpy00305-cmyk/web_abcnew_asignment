package com.abcnews.servlet;

import com.abcnews.dao.NewsDAO;
import com.abcnews.dao.CategoryDAO;
import com.abcnews.model.News;
import com.abcnews.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    private NewsDAO newsDAO = new NewsDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String searchKeyword = request.getParameter("q");
        String pageStr = request.getParameter("page");
        
        // Validate search keyword
        if (searchKeyword == null || searchKeyword.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        searchKeyword = searchKeyword.trim();
        
        // Pagination parameters
        int page = 1;
        int pageSize = 12;
        
        try {
            if (pageStr != null) {
                page = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }
        
        try {
            // Perform search
            List<News> allResults = performSearch(searchKeyword);
            
            // Calculate pagination
            int totalNews = allResults.size();
            int totalPages = (int) Math.ceil((double) totalNews / pageSize);
            int startIndex = (page - 1) * pageSize;
            int endIndex = Math.min(startIndex + pageSize, totalNews);
            
            List<News> pagedResults = allResults.subList(startIndex, endIndex);
            
            // Get categories for navigation
            List<Category> categories = categoryDAO.getAllCategories();
            
            // Set attributes
            request.setAttribute("searchKeyword", searchKeyword);
            request.setAttribute("searchResults", pagedResults);
            request.setAttribute("categories", categories);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalNews", totalNews);
            request.setAttribute("pageTitle", "Tìm kiếm: " + searchKeyword + " - ABC News");
            
            // Forward to JSP
            request.getRequestDispatcher("/views/docgia/search-results.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tìm kiếm: " + e.getMessage());
            request.getRequestDispatcher("/views/docgia/search-results.jsp").forward(request, response);
        }
    }
    
    /**
     * Thực hiện tìm kiếm tin tức
     */
    private List<News> performSearch(String keyword) {
        // Get all news
        List<News> allNews = newsDAO.getAllNews();
        
        // Convert keyword to lowercase for case-insensitive search
        String lowerKeyword = keyword.toLowerCase();
        
        // Filter news based on keyword
        return allNews.stream()
            .filter(news -> {
                // Search in title
                if (news.getTitle() != null && 
                    news.getTitle().toLowerCase().contains(lowerKeyword)) {
                    return true;
                }
                
                // Search in content
                if (news.getContent() != null && 
                    news.getContent().toLowerCase().contains(lowerKeyword)) {
                    return true;
                }
                
                // Search in author name
                if (news.getAuthorName() != null && 
                    news.getAuthorName().toLowerCase().contains(lowerKeyword)) {
                    return true;
                }
                
                // Search in category name
                if (news.getCategoryName() != null && 
                    news.getCategoryName().toLowerCase().contains(lowerKeyword)) {
                    return true;
                }
                
                return false;
            })
            .sorted((n1, n2) -> {
                // Sort by relevance (title matches first, then by date)
                boolean n1TitleMatch = n1.getTitle() != null && 
                    n1.getTitle().toLowerCase().contains(lowerKeyword);
                boolean n2TitleMatch = n2.getTitle() != null && 
                    n2.getTitle().toLowerCase().contains(lowerKeyword);
                
                if (n1TitleMatch && !n2TitleMatch) return -1;
                if (!n1TitleMatch && n2TitleMatch) return 1;
                
                // If both or neither match title, sort by date (newest first)
                if (n1.getPostedDate() == null && n2.getPostedDate() == null) return 0;
                if (n1.getPostedDate() == null) return 1;
                if (n2.getPostedDate() == null) return -1;
                
                return n2.getPostedDate().compareTo(n1.getPostedDate());
            })
            .collect(Collectors.toList());
    }
}