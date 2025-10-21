<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý người dùng - ABC News Admin</title>
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
        
        .table-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .table th,
        .table td {
            padding: 15px;
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
        
        .role-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .role-badge.admin {
            background: #f8d7da;
            color: #721c24;
        }
        
        .role-badge.reporter {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .gender-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .gender-badge.male {
            background: #cce5ff;
            color: #004085;
        }
        
        .gender-badge.female {
            background: #f8d7da;
            color: #721c24;
        }
        
        .action-links {
            display: flex;
            gap: 10px;
        }
        
        .action-links a {
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .edit-link {
            background: #fff3cd;
            color: #856404;
        }
        
        .edit-link:hover {
            background: #ffeaa7;
            color: #856404;
        }
        
        .delete-link {
            background: #f8d7da;
            color: #721c24;
        }
        
        .delete-link:hover {
            background: #f5c6cb;
            color: #721c24;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        
        .empty-state .icon {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.5;
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
                <h1 class="page-title">👥 Quản lý người dùng</h1>
            </div>
            <a href="${pageContext.request.contextPath}/admin/users/add" class="add-btn">
                ➕ Thêm người dùng mới
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

        <!-- Users Table -->
        <div class="table-container">
            <c:choose>
                <c:when test="${not empty users}">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Điện thoại</th>
                                <th>Giới tính</th>
                                <th>Ngày sinh</th>
                                <th>Vai trò</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td><strong>${user.id}</strong></td>
                                    <td>${user.fullname}</td>
                                    <td>${user.email != null ? user.email : 'Chưa có'}</td>
                                    <td>${user.mobile != null ? user.mobile : 'Chưa có'}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.gender == 1}">
                                                <span class="gender-badge male">Nam</span>
                                            </c:when>
                                            <c:when test="${user.gender == 0}">
                                                <span class="gender-badge female">Nữ</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span>Chưa xác định</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${user.birthday != null ? user.birthday : 'Chưa có'}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.role == 1}">
                                                <span class="role-badge admin">🛡️ Quản trị</span>
                                            </c:when>
                                            <c:when test="${user.role == 0}">
                                                <span class="role-badge reporter">✍️ Phóng viên</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span>Chưa xác định</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="action-links">
                                            <a href="${pageContext.request.contextPath}/admin/users/edit/${user.id}" class="edit-link">
                                                ✏️ Sửa
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/users/delete/${user.id}" 
                                               class="delete-link" 
                                               onclick="return confirm('Bạn có chắc muốn xóa người dùng ${user.fullname}?')">
                                                🗑️ Xóa
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="icon">👥</div>
                        <h3>Chưa có người dùng nào</h3>
                        <p>Hệ thống chưa có người dùng nào. Hãy thêm người dùng đầu tiên!</p>
                        <br>
                        <a href="${pageContext.request.contextPath}/admin/users/add" class="add-btn">
                            ➕ Thêm người dùng đầu tiên
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        // Confirm delete
        function confirmDelete(userId, fullname) {
            if (confirm('Bạn có chắc muốn xóa người dùng "' + fullname + '"?')) {
                window.location.href = '${pageContext.request.contextPath}/admin/users/delete/' + userId;
            }
        }
    </script>
</body>
</html>