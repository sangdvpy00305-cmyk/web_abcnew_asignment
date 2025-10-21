package com.abcnews.servlet;

import com.abcnews.dao.*;
import com.abcnews.model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.util.stream.Collectors;

@WebServlet({"/home", "/", "/news/*", "/category/*", "/searchs"})
public class HomeServlet extends HttpServlet {
    private NewsDAO newsDAO = new NewsDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        String servletPath = request.getServletPath();
        
        try {
            if (servletPath.equals("/news") && pathInfo != null) {
                // Xử lý trang chi tiết tin tức: /news/{id}
                handleNewsDetail(request, response, pathInfo);
            } else if (servletPath.equals("/category") && pathInfo != null) {
                // Xử lý trang danh sách tin theo loại: /category/{id}
                handleCategoryNews(request, response, pathInfo);
            } else if (servletPath.equals("/search")) {
                // Xử lý tìm kiếm
                handleSearch(request, response);
            } else {
                // Trang chủ
                handleHomePage(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/views/docgia/index.jsp").forward(request, response);
        }
    }
    
    /**
     * Xử lý trang chủ
     */
    private void handleHomePage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("🏠 Loading homepage data...");
        
        // Lấy tin tức trang chủ (featured)
        List<News> featuredNews = newsDAO.getHomePageNews();
        System.out.println("📰 Featured news count: " + featuredNews.size());
        
        // Lấy 5 tin tức hot nhất (xem nhiều nhất)
        List<News> hotNews = newsDAO.getMostViewedNews(5);
        System.out.println("🔥 Hot news count: " + hotNews.size());
        
        // Lấy 5 tin tức mới nhất
        List<News> latestNews = newsDAO.getLatestNews(5);
        System.out.println("⏰ Latest news count: " + latestNews.size());
        
        // Lấy 5 tin tức đã xem gần đây từ session
        List<News> recentViewedNews = getRecentViewedNews(request);
        
        // Lấy danh sách danh mục cho menu
        List<Category> categories = categoryDAO.getAllCategories();
        
        // Đặt dữ liệu vào request
        request.setAttribute("featuredNews", featuredNews);
        request.setAttribute("hotNews", hotNews);
        request.setAttribute("latestNews", latestNews);
        request.setAttribute("recentViewedNews", recentViewedNews);
        request.setAttribute("categories", categories);
        request.setAttribute("pageTitle", "Trang chủ - ABC News");
        
        // Forward đến trang JSP
        request.getRequestDispatcher("/views/docgia/index.jsp").forward(request, response);
    }
    
    /**
     * Xử lý trang chi tiết tin tức
     */
    private void handleNewsDetail(HttpServletRequest request, HttpServletResponse response, String pathInfo) 
            throws ServletException, IOException {
        
        String newsId = pathInfo.substring(1); // Bỏ dấu / đầu
        
        // Lấy tin tức chi tiết (chỉ đã duyệt)
        News news = newsDAO.getApprovedNewsById(newsId);
        if (news == null) {
            // Redirect to custom 404 page
            request.setAttribute("errorMessage", "Không tìm thấy tin tức hoặc tin tức chưa được duyệt");
            request.setAttribute("pageTitle", "Không tìm thấy trang - ABC News");
            request.getRequestDispatcher("/error/404.jsp").forward(request, response);
            return;
        }
        
        // Tăng số lượt xem
        newsDAO.incrementViewCount(newsId);
        news.setViewCount(news.getViewCount() + 1);
        
        // Lưu vào danh sách đã xem gần đây
        addToRecentViewed(request, news);
        
        // Lấy tin tức cùng loại (không bao gồm tin hiện tại)
        List<News> relatedNews = newsDAO.getNewsByCategory(news.getCategoryId(), 5)
            .stream()
            .filter(n -> !n.getId().equals(newsId))
            .limit(4)
            .collect(Collectors.toList());
        
        // Lấy danh sách danh mục cho menu
        List<Category> categories = categoryDAO.getAllCategories();
        
        // Đặt dữ liệu vào request
        request.setAttribute("news", news);
        request.setAttribute("relatedNews", relatedNews);
        request.setAttribute("categories", categories);
        request.setAttribute("pageTitle", news.getTitle() + " - ABC News");
        
        // Forward đến trang chi tiết
        request.getRequestDispatcher("/views/docgia/news-detail.jsp").forward(request, response);
    }
    
