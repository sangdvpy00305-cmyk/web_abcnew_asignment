<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa danh mục - ABC News Admin</title>
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
            max-width: 600px;
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
        
        .category-id-display {
            background: #f8f9fa;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .category-id-display .label {
            font-size: 14px;
            color: #666;
            margin-bottom: 5px;
        }
        
        .category-id-display .value {
            font-size: 1.5rem;
            font-weight: bold;
            color: #c41e3a;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
        }
        
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus {
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
        <a href="${pageContext.request.contextPath}/admin/categories" class="back-btn">
            ← Quay lại danh sách
        </a>
        
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">✏️ Sửa danh mục</h1>
            <p class="page-subtitle">Cập nhật thông tin danh mục đã chọn</p>
        </div>

        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                ❌ ${error}
            </div>
        </c:if>

        <!-- Edit Category Form -->
        <div class="form-container">
            <c:if test="${not empty category}">
                <!-- Display Category ID (non-editable) -->
                <div class="category-id-display">
                    <div class="label">ID danh mục (không thể thay đổi)</div>
                    <div class="value">${category.id}</div>
                </div>
                
                <form method="post" action="${pageContext.request.contextPath}/admin/categories/edit/${category.id}">
                    <div class="form-group">
                        <label for="name">Tên danh mục</label>
                        <input type="text" id="name" name="name" required
                               value="${category.name}" placeholder="Nhập tên danh mục">
                    </div>
                    
                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary">
                            ❌ Hủy bỏ
                        </a>
                        <button type="submit" class="btn btn-primary">
                            ✅ Cập nhật
                        </button>
                    </div>
                </form>
            </c:if>
            
            <c:if test="${empty category}">
                <div style="text-align: center; padding: 40px; color: #666;">
                    <h3>❌ Không tìm thấy danh mục</h3>
                    <p>Danh mục bạn muốn sửa không tồn tại hoặc đã bị xóa.</p>
                    <br>
                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary">
                        ← Quay lại danh sách
                    </a>
                </div>
            </c:if>
        </div>
    </div>

    <script>
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const name = document.getElementById('name').value.trim();
            
            if (!name) {
                e.preventDefault();
                alert('Vui lòng nhập tên danh mục!');
                return;
            }
        });
    </script>
</body>
</html>