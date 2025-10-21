package com.abcnews.servlet;

import com.abcnews.dao.NewsDAO;
import com.abcnews.model.News;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;

@WebServlet("/rss")
public class RSSServlet extends HttpServlet {
    private NewsDAO newsDAO = new NewsDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set content type for RSS
        response.setContentType("application/rss+xml; charset=UTF-8");
        
        try {
            // Get latest news for RSS feed
            List<News> latestNews = newsDAO.getLatestNews(20);
            
            // Generate RSS XML
            String rssXml = generateRSSXML(request, latestNews);
            
            // Write RSS to response
            PrintWriter out = response.getWriter();
            out.print(rssXml);
            out.flush();
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Lỗi tạo RSS feed: " + e.getMessage());
        }
    }
    
    private String generateRSSXML(HttpServletRequest request, List<News> newsList) {
        StringBuilder rss = new StringBuilder();
        String baseUrl = request.getScheme() + "://" + request.getServerName() + 
                        ":" + request.getServerPort() + request.getContextPath();
        
        SimpleDateFormat rssDateFormat = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss Z", Locale.ENGLISH);
        
        // RSS Header
        rss.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
        rss.append("<rss version=\"2.0\">\n");
        rss.append("<channel>\n");
        rss.append("<title>ABC News - Tin tức hàng đầu Việt Nam</title>\n");
        rss.append("<link>").append(baseUrl).append("/home</link>\n");
        rss.append("<description>Tin tức nhanh chóng, chính xác và đáng tin cậy từ ABC News</description>\n");
        rss.append("<language>vi-VN</language>\n");
        rss.append("<copyright>Copyright © 2024 ABC News. All rights reserved.</copyright>\n");
        rss.append("<managingEditor>editor@abcnews.com (ABC News Editor)</managingEditor>\n");
        rss.append("<webMaster>webmaster@abcnews.com (ABC News Webmaster)</webMaster>\n");
        rss.append("<pubDate>").append(rssDateFormat.format(new java.util.Date())).append("</pubDate>\n");
        rss.append("<lastBuildDate>").append(rssDateFormat.format(new java.util.Date())).append("</lastBuildDate>\n");
        rss.append("<generator>ABC News RSS Generator</generator>\n");
        
        // RSS Items
        for (News news : newsList) {
            rss.append("<item>\n");
            rss.append("<title><![CDATA[").append(escapeXml(news.getTitle())).append("]]></title>\n");
            rss.append("<link>").append(baseUrl).append("/news/").append(news.getId()).append("</link>\n");
            rss.append("<guid>").append(baseUrl).append("/news/").append(news.getId()).append("</guid>\n");
            
            if (news.getContent() != null) {
                String description = stripHtml(news.getContent());
                if (description.length() > 300) {
                    description = description.substring(0, 300) + "...";
                }
                rss.append("<description><![CDATA[").append(escapeXml(description)).append("]]></description>\n");
            }
            
            if (news.getAuthorName() != null) {
                rss.append("<author>").append(escapeXml(news.getAuthorName())).append("</author>\n");
            }
            
            if (news.getCategoryName() != null) {
                rss.append("<category>").append(escapeXml(news.getCategoryName())).append("</category>\n");
            }
            
            if (news.getPostedDate() != null) {
                rss.append("<pubDate>").append(rssDateFormat.format(news.getPostedDate())).append("</pubDate>\n");
            }
            
            rss.append("</item>\n");
        }
        
        // RSS Footer
        rss.append("</channel>\n");
        rss.append("</rss>");
        
        return rss.toString();
    }
    
    private String escapeXml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;")
                  .replace("<", "&lt;")
                  .replace(">", "&gt;")
                  .replace("\"", "&quot;")
                  .replace("'", "&apos;");
    }
    
    private String stripHtml(String html) {
        if (html == null) return "";
        return html.replaceAll("<[^>]+>", "").trim();
    }
}