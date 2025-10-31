<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Duyệt bài viết - ABC News Admin</title>
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                    min-height: 100vh;
                    padding: 20px;
                    color: #333;
                }

                .container {
                    max-width: 1400px;
                    margin: 0 auto;
                    background: white;
                    border-radius: 15px;
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                    overflow: hidden;
                }

                .header {
                    background: linear-gradient(135deg, #c41e3a, #a01729);
                    color: white;
                    padding: 30px;
                    text-align: center;
                }

                .logo {
                    font-size: 2.5rem;
                    font-weight: bold;
                    margin-bottom: 10px;
                    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
                }

                .subtitle {
                    font-size: 1.2rem;
                    opacity: 0.9;
                }

                .content {
                    padding: 40px;
                }

                .stats {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                    gap: 20px;
                    margin-bottom: 30px;
                }

                .stat-card {
                    background: linear-gradient(135deg, #ffc107, #ff8f00);
                    color: white;
                    padding: 20px;
                    border-radius: 10px;
                    text-align: center;
                    box-shadow: 0 5px 15px rgba(255, 193, 7, 0.3);
                }

                .stat-number {
                    font-size: 2rem;
                    font-weight: bold;
                    margin-bottom: 5px;
                }

                .stat-label {
                    font-size: 0.9rem;
                    opacity: 0.9;
                }

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

                .news-grid {
                    display: grid;
                    gap: 20px;
                }

                .news-card {
                    background: #f8f9fa;
                    border-radius: 10px;
                    padding: 20px;
                    border-left: 4px solid #ffc107;
                    transition: all 0.3s;
                }

                .news-card:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                }

                .news-header {
                    display: flex;
                    justify-content: between;
                    align-items: flex-start;
                    margin-bottom: 15px;
                    gap: 20px;
                }

                .news-info {
                    flex: 1;
                }

                .news-title {
                    font-size: 1.2rem;
                    font-weight: bold;
                    color: #333;
                    margin-bottom: 10px;
                    line-height: 1.4;
                }

                .news-meta {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 15px;
                    font-size: 0.9rem;
                    color: #666;
                    margin-bottom: 10px;
                }

                .meta-item {
                    display: flex;
                    align-items: center;
                    gap: 5px;
                }

                .news-summary {
                    color: #555;
                    line-height: 1.5;
                    margin-bottom: 15px;
                }

                .news-actions {
                    display: flex;
                    gap: 10px;
                    flex-wrap: wrap;
                }

                .btn {
                    padding: 8px 16px;
                    border: none;
                    border-radius: 6px;
                    font-weight: 500;
                    cursor: pointer;
                    transition: all 0.3s;
                    text-decoration: none;
                    display: inline-flex;
                    align-items: center;
                    gap: 5px;
                    font-size: 0.9rem;
                }

                .btn-success {
                    background: #28a745;
                    color: white;
                }

                .btn-success:hover {
                    background: #218838;
                    transform: translateY(-1px);
                }

                .btn-danger {
                    background: #dc3545;
                    color: white;
                }

                .btn-danger:hover {
                    background: #c82333;
                    transform: translateY(-1px);
                }

                .btn-info {
                    background: #17a2b8;
                    color: white;
                }

                .btn-info:hover {
                    background: #138496;
                }

                .modal {
                    display: none;
                    position: fixed;
                    z-index: 1000;
                    left: 0;
                    top: 0;
                    width: 100%;
                    height: 100%;
                    background-color: rgba(0, 0, 0, 0.5);
                }

                .modal-content {
                    background-color: white;
                    margin: 10% auto;
                    padding: 30px;
                    border-radius: 10px;
                    width: 90%;
                    max-width: 500px;
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                }

                .modal-header {
                    margin-bottom: 20px;
                }

                .modal-title {
                    font-size: 1.3rem;
                    font-weight: bold;
                    color: #333;
                }

                .form-group {
                    margin-bottom: 15px;
                }

                .form-label {
                    display: block;
                    margin-bottom: 5px;
                    font-weight: 500;
                    color: #333;
                }

                .form-textarea {
                    width: 100%;
                    padding: 10px;
                    border: 1px solid #ddd;
                    border-radius: 6px;
                    resize: vertical;
                    min-height: 80px;
                }

                .modal-actions {
                    display: flex;
                    gap: 10px;
                    justify-content: flex-end;
                }

                .btn-secondary {
                    background: #6c757d;
                    color: white;
                }

                .btn-secondary:hover {
                    background: #5a6268;
                }

                .empty-state {
                    text-align: center;
                    padding: 60px 20px;
                    color: #666;
                }

                .empty-icon {
                    font-size: 4rem;
                    margin-bottom: 20px;
                }

                .empty-title {
                    font-size: 1.5rem;
                    margin-bottom: 10px;
                    color: #333;
                }

                .back-link {
                    text-align: center;
                    margin-top: 30px;
                }

                .back-link a {
                    color: #c41e3a;
                    text-decoration: none;
                    font-weight: 500;
                }

                .back-link a:hover {
                    text-decoration: underline;
                }

                @media (max-width: 768px) {
                    .news-header {
                        flex-direction: column;
                    }

                    .news-actions {
                        justify-content: center;
                    }
                }
            </style>
        </head>

        <body>
            <div class="container">
                <div class="header">
                    <div class="logo">📋 DUYỆT BÀI VIẾT</div>
                    <div class="subtitle">Quản lý và duyệt các bài viết chờ phê duyệt</div>
                </div>

                <div class="content">
                    <!-- Statistics -->
                    <div class="stats">
                        <div class="stat-card">
                            <div class="stat-number">${pendingCount}</div>
                            <div class="stat-label">Bài chờ duyệt</div>
                        </div>
                    </div>

                    <!-- Alert Messages -->
                    <c:if test="${not empty sessionScope.message}">
                        <div class="alert alert-success">
                            ${sessionScope.message}
                        </div>
                        <c:remove var="message" scope="session" />
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-error">
                            ${error}
                        </div>
                    </c:if>

                    <!-- News List -->
                    <c:choose>
                        <c:when test="${not empty pendingNews}">
                            <div class="news-grid">
                                <c:forEach var="news" items="${pendingNews}">
                                    <div class="news-card">
                                        <div class="news-header">
                                            <div class="news-info">
                                                <div class="news-title">${news.title}</div>
                                                <div class="news-meta">
                                                    <div class="meta-item">
                                                        <span>👤</span>
                                                        <span>${news.authorName}</span>
                                                    </div>
                                                    <div class="meta-item">
                                                        <span>📁</span>
                                                        <span>${news.categoryName}</span>
                                                    </div>
                                                    <div class="meta-item">
                                                        <span>📅</span>
                                                        <span>${news.postedDate}</span>
                                                    </div>
                                                    <div class="meta-item">
                                                        <span>👁️</span>
                                                        <span>${news.viewCount} lượt xem</span>
                                                    </div>
                                                </div>
                                                <div class="news-summary">
                                                    <c:choose>
                                                        <c:when test="${not empty news.summary}">
                                                            ${news.summary.length() > 200 ?
                                                            news.summary.substring(0, 200).concat('...') :
                                                            news.summary}
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${news.content.length() > 200 ?
                                                            news.content.substring(0, 200).concat('...') :
                                                            news.content}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="news-actions">
                                            <button class="btn btn-success"
                                                onclick="approveNews('${news.id}', '${news.title}')">
                                                <span>✅</span>
                                                <span>Duyệt bài</span>
                                            </button>

                                            <button class="btn btn-danger"
                                                onclick="rejectNews('${news.id}', '${news.title}')">
                                                <span>❌</span>
                                                <span>Từ chối</span>
                                            </button>

                                            <a href="${pageContext.request.contextPath}/admin/news/view/${news.id}"
                                                class="btn btn-info">
                                                <span>👁️</span>
                                                <span>Xem chi tiết</span>
                                            </a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <div class="empty-icon">🎉</div>
                                <div class="empty-title">Không có bài viết nào chờ duyệt</div>
                                <div>Tất cả bài viết đã được xử lý!</div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="back-link">
                    <a href="${pageContext.request.contextPath}/admin/dashboard">← Quay lại Dashboard Admin</a>
                </div>
            </div>

            <!-- Modal Approve -->
            <div id="approveModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title">Duyệt bài viết</h3>
                    </div>
                    <form id="approveForm" method="post"
                        action="${pageContext.request.contextPath}/admin/approval/approve">
                        <input type="hidden" id="approveNewsId" name="newsId">
                        <div class="form-group">
                            <label class="form-label">Bài viết:</label>
                            <div id="approveNewsTitle" style="font-weight: bold; color: #333;"></div>
                        </div>
                        <div class="form-group">
                            <label for="approveNote" class="form-label">Ghi chú (tùy chọn):</label>
                            <textarea id="approveNote" name="note" class="form-textarea"
                                placeholder="Nhập ghi chú về việc duyệt bài..."></textarea>
                        </div>
                        <div class="modal-actions">
                            <button type="button" class="btn btn-secondary"
                                onclick="closeModal('approveModal')">Hủy</button>
                            <button type="submit" class="btn btn-success">✅ Duyệt bài</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Modal Reject -->
            <div id="rejectModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title">Từ chối bài viết</h3>
                    </div>
                    <form id="rejectForm" method="post"
                        action="${pageContext.request.contextPath}/admin/approval/reject">
                        <input type="hidden" id="rejectNewsId" name="newsId">
                        <div class="form-group">
                            <label class="form-label">Bài viết:</label>
                            <div id="rejectNewsTitle" style="font-weight: bold; color: #333;"></div>
                        </div>
                        <div class="form-group">
                            <label for="rejectNote" class="form-label">Lý do từ chối *:</label>
                            <textarea id="rejectNote" name="note" class="form-textarea" required
                                placeholder="Nhập lý do từ chối bài viết..."></textarea>
                        </div>
                        <div class="modal-actions">
                            <button type="button" class="btn btn-secondary"
                                onclick="closeModal('rejectModal')">Hủy</button>
                            <button type="submit" class="btn btn-danger">❌ Từ chối</button>
                        </div>
                    </form>
                </div>
            </div>

            <script>
                function approveNews(newsId, newsTitle) {
                    document.getElementById('approveNewsId').value = newsId;
                    document.getElementById('approveNewsTitle').textContent = newsTitle;
                    document.getElementById('approveNote').value = '';
                    document.getElementById('approveModal').style.display = 'block';
                }

                function rejectNews(newsId, newsTitle) {
                    document.getElementById('rejectNewsId').value = newsId;
                    document.getElementById('rejectNewsTitle').textContent = newsTitle;
                    document.getElementById('rejectNote').value = '';
                    document.getElementById('rejectModal').style.display = 'block';
                }

                function closeModal(modalId) {
                    document.getElementById(modalId).style.display = 'none';
                }

                // Đóng modal khi click outside
                window.onclick = function (event) {
                    const approveModal = document.getElementById('approveModal');
                    const rejectModal = document.getElementById('rejectModal');

                    if (event.target === approveModal) {
                        approveModal.style.display = 'none';
                    }
                    if (event.target === rejectModal) {
                        rejectModal.style.display = 'none';
                    }
                }
            </script>
        </body>

        </html>