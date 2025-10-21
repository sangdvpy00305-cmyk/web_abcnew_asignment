<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản trị - ABC News</title>
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
            border-left-color: #c41e3a;
            color: #c41e3a;
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
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
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
            font-size: 3rem;
            margin-bottom: 15px;
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: #c41e3a;
            margin-bottom: 10px;
        }
        
        .stat-label {
            color: #666;
            font-size: 1.1rem;
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
            background: linear-gradient(135deg, #c41e3a, #a01729);
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
            box-shadow: 0 5px 15px rgba(196, 30, 58, 0.3);
            color: white;
        }
        
        .action-btn.secondary {
            background: linear-gradient(135deg, #6c757d, #5a6268);
        }
        
        .action-btn.success {
            background: linear-gradient(135deg, #28a745, #218838);
        }
        
        .action-btn.info {
            background: linear-gradient(135deg, #17a2b8, #138496);
        }
        
        /* Recent Activity */
        .recent-activity {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .recent-activity h3 {
            color: #333;
            margin-bottom: 20px;
            font-size: 1.3rem;
        }
        
        .activity-list {
            list-style: none;
        }
        
        .activity-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .activity-item:last-child {
            border-bottom: none;
        }
        
        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            color: white;
        }
        
        .activity-icon.news { background: #c41e3a; }
        .activity-icon.user { background: #28a745; }
        .activity-icon.category { background: #17a2b8; }
        
        .activity-content {
            flex: 1;
        }
        
        .activity-content h4 {
            font-size: 14px;
            margin-bottom: 5px;
            color: #333;
        }
        
        .activity-content span {
            font-size: 12px;
            color: #999;
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
            <div class="user-info">
                <span>👤 ${sessionScope.username != null ? sessionScope.username : 'Admin'}</span>
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
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="active">
                        <span class="icon">📊</span>
                        <span>Tổng quan</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/users">
                        <span class="icon">👥</span>
                        <span>Quản lý người dùng</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/categories">
                        <span class="icon">📂</span>
                        <span>Quản lý danh mục</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/news">
                        <span class="icon">📰</span>
                        <span>Quản lý tin tức</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/newsletters">
                        <span class="icon">📧</span>
                        <span>Quản lý Newsletter</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/newsletters/send">
                        <span class="icon">📤</span>
                        <span>Gửi Newsletter</span>
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
                <h1 class="page-title">📊 Tổng quan hệ thống</h1>
                <p class="page-subtitle">Chào mừng bạn đến với trang quản trị ABC News</p>
            </div>

            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">📰</div>
                    <div class="stat-number">${totalNews != null ? totalNews : 0}</div>
                    <div class="stat-label">Tổng tin tức</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">👥</div>
                    <div class="stat-number">${totalUsers != null ? totalUsers : 0}</div>
                    <div class="stat-label">Người dùng</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">📂</div>
                    <div class="stat-number">${totalCategories != null ? totalCategories : 0}</div>
                    <div class="stat-label">Danh mục</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">📧</div>
                    <div class="stat-number">${totalSubscribers != null ? totalSubscribers : 0}</div>
                    <div class="stat-label">Đăng ký nhận tin</div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <h3>⚡ Thao tác nhanh</h3>
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/admin/news/add" class="action-btn">
                        <span>➕</span>
                        <span>Thêm tin tức mới</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/users/add" class="action-btn secondary">
                        <span>👤</span>
                        <span>Thêm người dùng</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/categories/add" class="action-btn success">
                        <span>📂</span>
                        <span>Thêm danh mục</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/reports" class="action-btn info">
                        <span>📊</span>
                        <span>Xem báo cáo</span>
                    </a>
                </div>
            </div>

            <!-- Recent Activity -->
            <div class="recent-activity">
                <h3>🕒 Hoạt động gần đây</h3>
                <ul class="activity-list">
                    <c:choose>
                        <c:when test="${not empty recentActivities}">
                            <c:forEach var="activity" items="${recentActivities}">
                                <li class="activity-item">
                                    <div class="activity-icon ${activity.type}">
                                        <c:choose>
                                            <c:when test="${activity.type == 'news'}">📰</c:when>
                                            <c:when test="${activity.type == 'user'}">👤</c:when>
                                            <c:when test="${activity.type == 'category'}">📂</c:when>
                                            <c:otherwise>📋</c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="activity-content">
                                        <h4>${activity.description}</h4>
                                        <span>${activity.timestamp}</span>
                                    </div>
                                </li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <li class="activity-item">
                                <div class="activity-icon news">📰</div>
                                <div class="activity-content">
                                    <h4>Tin tức "Công nghệ AI mới" được đăng bởi Phóng viên A</h4>
                                    <span>2 giờ trước</span>
                                </div>
                            </li>
                            <li class="activity-item">
                                <div class="activity-icon user">👤</div>
                                <div class="activity-content">
                                    <h4>Người dùng mới "reporter2" được tạo</h4>
                                    <span>4 giờ trước</span>
                                </div>
                            </li>
                            <li class="activity-item">
                                <div class="activity-icon category">📂</div>
                                <div class="activity-content">
                                    <h4>Danh mục "Sức khỏe" được cập nhật</h4>
                                    <span>6 giờ trước</span>
                                </div>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </main>
    </div>

    <script>
        // Auto refresh stats every 30 seconds
        setInterval(function() {
            // You can add AJAX call here to refresh stats
            console.log('Stats refreshed');
        }, 30000);

        // Welcome message
        document.addEventListener('DOMContentLoaded', function() {
            const username = '${sessionScope.username}';
            if (username && username !== 'null') {
                console.log('Chào mừng ' + username + ' đến với trang quản trị!');
            }
        });
    </script>
</body>
</html>