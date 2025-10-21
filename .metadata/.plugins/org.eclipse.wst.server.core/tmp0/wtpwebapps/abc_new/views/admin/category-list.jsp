<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục - ABC News Admin</title>
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
        
        .container {
            max-width: 1000px;
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
        
        .categories-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .category-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 25px;
            transition: all 0.3s;
        }
        
        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        
        .category-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }
        
        .category-icon {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .category-id {
            background: #f8f9fa;
            color: #666;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .category-name {
            font-size: 1.3rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
        }
        
        .category-stats {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .stat-item {
            text-align: center;
        }
        
        .stat-number {
            font-size: 1.5rem;
            font-weight: bold;
            color: #c41e3a;
        }
        
        .stat-label {
            font-size: 12px;
            color: #666;
        }
        
        .category-actions {
            display: flex;
            gap: 10px;
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
            .categories-grid {
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

    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <div>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="back-btn">
                    ← Quay lại Dashboard
                </a>
                <h1 class="page-title">📂 Quản lý danh mục</h1>
            </div>
            <a href="${pageContext.request.contextPath}/admin/categories/add" class="add-btn">
                ➕ Thêm danh mục mới
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

        <!-- Categories Grid -->
        <div class="categories-grid">
            <c:choose>
                <c:when test="${not empty categories}">
                    <c:forEach var="category" items="${categories}">
                        <div class="category-card">
                            <div class="category-header">
                                <div class="category-icon">
                                    <c:choose>
                                        <c:when test="${category.name.contains('Thể thao')}">⚽</c:when>
                                        <c:when test="${category.name.contains('Giải trí')}">🎭</c:when>
                                        <c:when test="${category.name.contains('Công nghệ')}">💻</c:when>
                                        <c:when test="${category.name.contains('Kinh tế')}">💰</c:when>
                                        <c:when test="${category.name.contains('Thời sự')}">📰</c:when>
                                        <c:when test="${category.name.contains('Sức khỏe')}">🏥</c:when>
                                        <c:when test="${category.name.contains('Giáo dục')}">📚</c:when>
                                        <c:otherwise>📂</c:otherwise>
                                    </c:choose>
                                </div>
                                <span class="category-id">${category.id}</span>
                            </div>
                            
                            <div class="category-name">${category.name}</div>
                            
                            <div class="category-stats">
                                <div class="stat-item">
                                    <div class="stat-number">0</div>
                                    <div class="stat-label">Tin tức</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-number">0</div>
                                    <div class="stat-label">Lượt xem</div>
                                </div>
                            </div>
                            
                            <div class="category-actions">
                                <a href="${pageContext.request.contextPath}/admin/categories/edit/${category.id}" 
                                   class="action-btn edit-btn">
                                    ✏️ Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/categories/delete/${category.id}" 
                                   class="action-btn delete-btn"
                                   onclick="return confirm('Bạn có chắc muốn xóa danh mục ${category.name}?')">
                                    🗑️ Xóa
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="icon">📂</div>
                        <h3>Chưa có danh mục nào</h3>
                        <p>Hệ thống chưa có danh mục tin tức nào. Hãy thêm danh mục đầu tiên!</p>
                        <br>
                        <a href="${pageContext.request.contextPath}/admin/categories/add" class="add-btn">
                            ➕ Thêm danh mục đầu tiên
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        // Confirm delete with category name
        function confirmDelete(categoryId, categoryName) {
            if (confirm('Bạn có chắc muốn xóa danh mục "' + categoryName + '"?\n\nLưu ý: Không thể xóa danh mục đang có tin tức.')) {
                window.location.href = '${pageContext.request.contextPath}/admin/categories/delete/' + categoryId;
            }
        }

        // Add click handlers to delete buttons
        document.addEventListener('DOMContentLoaded', function() {
            const deleteButtons = document.querySelectorAll('.delete-btn');
            deleteButtons.forEach(button => {
                button.addEventListener('click', function(e) {
                    e.preventDefault();
                    const href = this.getAttribute('href');
                    const categoryId = href.split('/').pop();
                    const categoryName = this.closest('.category-card').querySelector('.category-name').textContent;
                    
                    if (confirm('Bạn có chắc muốn xóa danh mục "' + categoryName + '"?\n\nLưu ý: Không thể xóa danh mục đang có tin tức.')) {
                        window.location.href = href;
                    }
                });
            });
        });
    </script>
</body>
</html>