<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phóng viên - ABC News</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico">
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
        
        /* Header */
        .header {
            background: linear-gradient(135deg, #c41e3a 0%, #a01729 100%);
            color: white;
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
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
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .user-info span {
            background: rgba(255,255,255,0.2);
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 14px;
        }
        
        .logout-btn {
            background: rgba(255,255,255,0.2);
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 20px;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s;
        }
        
        .logout-btn:hover {
            background: rgba(255,255,255,0.3);
            color: white;
        }
        
        /* Main Layout */
        .main-layout {
            display: grid;
            grid-template-columns: 250px 1fr;
            min-height: calc(100vh - 70px);
        }
        
        /* Sidebar */
        .sidebar {
            background: white;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            padding: 20px 0;
        }
        
        .sidebar-menu {
            list-style: none;
        }
        
        .sidebar-menu li {
            margin-bottom: 5px;
        }
        
        .sidebar-menu a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 15px 20px;
            color: #333;
            text-decoration: none;
            transition: all 0.3s;
            border-left: 3px solid transparent;
        }
        
        .sidebar-menu a:hover,
        .sidebar-menu a.active {
            background: #f8f9fa;
            border-left-color: #28a745;
            color: #28a745;
        }
        
        .sidebar-menu .icon {
            font-size: 18px;
            width: 20px;
            text-align: center;
        }
        
        /* Content Area */
        .content {
            padding: 30px;
        }
        
        .page-header {
            margin-bottom: 30px;
        }
        
        .page-title {
            font-size: 2rem;
            color: #333;
            margin-bottom: 10px;
        }
        
        .page-subtitle {
            color: #666;
            font-size: 1.1rem;
        }
        
        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            text-align: center;
            transition: all 0.3s;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        
        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #28a745;
            margin-bottom: 10px;
        }
        
        .stat-label {
            color: #666;
            font-size: 1rem;
        }
        
        /* Quick Actions */
        .quick-actions {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .quick-actions h3 {
            color: #333;
            margin-bottom: 20px;
            font-size: 1.3rem;
        }
        
        .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }
        
        .action-btn {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 15px 20px;
            background: linear-gradient(135deg, #c41e3a 0%, #a01729 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
        }
        
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
            color: white;
        }
        
        .action-btn.secondary {
            background: linear-gradient(135deg, #6c757d, #5a6268);
        }
        
        .action-btn.info {
            background: linear-gradient(135deg, #17a2b8, #138496);
        }
        
        /* My News Section */
        .my-news {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .my-news h3 {
            color: #333;
            margin-bottom: 20px;
            font-size: 1.3rem;
        }
        
        .news-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        
        .news-table th,
        .news-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .news-table th {
            background: #f8f9fa;
            font-weight: 600;
            color: #333;
        }
        
        .news-table tr:hover {
            background: #f8f9fa;
        }
        
        .status-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .status-badge.published {
            background: #d4edda;
            color: #155724;
        }
        
        .status-badge.draft {
            background: #fff3cd;
            color: #856404;
        }
        
        .action-links {
            display: flex;
            gap: 10px;
        }
        
        .action-links a {
            padding: 5px 10px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .edit-link {
            background: #fff3cd;
            color: #856404;
        }
        
        .edit-link:hover {
            background: #ffeaa7;
            color: #856404;
        }
        
        .delete-link {
            background: #f8d7da;
            color: #721c24;
        }
        
        .delete-link:hover {
            background: #f5c6cb;
            color: #721c24;
        }
        
        .view-link {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .view-link:hover {
            background: #bee5eb;
            color: #0c5460;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 40px;
            color: #666;
        }
        
        .empty-state .icon {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.5;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .main-layout {
                grid-template-columns: 1fr;
            }
            
            .sidebar {
                display: none;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                grid-template-columns: 1fr;
            }
            
            .news-table {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <a href="${pageContext.request.contextPath}/reporter/dashboard" class="logo">
                ✍️ ABC NEWS REPORTER
            </a>
            <div class="user-info">
                <span>👤 ${sessionScope.username != null ? sessionScope.username : 'Phóng viên'}</span>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                    🚪 Đăng xuất
                </a>
            </div>
        </div>
    </header>

    <div class="main-layout">
        <!-- Sidebar -->
        <nav class="sidebar">
            <ul class="sidebar-menu">
                <li>
                    <a href="${pageContext.request.contextPath}/reporter/dashboard" class="active">
                        <span class="icon">📊</span>
                        <span>Tổng quan</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/reporter/news">
                        <span class="icon">📰</span>
                        <span>Tin tức của tôi</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/reporter/news/add">
                        <span class="icon">➕</span>
                        <span>Viết tin mới</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/reporter/profile">
                        <span class="icon">👤</span>
                        <span>Hồ sơ cá nhân</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/home">
                        <span class="icon">🏠</span>
                        <span>Xem trang chủ</span>
                    </a>
                </li>
            </ul>
        </nav>

        <!-- Main Content -->
        <main class="content">
            <!-- Page Header -->
            <div class="page-header">
                <h1 class="page-title">📊 Bảng điều khiển phóng viên</h1>
                <p class="page-subtitle">Chào mừng bạn đến với khu vực làm việc của phóng viên</p>
            </div>

            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">📰</div>
                    <div class="stat-number">${myNewsCount != null ? myNewsCount : 0}</div>
                    <div class="stat-label">Tin đã viết</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">👁️</div>
                    <div class="stat-number">${totalViews != null ? totalViews : 0}</div>
                    <div class="stat-label">Lượt xem</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">📅</div>
                    <div class="stat-number">${newsThisMonth != null ? newsThisMonth : 0}</div>
                    <div class="stat-label">Tin tháng này</div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <h3>⚡ Thao tác nhanh</h3>
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/reporter/news/add" class="action-btn">
                        <span>✍️</span>
                        <span>Viết tin mới</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/reporter/news" class="action-btn secondary">
                        <span>📋</span>
                        <span>Quản lý tin tức</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/reporter/profile" class="action-btn info">
                        <span>👤</span>
                        <span>Cập nhật hồ sơ</span>
                    </a>
                </div>
            </div>

            <!-- My Recent News -->
            <div class="my-news">
                <h3>📰 Tin tức gần đây của tôi</h3>
                <c:choose>
                    <c:when test="${not empty myRecentNews}">
                        <table class="news-table">
                            <thead>
                                <tr>
                                    <th>Tiêu đề</th>
                                    <th>Danh mục</th>
                                    <th>Ngày đăng</th>
                                    <th>Lượt xem</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="news" items="${myRecentNews}">
                                    <tr>
                                        <td>
                                            <strong>${news.title.length() > 50 ? news.title.substring(0, 50).concat('...') : news.title}</strong>
                                        </td>
                                        <td>${news.categoryName}</td>
                                        <td>${news.postedDate}</td>
                                        <td>${news.viewCount}</td>
                                        <td>
                                            <span class="status-badge ${news.home == 1 ? 'published' : 'draft'}">
                                                ${news.home == 1 ? 'Đã đăng' : 'Nháp'}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="action-links">
                                                <a href="${pageContext.request.contextPath}/reporter/news/view/${news.id}" class="view-link">👁️ Xem</a>
                                                <a href="${pageContext.request.contextPath}/reporter/news/edit/${news.id}" class="edit-link">✏️ Sửa</a>
                                                <a href="${pageContext.request.contextPath}/reporter/news/delete/${news.id}" 
                                                   class="delete-link" onclick="return confirm('Bạn có chắc muốn xóa tin này?')">🗑️ Xóa</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="icon">📝</div>
                            <h3>Chưa có tin tức nào</h3>
                            <p>Bạn chưa viết tin tức nào. Hãy bắt đầu viết tin đầu tiên!</p>
                            <br>
                            <a href="${pageContext.request.contextPath}/reporter/news/add" class="action-btn">
                                <span>✍️</span>
                                <span>Viết tin đầu tiên</span>
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>

    <script>
        // Auto refresh stats every 60 seconds
        setInterval(function() {
            // You can add AJAX call here to refresh stats
            console.log('Stats refreshed');
        }, 60000);

        // Welcome message
        document.addEventListener('DOMContentLoaded', function() {
            const username = '${sessionScope.username}';
            if (username && username !== 'null') {
                console.log('Chào mừng phóng viên ' + username + '!');
            }
        });

        // Confirm delete
        function confirmDelete(newsId, title) {
            if (confirm('Bạn có chắc muốn xóa tin "' + title + '"?')) {
                window.location.href = '${pageContext.request.contextPath}/reporter/news/delete/' + newsId;
            }
        }
    </script>
</body>
</html>