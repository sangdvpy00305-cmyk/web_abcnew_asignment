<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Danh mục - ABC News Admin</title>
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
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
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
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .subtitle {
            font-size: 1.2rem;
            opacity: 0.9;
        }
        
        .content {
            padding: 40px;
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 40px;
        }
        
        .form-section {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 30px;
        }
        
        .list-section {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 30px;
        }
        
        .section-title {
            font-size: 1.3rem;
            color: #333;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
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
        .form-textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
        }
        
        .form-input:focus,
        .form-textarea:focus {
            outline: none;
            border-color: #c41e3a;
            box-shadow: 0 0 0 3px rgba(196, 30, 58, 0.1);
        }
        
        .form-textarea {
            resize: vertical;
            min-height: 100px;
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
            margin: 5px;
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
        }
        
        .btn-warning {
            background: #ffc107;
            color: #212529;
        }
        
        .btn-warning:hover {
            background: #e0a800;
        }
        
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        
        .btn-danger:hover {
            background: #c82333;
        }
        
        .btn-sm {
            padding: 6px 12px;
            font-size: 12px;
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
        
        .table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .table th,
        .table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .table th {
            background: #f8f9fa;
            font-weight: 600;
            color: #333;
        }
        
        .table tr:hover {
            background: #f8f9fa;
        }
        
        .actions {
            display: flex;
            gap: 5px;
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
        
        .form-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .content {
                grid-template-columns: 1fr;
                gap: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="logo">📂 QUẢN LÝ DANH MỤC</div>
            <div class="subtitle">Thêm, sửa, xóa danh mục tin tức ABC News</div>
        </div>
        
        <div class="content">
            <!-- Form Section -->
            <div class="form-section">
                <h3 class="section-title">
                    <span>${empty item.id ? '➕' : '✏️'}</span>
                    <span>${empty item.id ? 'Thêm danh mục mới' : 'Chỉnh sửa danh mục'}</span>
                </h3>
                
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
                
                <!-- Form -->
                <form action="${pageContext.request.contextPath}/admin/categories/${empty item.id ? 'create' : 'update'}" method="post">
                    <c:if test="${not empty item.id}">
                        <input type="hidden" name="id" value="${item.id}">
                    </c:if>
                    
                    <div class="form-group">
                        <label for="name" class="form-label">Tên danh mục *</label>
                        <input type="text" id="name" name="name" class="form-input" 
                               value="${item.name}" required 
                               placeholder="Ví dụ: Thể thao, Kinh tế, Chính trị...">
                    </div>
                    
                    <c:if test="${not empty item.id}">
                        <div class="form-group">
                            <label for="id" class="form-label">ID danh mục</label>
                            <input type="text" id="id" name="id" class="form-input" 
                                   value="${item.id}" readonly 
                                   style="background-color: #f8f9fa; cursor: not-allowed;">
                        </div>
                    </c:if>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">
                            <span>${empty item.id ? '➕' : '💾'}</span>
                            <span>${empty item.id ? 'Thêm danh mục' : 'Cập nhật'}</span>
                        </button>
                        
                        <a href="${pageContext.request.contextPath}/admin/categories/reset" class="btn btn-secondary">
                            <span>🔄</span>
                            <span>Làm mới</span>
                        </a>
                    </div>
                </form>
            </div>
            
            <!-- List Section -->
            <div class="list-section">
                <h3 class="section-title">
                    <span>📋</span>
                    <span>Danh sách danh mục (${not empty list ? list.size() : 0})</span>
                </h3>
                
                <c:choose>
                    <c:when test="${not empty list}">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tên danh mục</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="category" items="${list}">
                                    <tr>
                                        <td><code>${category.id}</code></td>
                                        <td><strong>${category.name}</strong></td>
                                        <td>
                                            <div class="actions">
                                                <a href="${pageContext.request.contextPath}/admin/categories/edit/${category.id}" 
                                                   class="btn btn-warning btn-sm">
                                                    <span>✏️</span>
                                                    <span>Sửa</span>
                                                </a>
                                                
                                                <form action="${pageContext.request.contextPath}/admin/categories/delete" 
                                                      method="post" style="display: inline;"
                                                      onsubmit="return confirm('Bạn có chắc chắn muốn xóa danh mục \\\"${category.name}\\\"?\\n\\nHành động này không thể hoàn tác!')">
                                                    <input type="hidden" name="id" value="${category.id}">
                                                    <button type="submit" class="btn btn-danger btn-sm">
                                                        <span>🗑️</span>
                                                        <span>Xóa</span>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 40px; color: #999;">
                            <div style="font-size: 3rem; margin-bottom: 15px;">📂</div>
                            <div style="font-size: 1.2rem; margin-bottom: 10px;">Chưa có danh mục nào</div>
                            <div>Hãy thêm danh mục đầu tiên để bắt đầu!</div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="back-link">
            <a href="${pageContext.request.contextPath}/admin/dashboard">← Quay lại Dashboard Admin</a>
        </div>
    </div>
</body>
</html>