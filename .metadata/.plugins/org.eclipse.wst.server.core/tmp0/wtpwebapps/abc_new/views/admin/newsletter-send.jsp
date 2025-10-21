<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gửi Newsletter - ABC News Admin</title>
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
        
        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
        }
        
        .checkbox {
            width: 18px;
            height: 18px;
            accent-color: #c41e3a;
        }
        
        /* Recipients Section */
        .recipients-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        
        .recipients-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 15px;
            margin-bottom: 15px;
        }
        
        .stat-item {
            text-align: center;
            padding: 10px;
            background: white;
            border-radius: 6px;
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
        
        /* Preview Section */
        .preview-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        
        .preview-content {
            background: white;
            padding: 20px;
            border-radius: 6px;
            border: 1px solid #ddd;
            min-height: 200px;
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
        
        .alert-warning {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
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
        
        /* Progress Bar */
        .progress-container {
            background: #f0f0f0;
            border-radius: 10px;
            padding: 3px;
            margin: 20px 0;
            display: none;
        }
        
        .progress-bar {
            background: linear-gradient(135deg, #c41e3a, #a01729);
            height: 20px;
            border-radius: 8px;
            width: 0%;
            transition: width 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 12px;
            font-weight: bold;
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
            
            .recipients-stats {
                grid-template-columns: repeat(2, 1fr);
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
                <h1 class="page-title">📤 Gửi Newsletter</h1>
                <a href="${pageContext.request.contextPath}/admin/newsletters" class="back-btn">
                    <span>←</span>
                    <span>Quay lại danh sách</span>
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

            <!-- Form Container -->
            <div class="form-container">
                <form action="${pageContext.request.contextPath}/admin/newsletters/send" method="post" id="newsletterForm">
                    <div class="form-grid">
                        <!-- Main Form -->
                        <div class="main-form">
                            <div class="form-group">
                                <label for="subject" class="form-label">Tiêu đề email *</label>
                                <input type="text" id="subject" name="subject" class="form-input" 
                                       value="${param.subject}" required 
                                       placeholder="Nhập tiêu đề email newsletter...">
                            </div>

                            <!-- Recipients Section -->
                            <div class="recipients-section">
                                <h4 style="margin-bottom: 15px; color: #333;">👥 Người nhận</h4>
                                <div class="recipients-stats">
                                    <div class="stat-item">
                                        <div class="stat-number">${totalSubscribers != null ? totalSubscribers : 0}</div>
                                        <div class="stat-label">Tổng đăng ký</div>
                                    </div>
                                    <div class="stat-item">
                                        <div class="stat-number">${activeSubscribers != null ? activeSubscribers : 0}</div>
                                        <div class="stat-label">Đang hoạt động</div>
                                    </div>
                                    <div class="stat-item">
                                        <div class="stat-number" id="selectedCount">0</div>
                                        <div class="stat-label">Được chọn</div>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <div class="checkbox-group">
                                        <input type="checkbox" id="sendToAll" name="sendToAll" 
                                               value="1" class="checkbox" checked onchange="toggleRecipients()">
                                        <label for="sendToAll" class="form-label">Gửi đến tất cả người đăng ký hoạt động</label>
                                    </div>
                                    <div class="checkbox-group">
                                        <input type="checkbox" id="sendToCustom" name="sendToCustom" 
                                               value="1" class="checkbox" onchange="toggleRecipients()">
                                        <label for="sendToCustom" class="form-label">Chọn người nhận cụ thể</label>
                                    </div>
                                </div>
                                
                                <div id="customRecipients" style="display: none;">
                                    <label class="form-label">Danh sách email (mỗi email một dòng):</label>
                                    <textarea name="customEmails" class="form-textarea" 
                                              placeholder="email1@example.com&#10;email2@example.com&#10;..."></textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="content" class="form-label">Nội dung email *</label>
                                <textarea id="content" name="content" class="form-textarea content" 
                                          required placeholder="Nhập nội dung email newsletter...">${param.content}</textarea>
                            </div>

                            <!-- Preview Section -->
                            <div class="preview-section">
                                <h4 style="margin-bottom: 15px; color: #333;">👁️ Xem trước</h4>
                                <div class="preview-content" id="previewContent">
                                    <p style="color: #999; text-align: center;">Nhập nội dung để xem trước...</p>
                                </div>
                            </div>

                            <!-- Progress Bar -->
                            <div class="progress-container" id="progressContainer">
                                <div class="progress-bar" id="progressBar">0%</div>
                            </div>
                        </div>

                        <!-- Side Panel -->
                        <div class="side-panel">
                            <h3>📋 Tùy chọn gửi</h3>
                            
                            <div class="form-group">
                                <div class="checkbox-group">
                                    <input type="checkbox" id="sendTest" name="sendTest" 
                                           value="1" class="checkbox">
                                    <label for="sendTest" class="form-label">Gửi email thử nghiệm</label>
                                </div>
                            </div>

                            <div class="form-group" id="testEmailGroup" style="display: none;">
                                <label for="testEmail" class="form-label">Email thử nghiệm</label>
                                <input type="email" id="testEmail" name="testEmail" class="form-input" 
                                       placeholder="test@example.com">
                            </div>

                            <div class="form-group">
                                <div class="checkbox-group">
                                    <input type="checkbox" id="scheduleEmail" name="scheduleEmail" 
                                           value="1" class="checkbox">
                                    <label for="scheduleEmail" class="form-label">Lên lịch gửi</label>
                                </div>
                            </div>

                            <div class="form-group" id="scheduleGroup" style="display: none;">
                                <label for="scheduleTime" class="form-label">Thời gian gửi</label>
                                <input type="datetime-local" id="scheduleTime" name="scheduleTime" class="form-input">
                            </div>

                            <div class="help-text">
                                <strong>💡 Lưu ý:</strong>
                                <ul class="tips-list">
                                    <li>📧 Kiểm tra kỹ nội dung trước khi gửi</li>
                                    <li>🧪 Nên gửi email thử nghiệm trước</li>
                                    <li>⏰ Thời gian tốt nhất: 9-11h hoặc 14-16h</li>
                                    <li>📱 Nội dung nên tương thích mobile</li>
                                    <li>🔗 Kiểm tra các liên kết hoạt động</li>
                                </ul>
                            </div>
                        </div>

                        <!-- Form Actions -->
                        <div class="form-actions">
                            <button type="button" class="btn btn-secondary" onclick="saveDraft()">
                                <span>💾</span>
                                <span>Lưu bản nháp</span>
                            </button>
                            <button type="button" class="btn btn-success" onclick="sendTest()">
                                <span>🧪</span>
                                <span>Gửi thử nghiệm</span>
                            </button>
                            <button type="submit" class="btn btn-primary" onclick="return confirmSend()">
                                <span>📤</span>
                                <span>Gửi Newsletter</span>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </main>
    </div>

    <script>
        function toggleRecipients() {
            const sendToAll = document.getElementById('sendToAll');
            const sendToCustom = document.getElementById('sendToCustom');
            const customRecipients = document.getElementById('customRecipients');
            const selectedCount = document.getElementById('selectedCount');
            
            if (sendToAll.checked) {
                sendToCustom.checked = false;
                customRecipients.style.display = 'none';
                selectedCount.textContent = '${activeSubscribers != null ? activeSubscribers : 0}';
            } else if (sendToCustom.checked) {
                sendToAll.checked = false;
                customRecipients.style.display = 'block';
                updateCustomCount();
            } else {
                sendToAll.checked = true;
                selectedCount.textContent = '${activeSubscribers != null ? activeSubscribers : 0}';
            }
        }

        function updateCustomCount() {
            const customEmails = document.querySelector('textarea[name="customEmails"]').value;
            const emails = customEmails.split('\n').filter(email => email.trim() && email.includes('@'));
            document.getElementById('selectedCount').textContent = emails.length;
        }

        // Preview functionality
        function updatePreview() {
            const subject = document.getElementById('subject').value;
            const content = document.getElementById('content').value;
            const previewContent = document.getElementById('previewContent');
            
            if (subject || content) {
                previewContent.innerHTML = `
                    <div style="border-bottom: 1px solid #ddd; padding-bottom: 10px; margin-bottom: 15px;">
                        <strong>Tiêu đề:</strong> ${subject || 'Chưa có tiêu đề'}
                    </div>
                    <div style="line-height: 1.6;">
                        ${content.replace(/\n/g, '<br>') || 'Chưa có nội dung'}
                    </div>
                `;
            } else {
                previewContent.innerHTML = '<p style="color: #999; text-align: center;">Nhập nội dung để xem trước...</p>';
            }
        }

        // Test email functionality
        document.getElementById('sendTest').addEventListener('change', function() {
            const testEmailGroup = document.getElementById('testEmailGroup');
            testEmailGroup.style.display = this.checked ? 'block' : 'none';
        });

        // Schedule email functionality
        document.getElementById('scheduleEmail').addEventListener('change', function() {
            const scheduleGroup = document.getElementById('scheduleGroup');
            scheduleGroup.style.display = this.checked ? 'block' : 'none';
            
            if (this.checked) {
                // Set minimum time to current time + 1 hour
                const now = new Date();
                now.setHours(now.getHours() + 1);
                document.getElementById('scheduleTime').min = now.toISOString().slice(0, 16);
            }
        });

        // Auto-update preview
        document.getElementById('subject').addEventListener('input', updatePreview);
        document.getElementById('content').addEventListener('input', updatePreview);
        document.querySelector('textarea[name="customEmails"]').addEventListener('input', updateCustomCount);

        function confirmSend() {
            const selectedCount = document.getElementById('selectedCount').textContent;
            const subject = document.getElementById('subject').value;
            
            if (!subject.trim()) {
                alert('Vui lòng nhập tiêu đề email');
                return false;
            }
            
            if (selectedCount == 0) {
                alert('Vui lòng chọn người nhận');
                return false;
            }
            
            return confirm(`Bạn có chắc chắn muốn gửi newsletter "${subject}" đến ${selectedCount} người nhận?\n\nHành động này không thể hoàn tác.`);
        }

        function sendTest() {
            const testEmail = document.getElementById('testEmail').value;
            const subject = document.getElementById('subject').value;
            const content = document.getElementById('content').value;
            
            if (!testEmail) {
                alert('Vui lòng nhập email thử nghiệm');
                return;
            }
            
            if (!subject || !content) {
                alert('Vui lòng nhập đầy đủ tiêu đề và nội dung');
                return;
            }
            
            // Send test email via AJAX
            fetch('${pageContext.request.contextPath}/admin/newsletters/send-test', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `testEmail=${encodeURIComponent(testEmail)}&subject=${encodeURIComponent(subject)}&content=${encodeURIComponent(content)}`
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Email thử nghiệm đã được gửi thành công!');
                } else {
                    alert('Lỗi: ' + data.message);
                }
            })
            .catch(error => {
                alert('Có lỗi xảy ra khi gửi email thử nghiệm');
                console.error('Error:', error);
            });
        }

        function saveDraft() {
            const formData = new FormData(document.getElementById('newsletterForm'));
            formData.append('action', 'save_draft');
            
            fetch('${pageContext.request.contextPath}/admin/newsletters/draft', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Bản nháp đã được lưu thành công!');
                } else {
                    alert('Lỗi: ' + data.message);
                }
            })
            .catch(error => {
                alert('Có lỗi xảy ra khi lưu bản nháp');
                console.error('Error:', error);
            });
        }

        // Progress bar simulation
        function showProgress() {
            const progressContainer = document.getElementById('progressContainer');
            const progressBar = document.getElementById('progressBar');
            
            progressContainer.style.display = 'block';
            let progress = 0;
            
            const interval = setInterval(() => {
                progress += Math.random() * 10;
                if (progress >= 100) {
                    progress = 100;
                    clearInterval(interval);
                }
                
                progressBar.style.width = progress + '%';
                progressBar.textContent = Math.round(progress) + '%';
            }, 200);
        }

        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            updatePreview();
            
            // Form submission with progress
            document.getElementById('newsletterForm').addEventListener('submit', function(e) {
                if (confirmSend()) {
                    showProgress();
                }
            });
        });
    </script>
</body>
</html>div>