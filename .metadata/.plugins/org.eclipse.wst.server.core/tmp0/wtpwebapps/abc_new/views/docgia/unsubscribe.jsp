<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'vi'}" scope="request" />
<fmt:setBundle basename="global" scope="request" />
<!DOCTYPE html>
<html lang="${sessionScope.lang != null ? sessionScope.lang : 'vi'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="newsletter.unsubscribe.title" /> - <fmt:message key="app.title" /></title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            color: #333;
        }
        
        .container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            padding: 40px;
            max-width: 500px;
            width: 90%;
            text-align: center;
        }
        
        .logo {
            font-size: 2.5rem;
            font-weight: bold;
            color: #c41e3a;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }
        
        .title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 15px;
        }
        
        .description {
            color: #666;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }
        
        .form-input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
        }
        
        .form-input:focus {
            outline: none;
            border-color: #c41e3a;
            box-shadow: 0 0 0 3px rgba(196, 30, 58, 0.1);
        }
        
        .btn {
            padding: 12px 30px;
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
        
        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }
        
        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(220, 53, 69, 0.3);
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
            color: white;
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
        
        .icon {
            font-size: 4rem;
            margin-bottom: 20px;
        }
        
        .success-icon {
            color: #28a745;
        }
        
        .error-icon {
            color: #dc3545;
        }
        
        .info-icon {
            color: #17a2b8;
        }
        
        .back-link {
            margin-top: 20px;
        }
        
        .back-link a {
            color: #c41e3a;
            text-decoration: none;
            font-weight: 500;
        }
        
        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">ABC NEWS</div>
        
        <c:choose>
            <c:when test="${param.success == 'true'}">
                <!-- Success State -->
                <div class="icon success-icon">✅</div>
                <h2 class="title">Hủy đăng ký thành công!</h2>
                <p class="description">
                    Email <strong>${param.email}</strong> đã được hủy khỏi danh sách nhận tin tức của chúng tôi.
                    <br><br>
                    Chúng tôi rất tiếc khi bạn rời đi. Nếu thay đổi ý định, bạn có thể đăng ký lại bất cứ lúc nào.
                </p>
            </c:when>
            
            <c:when test="${param.error == 'true'}">
                <!-- Error State -->
                <div class="icon error-icon">❌</div>
                <h2 class="title">Có lỗi xảy ra!</h2>
                <p class="description">
                    Không thể hủy đăng ký email. Có thể email này chưa đăng ký hoặc đã được hủy trước đó.
                    <br><br>
                    Vui lòng thử lại hoặc liên hệ với chúng tôi để được hỗ trợ.
                </p>
            </c:when>
            
            <c:otherwise>
                <!-- Unsubscribe Form -->
                <div class="icon info-icon">📧</div>
                <h2 class="title">Hủy đăng ký Newsletter</h2>
                <p class="description">
                    Chúng tôi rất tiếc khi bạn muốn hủy đăng ký nhận tin tức từ ABC News. 
                    Vui lòng nhập email để xác nhận hủy đăng ký.
                </p>
                
                <form action="${pageContext.request.contextPath}/newsletter" method="post" id="unsubscribeForm">
                    <input type="hidden" name="action" value="unsubscribe">
                    
                    <div class="form-group">
                        <label for="email" class="form-label">Email đã đăng ký:</label>
                        <input type="email" id="email" name="email" class="form-input" 
                               value="${param.email}" required 
                               placeholder="Nhập email bạn muốn hủy đăng ký...">
                    </div>
                    
                    <div style="margin-top: 30px;">
                        <button type="submit" class="btn btn-danger">
                            <span>🚫</span>
                            <span>Hủy đăng ký</span>
                        </button>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">
                            <span>←</span>
                            <span>Quay lại trang chủ</span>
                        </a>
                    </div>
                </form>
                
                <div style="margin-top: 30px; padding-top: 20px; border-top: 1px solid #f0f0f0;">
                    <p style="font-size: 14px; color: #666;">
                        <strong>Lưu ý:</strong> Sau khi hủy đăng ký, bạn sẽ không nhận được email tin tức từ chúng tôi nữa. 
                        Bạn có thể đăng ký lại bất cứ lúc nào tại trang chủ.
                    </p>
                </div>
            </c:otherwise>
        </c:choose>
        
        <div class="back-link">
            <a href="${pageContext.request.contextPath}/home">← Quay lại trang chủ ABC News</a>
        </div>
    </div>
    
    <script>
        document.getElementById('unsubscribeForm')?.addEventListener('submit', function(e) {
            const email = document.getElementById('email').value;
            
            if (!email) {
                e.preventDefault();
                alert('Vui lòng nhập email!');
                return;
            }
            
            if (!confirm('Bạn có chắc chắn muốn hủy đăng ký nhận tin tức từ email: ' + email + '?')) {
                e.preventDefault();
                return;
            }
            
            // Show loading state
            const button = this.querySelector('button[type="submit"]');
            button.disabled = true;
            button.innerHTML = '<span>⏳</span><span>Đang xử lý...</span>';
        });
    </script>
</body>
</html>