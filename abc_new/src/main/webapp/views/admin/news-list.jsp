<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý tin tức - ABC News Admin</title>
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
        
        .add-btn {
            background: linear-gradient(135deg, #c41e3a, #a01729);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(196, 30, 58, 0.3);
            color: white;
        }
        
        /* Search and Filter */
        .search-filter {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .search-input {
            flex: 1;
            min-width: 250px;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        
        .filter-select {
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            min-width: 150px;
        }
        
        .search-btn {
            background: #c41e3a;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
        }
        
        .search-btn:hover {
            background: #a01729;
        }
        
        /* News Table */
        .news-table {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .table th {
            background: #f8f9fa;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #333;
            border-bottom: 1px solid #dee2e6;
        }
        
        .table td {
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
            vertical-align: top;
        }
        
        .table tr:hover {
            background: #f8f9fa;
        }
        
        .news-title {
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }
        
        .news-summary {
            color: #666;
            font-size: 14px;
            line-height: 1.4;
        }
        
        .news-image {
            width: 60px;
            height: 40px;
            object-fit: cover;
            border-radius: 4px;
        }
        
        .category-badge {
            background: #e9ecef;
            color: #495057;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .status-badge {
            padding: 4px 8px;
            border-radius: 12px;
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
        
        .status-badge.archived {
            background: #f8d7da;
            color: #721c24;
        }
        
        .action-buttons {
            display: flex;
            gap: 8px;
        }
        
        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-edit {
            background: #ffc107;
            color: #212529;
        }
        
        .btn-edit:hover {
            background: #e0a800;
            color: #212529;
        }
        
        .btn-delete {
            background: #dc3545;
            color: white;
        }
        
        .btn-delete:hover {
            background: #c82333;
        }
        
        .btn-view {
            background: #17a2b8;
            color: white;
        }
        
        .btn-view:hover {
            background: #138496;
            color: white;
        }
        
        .btn-approve {
            background: #28a745;
            color: white;
        }
        
        .btn-approve:hover {
            background: #218838;
            color: white;
        }
        
        .btn-reject {
            background: #fd7e14;
            color: white;
        }
        
        .btn-reject:hover {
            background: #e55a00;
            color: white;
        }
        
        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin-top: 20px;
        }
        
        .pagination a,
        .pagination span {
            padding: 8px 12px;
            border: 1px solid #ddd;
            text-decoration: none;
            color: #333;
            border-radius: 4px;
            transition: all 0.3s;
        }
        
        .pagination a:hover {
            background: #c41e3a;
            color: white;
            border-color: #c41e3a;
        }
        
        .pagination .current {
            background: #c41e3a;
            color: white;
            border-color: #c41e3a;
        }
        
        /* Alert Messages */
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-weight: 500;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .main-layout {
                grid-template-columns: 1fr;
            }
            
            .sidebar {
                display: none;
            }
            
            .search-filter {
                flex-direction: column;
                align-items: stretch;
            }
            
            .search-input,
            .filter-select {
                min-width: auto;
            }
            
            .table {
                font-size: 14px;
            }
            
            .table th,
            .table td {
                padding: 10px;
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
                    <a href="${pageContext.request.contextPath}/admin/news" class="active">
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
                <h1 class="page-title">📰 Quản lý tin tức</h1>
                <a href="${pageContext.request.contextPath}/admin/news/add" class="add-btn">
                    <span>➕</span>
                    <span>Thêm tin tức mới</span>
                </a>
            </div>

            <!-- Alert Messages -->
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    ${message}
                </div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    ${error}
                </div>
            </c:if>

            <!-- Search and Filter -->
            <div class="search-filter">
                <input type="text" class="search-input" placeholder="🔍 Tìm kiếm tin tức..." id="searchInput">
                <select class="filter-select" id="categoryFilter">
                    <option value="">Tất cả danh mục</option>
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.id}">${category.name}</option>
                    </c:forEach>
                </select>
                <select class="filter-select" id="statusFilter">
                    <option value="">Tất cả trạng thái</option>
                    <option value="1">Đã xuất bản</option>
                    <option value="0">Bản nháp</option>
                </select>
                <button class="search-btn" onclick="searchNews()">Tìm kiếm</button>
            </div>

            <!-- News Table -->
            <div class="news-table">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Hình ảnh</th>
                            <th>Tiêu đề & Tóm tắt</th>
                            <th>Danh mục</th>
                            <th>Tác giả</th>
                            <th>Trạng thái xuất bản</th>
                            <th>Trạng thái duyệt</th>
                            <th>Ngày tạo</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty newsList}">
                                <c:forEach var="news" items="${newsList}">
                                    <tr>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty news.image}">
                                                    <img src="${pageContext.request.contextPath}${news.image}" 
                                                         alt="News Image" class="news-image"
                                                         onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                    <div style="width: 60px; height: 40px; background: #f0f0f0; 
                                                                border-radius: 4px; display: none; align-items: center; 
                                                                justify-content: center; font-size: 12px; color: #999;">
                                                        ❌
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div style="width: 60px; height: 40px; background: #f0f0f0; 
                                                                border-radius: 4px; display: flex; align-items: center; 
                                                                justify-content: center; font-size: 12px; color: #999;">
                                                        📰
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="news-title">${news.title}</div>
                                            <div class="news-summary">
                                                <c:choose>
                                                    <c:when test="${news.summary.length() > 100}">
                                                        ${news.summary.substring(0, 100)}...
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${news.summary}
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="category-badge">${news.categoryName}</span>
                                        </td>
                                        <td>${news.authorName}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${news.home == 1}">
                                                    <span class="status-badge published">📢 Đã xuất bản</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge draft">📝 Bản nháp</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${news.approvalStatus == null || news.approvalStatus == 0}">
                                                    <span class="status-badge" style="background: #fff3cd; color: #856404;">⏳ Chờ duyệt</span>
                                                </c:when>
                                                <c:when test="${news.approvalStatus == 1}">
                                                    <span class="status-badge" style="background: #d4edda; color: #155724;">✅ Đã duyệt</span>
                                                </c:when>
                                                <c:when test="${news.approvalStatus == 2}">
                                                    <span class="status-badge" style="background: #f8d7da; color: #721c24;">❌ Từ chối</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge" style="background: #e9ecef; color: #495057;">❓ Không xác định</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${news.postedDate}</td>
                                        <td>
                                            <div class="action-buttons">
                                                <a href="${pageContext.request.contextPath}/admin/news/view/${news.id}" 
                                                   class="btn btn-view" title="Xem chi tiết">👁️</a>
                                                <a href="${pageContext.request.contextPath}/admin/news/edit/${news.id}" 
                                                   class="btn btn-edit" title="Chỉnh sửa">✏️</a>
                                                <!-- Nút duyệt/từ chối dựa trên ApprovalStatus -->
                                                <c:choose>
                                                    <c:when test="${news.approvalStatus == null || news.approvalStatus == 0}">
                                                        <!-- Chờ duyệt: hiển thị nút Duyệt và Từ chối -->
                                                        <a href="${pageContext.request.contextPath}/admin/news/approve/${news.id}" 
                                                           class="btn" style="background: #28a745; color: white;" 
                                                           title="Duyệt bài" onclick="return confirm('Bạn có chắc muốn duyệt bài này?')">✅ Duyệt</a>
                                                        <button class="btn" style="background: #dc3545; color: white;" 
                                                                onclick="rejectNews('${news.id}', '${news.title}')" 
                                                                title="Từ chối">❌ Từ chối</button>
                                                    </c:when>
                                                    <c:when test="${news.approvalStatus == 1}">
                                                        <!-- Đã duyệt: hiển thị nút Hủy duyệt -->
                                                        <button class="btn" style="background: #ffc107; color: #212529;" 
                                                                onclick="rejectNews('${news.id}', '${news.title}')" 
                                                                title="Hủy duyệt">⚠️ Hủy duyệt</button>
                                                    </c:when>
                                                    <c:when test="${news.approvalStatus == 2}">
                                                        <!-- Đã từ chối: hiển thị nút Duyệt lại -->
                                                        <a href="${pageContext.request.contextPath}/admin/news/approve/${news.id}" 
                                                           class="btn" style="background: #28a745; color: white;" 
                                                           title="Duyệt lại" onclick="return confirm('Bạn có chắc muốn duyệt lại bài này?')">✅ Duyệt lại</a>
                                                    </c:when>
                                                </c:choose>
                                                <button class="btn btn-delete" 
                                                        onclick="deleteNews('${news.id}', '${news.title}')" 
                                                        title="Xóa">🗑️</button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" style="text-align: center; padding: 40px; color: #999;">
                                        📰 Chưa có tin tức nào. <a href="${pageContext.request.contextPath}/admin/news/add">Thêm tin tức đầu tiên</a>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <div class="pagination">
                    <c:if test="${currentPage > 1}">
                        <a href="?page=${currentPage - 1}&search=${param.search}&category=${param.category}&status=${param.status}">« Trước</a>
                    </c:if>
                    
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <span class="current">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="?page=${i}&search=${param.search}&category=${param.category}&status=${param.status}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    
                    <c:if test="${currentPage < totalPages}">
                        <a href="?page=${currentPage + 1}&search=${param.search}&category=${param.category}&status=${param.status}">Sau »</a>
                    </c:if>
                </div>
            </c:if>
        </main>
    </div>

    <script>
        function searchNews() {
            const search = document.getElementById('searchInput').value;
            const category = document.getElementById('categoryFilter').value;
            const status = document.getElementById('statusFilter').value;
            
            let url = '${pageContext.request.contextPath}/admin/news?';
            const params = [];
            
            if (search) params.push('search=' + encodeURIComponent(search));
            if (category) params.push('category=' + category);
            if (status) params.push('status=' + status);
            
            url += params.join('&');
            window.location.href = url;
        }

        function deleteNews(id, title) {
            if (confirm('Bạn có chắc chắn muốn xóa tin tức "' + title + '"?\nHành động này không thể hoàn tác.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin/news/delete/' + id;
                
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = '_method';
                input.value = 'DELETE';
                form.appendChild(input);
                
                document.body.appendChild(form);
                form.submit();
            }
        }

        function rejectNews(id, title) {
            const reason = prompt('Lý do từ chối bài viết "' + title + '":\n(Tùy chọn - có thể để trống)', '');
            
            if (reason !== null) { // User didn't cancel
                const form = document.createElement('form');
                form.method = 'GET';
                form.action = '${pageContext.request.contextPath}/admin/news/reject/' + id;
                
                if (reason.trim()) {
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'reason';
                    input.value = reason.trim();
                    form.appendChild(input);
                }
                
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Enter key search
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchNews();
            }
        });

        // Auto-search on filter change
        document.getElementById('categoryFilter').addEventListener('change', searchNews);
        document.getElementById('statusFilter').addEventListener('change', searchNews);
    </script>
</body>
</html>