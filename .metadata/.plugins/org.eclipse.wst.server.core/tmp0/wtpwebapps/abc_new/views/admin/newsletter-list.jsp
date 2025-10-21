<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Newsletter - ABC News Admin</title>
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
        
        .header-actions {
            display: flex;
            gap: 10px;
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
        
        .export-btn {
            background: #28a745;
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
        
        .export-btn:hover {
            background: #218838;
            color: white;
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
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #c41e3a;
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: #666;
            font-size: 14px;
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
        
        /* Newsletter Table */
        .newsletter-table {
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
            vertical-align: middle;
        }
        
        .table tr:hover {
            background: #f8f9fa;
        }
        
        .status-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .status-badge.active {
            background: #d4edda;
            color: #155724;
        }
        
        .status-badge.inactive {
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
        
        .btn-send {
            background: #17a2b8;
            color: white;
        }
        
        .btn-send:hover {
            background: #138496;
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
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .header-actions {
                flex-direction: column;
                gap: 5px;
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
                    <a href="${pageContext.request.contextPath}/admin/news">
                        <span class="icon">📰</span>
                        <span>Quản lý tin tức</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/newsletters" class="active">
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
                <h1 class="page-title">📧 Quản lý Newsletter</h1>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/admin/newsletters/export" class="export-btn">
                        <span>📊</span>
                        <span>Xuất danh sách</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/newsletters/send" class="add-btn">
                        <span>📤</span>
                        <span>Gửi Newsletter</span>
                    </a>
                </div>
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

            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-number">${totalSubscribers != null ? totalSubscribers : 0}</div>
                    <div class="stat-label">Tổng đăng ký</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">${activeSubscribers != null ? activeSubscribers : 0}</div>
                    <div class="stat-label">Đang hoạt động</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">${todaySubscribers != null ? todaySubscribers : 0}</div>
                    <div class="stat-label">Đăng ký hôm nay</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">${monthSubscribers != null ? monthSubscribers : 0}</div>
                    <div class="stat-label">Đăng ký tháng này</div>
                </div>
            </div>

            <!-- Search and Filter -->
            <div class="search-filter">
                <input type="text" class="search-input" placeholder="🔍 Tìm kiếm theo email..." id="searchInput">
                <select class="filter-select" id="statusFilter">
                    <option value="">Tất cả trạng thái</option>
                    <option value="1">Đang hoạt động</option>
                    <option value="0">Đã hủy</option>
                </select>
                <input type="date" class="filter-select" id="dateFilter" title="Lọc theo ngày đăng ký">
                <button class="search-btn" onclick="searchNewsletters()">Tìm kiếm</button>
            </div>

            <!-- Newsletter Table -->
            <div class="newsletter-table">
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Email</th>
                            <th>Trạng thái</th>
                            <th>Ngày đăng ký</th>
                            <th>Lần gửi cuối</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty newsletterList}">
                                <c:forEach var="newsletter" items="${newsletterList}">
                                    <tr>
                                        <td>#${newsletter.id}</td>
                                        <td>
                                            <strong>${newsletter.email}</strong>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${newsletter.isActive == 1}">
                                                    <span class="status-badge active">Đang hoạt động</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge inactive">Đã hủy</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${newsletter.subscribedAt}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty newsletter.lastSentAt}">
                                                    ${newsletter.lastSentAt}
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: #999;">Chưa gửi</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <c:if test="${newsletter.isActive == 1}">
                                                    <button class="btn btn-send" 
                                                            onclick="sendToSubscriber(${newsletter.id}, '${newsletter.email}')" 
                                                            title="Gửi email">📤</button>
                                                </c:if>
                                                <button class="btn btn-edit" 
                                                        onclick="toggleStatus(${newsletter.id}, ${newsletter.isActive})" 
                                                        title="${newsletter.isActive == 1 ? 'Hủy đăng ký' : 'Kích hoạt lại'}">
                                                    ${newsletter.isActive == 1 ? '🚫' : '✅'}
                                                </button>
                                                <button class="btn btn-delete" 
                                                        onclick="deleteSubscriber(${newsletter.id}, '${newsletter.email}')" 
                                                        title="Xóa vĩnh viễn">🗑️</button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" style="text-align: center; padding: 40px; color: #999;">
                                        📧 Chưa có người đăng ký newsletter nào.
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
                        <a href="?page=${currentPage - 1}&search=${param.search}&status=${param.status}&date=${param.date}">« Trước</a>
                    </c:if>
                    
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <span class="current">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="?page=${i}&search=${param.search}&status=${param.status}&date=${param.date}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    
                    <c:if test="${currentPage < totalPages}">
                        <a href="?page=${currentPage + 1}&search=${param.search}&status=${param.status}&date=${param.date}">Sau »</a>
                    </c:if>
                </div>
            </c:if>
        </main>
    </div>

    <script>
        function searchNewsletters() {
            const search = document.getElementById('searchInput').value;
            const status = document.getElementById('statusFilter').value;
            const date = document.getElementById('dateFilter').value;
            
            let url = '${pageContext.request.contextPath}/admin/newsletters?';
            const params = [];
            
            if (search) params.push('search=' + encodeURIComponent(search));
            if (status) params.push('status=' + status);
            if (date) params.push('date=' + date);
            
            url += params.join('&');
            window.location.href = url;
        }

        function sendToSubscriber(id, email) {
            if (confirm('Gửi newsletter đến email: ' + email + '?')) {
                fetch('${pageContext.request.contextPath}/admin/newsletters/send-single', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'subscriberId=' + id
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('Đã gửi newsletter thành công!');
                        location.reload();
                    } else {
                        alert('Lỗi: ' + data.message);
                    }
                })
                .catch(error => {
                    alert('Có lỗi xảy ra khi gửi email');
                    console.error('Error:', error);
                });
            }
        }

        function toggleStatus(id, currentStatus) {
            const action = currentStatus == 1 ? 'hủy đăng ký' : 'kích hoạt lại';
            if (confirm('Bạn có chắc chắn muốn ' + action + ' cho người dùng này?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin/newsletters/toggle/' + id;
                
                document.body.appendChild(form);
                form.submit();
            }
        }

        function deleteSubscriber(id, email) {
            if (confirm('Bạn có chắc chắn muốn xóa vĩnh viễn đăng ký của email: ' + email + '?\n\nHành động này không thể hoàn tác.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin/newsletters/delete/' + id;
                
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = '_method';
                input.value = 'DELETE';
                form.appendChild(input);
                
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Enter key search
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchNewsletters();
            }
        });

        // Auto-search on filter change
        document.getElementById('statusFilter').addEventListener('change', searchNewsletters);
        document.getElementById('dateFilter').addEventListener('change', searchNewsletters);

        // Bulk actions
        function selectAll() {
            const checkboxes = document.querySelectorAll('input[name="selectedIds"]');
            const selectAllCheckbox = document.getElementById('selectAll');
            
            checkboxes.forEach(checkbox => {
                checkbox.checked = selectAllCheckbox.checked;
            });
        }

        function bulkSendNewsletter() {
            const selectedIds = Array.from(document.querySelectorAll('input[name="selectedIds"]:checked'))
                                    .map(cb => cb.value);
            
            if (selectedIds.length === 0) {
                alert('Vui lòng chọn ít nhất một người đăng ký');
                return;
            }
            
            if (confirm('Gửi newsletter đến ' + selectedIds.length + ' người đăng ký đã chọn?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin/newsletters/bulk-send';
                
                selectedIds.forEach(id => {
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'selectedIds';
                    input.value = id;
                    form.appendChild(input);
                });
                
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>