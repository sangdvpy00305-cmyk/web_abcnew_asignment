<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Báo cáo thống kê - ABC News Admin</title>
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
        
        /* Content */
        .content {
            padding: 30px;
        }
        
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        
        .page-title {
            font-size: 2rem;
            color: #333;
        }
        
        .export-actions {
            display: flex;
            gap: 10px;
        }
        
        .export-btn {
            background: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .export-btn:hover {
            background: #218838;
            color: white;
        }
        
        /* Filter Section */
        .filter-section {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .filter-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            align-items: end;
        }
        
        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        
        .filter-label {
            font-weight: 600;
            color: #333;
            font-size: 14px;
        }
        
        .filter-input,
        .filter-select {
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        
        .filter-btn {
            background: #c41e3a;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .filter-btn:hover {
            background: #a01729;
        }
        
        /* Stats Overview */
        .stats-overview {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, #c41e3a, #a01729);
        }
        
        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }
        
        .stat-number {
            font-size: 2.2rem;
            font-weight: bold;
            color: #c41e3a;
            margin-bottom: 10px;
        }
        
        .stat-label {
            color: #666;
            font-size: 1rem;
            margin-bottom: 10px;
        }
        
        .stat-change {
            font-size: 14px;
            font-weight: 500;
        }
        
        .stat-change.positive {
            color: #28a745;
        }
        
        .stat-change.negative {
            color: #dc3545;
        }
        
        /* Charts Section */
        .charts-section {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .chart-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .chart-title {
            font-size: 1.3rem;
            color: #333;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .chart-placeholder {
            height: 300px;
            background: #f8f9fa;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #666;
            font-size: 16px;
            border: 2px dashed #ddd;
        }
        
        /* Tables Section */
        .tables-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .table-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .table-header {
            background: #f8f9fa;
            padding: 20px;
            border-bottom: 1px solid #dee2e6;
        }
        
        .table-title {
            font-size: 1.2rem;
            color: #333;
            margin: 0;
        }
        
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .table th {
            background: #f8f9fa;
            padding: 12px 15px;
            text-align: left;
            font-weight: 600;
            color: #333;
            font-size: 14px;
        }
        
        .table td {
            padding: 12px 15px;
            border-bottom: 1px solid #f0f0f0;
            font-size: 14px;
        }
        
        .table tr:hover {
            background: #f8f9fa;
        }
        
        .rank-number {
            background: #c41e3a;
            color: white;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: bold;
        }
        
        /* Activity Feed */
        .activity-feed {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 25px;
            margin-top: 20px;
        }
        
        .activity-title {
            font-size: 1.3rem;
            color: #333;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
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
            font-size: 16px;
            color: white;
        }
        
        .activity-icon.news { background: #c41e3a; }
        .activity-icon.user { background: #28a745; }
        .activity-icon.newsletter { background: #17a2b8; }
        
        .activity-content {
            flex: 1;
        }
        
        .activity-text {
            color: #333;
            margin-bottom: 5px;
        }
        
        .activity-time {
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
            
            .filter-grid {
                grid-template-columns: 1fr;
            }
            
            .charts-section {
                grid-template-columns: 1fr;
            }
            
            .tables-section {
                grid-template-columns: 1fr;
            }
            
            .stats-overview {
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
                    <a href="${pageContext.request.contextPath}/admin/dashboard">
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
                    <a href="${pageContext.request.contextPath}/admin/reports" class="active">
                        <span class="icon">📈</span>
                        <span>Báo cáo</span>
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
                <h1 class="page-title">📊 Báo cáo thống kê</h1>
                <div class="export-actions">
                    <a href="${pageContext.request.contextPath}/admin/reports/export?type=pdf" class="export-btn">
                        <span>📄</span>
                        <span>Xuất PDF</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/reports/export?type=excel" class="export-btn">
                        <span>📊</span>
                        <span>Xuất Excel</span>
                    </a>
                </div>
            </div>

            <!-- Filter Section -->
            <div class="filter-section">
                <form method="get" action="${pageContext.request.contextPath}/admin/reports">
                    <div class="filter-grid">
                        <div class="filter-group">
                            <label class="filter-label">Từ ngày</label>
                            <input type="date" name="startDate" class="filter-input" 
                                   value="${param.startDate}" id="startDate">
                        </div>
                        <div class="filter-group">
                            <label class="filter-label">Đến ngày</label>
                            <input type="date" name="endDate" class="filter-input" 
                                   value="${param.endDate}" id="endDate">
                        </div>
                        <div class="filter-group">
                            <label class="filter-label">Loại báo cáo</label>
                            <select name="reportType" class="filter-select">
                                <option value="overview" ${param.reportType == 'overview' ? 'selected' : ''}>Tổng quan</option>
                                <option value="news" ${param.reportType == 'news' ? 'selected' : ''}>Tin tức</option>
                                <option value="users" ${param.reportType == 'users' ? 'selected' : ''}>Người dùng</option>
                                <option value="newsletter" ${param.reportType == 'newsletter' ? 'selected' : ''}>Newsletter</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <button type="submit" class="filter-btn">🔍 Lọc dữ liệu</button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Stats Overview -->
            <div class="stats-overview">
                <div class="stat-card">
                    <div class="stat-icon">📰</div>
                    <div class="stat-number">${totalNews != null ? totalNews : 156}</div>
                    <div class="stat-label">Tổng tin tức</div>
                    <div class="stat-change positive">+12% so với tháng trước</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">👥</div>
                    <div class="stat-number">${totalUsers != null ? totalUsers : 1248}</div>
                    <div class="stat-label">Người dùng</div>
                    <div class="stat-change positive">+8% so với tháng trước</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">📧</div>
                    <div class="stat-number">${totalSubscribers != null ? totalSubscribers : 892}</div>
                    <div class="stat-label">Đăng ký Newsletter</div>
                    <div class="stat-change positive">+15% so với tháng trước</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">👁️</div>
                    <div class="stat-number">${totalViews != null ? totalViews : 45678}</div>
                    <div class="stat-label">Lượt xem</div>
                    <div class="stat-change positive">+23% so với tháng trước</div>
                </div>
            </div>

            <!-- Charts Section -->
            <div class="charts-section">
                <div class="chart-card">
                    <h3 class="chart-title">📈 Thống kê theo thời gian</h3>
                    <div class="chart-placeholder">
                        📊 Biểu đồ thống kê tin tức và người dùng theo thời gian<br>
                        <small>(Tích hợp thư viện Chart.js hoặc D3.js để hiển thị biểu đồ thực tế)</small>
                    </div>
                </div>
                <div class="chart-card">
                    <h3 class="chart-title">🥧 Phân bố danh mục</h3>
                    <div class="chart-placeholder">
                        📊 Biểu đồ tròn phân bố tin tức theo danh mục<br>
                        <small>(Hiển thị tỷ lệ % các danh mục tin tức)</small>
                    </div>
                </div>
            </div>

            <!-- Tables Section -->
            <div class="tables-section">
                <!-- Top News -->
                <div class="table-card">
                    <div class="table-header">
                        <h3 class="table-title">🏆 Tin tức được xem nhiều nhất</h3>
                    </div>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Hạng</th>
                                <th>Tiêu đề</th>
                                <th>Lượt xem</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty topNews}">
                                    <c:forEach var="news" items="${topNews}" varStatus="status">
                                        <tr>
                                            <td><span class="rank-number">${status.index + 1}</span></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${news.title.length() > 40}">
                                                        ${news.title.substring(0, 40)}...
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${news.title}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><strong>${news.views}</strong></td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr><td><span class="rank-number">1</span></td><td>Công nghệ AI mới nhất năm 2024</td><td><strong>2,456</strong></td></tr>
                                    <tr><td><span class="rank-number">2</span></td><td>Kinh tế Việt Nam tăng trưởng mạnh</td><td><strong>1,892</strong></td></tr>
                                    <tr><td><span class="rank-number">3</span></td><td>Thể thao: Đội tuyển Việt Nam chiến thắng</td><td><strong>1,654</strong></td></tr>
                                    <tr><td><span class="rank-number">4</span></td><td>Sức khỏe: Cách phòng chống bệnh mùa đông</td><td><strong>1,432</strong></td></tr>
                                    <tr><td><span class="rank-number">5</span></td><td>Giáo dục: Chương trình đào tạo mới</td><td><strong>1,287</strong></td></tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- Top Categories -->
                <div class="table-card">
                    <div class="table-header">
                        <h3 class="table-title">📂 Danh mục phổ biến</h3>
                    </div>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Hạng</th>
                                <th>Danh mục</th>
                                <th>Số tin</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty topCategories}">
                                    <c:forEach var="category" items="${topCategories}" varStatus="status">
                                        <tr>
                                            <td><span class="rank-number">${status.index + 1}</span></td>
                                            <td>${category.name}</td>
                                            <td><strong>${category.newsCount}</strong></td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr><td><span class="rank-number">1</span></td><td>Công nghệ</td><td><strong>45</strong></td></tr>
                                    <tr><td><span class="rank-number">2</span></td><td>Kinh tế</td><td><strong>38</strong></td></tr>
                                    <tr><td><span class="rank-number">3</span></td><td>Thể thao</td><td><strong>32</strong></td></tr>
                                    <tr><td><span class="rank-number">4</span></td><td>Sức khỏe</td><td><strong>28</strong></td></tr>
                                    <tr><td><span class="rank-number">5</span></td><td>Giáo dục</td><td><strong>24</strong></td></tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Activity Feed -->
            <div class="activity-feed">
                <h3 class="activity-title">🕒 Hoạt động gần đây</h3>
                <ul class="activity-list">
                    <c:choose>
                        <c:when test="${not empty recentActivities}">
                            <c:forEach var="activity" items="${recentActivities}">
                                <li class="activity-item">
                                    <div class="activity-icon ${activity.type}">
                                        <c:choose>
                                            <c:when test="${activity.type == 'news'}">📰</c:when>
                                            <c:when test="${activity.type == 'user'}">👤</c:when>
                                            <c:when test="${activity.type == 'newsletter'}">📧</c:when>
                                            <c:otherwise>📋</c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="activity-content">
                                        <div class="activity-text">${activity.description}</div>
                                        <div class="activity-time">${activity.timestamp}</div>
                                    </div>
                                </li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <li class="activity-item">
                                <div class="activity-icon news">📰</div>
                                <div class="activity-content">
                                    <div class="activity-text">Tin tức "Công nghệ AI mới" được đăng bởi Admin</div>
                                    <div class="activity-time">2 giờ trước</div>
                                </div>
                            </li>
                            <li class="activity-item">
                                <div class="activity-icon user">👤</div>
                                <div class="activity-content">
                                    <div class="activity-text">Người dùng mới "reporter3" được tạo</div>
                                    <div class="activity-time">4 giờ trước</div>
                                </div>
                            </li>
                            <li class="activity-item">
                                <div class="activity-icon newsletter">📧</div>
                                <div class="activity-content">
                                    <div class="activity-text">Newsletter được gửi đến 150 người đăng ký</div>
                                    <div class="activity-time">6 giờ trước</div>
                                </div>
                            </li>
                            <li class="activity-item">
                                <div class="activity-icon news">📰</div>
                                <div class="activity-content">
                                    <div class="activity-text">Danh mục "Văn hóa" được cập nhật</div>
                                    <div class="activity-time">8 giờ trước</div>
                                </div>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </main>
    </div>

    <script>
        // Set default date range (last 30 days)
        document.addEventListener('DOMContentLoaded', function() {
            const endDate = document.getElementById('endDate');
            const startDate = document.getElementById('startDate');
            
            if (!endDate.value) {
                const today = new Date();
                endDate.value = today.toISOString().split('T')[0];
            }
            
            if (!startDate.value) {
                const thirtyDaysAgo = new Date();
                thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
                startDate.value = thirtyDaysAgo.toISOString().split('T')[0];
            }
        });

        // Auto-refresh data every 5 minutes
        setInterval(function() {
            // You can add AJAX call here to refresh data
            console.log('Refreshing report data...');
        }, 300000);

        // Print report
        function printReport() {
            window.print();
        }

        // Quick date filters
        function setDateRange(days) {
            const endDate = document.getElementById('endDate');
            const startDate = document.getElementById('startDate');
            
            const today = new Date();
            endDate.value = today.toISOString().split('T')[0];
            
            const pastDate = new Date();
            pastDate.setDate(pastDate.getDate() - days);
            startDate.value = pastDate.toISOString().split('T')[0];
            
            // Submit form
            document.querySelector('form').submit();
        }

        // Add quick filter buttons
        const filterSection = document.querySelector('.filter-section form');
        const quickFilters = document.createElement('div');
        quickFilters.innerHTML = `
            <div style="margin-top: 15px; padding-top: 15px; border-top: 1px solid #ddd;">
                <span style="font-weight: 600; margin-right: 10px;">Lọc nhanh:</span>
                <button type="button" onclick="setDateRange(7)" style="margin-right: 5px; padding: 5px 10px; border: 1px solid #ddd; background: white; border-radius: 3px; cursor: pointer;">7 ngày</button>
                <button type="button" onclick="setDateRange(30)" style="margin-right: 5px; padding: 5px 10px; border: 1px solid #ddd; background: white; border-radius: 3px; cursor: pointer;">30 ngày</button>
                <button type="button" onclick="setDateRange(90)" style="margin-right: 5px; padding: 5px 10px; border: 1px solid #ddd; background: white; border-radius: 3px; cursor: pointer;">3 tháng</button>
                <button type="button" onclick="setDateRange(365)" style="padding: 5px 10px; border: 1px solid #ddd; background: white; border-radius: 3px; cursor: pointer;">1 năm</button>
            </div>
        `;
        filterSection.appendChild(quickFilters);
    </script>
</body>
</html>