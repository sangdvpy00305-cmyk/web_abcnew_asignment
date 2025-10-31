<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Tin tức của tôi - ABC News Reporter</title>
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
                    background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
                    color: white;
                    padding: 15px 0;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
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
                    background: rgba(255, 255, 255, 0.2);
                    padding: 8px 15px;
                    border-radius: 20px;
                    font-size: 14px;
                }

                .logout-btn {
                    background: rgba(255, 255, 255, 0.2);
                    color: white;
                    border: none;
                    padding: 8px 15px;
                    border-radius: 20px;
                    text-decoration: none;
                    font-size: 14px;
                    transition: all 0.3s;
                }

                .logout-btn:hover {
                    background: rgba(255, 255, 255, 0.3);
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
                    box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
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
                    background: linear-gradient(135deg, #28a745, #20c997);
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
                    box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
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
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                    text-align: center;
                }

                .stat-number {
                    font-size: 2rem;
                    font-weight: bold;
                    color: #28a745;
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
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
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
                    background: #28a745;
                    color: white;
                    border: none;
                    padding: 10px 20px;
                    border-radius: 5px;
                    cursor: pointer;
                    font-size: 14px;
                    transition: all 0.3s;
                }

                .search-btn:hover {
                    background: #218838;
                }

                /* News Grid */
                .news-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
                    gap: 20px;
                }

                .news-card {
                    background: white;
                    border-radius: 10px;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                    overflow: hidden;
                    transition: all 0.3s;
                }

                .news-card:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
                }

                .news-image {
                    width: 100%;
                    height: 200px;
                    object-fit: cover;
                    background: #f0f0f0;
                }

                .news-image-placeholder {
                    width: 100%;
                    height: 200px;
                    background: linear-gradient(135deg, #f0f0f0, #e0e0e0);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 3rem;
                    color: #999;
                }

                .news-content {
                    padding: 20px;
                }

                .news-title {
                    font-size: 1.2rem;
                    font-weight: bold;
                    color: #333;
                    margin-bottom: 10px;
                    line-height: 1.4;
                    display: -webkit-box;
                    -webkit-line-clamp: 2;
                    -webkit-box-orient: vertical;
                    overflow: hidden;
                }

                .news-summary {
                    color: #666;
                    font-size: 14px;
                    line-height: 1.5;
                    margin-bottom: 15px;
                    display: -webkit-box;
                    -webkit-line-clamp: 3;
                    -webkit-box-orient: vertical;
                    overflow: hidden;
                }

                .news-meta {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    font-size: 12px;
                    color: #999;
                    margin-bottom: 15px;
                }

                .category-tag {
                    background: #28a745;
                    color: white;
                    padding: 4px 8px;
                    border-radius: 12px;
                    font-size: 11px;
                    font-weight: bold;
                }

                .status-badge {
                    padding: 4px 8px;
                    border-radius: 12px;
                    font-size: 12px;
                    font-weight: bold;
                    white-space: nowrap;
                }

                .status-badge.published {
                    background: #d4edda;
                    color: #155724;
                }

                .status-badge.pending {
                    background: #fff3cd;
                    color: #856404;
                }

                .status-badge.draft {
                    background: #f8d7da;
                    color: #721c24;
                }

                .news-actions {
                    display: flex;
                    gap: 8px;
                }

                .action-btn {
                    flex: 1;
                    padding: 8px 12px;
                    border: none;
                    border-radius: 5px;
                    font-size: 12px;
                    font-weight: 500;
                    cursor: pointer;
                    transition: all 0.3s;
                    text-decoration: none;
                    text-align: center;
                }

                .action-btn.edit {
                    background: #ffc107;
                    color: #212529;
                }

                .action-btn.edit:hover {
                    background: #e0a800;
                    color: #212529;
                }

                .action-btn.delete {
                    background: #dc3545;
                    color: white;
                }

                .action-btn.delete:hover {
                    background: #c82333;
                }

                .action-btn.view {
                    background: #17a2b8;
                    color: white;
                }

                .action-btn.view:hover {
                    background: #138496;
                    color: white;
                }

                /* Empty State */
                .empty-state {
                    text-align: center;
                    padding: 60px 20px;
                    color: #666;
                }

                .empty-state .icon {
                    font-size: 4rem;
                    margin-bottom: 20px;
                    opacity: 0.5;
                }

                .empty-state h3 {
                    font-size: 1.5rem;
                    margin-bottom: 10px;
                    color: #333;
                }

                .empty-state p {
                    font-size: 1rem;
                    margin-bottom: 30px;
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

                /* Pagination */
                .pagination {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    gap: 10px;
                    margin-top: 30px;
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
                    background: #28a745;
                    color: white;
                    border-color: #28a745;
                }

                .pagination .current {
                    background: #28a745;
                    color: white;
                    border-color: #28a745;
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

                    .news-grid {
                        grid-template-columns: 1fr;
                    }

                    .stats-grid {
                        grid-template-columns: repeat(2, 1fr);
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
                            <a href="${pageContext.request.contextPath}/reporter/dashboard">
                                <span class="icon">📊</span>
                                <span>Bảng điều khiển</span>
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/reporter/news" class="active">
                                <span class="icon">📰</span>
                                <span>Quản lý tin tức</span>
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
                        <h1 class="page-title">📰 Tin tức của tôi</h1>
                        <a href="${pageContext.request.contextPath}/reporter/news/add" class="add-btn">
                            <span>✍️</span>
                            <span>Viết tin mới</span>
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

                    <!-- Stats Cards -->
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-number">${totalNews != null ? totalNews : 0}</div>
                            <div class="stat-label">Tổng tin tức</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">${publishedNews != null ? publishedNews : 0}</div>
                            <div class="stat-label">Đã xuất bản</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">${pendingNews != null ? pendingNews : 0}</div>
                            <div class="stat-label">Chờ duyệt</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">${draftNews != null ? draftNews : 0}</div>
                            <div class="stat-label">Bản nháp</div>
                        </div>
                    </div>

                    <!-- Search and Filter -->
                    <div class="search-filter">
                        <input type="text" class="search-input" placeholder="🔍 Tìm kiếm tin tức..." id="searchInput">
                        <select class="filter-select" id="statusFilter">
                            <option value="">Tất cả trạng thái</option>
                            <option value="published">Đã xuất bản</option>
                            <option value="pending">Chờ duyệt</option>
                            <option value="draft">Bản nháp</option>
                        </select>
                        <select class="filter-select" id="categoryFilter">
                            <option value="">Tất cả danh mục</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                        <button class="search-btn" onclick="searchNews()">Tìm kiếm</button>
                    </div>

                    <!-- News Grid -->
                    <div class="news-grid">
                        <c:choose>
                            <c:when test="${not empty newsList}">
                                <c:forEach var="news" items="${newsList}">
                                    <div class="news-card">
                                        <c:choose>
                                            <c:when test="${not empty news.imageUrl}">
                                                <img src="${pageContext.request.contextPath}${news.imageUrl}"
                                                    alt="News Image" class="news-image">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="news-image-placeholder">📰</div>
                                            </c:otherwise>
                                        </c:choose>

                                        <div class="news-content">
                                            <h3 class="news-title">${news.title}</h3>
                                            <p class="news-summary">${news.summary}</p>

                                            <div class="news-meta">
                                                <span class="category-tag">${news.categoryName}</span>
                                                <span>${news.createdAt}</span>
                                            </div>

                                            <div
                                                style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
                                                <c:choose>
                                                    <c:when test="${news.published == 1}">
                                                        <span class="status-badge published">✅ Đã xuất bản</span>
                                                    </c:when>
                                                    <c:when test="${news.published == 0}">
                                                        <span class="status-badge pending">⏳ Chờ duyệt</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge draft">📝 Bản nháp</span>
                                                    </c:otherwise>
                                                </c:choose>

                                                <c:if test="${news.published == 1}">
                                                    <span style="font-size: 12px; color: #999;">
                                                        👁️ ${news.views != null ? news.views : 0} lượt xem
                                                    </span>
                                                </c:if>
                                            </div>

                                            <div class="news-actions">
                                                <c:if test="${news.published == 1}">
                                                    <a href="${pageContext.request.contextPath}/news/${news.id}"
                                                        class="action-btn view" target="_blank">👁️ Xem</a>
                                                </c:if>
                                                <a href="${pageContext.request.contextPath}/reporter/news/edit/${news.id}"
                                                    class="action-btn edit">✏️ Sửa</a>
                                                <c:if test="${news.published != 1}">
                                                    <button class="action-btn delete"
                                                        onclick="deleteNews(${news.id}, '${news.title}')">🗑️
                                                        Xóa</button>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state" style="grid-column: 1 / -1;">
                                    <div class="icon">📝</div>
                                    <h3>Chưa có tin tức nào</h3>
                                    <p>Bạn chưa viết tin tức nào. Hãy bắt đầu viết tin đầu tiên!</p>
                                    <a href="${pageContext.request.contextPath}/reporter/news/add" class="add-btn">
                                        ✍️ Viết tin đầu tiên
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="pagination">
                            <c:if test="${currentPage > 1}">
                                <a
                                    href="?page=${currentPage - 1}&search=${param.search}&status=${param.status}&category=${param.category}">«
                                    Trước</a>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <span class="current">${i}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a
                                            href="?page=${i}&search=${param.search}&status=${param.status}&category=${param.category}">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <a
                                    href="?page=${currentPage + 1}&search=${param.search}&status=${param.status}&category=${param.category}">Sau
                                    »</a>
                            </c:if>
                        </div>
                    </c:if>
                </main>
            </div>

            <script>
                function searchNews() {
                    const search = document.getElementById('searchInput').value;
                    const status = document.getElementById('statusFilter').value;
                    const category = document.getElementById('categoryFilter').value;

                    let url = '${pageContext.request.contextPath}/reporter/news?';
                    const params = [];

                    if (search) params.push('search=' + encodeURIComponent(search));
                    if (status) params.push('status=' + status);
                    if (category) params.push('category=' + category);

                    url += params.join('&');
                    window.location.href = url;
                }

                function deleteNews(id, title) {
                    if (confirm('Bạn có chắc chắn muốn xóa tin tức "' + title + '"?\n\nHành động này không thể hoàn tác.')) {
                        const form = document.createElement('form');
                        form.method = 'POST';
                        form.action = '${pageContext.request.contextPath}/reporter/news/delete/' + id;

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
                document.getElementById('searchInput').addEventListener('keypress', function (e) {
                    if (e.key === 'Enter') {
                        searchNews();
                    }
                });

                // Auto-search on filter change
                document.getElementById('statusFilter').addEventListener('change', searchNews);
                document.getElementById('categoryFilter').addEventListener('change', searchNews);

                // Auto-refresh every 30 seconds to check for approval status updates
                setInterval(function () {
                    // Only refresh if there are pending news
                    const pendingCount = ${ pendingNews != null ? pendingNews : 0
                };
                if (pendingCount > 0) {
                    // You can add AJAX call here to check for updates
                    console.log('Checking for approval updates...');
                }
        }, 30000);
            </script>
        </body>

        </html>