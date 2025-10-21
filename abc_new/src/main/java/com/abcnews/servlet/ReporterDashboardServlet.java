package com.abcnews.servlet;

import com.abcnews.dao.NewsDAO;
import com.abcnews.model.News;
import com.abcnews.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import java.util.Calendar;
import java.util.Date;
import java.sql.Timestamp;

@WebServlet("/reporter/dashboard")
public class ReporterDashboardServlet extends HttpServlet {
    private NewsDAO newsDAO = new NewsDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền phóng viên
        HttpSession session = request.getSession(false);
        System.out.println("🔍 ReporterDashboard - Session: " + (session != null ? session.getId() : "null"));
        
        if (session == null || session.getAttribute("user") == null) {
            System.out.println("❌ ReporterDashboard - No session or user, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        System.out.println("🔍 ReporterDashboard - User: " + user.getFullname() + ", isReporter: " + user.isReporter());
        
        if (!user.isReporter()) {
            System.out.println("❌ ReporterDashboard - User is not reporter, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        System.out.println("✅ ReporterDashboard - Access granted");
        
        try {
            // Lấy tất cả tin tức
            List<News> allNews = newsDAO.getAllNews();
            
            // Lọc tin tức của phóng viên này
            List<News> myNews = allNews.stream()
                .filter(news -> user.getId().equals(news.getAuthor()))
                .collect(Collectors.toList());
            
            // Tính thống kê
            int myNewsCount = myNews.size();
            int totalViews = myNews.stream().mapToInt(News::getViewCount).sum();
            
            // Tính tin tức tháng này
            Calendar cal = Calendar.getInstance();
            cal.set(Calendar.DAY_OF_MONTH, 1);
            cal.set(Calendar.HOUR_OF_DAY, 0);
            cal.set(Calendar.MINUTE, 0);
            cal.set(Calendar.SECOND, 0);
            cal.set(Calendar.MILLISECOND, 0);
            Date startOfMonth = cal.getTime();
            
            int newsThisMonth = (int) myNews.stream()
                .filter(news -> {
                    if (news.getPostedDate() != null) {
                        return news.getPostedDate().after(startOfMonth);
                    }
                    return false;
                })
                .count();
            
            // Lấy tin tức gần đây (5 tin mới nhất) - sắp xếp theo ngày đăng
            List<News> myRecentNews = myNews.stream()
                .sorted((n1, n2) -> {
                    if (n1.getPostedDate() == null && n2.getPostedDate() == null) return 0;
                    if (n1.getPostedDate() == null) return 1;
                    if (n2.getPostedDate() == null) return -1;
                    return n2.getPostedDate().compareTo(n1.getPostedDate());
                })
                .limit(5)
                .collect(Collectors.toList());
            
            // Đặt dữ liệu vào request
            request.setAttribute("myNewsCount", myNewsCount);
            request.setAttribute("totalViews", totalViews);
            request.setAttribute("newsThisMonth", newsThisMonth);
            request.setAttribute("myRecentNews", myRecentNews);
            
            // Forward đến trang JSP
            request.getRequestDispatcher("/views/phongvien/dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/views/phongvien/dashboard.jsp").forward(request, response);
        }
    }
}