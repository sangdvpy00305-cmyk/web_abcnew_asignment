<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ cá nhân - ABC News Reporter</title>
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
        
        /* Profile Container */
        .profile-container {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 30px;
        }
        
        /* Profile Card */
        .profile-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
            text-align: center;
            height: fit-content;
        }
        
        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin: 0 auto 20px;
            background: linear-gradient(135deg, #28a745, #20c997);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: white;
            position: relative;
            overflow: hidden;
        }
        
        .profile-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }
        
        .profile-name {
            font-size: 1.5rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }
        
        .profile-role {
            color: #28a745;
            font-weight: 500;
            margin-bottom: 20px;
        }
        
        .profile-stats {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-top: 20px;
        }
        
        .stat-item {
            text-align: center;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .stat-number {
            font-size: 1.5rem;
            font-weight: bold;
            color: #28a745;
        }
        
        .stat-label {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
        
        /* Form Container */
        .form-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }
        
        .form-tabs {
            display: flex;
            border-bottom: 1px solid #f0f0f0;
            margin-bottom: 30px;
        }
        
        .tab-btn {
            padding: 15px 20px;
            border: none;
            background: none;
            color: #666;
            font-weight: 500;
            cursor: pointer;
            border-bottom: 2px solid transparent;
            transition: all 0.3s;
        }
        
        .tab-btn.active {
            color: #28a745;
            border-bottom-color: #28a745;
        }
        
        .tab-content {
            display: none;
        }
        
        .tab-content.active {
            display: block;
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
            min-height: 100px;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
        
        /* File Upload */
        .file-upload {
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
        
        .file-display {
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
        
        .file-display:hover {
            border-color: #28a745;
            background: #f0fff4;
        }
        
        /* Buttons */
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
            background: linear-gradient(135deg, #c41e3a 0%, #a01729 100%);
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
        
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        
        .btn-danger:hover {
            background: #c82333;
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
        
        /* Activity Timeline */
        .activity-timeline {
            margin-top: 20px;
        }
        
        .timeline-item {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .timeline-item:last-child {
            border-bottom: none;
        }
        
        .timeline-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #28a745;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            flex-shrink: 0;
        }
        
        .timeline-content {
            flex: 1;
        }
        
        .timeline-title {
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }
        
        .timeline-desc {
            color: #666;
            font-size: 14px;
            margin-bottom: 5px;
        }
        
        .timeline-time {
            color: #999;
            font-size: 12px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .main-layout {
                grid-template-columns: 1fr;
            }
            
            .sidebar {
                display: none;
            }
            
            .profile-container {
                grid-template-columns: 1fr;
            }
            
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .form-tabs {
                flex-wrap: wrap;
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
                    <a href="${pageContext.request.contextPath}/reporter/news">
                        <span class="icon">📰</span>
                        <span>Quản lý tin tức</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/reporter/profile" class="active">
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
                <h1 class="page-title">👤 Hồ sơ cá nhân</h1>
                <a href="${pageContext.request.contextPath}/reporter/dashboard" class="back-btn">
                    <span>←</span>
                    <span>Quay lại dashboard</span>
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

            <!-- Profile Container -->
            <div class="profile-container">
                <!-- Profile Card -->
                <div class="profile-card">
                    <div class="profile-avatar">
                        <c:choose>
                            <c:when test="${not empty user.avatar}">
                                <img src="${pageContext.request.contextPath}${user.avatar}" alt="Avatar">
                            </c:when>
                            <c:otherwise>
                                👤
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="profile-name">${user.fullName != null ? user.fullName : user.username}</div>
                    <div class="profile-role">📝 Phóng viên</div>
                    
                    <div class="profile-stats">
                        <div class="stat-item">
                            <div class="stat-number">${userStats.totalNews != null ? userStats.totalNews : 0}</div>
                            <div class="stat-label">Tin đã viết</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-number">${userStats.totalViews != null ? userStats.totalViews : 0}</div>
                            <div class="stat-label">Lượt xem</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-number">${userStats.publishedNews != null ? userStats.publishedNews : 0}</div>
                            <div class="stat-label">Đã xuất bản</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-number">${userStats.draftNews != null ? userStats.draftNews : 0}</div>
                            <div class="stat-label">Bản nháp</div>
                        </div>
                    </div>
                </div>

                <!-- Form Container -->
                <div class="form-container">
                    <!-- Tabs -->
                    <div class="form-tabs">
                        <button class="tab-btn active" onclick="switchTab('personal')">
                            👤 Thông tin cá nhân
                        </button>
                        <button class="tab-btn" onclick="switchTab('security')">
                            🔒 Bảo mật
                        </button>
                        <button class="tab-btn" onclick="switchTab('activity')">
                            📊 Hoạt động
                        </button>
                    </div>

                    <!-- Personal Info Tab -->
                    <div id="personal" class="tab-content active">
                        <form action="${pageContext.request.contextPath}/reporter/profile/update" method="post" enctype="multipart/form-data">
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="username" class="form-label">Tên đăng nhập</label>
                                    <input type="text" id="username" name="username" class="form-input" 
                                           value="${user.username}" readonly style="background: #f8f9fa;">
                                </div>
                                <div class="form-group">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" id="email" name="email" class="form-input" 
                                           value="${user.email}" required>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="fullName" class="form-label">Họ và tên</label>
                                    <input type="text" id="fullName" name="fullName" class="form-input" 
                                           value="${user.fullName}" required>
                                </div>
                                <div class="form-group">
                                    <label for="phone" class="form-label">Số điện thoại</label>
                                    <input type="tel" id="phone" name="phone" class="form-input" 
                                           value="${user.phone}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="bio" class="form-label">Giới thiệu bản thân</label>
                                <textarea id="bio" name="bio" class="form-textarea" 
                                          placeholder="Viết vài dòng giới thiệu về bản thân...">${user.bio}</textarea>
                            </div>

                            <div class="form-group">
                                <label for="avatarFile" class="form-label">Ảnh đại diện</label>
                                <div class="file-upload">
                                    <input type="file" id="avatarFile" name="avatarFile" class="file-input" 
                                           accept="image/*" onchange="previewAvatar(this)">
                                    <div class="file-display">
                                        <span>📷</span>
                                        <span>Chọn ảnh đại diện mới</span>
                                    </div>
                                </div>
                            </div>

                            <div style="text-align: right; margin-top: 30px;">
                                <button type="submit" class="btn btn-primary">
                                    <span>💾</span>
                                    <span>Cập nhật thông tin</span>
                                </button>
                            </div>
                        </form>
                    </div>

                    <!-- Security Tab -->
                    <div id="security" class="tab-content">
                        <form action="${pageContext.request.contextPath}/reporter/profile/change-password" method="post">
                            <div class="form-group">
                                <label for="currentPassword" class="form-label">Mật khẩu hiện tại *</label>
                                <input type="password" id="currentPassword" name="currentPassword" class="form-input" 
                                       required placeholder="Nhập mật khẩu hiện tại">
                            </div>

                            <div class="form-group">
                                <label for="newPassword" class="form-label">Mật khẩu mới *</label>
                                <input type="password" id="newPassword" name="newPassword" class="form-input" 
                                       required placeholder="Nhập mật khẩu mới (ít nhất 6 ký tự)">
                            </div>

                            <div class="form-group">
                                <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới *</label>
                                <input type="password" id="confirmPassword" name="confirmPassword" class="form-input" 
                                       required placeholder="Nhập lại mật khẩu mới">
                            </div>

                            <div style="background: #fff3cd; border: 1px solid #ffeaa7; border-radius: 8px; padding: 15px; margin: 20px 0;">
                                <h4 style="color: #856404; margin-bottom: 10px;">🔒 Lưu ý bảo mật:</h4>
                                <ul style="color: #856404; font-size: 14px; margin-left: 20px;">
                                    <li>Mật khẩu nên có ít nhất 8 ký tự</li>
                                    <li>Kết hợp chữ hoa, chữ thường, số và ký tự đặc biệt</li>
                                    <li>Không sử dụng thông tin cá nhân dễ đoán</li>
                                    <li>Thay đổi mật khẩu định kỳ</li>
                                </ul>
                            </div>

                            <div style="text-align: right;">
                                <button type="submit" class="btn btn-primary">
                                    <span>🔒</span>
                                    <span>Đổi mật khẩu</span>
                                </button>
                            </div>
                        </form>
                    </div>

                    <!-- Activity Tab -->
                    <div id="activity" class="tab-content">
                        <h3 style="margin-bottom: 20px; color: #333;">📊 Hoạt động gần đây</h3>
                        
                        <div class="activity-timeline">
                            <c:choose>
                                <c:when test="${not empty recentActivities}">
                                    <c:forEach var="activity" items="${recentActivities}">
                                        <div class="timeline-item">
                                            <div class="timeline-icon">
                                                <c:choose>
                                                    <c:when test="${activity.type == 'news_created'}">📝</c:when>
                                                    <c:when test="${activity.type == 'news_published'}">📰</c:when>
                                                    <c:when test="${activity.type == 'profile_updated'}">👤</c:when>
                                                    <c:otherwise>📋</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="timeline-content">
                                                <div class="timeline-title">${activity.title}</div>
                                                <div class="timeline-desc">${activity.description}</div>
                                                <div class="timeline-time">${activity.timestamp}</div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="timeline-item">
                                        <div class="timeline-icon">📝</div>
                                        <div class="timeline-content">
                                            <div class="timeline-title">Tin tức được tạo</div>
                                            <div class="timeline-desc">Bạn đã tạo tin tức "Công nghệ AI mới nhất"</div>
                                            <div class="timeline-time">2 giờ trước</div>
                                        </div>
                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-icon">📰</div>
                                        <div class="timeline-content">
                                            <div class="timeline-title">Tin tức được duyệt</div>
                                            <div class="timeline-desc">Tin tức "Kinh tế Việt Nam" đã được duyệt và xuất bản</div>
                                            <div class="timeline-time">1 ngày trước</div>
                                        </div>
                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-icon">👤</div>
                                        <div class="timeline-content">
                                            <div class="timeline-title">Cập nhật hồ sơ</div>
                                            <div class="timeline-desc">Bạn đã cập nhật thông tin cá nhân</div>
                                            <div class="timeline-time">3 ngày trước</div>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        function switchTab(tabName) {
            // Hide all tab contents
            const tabContents = document.querySelectorAll('.tab-content');
            tabContents.forEach(content => {
                content.classList.remove('active');
            });
            
            // Remove active class from all tab buttons
            const tabBtns = document.querySelectorAll('.tab-btn');
            tabBtns.forEach(btn => {
                btn.classList.remove('active');
            });
            
            // Show selected tab content
            document.getElementById(tabName).classList.add('active');
            
            // Add active class to clicked tab button
            event.target.classList.add('active');
        }

        function previewAvatar(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    const avatar = document.querySelector('.profile-avatar');
                    avatar.innerHTML = `<img src="${e.target.result}" alt="Avatar">`;
                };
                
                reader.readAsDataURL(input.files[0]);
            }
        }

        // Password validation
        document.querySelector('form[action*="change-password"]').addEventListener('submit', function(e) {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (newPassword !== confirmPassword) {
                e.preventDefault();
                alert('Mật khẩu xác nhận không khớp');
                return false;
            }
            
            if (newPassword.length < 6) {
                e.preventDefault();
                alert('Mật khẩu mới phải có ít nhất 6 ký tự');
                return false;
            }
            
            return true;
        });

        // Form validation for personal info
        document.querySelector('form[action*="profile/update"]').addEventListener('submit', function(e) {
            const email = document.getElementById('email').value;
            const fullName = document.getElementById('fullName').value;
            
            if (!email || !fullName) {
                e.preventDefault();
                alert('Vui lòng điền đầy đủ thông tin bắt buộc');
                return false;
            }
            
            // Email validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('Email không hợp lệ');
                return false;
            }
            
            return true;
        });

        // Auto-save form data
        function autoSaveFormData() {
            const formData = {
                email: document.getElementById('email').value,
                fullName: document.getElementById('fullName').value,
                phone: document.getElementById('phone').value,
                bio: document.getElementById('bio').value
            };
            
            localStorage.setItem('reporter_profile_data', JSON.stringify(formData));
        }

        // Load saved form data
        function loadSavedFormData() {
            const savedData = localStorage.getItem('reporter_profile_data');
            if (savedData) {
                const data = JSON.parse(savedData);
                // Only load if fields are empty
                if (!document.getElementById('email').value) {
                    Object.keys(data).forEach(key => {
                        const element = document.getElementById(key);
                        if (element && !element.value) {
                            element.value = data[key] || '';
                        }
                    });
                }
            }
        }

        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            loadSavedFormData();
            
            // Auto-save on input
            const inputs = document.querySelectorAll('#personal input, #personal textarea');
            inputs.forEach(input => {
                input.addEventListener('input', autoSaveFormData);
            });
            
            // Clear saved data on successful submission
            document.querySelector('form[action*="profile/update"]').addEventListener('submit', function() {
                localStorage.removeItem('reporter_profile_data');
            });
        });
    </script>
</body>
</html>