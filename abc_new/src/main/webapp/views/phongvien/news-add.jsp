<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Viết tin tức mới - ABC News Reporter</title>
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
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
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
                    border-color: #28a745;
                    box-shadow: 0 0 0 3px rgba(40, 167, 69, 0.1);
                }

                .form-textarea {
                    resize: vertical;
                    min-height: 120px;
                }

                .form-textarea.content {
                    min-height: 300px;
                }

                /* File Upload Styles */
                .file-input-wrapper {
                    position: relative;
                    border: 2px dashed #ddd;
                    border-radius: 8px;
                    padding: 20px;
                    text-align: center;
                    transition: all 0.3s;
                    cursor: pointer;
                }

                .file-input-wrapper:hover {
                    border-color: #28a745;
                    background: #f8fff9;
                }

                .file-input-wrapper.dragover {
                    border-color: #28a745;
                    background: #e8f5e8;
                }

                .file-input {
                    position: absolute;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    opacity: 0;
                    cursor: pointer;
                }

                .file-input-display {
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    gap: 10px;
                    color: #666;
                }

                .file-input-display span:first-child {
                    font-size: 2rem;
                }

                .image-preview {
                    max-width: 100%;
                    max-height: 200px;
                    margin-top: 15px;
                    border-radius: 8px;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                    display: none;
                }

                .file-info {
                    margin-top: 10px;
                    padding: 10px;
                    background: #f8f9fa;
                    border-radius: 6px;
                    font-size: 14px;
                    color: #666;
                    display: none;
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
                    border-color: #28a745;
                    background: #f0fff4;
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
                    accent-color: #28a745;
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
                    background: linear-gradient(135deg, #28a745, #20c997);
                    color: white;
                }

                .btn-primary:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
                }

                .btn-secondary {
                    background: #6c757d;
                    color: white;
                }

                .btn-secondary:hover {
                    background: #5a6268;
                    color: white;
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

                /* Status Info */
                .status-info {
                    background: #e7f3ff;
                    border: 1px solid #b3d9ff;
                    border-radius: 8px;
                    padding: 15px;
                    margin-bottom: 20px;
                }

                .status-info h4 {
                    color: #0066cc;
                    margin-bottom: 10px;
                }

                .status-info p {
                    color: #004499;
                    font-size: 14px;
                    line-height: 1.5;
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
                        <h1 class="page-title">✍️ Viết tin tức mới</h1>
                        <a href="${pageContext.request.contextPath}/reporter/news" class="back-btn">
                            <span>←</span>
                            <span>Quay lại danh sách</span>
                        </a>
                    </div>

                    <!-- Status Info -->
                    <div class="status-info">
                        <h4>📝 Quy trình đăng tin</h4>
                        <p>Tin tức của bạn sẽ được gửi đến quản trị viên để duyệt trước khi xuất bản. Hãy đảm bảo nội
                            dung chính xác và tuân thủ quy định biên tập.</p>
                    </div>

                    <!-- Error Messages -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-error">
                            ${error}
                        </div>
                    </c:if>

                    <!-- Form Container -->
                    <div class="form-container">
                        <form action="${pageContext.request.contextPath}/reporter/news/add" method="post"
                            enctype="multipart/form-data">
                            <div class="form-grid">
                                <!-- Main Form -->
                                <div class="main-form">
                                    <div class="form-group">
                                        <label for="title" class="form-label">Tiêu đề tin tức *</label>
                                        <input type="text" id="title" name="title" class="form-input"
                                            value="${param.title}" required placeholder="Nhập tiêu đề tin tức...">
                                    </div>

                                    <div class="form-group">
                                        <label for="summary" class="form-label">Tóm tắt</label>
                                        <textarea id="summary" name="summary" class="form-textarea"
                                            placeholder="Nhập tóm tắt ngắn gọn về tin tức...">${param.summary}</textarea>
                                    </div>

                                    <div class="form-group">
                                        <label for="content" class="form-label">Nội dung tin tức *</label>
                                        <textarea id="content" name="content" class="form-textarea content" required
                                            placeholder="Nhập nội dung chi tiết của tin tức...">${param.content}</textarea>
                                    </div>

                                    <div class="form-group">
                                        <label for="imageFile" class="form-label">Hình ảnh đại diện</label>
                                        <input type="file" id="imageFile" name="imageFile" class="form-control"
                                            accept="image/*" onchange="previewImage(this)">
                                        <div class="mt-2">
                                            <img id="imagePreview" class="img-thumbnail"
                                                style="max-width: 200px; display: none;" alt="Preview">
                                        </div>
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
                                                <option value="${category.id}" ${param.categoryId==category.id
                                                    ? 'selected' : '' }>
                                                    ${category.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <div class="checkbox-group">
                                            <input type="checkbox" id="requestPublish" name="requestPublish" value="1"
                                                class="checkbox" ${param.requestPublish=='1' ? 'checked' : '' }>
                                            <label for="requestPublish" class="form-label">Yêu cầu duyệt ngay</label>
                                        </div>
                                        <p style="font-size: 12px; color: #666; margin-top: 5px;">
                                            Nếu không chọn, tin sẽ được lưu dưới dạng bản nháp
                                        </p>
                                    </div>

                                    <div class="help-text">
                                        <strong>💡 Hướng dẫn viết tin:</strong>
                                        <ul class="tips-list">
                                            <li>📝 Tiêu đề nên ngắn gọn, hấp dẫn</li>
                                            <li>📄 Tóm tắt không quá 200 từ</li>
                                            <li>🖼️ Hình ảnh nên có kích thước 800x600px</li>
                                            <li>✅ Kiểm tra chính tả và ngữ pháp</li>
                                            <li>🔍 Đảm bảo thông tin chính xác</li>
                                            <li>📚 Tuân thủ quy định biên tập</li>
                                        </ul>
                                    </div>

                                    <div class="help-text">
                                        <strong>⏱️ Thời gian duyệt:</strong><br>
                                        Tin tức thường được duyệt trong vòng 2-4 giờ làm việc. Bạn sẽ nhận được thông
                                        báo qua email khi tin được duyệt hoặc từ chối.
                                    </div>
                                </div>

                                <!-- Form Actions -->
                                <div class="form-actions">
                                    <button type="submit" name="action" value="draft" class="btn btn-secondary">
                                        <span>💾</span>
                                        <span>Lưu bản nháp</span>
                                    </button>
                                    <button type="submit" name="action" value="submit" class="btn btn-primary">
                                        <span>📤</span>
                                        <span>Gửi duyệt</span>
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

                    if (input.files && input.files[0]) {
                        const file = input.files[0];

                        // Validate file type
                        if (!file.type.startsWith('image/')) {
                            alert('Vui lòng chọn file ảnh (JPG, PNG, GIF)!');
                            input.value = '';
                            return;
                        }

                        // Validate file size (5MB)
                        if (file.size > 5 * 1024 * 1024) {
                            alert('File quá lớn! Kích thước tối đa cho phép là 5MB.');
                            input.value = '';
                            return;
                        }

                        const reader = new FileReader();

                        reader.onload = function (e) {
                            preview.src = e.target.result;
                            preview.style.display = 'block';
                        };

                        reader.readAsDataURL(file);
                    } else {
                        preview.style.display = 'none';
                    }
                }

                function formatFileSize(bytes) {
                    if (bytes < 1024) return bytes + ' B';
                    if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + ' KB';
                    return (bytes / (1024 * 1024)).toFixed(1) + ' MB';
                }

                // Initialize form
                document.addEventListener('DOMContentLoaded', function () {
                    loadDraft();
                    startAutoSave();
                });

                // Auto-save draft every 2 minutes
                let autoSaveInterval;

                function startAutoSave() {
                    autoSaveInterval = setInterval(function () {
                        const title = document.getElementById('title').value;
                        const summary = document.getElementById('summary').value;
                        const content = document.getElementById('content').value;

                        if (title || content) {
                            // Save to localStorage as backup
                            localStorage.setItem('reporter_news_draft', JSON.stringify({
                                title: title,
                                summary: summary,
                                content: content,
                                categoryId: document.getElementById('categoryId').value,
                                timestamp: new Date().toISOString()
                            }));
                            console.log('Đã tự động lưu bản nháp');
                        }
                    }, 120000); // 2 minutes
                }

                // Load draft from localStorage
                function loadDraft() {
                    const draft = localStorage.getItem('reporter_news_draft');
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
                                document.getElementById('categoryId').value = data.categoryId || '';
                            }
                        }
                    }
                }

                // Clear draft after successful submission
                function clearDraft() {
                    localStorage.removeItem('reporter_news_draft');
                }

                // Initialize
                document.addEventListener('DOMContentLoaded', function () {
                    loadDraft();
                    startAutoSave();

                    // Clear draft on form submission
                    document.querySelector('form').addEventListener('submit', function () {
                        clearDraft();
                    });
                });

                // Character counter for summary
                document.getElementById('summary').addEventListener('input', function () {
                    const maxLength = 500;
                    const currentLength = this.value.length;

                    if (currentLength > maxLength) {
                        this.style.borderColor = '#dc3545';
                    } else {
                        this.style.borderColor = '#ddd';
                    }
                });

                // Form validation
                document.querySelector('form').addEventListener('submit', function (e) {
                    const title = document.getElementById('title').value.trim();
                    const content = document.getElementById('content').value.trim();
                    const categoryId = document.getElementById('categoryId').value;

                    if (!title || !content || !categoryId) {
                        e.preventDefault();
                        alert('Vui lòng điền đầy đủ thông tin bắt buộc (Tiêu đề, Nội dung, Danh mục)');
                        return false;
                    }

                    if (title.length < 10) {
                        e.preventDefault();
                        alert('Tiêu đề phải có ít nhất 10 ký tự');
                        return false;
                    }

                    if (content.length < 100) {
                        e.preventDefault();
                        alert('Nội dung phải có ít nhất 100 ký tự');
                        return false;
                    }

                    return true;
                });
            </script>
        </body>

        </html>