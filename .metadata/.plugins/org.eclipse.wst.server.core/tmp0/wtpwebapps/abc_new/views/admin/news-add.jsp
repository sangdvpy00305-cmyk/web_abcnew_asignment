<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm tin tức mới - ABC News Admin</title>
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
        
        .back-btn {
            background: #6c757d;
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
        
        .back-btn:hover {
            background: #5a6268;
            color: white;
        }
        
        /* Form Container */
        .form-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 30px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }
        
        .form-input,
        .form-select,
        .form-textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
        }
        
        .form-input:focus,
        .form-select:focus,
        .form-textarea:focus {
            outline: none;
            border-color: #c41e3a;
            box-shadow: 0 0 0 3px rgba(196, 30, 58, 0.1);
        }
        
        .form-textarea {
            resize: vertical;
            min-height: 120px;
        }
        
        .form-textarea.content {
            min-height: 300px;
        }
        
        .file-input-wrapper {
            position: relative;
            display: inline-block;
            width: 100%;
        }
        
        .file-input {
            position: absolute;
            opacity: 0;
            width: 100%;
            height: 100%;
            cursor: pointer;
        }
        
        .file-input-display {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 15px;
            border: 2px dashed #ddd;
            border-radius: 8px;
            background: #f8f9fa;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .file-input-display:hover {
            border-color: #c41e3a;
            background: #fff5f5;
        }
        
        .image-preview {
            max-width: 100%;
            max-height: 200px;
            border-radius: 8px;
            margin-top: 10px;
            display: none;
        }
        
        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .checkbox {
            width: 18px;
            height: 18px;
            accent-color: #c41e3a;
        }
        
        /* Form Actions */
        .form-actions {
            grid-column: 1 / -1;
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #f0f0f0;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #c41e3a, #a01729);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(196, 30, 58, 0.3);
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
            color: white;
        }
        
        .btn-success {
            background: #28a745;
            color: white;
        }
        
        .btn-success:hover {
            background: #218838;
        }
        
        /* Alert Messages */
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-weight: 500;
        }
        
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        /* Side Panel */
        .side-panel {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            height: fit-content;
        }
        
        .side-panel h3 {
            color: #333;
            margin-bottom: 15px;
            font-size: 1.2rem;
        }
        
        .help-text {
            font-size: 14px;
            color: #666;
            line-height: 1.5;
            margin-bottom: 15px;
        }
        
        .tips-list {
            list-style: none;
            font-size: 14px;
        }
        
        .tips-list li {
            margin-bottom: 8px;
            color: #666;
            display: flex;
            align-items: flex-start;
            gap: 8px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .main-layout {
                grid-template-columns: 1fr;
            }
            
            .sidebar {
                display: none;
            }
            
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .form-actions {
                flex-direction: column;
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
                <h1 class="page-title">➕ Thêm tin tức mới</h1>
                <a href="${pageContext.request.contextPath}/admin/news" class="back-btn">
                    <span>←</span>
                    <span>Quay lại danh sách</span>
                </a>
            </div>

            <!-- Error Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    ${error}
                </div>
            </c:if>

            <!-- Form Container -->
            <div class="form-container">
                <form action="${pageContext.request.contextPath}/admin/news/add" method="post" enctype="multipart/form-data">
                    <div class="form-grid">
                        <!-- Main Form -->
                        <div class="main-form">
                            <div class="form-group">
                                <label for="title" class="form-label">Tiêu đề tin tức *</label>
                                <input type="text" id="title" name="title" class="form-input" 
                                       value="${param.title}" required 
                                       placeholder="Nhập tiêu đề tin tức...">
                            </div>

                            <div class="form-group">
                                <label for="summary" class="form-label">Tóm tắt *</label>
                                <textarea id="summary" name="summary" class="form-textarea" 
                                          required placeholder="Nhập tóm tắt ngắn gọn về tin tức...">${param.summary}</textarea>
                            </div>

                            <div class="form-group">
                                <label for="content" class="form-label">Nội dung tin tức *</label>
                                <textarea id="content" name="content" class="form-textarea content" 
                                          required placeholder="Nhập nội dung chi tiết của tin tức...">${param.content}</textarea>
                            </div>

                            <div class="form-group">
                                <label for="imageFile" class="form-label">Hình ảnh đại diện</label>
                                <div class="file-input-wrapper">
                                    <input type="file" id="imageFile" name="imageFile" class="file-input" 
                                           accept="image/*" onchange="previewImage(this)">
                                    <div class="file-input-display">
                                        <span>📷</span>
                                        <span>Chọn hình ảnh hoặc kéo thả vào đây</span>
                                    </div>
                                </div>
                                <img id="imagePreview" class="image-preview" alt="Preview">
                            </div>
                        </div>

                        <!-- Side Panel -->
                        <div class="side-panel">
                            <h3>📋 Thông tin xuất bản</h3>
                            
                            <div class="form-group">
                                <label for="categoryId" class="form-label">Danh mục *</label>
                                <select id="categoryId" name="categoryId" class="form-select" required>
                                    <option value="">Chọn danh mục</option>
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.id}" 
                                                ${param.categoryId == category.id ? 'selected' : ''}>
                                            ${category.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <div class="checkbox-group">
                                    <input type="checkbox" id="published" name="published" 
                                           value="1" class="checkbox" ${param.published == '1' ? 'checked' : ''}>
                                    <label for="published" class="form-label">Xuất bản ngay</label>
                                </div>
                            </div>

                            <div class="help-text">
                                <strong>💡 Gợi ý:</strong>
                                <ul class="tips-list">
                                    <li>📝 Tiêu đề nên ngắn gọn, súc tích</li>
                                    <li>📄 Tóm tắt không quá 200 từ</li>
                                    <li>🖼️ Hình ảnh nên có kích thước 800x600px</li>
                                    <li>✅ Kiểm tra chính tả trước khi đăng</li>
                                    <li>🔍 Sử dụng từ khóa phù hợp</li>
                                </ul>
                            </div>
                        </div>

                        <!-- Form Actions -->
                        <div class="form-actions">
                            <button type="submit" name="action" value="draft" class="btn btn-secondary">
                                <span>💾</span>
                                <span>Lưu bản nháp</span>
                            </button>
                            <button type="submit" name="action" value="publish" class="btn btn-primary">
                                <span>🚀</span>
                                <span>Đăng tin tức</span>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </main>
    </div>

    <script>
        function previewImage(input) {
            const preview = document.getElementById('imagePreview');
            const display = input.parentElement.querySelector('.file-input-display span:last-child');
            
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                    display.textContent = input.files[0].name;
                };
                
                reader.readAsDataURL(input.files[0]);
            } else {
                preview.style.display = 'none';
                display.textContent = 'Chọn hình ảnh hoặc kéo thả vào đây';
            }
        }

        // Auto-save draft every 2 minutes
        let autoSaveInterval;
        
        function startAutoSave() {
            autoSaveInterval = setInterval(function() {
                const title = document.getElementById('title').value;
                const summary = document.getElementById('summary').value;
                const content = document.getElementById('content').value;
                
                if (title || summary || content) {
                    // Save to localStorage as backup
                    localStorage.setItem('news_draft', JSON.stringify({
                        title: title,
                        summary: summary,
                        content: content,
                        timestamp: new Date().toISOString()
                    }));
                    console.log('Đã tự động lưu bản nháp');
                }
            }, 120000); // 2 minutes
        }

        // Load draft from localStorage
        function loadDraft() {
            const draft = localStorage.getItem('news_draft');
            if (draft) {
                const data = JSON.parse(draft);
                const now = new Date();
                const draftTime = new Date(data.timestamp);
                const diffHours = (now - draftTime) / (1000 * 60 * 60);
                
                // Only load if draft is less than 24 hours old
                if (diffHours < 24) {
                    if (confirm('Tìm thấy bản nháp đã lưu từ ' + draftTime.toLocaleString() + '. Bạn có muốn khôi phục không?')) {
                        document.getElementById('title').value = data.title || '';
                        document.getElementById('summary').value = data.summary || '';
                        document.getElementById('content').value = data.content || '';
                    }
                }
            }
        }

        // Clear draft after successful submission
        function clearDraft() {
            localStorage.removeItem('news_draft');
        }

        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            loadDraft();
            startAutoSave();
            
            // Clear draft on form submission
            document.querySelector('form').addEventListener('submit', function() {
                clearDraft();
            });
        });

        // Character counter for summary
        document.getElementById('summary').addEventListener('input', function() {
            const maxLength = 500;
            const currentLength = this.value.length;
            
            // You can add a character counter display here
            if (currentLength > maxLength) {
                this.style.borderColor = '#dc3545';
            } else {
                this.style.borderColor = '#ddd';
            }
        });
    </script>
</body>
</html>