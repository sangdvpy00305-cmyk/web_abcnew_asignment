<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết tin tức - ABC News Admin</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }
        
        .header {
            background: linear-gradient(135deg, #c41e3a 0%, #a01729 100%);
            color: white;
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .header .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo {
            font-size: 1.8rem;
            font-weight: bold;
            text-decoration: none;
            color: white;
        }
        
        .content {
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .news-detail {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .news-header {
            padding: 30px;
            border-bottom: 1px solid #eee;
        }
        
        .news-title {
            font-size: 2rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
            line-height: 1.3;
        }
        
        .news-meta {
            display: flex;
            gap: 20px;
            color: #666;
            font-size: 14px;
            margin-bottom: 20px;
        }
        
        .news-image {
            width: 100%;
            max-height: 400px;
            object-fit: cover;
            margin-bottom: 20px;
        }
        
        .news-content {
            padding: 30px;
            line-height: 1.8;
            font-size: 16px;
        }
        
        .back-btn {
            background: #6c757d;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
        }
        
        .back-btn:hover {
            background: #5a6268;
            color: white;
        }
        
        .status-badge {
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .status-badge.published {
            background: #d4edda;
            color: #155724;
        }
        
        .status-badge.draft {
            background: #fff3cd;
            color: #856404;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="logo">
                🛡️ ABC NEWS ADMIN
            </a>
        </div>
    </header>

    <div class="content">
        <a href="${pageContext.request.contextPath}/admin/news" class="back-btn">
            ← Quay lại danh sách
        </a>

        <c:if test="${not empty news}">
            <div class="news-detail">
                <div class="news-header">
                    <h1 class="news-title">${news.title}</h1>
                    
                    <div class="news-meta">
                        <span>📝 ID: ${news.id}</span>
                        <span>👤 Tác giả: ${news.authorName}</span>
                        <span>📂 Danh mục: ${news.categoryName}</span>
                        <span>📅 Ngày đăng: ${news.postedDate}</span>
                        <span>👁️ Lượt xem: ${news.viewCount}</span>
                        <span>
                            <c:choose>
                                <c:when test="${news.home == 1}">
                                    <span class="status-badge published">Đã xuất bản</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge draft">Bản nháp</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    
                    <c:if test="${not empty news.summary}">
                        <div style="background: #f8f9fa; padding: 15px; border-radius: 5px; font-style: italic;">
                            <strong>Tóm tắt:</strong> ${news.summary}
                        </div>
                    </c:if>
                </div>
                
                <div class="news-content">
                    <c:if test="${not empty news.image}">
                        <img src="${pageContext.request.contextPath}${news.image}" 
                             alt="News Image" class="news-image"
                             onerror="this.style.display='none';">
                    </c:if>
                    
                    <div style="white-space: pre-wrap;">${news.content}</div>
                </div>
            </div>
        </c:if>
        
        <c:if test="${empty news}">
            <div style="text-align: center; padding: 50px; background: white; border-radius: 10px;">
                <h2>❌ Không tìm thấy tin tức</h2>
                <p>Tin tức bạn đang tìm kiếm không tồn tại hoặc đã bị xóa.</p>
                <a href="${pageContext.request.contextPath}/admin/news" class="back-btn">
                    Quay lại danh sách
                </a>
            </div>
        </c:if>
    </div>
</body>
</html>