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
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/sitemap.xml")
public class SitemapServlet extends HttpServlet {
    private NewsDAO newsDAO = new NewsDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set content type for XML
        response.setContentType("application/xml; charset=UTF-8");
        
        try {
            // Generate sitemap XML
            String sitemapXml = generateSitemapXML(request);
            
            // Write sitemap to response
            PrintWriter out = response.getWriter();
            out.print(sitemapXml);
            out.flush();
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Lỗi tạo sitemap: " + e.getMessage());
        }
    }
    
    private String generateSitemapXML(HttpServletRequest request) {
        StringBuilder sitemap = new StringBuilder();
        String baseUrl = request.getScheme() + "://" + request.getServerName() + 
                        ":" + request.getServerPort() + request.getContextPath();
        
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        
        // XML Header
        sitemap.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
        sitemap.append("<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">\n");
        
        // Home page
        sitemap.append("<url>\n");
        sitemap.append("<loc>").append(baseUrl).append("/home</loc>\n");
        sitemap.append("<lastmod>").append(dateFormat.format(new java.util.Date())).append("</lastmod>\n");
        sitemap.append("<changefreq>daily</changefreq>\n");
        sitemap.append("<priority>1.0</priority>\n");
        sitemap.append("</url>\n");
        
        // Categories
        List<Category> categories = categoryDAO.getAllCategories();
        for (Category category : categories) {
            sitemap.append("<url>\n");
            sitemap.append("<loc>").append(baseUrl).append("/category/").append(category.getId()).append("</loc>\n");
            sitemap.append("<lastmod>").append(dateFormat.format(new java.util.Date())).append("</lastmod>\n");
            sitemap.append("<changefreq>daily</changefreq>\n");
            sitemap.append("<priority>0.8</priority>\n");
            sitemap.append("</url>\n");
        }
        
        // News articles
        List<News> allNews = newsDAO.getAllNews();
        for (News news : allNews) {
            sitemap.append("<url>\n");
            sitemap.append("<loc>").append(baseUrl).append("/news/").append(news.getId()).append("</loc>\n");
            if (news.getPostedDate() != null) {
                sitemap.append("<lastmod>").append(dateFormat.format(news.getPostedDate())).append("</lastmod>\n");
            }
            sitemap.append("<changefreq>weekly</changefreq>\n");
            sitemap.append("<priority>0.6</priority>\n");
            sitemap.append("</url>\n");
        }
        
        // Static pages
        sitemap.append("<url>\n");
        sitemap.append("<loc>").append(baseUrl).append("/search</loc>\n");
        sitemap.append("<changefreq>monthly</changefreq>\n");
        sitemap.append("<priority>0.5</priority>\n");
        sitemap.append("</url>\n");
        
        // XML Footer
        sitemap.append("</urlset>");
        
        return sitemap.toString();
    }
}