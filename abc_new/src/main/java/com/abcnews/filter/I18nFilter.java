package com.abcnews.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/*")
public class I18nFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        
        String lang = req.getParameter("lang");
        System.out.println("Language parameter: " + lang); // Debug log
        
        if (lang != null) {
            // Lưu ngôn ngữ vào session
            req.getSession().setAttribute("lang", lang);
            System.out.println("Set language to: " + lang); // Debug log
            
            // Tạo URL redirect không có parameter lang
            String requestURL = req.getRequestURL().toString();
            String queryString = req.getQueryString();
            
            // Xóa parameter lang khỏi query string
            String redirectURL = requestURL;
            if (queryString != null) {
                // Xóa parameter lang
                String newQueryString = queryString.replaceAll("(^|&)lang=[^&]*(&|$)", "$2")
                                                   .replaceAll("^&+|&+$", "")
                                                   .replaceAll("&+", "&");
                if (!newQueryString.isEmpty()) {
                    redirectURL += "?" + newQueryString;
                }
            }
            
            // Redirect để làm mới trang với ngôn ngữ mới
            resp.sendRedirect(redirectURL);
            return;
        }
        
        chain.doFilter(req, resp);
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}