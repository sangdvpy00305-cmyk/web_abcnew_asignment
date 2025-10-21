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

                .container {
                    max-width: 1200px;
                    margin: 0 auto;
                    padding: 30px 20px;
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
                }

                .add-btn:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
                    color: white;
                }

                .back-btn {
                    background: #6c757d;
                    color: white;
                    padding: 10px 20px;
                    border: none;
                    border-radius: 6px;
                    text-decoration: none;
                    font-size: 14px;
                    margin-right: 15px;
                    transition: all 0.3s;
                }

                .back-btn:hover {
                    background: #5a6268;
                    color: white;
                }

                .alert {
                    padding: 15px;
                    border-radius: 8px;
                    margin-bottom: 20px;
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

                .news-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
                    gap: 20px;
                }

                .news-card {
                    background: white;
                    border-radius: 10px;
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                    overflow: hidden;
                    transition: all 0.3s;
                }

                .news-card:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
                }

                .news-image {
                    height: 200px;
                    background: linear-gradient(45deg, #28a745, #20c997);
                    position: relative;
                    overflow: hidden;
                }

                .news-image::after {
                    content: '📰';
                    position: absolute;
                    top: 50%;
                    left: 50%;
                    transform: translate(-50%, -50%);
                    font-size: 3rem;
                    opacity: 0.3;
                }

                .news-content {
                    padding: 20px;
                }

                .news-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: flex-start;
                    margin-bottom: 15px;
                }

                .news-title {
                    font-size: 1.1rem;
                    font-weight: bold;
                    color: #333;
                    line-height: 1.4;
                    margin-bottom: 10px;
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

                .status-badge.rejected {
                    background: #f8d7da;
                    color: #721c24;
                }

                .rejection-reason {
                    background: #f8d7da;
                    color: #721c24;
                    padding: 8px 12px;
                    border-radius: 6px;
                    font-size: 12px;
                    margin-top: 8px;
                    border-left: 3px solid #dc3545;
                }

                .news-excerpt {
                    color: #666;
                    font-size: 14px;
                    line-height: 1.5;
                    margin-bottom: 15px;
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

                .news-actions {
                    display: flex;
                    gap: 8px;
                }

                .action-btn {
                    flex: 1;
                    padding: 8px 12px;
                    border: none;
                    border-radius: 6px;
                    text-decoration: none;
                    font-size: 12px;
                    font-weight: 500;
                    text-align: center;
                    transition: all 0.3s;
                }

                .view-btn {
                    background: #d1ecf1;
                    color: #0c5460;
                }

                .view-btn:hover {
                    background: #bee5eb;
                    color: #0c5460;
                }

                .edit-btn {
                    background: #fff3cd;
                    color: #856404;
                }

                .edit-btn:hover {
                    background: #ffeaa7;
                    color: #856404;
                }

                .delete-btn {
                    background: #f8d7da;
                    color: #721c24;
                }

                .delete-btn:hover {
                    background: #f5c6cb;
                    color: #721c24;
                }

                .empty-state {
                    text-align: center;
                    padding: 60px 20px;
                    color: #666;
                    grid-column: 1 / -1;
                }

                .empty-state .icon {
                    font-size: 4rem;
                    margin-bottom: 20px;
                    opacity: 0.5;
                }

                @media (max-width: 768px) {
                    .news-grid {
                        grid-template-columns: 1fr;
                    }

                    .page-header {
                        flex-direction: column;
                        gap: 15px;
                        align-items: stretch;
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

            <div class="container">
                <!-- Page Header -->
                <div class="page-header">
                    <div>
                        <a href="${pageContext.request.contextPath}/reporter/dashboard" class="back-btn">
                            ← Quay lại Dashboard
                        </a>
                        <h1 class="page-title">📰 Tin tức của tôi</h1>
                    </div>
                    <a href="${pageContext.request.contextPath}/reporter/news/add" class="add-btn">
                        ✍️ Viết tin mới
                    </a>
                </div>

                <!-- Messages -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success">
                        ✅ ${success}
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-error">
                        ❌ ${error}
                    </div>
                </c:if>

                <!-- News Grid -->
                <div class="news-grid">
                    <c:choose>
                        <c:when test="${not empty myNews}">
                            <c:forEach var="news" items="${myNews}">
                                <div class="news-card">
                                    <div class="news-image">
                                        <c:choose>
                                            <c:when test="${not empty news.image}">
                                                <img src="${pageContext.request.contextPath}${news.image}"
                                                    alt="${news.title}"
                                                    style="width: 100%; height: 100%; object-fit: cover;">
                                            </c:when>
                                            <c:otherwise>
                                                <div
                                                    style="width: 100%; height: 100%; background: linear-gradient(135deg, #f8f9fa, #e9ecef); display: flex; align-items: center; justify-content: center; color: #999; font-size: 2rem;">
                                                    📰
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="news-content">
                                        <div class="news-header">
                                            <span
                                                class="status-badge ${news.approvalStatus == 1 ? 'published' : (news.approvalStatus == 2 ? 'rejected' : 'pending')}">
                                                <c:choose>
                                                    <c:when test="${news.approvalStatus == 1}">✅ Đã duyệt</c:when>
                                                    <c:when test="${news.approvalStatus == 2}">❌ Từ chối</c:when>
                                                    <c:otherwise>⏳ Chờ duyệt</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>

                                        <!-- Hiển thị lý do từ chối nếu có -->
                                        <c:if test="${news.approvalStatus == 2 && not empty news.approvalNote}">
                                            <div class="rejection-reason">
                                                <strong>Lý do từ chối:</strong> ${news.approvalNote}
                                            </div>
                                        </c:if>

                                        <h3 class="news-title">${news.title}</h3>

                                        <p class="news-excerpt">
                                            ${news.content.length() > 120 ? news.content.substring(0, 120).concat('...')
                                            : news.content}
                                        </p>

                                        <div class="news-meta">
                                            <span class="category-tag">${news.categoryName != null ? news.categoryName :
                                                'Tin tức'}</span>
                                            <span>${news.postedDate}</span>
                                            <span>👁️ ${news.viewCount}</span>
                                        </div>

                                        <div class="news-actions">
                                            <a href="${pageContext.request.contextPath}/reporter/news/view/${news.id}"
                                                class="action-btn view-btn">
                                                👁️ Xem
                                            </a>
                                            <a href="${pageContext.request.contextPath}/reporter/news/edit/${news.id}"
                                                class="action-btn edit-btn">
                                                ✏️ Sửa
                                            </a>
                                            <a href="${pageContext.request.contextPath}/reporter/news/delete/${news.id}"
                                                class="action-btn delete-btn"
                                                onclick="return confirm('Bạn có chắc muốn xóa tin này?')">
                                                🗑️ Xóa
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <div class="icon">📝</div>
                                <h3>Chưa có tin tức nào</h3>
                                <p>Bạn chưa viết tin tức nào. Hãy bắt đầu viết tin đầu tiên!</p>
                                <br>
                                <a href="${pageContext.request.contextPath}/reporter/news/add" class="add-btn">
                                    ✍️ Viết tin đầu tiên
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <script>
                // Confirm delete
                function confirmDelete(newsId, title) {
                    if (confirm('Bạn có chắc muốn xóa tin "' + title + '"?')) {
                        window.location.href = '${pageContext.request.contextPath}/reporter/news/delete/' + newsId;
                    }
                }
            </script>
        </body>

        </html>