    /**
     * Xử lý trang danh sách tin theo loại
     */
    private void handleCategoryNews(HttpServletRequest request, HttpServletResponse response, String pathInfo) 
            throws ServletException, IOException {
        
        String categoryId = pathInfo.substring(1); // Bỏ dấu / đầu
        
        // Lấy thông tin danh mục
        Category category = categoryDAO.getCategoryById(categoryId);
        if (category == null) {
            // Redirect to custom 404 page
            request.setAttribute("errorMessage", "Không tìm thấy danh mục với ID: " + categoryId);
            request.setAttribute("pageTitle", "Không tìm thấy trang - ABC News");
            request.getRequestDispatcher("/error/404.jsp").forward(request, response);
            return;
        }
        
        // Lấy parameters cho phân trang
        String pageStr = request.getParameter("page");
        int page = 1;
        int pageSize = 10;
        
        try {
            if (pageStr != null) {
                page = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }
        
        // Lấy tin tức theo danh mục
        List<News> allCategoryNews = newsDAO.getNewsByCategory(categoryId, 0); // 0 = lấy tất cả
        
        // Tính toán phân trang
        int totalNews = allCategoryNews.size();
        int totalPages = (int) Math.ceil((double) totalNews / pageSize);
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalNews);
        
        List<News> pagedNews = allCategoryNews.subList(startIndex, endIndex);
        
        // Lấy danh sách danh mục cho menu
        List<Category> categories = categoryDAO.getAllCategories();
        
        // Đặt dữ liệu vào request
        request.setAttribute("category", category);
        request.setAttribute("categoryNews", pagedNews);
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalNews", totalNews);
        request.setAttribute("pageTitle", category.getName() + " - ABC News");
        
        // Forward đến trang danh sách theo loại
        request.getRequestDispatcher("/views/docgia/category-news.jsp").forward(request, response);
    }
    
    /**
     * Lấy danh sách tin đã xem gần đây từ session
     */
    @SuppressWarnings("unchecked")
    private List<News> getRecentViewedNews(HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<String> recentViewedIds = (List<String>) session.getAttribute("recentViewedNews");
        
        if (recentViewedIds == null || recentViewedIds.isEmpty()) {
            return new ArrayList<>();
        }
        
        // Lấy thông tin chi tiết của các tin đã xem
        List<News> recentNews = new ArrayList<>();
        for (String newsId : recentViewedIds) {
            News news = newsDAO.getNewsById(newsId);
            if (news != null) {
                recentNews.add(news);
            }
        }
        
        return recentNews;
    }
    
    /**
     * Thêm tin vào danh sách đã xem gần đây
     */
    @SuppressWarnings("unchecked")
    private void addToRecentViewed(HttpServletRequest request, News news) {
        HttpSession session = request.getSession();
        List<String> recentViewedIds = (List<String>) session.getAttribute("recentViewedNews");
        
        if (recentViewedIds == null) {
            recentViewedIds = new ArrayList<>();
        }
        
        // Xóa nếu đã tồn tại (để đưa lên đầu)
        recentViewedIds.remove(news.getId());
        
        // Thêm vào đầu danh sách
        recentViewedIds.add(0, news.getId());
        
        // Giới hạn chỉ lưu 5 tin gần nhất
        if (recentViewedIds.size() > 5) {
            recentViewedIds = recentViewedIds.subList(0, 5);
        }
        
        // Lưu lại vào session
        session.setAttribute("recentViewedNews", recentViewedIds);
    }
    
    /**
     * Xử lý tìm kiếm tin tức
     */
    private void handleSearch(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String keyword = request.getParameter("q");
        String pageStr = request.getParameter("page");
        
        if (keyword == null || keyword.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        keyword = keyword.trim();
        
        // Phân trang
        int page = 1;
        int pageSize = 10;
        
        try {
            if (pageStr != null) {
                page = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }
        
        // Tìm kiếm tin tức
        List<News> searchResults = newsDAO.searchNews(keyword);
        
        // Tính toán phân trang
        int totalNews = searchResults.size();
        int totalPages = (int) Math.ceil((double) totalNews / pageSize);
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalNews);
        
        List<News> pagedResults = totalNews > 0 ? searchResults.subList(startIndex, endIndex) : new ArrayList<>();
        
        // Lấy danh sách danh mục cho menu
        List<Category> categories = categoryDAO.getAllCategories();
        
        // Đặt dữ liệu vào request
        request.setAttribute("searchResults", pagedResults);
        request.setAttribute("searchKeyword", keyword);
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalNews", totalNews);
        request.setAttribute("pageTitle", "Tìm kiếm: " + keyword + " - ABC News");
        
        // Forward đến trang kết quả tìm kiếm
        request.getRequestDispatcher("/views/docgia/search-results.jsp").forward(request, response);
    }
}