package com.abcnews.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Filter để set UTF-8 encoding cho tất cả request và response
 */
public class CharacterEncodingFilter implements Filter {
    
    private String encoding = "UTF-8";
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        String encodingParam = filterConfig.getInitParameter("encoding");
        if (encodingParam != null && !encodingParam.trim().isEmpty()) {
            this.encoding = encodingParam.trim();
        }
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        // Set request encoding
        if (request.getCharacterEncoding() == null) {
            request.setCharacterEncoding(encoding);
        }
        
        // Set response encoding
        response.setCharacterEncoding(encoding);
        
        // Set content type for HTML responses
        if (response instanceof HttpServletResponse) {
            HttpServletResponse httpResponse = (HttpServletResponse) response;
            HttpServletRequest httpRequest = (HttpServletRequest) request;
            
            // Chỉ set content type cho HTML responses
            String requestURI = httpRequest.getRequestURI();
            if (requestURI.endsWith(".jsp") || requestURI.contains("/views/") || 
                (!requestURI.contains(".") && !requestURI.contains("/api/"))) {
                httpResponse.setContentType("text/html; charset=" + encoding);
            }
        }
        
        // Continue with the filter chain
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // Cleanup if needed
    }
}