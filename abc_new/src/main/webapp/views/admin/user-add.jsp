<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm người dùng - ABC News Admin</title>
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
            max-width: 800px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        
        .page-header {
            margin-bottom: 30px;
        }
        
        .page-title {
            font-size: 2rem;
            color: #333;
            margin-bottom: 10px;
        }
        
        .page-subtitle {
            color: #666;
            font-size: 1.1rem;
        }
        
        .back-btn {
            background: #6c757d;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 20px;
            display: inline-block;
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
        
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .form-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 30px;
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
        }
        
        .required {
            color: #dc3545;
        }
        
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #c41e3a;
            box-shadow: 0 0 0 3px rgba(196, 30, 58, 0.1);
        }
        
        .form-actions {
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
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            transition: all 0.3s;
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
        
        .form-help {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
        
        @media (max-width: 768px) {
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

    <div class="container">
        <a href="${pageContext.request.contextPath}/admin/users" class="back-btn">
            ← Quay lại danh sách
        </a>
        
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">➕ Thêm người dùng mới</h1>
            <p class="page-subtitle">Điền thông tin để tạo tài khoản người dùng mới</p>
        </div>

        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                ❌ ${error}
            </div>
        </c:if>

        <!-- Add User Form -->
        <div class="form-container">
            <form method="post" action="${pageContext.request.contextPath}/admin/users/add">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="id">ID người dùng <span class="required">*</span></label>
                        <input type="text" id="id" name="id" required 
                               value="${param.id}" placeholder="Nhập ID (vd: admin, pv001)">
                        <div class="form-help">ID duy nhất, không thể thay đổi sau khi tạo</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Mật khẩu <span class="required">*</span></label>
                        <input type="password" id="password" name="password" required 
                               placeholder="Nhập mật khẩu">
                        <div class="form-help">Tối thiểu 6 ký tự</div>
                    </div>
                    
                    <div class="form-group full-width">
                        <label for="fullname">Họ và tên <span class="required">*</span></label>
                        <input type="text" id="fullname" name="fullname" required 
                               value="${param.fullname}" placeholder="Nhập họ và tên đầy đủ">
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" 
                               value="${param.email}" placeholder="Nhập địa chỉ email">
                    </div>
                    
                    <div class="form-group">
                        <label for="mobile">Số điện thoại</label>
                        <input type="tel" id="mobile" name="mobile" 
                               value="${param.mobile}" placeholder="Nhập số điện thoại">
                    </div>
                    
                    <div class="form-group">
                        <label for="birthday">Ngày sinh</label>
                        <input type="date" id="birthday" name="birthday" value="${param.birthday}">
                    </div>
                    
                    <div class="form-group">
                        <label for="gender">Giới tính</label>
                        <select id="gender" name="gender">
                            <option value="">-- Chọn giới tính --</option>
                            <option value="1" ${param.gender == '1' ? 'selected' : ''}>Nam</option>
                            <option value="0" ${param.gender == '0' ? 'selected' : ''}>Nữ</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="role">Vai trò <span class="required">*</span></label>
                        <select id="role" name="role" required>
                            <option value="">-- Chọn vai trò --</option>
                            <option value="1" ${param.role == '1' ? 'selected' : ''}>🛡️ Quản trị viên</option>
                            <option value="0" ${param.role == '0' ? 'selected' : ''}>✍️ Phóng viên</option>
                        </select>
                        <div class="form-help">Quản trị viên có quyền quản lý toàn bộ hệ thống</div>
                    </div>
                </div>
                
                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">
                        ❌ Hủy bỏ
                    </a>
                    <button type="submit" class="btn btn-primary">
                        ✅ Thêm người dùng
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Auto generate ID from fullname
        document.getElementById('fullname').addEventListener('input', function() {
            const fullname = this.value;
            const idField = document.getElementById('id');
            
            if (fullname && !idField.value) {
                // Simple ID generation (you can improve this)
                const words = fullname.toLowerCase().split(' ');
                let suggestedId = '';
                
                if (words.length >= 2) {
                    suggestedId = words[words.length - 1] + words[0].charAt(0);
                } else {
                    suggestedId = words[0];
                }
                
                // Remove Vietnamese accents and special characters
                suggestedId = suggestedId.normalize('NFD').replace(/[\u0300-\u036f]/g, '');
                suggestedId = suggestedId.replace(/[^a-z0-9]/g, '');
                
                idField.placeholder = 'Gợi ý: ' + suggestedId;
            }
        });

        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const id = document.getElementById('id').value.trim();
            const password = document.getElementById('password').value;
            const fullname = document.getElementById('fullname').value.trim();
            const role = document.getElementById('role').value;
            
            if (!id || !password || !fullname || !role) {
                e.preventDefault();
                alert('Vui lòng điền đầy đủ các trường bắt buộc!');
                return;
            }
            
            if (password.length < 6) {
                e.preventDefault();
                alert('Mật khẩu phải có ít nhất 6 ký tự!');
                return;
            }
            
            if (!/^[a-zA-Z0-9_]+$/.test(id)) {
                e.preventDefault();
                alert('ID chỉ được chứa chữ cái, số và dấu gạch dưới!');
                return;
            }
        });
    </script>
</body>
</html>