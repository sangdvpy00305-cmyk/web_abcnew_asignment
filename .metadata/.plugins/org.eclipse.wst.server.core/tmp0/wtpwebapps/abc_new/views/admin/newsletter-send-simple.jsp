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
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            min-height: 100vh;
            padding: 20px;
            color: #333;
        }
        
        .container {
            max-width: 900px;
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
        }
        
        .stats-section {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 30px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
        }
        
        .stat-item {
            text-align: center;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #c41e3a;
            margin-bottom: 5px;
        }
        
        .stat-label {
            font-size: 14px;
            color: #666;
        }
        
        .form-section {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 30px;
            margin-bottom: 20px;
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
            min-height: 150px;
        }
        
        .radio-group {
            display: flex;
            gap: 20px;
            margin-bottom: 15px;
        }
        
        .radio-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .radio {
            width: 18px;
            height: 18px;
            accent-color: #c41e3a;
        }
        
        .custom-emails {
            display: none;
            margin-top: 15px;
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
        
        .btn-success {
            background: #28a745;
            color: white;
        }
        
        .btn-success:hover {
            background: #218838;
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
        
        .form-actions {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #f0f0f0;
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
        
        .preview-section {
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin-top: 15px;
        }
        
        .preview-content {
            min-height: 100px;
            color: #666;
            font-style: italic;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .stats-section {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .radio-group {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="logo">📧 GỬI NEWSLETTER</div>
            <div class="subtitle">Gửi tin tức đến tất cả độc giả ABC News</div>
        </div>
        
        <div class="content">
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
            
            <!-- Statistics -->
            <div class="stats-section">
                <div class="stat-item">
                    <div class="stat-number">${totalSubscribers != null ? totalSubscribers : 0}</div>
                    <div class="stat-label">Tổng đăng ký</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">${activeSubscribers != null ? activeSubscribers : 0}</div>
                    <div class="stat-label">Đang hoạt động</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number" id="selectedCount">${activeSubscribers != null ? activeSubscribers : 0}</div>
                    <div class="stat-label">Sẽ nhận email</div>
                </div>
            </div>
            
            <!-- Newsletter Form -->
            <form action="${pageContext.request.contextPath}/admin/newsletters/send" method="post" id="newsletterForm">
                <div class="form-section">
                    <h3 class="section-title">
                        <span>📝</span>
                        <span>Thông tin Newsletter</span>
                    </h3>
                    
                    <div class="form-group">
                        <label for="subject" class="form-label">Tiêu đề email *</label>
                        <input type="text" id="subject" name="subject" class="form-input" 
                               value="${param.subject}" required 
                               placeholder="Ví dụ: ABC News - Tin tức nổi bật tuần này">
                    </div>
                    
                    <div class="form-group">
                        <label for="content" class="form-label">Nội dung email *</label>
                        <textarea id="content" name="content" class="form-textarea" 
                                  required placeholder="Nhập nội dung newsletter của bạn...&#10;&#10;Ví dụ:&#10;Xin chào các bạn độc giả ABC News!&#10;&#10;Dưới đây là những tin tức nổi bật trong tuần:&#10;&#10;1. Tin tức chính trị...&#10;2. Tin tức kinh tế...&#10;3. Tin tức xã hội...&#10;&#10;Cảm ơn các bạn đã theo dõi ABC News!">${param.content}</textarea>
                    </div>
                    
                    <!-- Preview -->
                    <div class="form-group">
                        <label class="form-label">Xem trước nội dung:</label>
                        <div class="preview-section">
                            <div class="preview-content" id="previewContent">
                                Nhập nội dung để xem trước...
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="form-section">
                    <h3 class="section-title">
                        <span>👥</span>
                        <span>Chọn người nhận</span>
                    </h3>
                    
                    <div class="radio-group">
                        <div class="radio-item">
                            <input type="radio" id="sendToAll" name="recipientType" 
                                   value="all" class="radio" checked onchange="toggleRecipients()">
                            <label for="sendToAll" class="form-label">Gửi đến tất cả độc giả đã đăng ký (${activeSubscribers != null ? activeSubscribers : 0} người)</label>
                        </div>
                        <div class="radio-item">
                            <input type="radio" id="sendToCustom" name="recipientType" 
                                   value="custom" class="radio" onchange="toggleRecipients()">
                            <label for="sendToCustom" class="form-label">Gửi đến danh sách email cụ thể</label>
                        </div>
                    </div>
                    
                    <div class="custom-emails" id="customEmailsDiv">
                        <label for="customEmails" class="form-label">Danh sách email (mỗi email một dòng):</label>
                        <textarea id="customEmails" name="customEmails" class="form-textarea" 
                                  placeholder="email1@example.com&#10;email2@example.com&#10;email3@example.com"></textarea>
                    </div>
                    
                    <!-- Hidden inputs for form processing -->
                    <input type="hidden" name="sendToAll" value="" id="sendToAllHidden">
                </div>
                
                <div class="form-actions">
                    <button type="button" class="btn btn-success" onclick="sendTestEmail()">
                        <span>🧪</span>
                        <span>Gửi email thử nghiệm</span>
                    </button>
                    <button type="submit" class="btn btn-primary" onclick="return confirmSend()">
                        <span>📤</span>
                        <span>Gửi Newsletter</span>
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="clearForm()">
                        <span>🔄</span>
                        <span>Xóa form</span>
                    </button>
                </div>
            </form>
            
            <div class="back-link">
                <a href="${pageContext.request.contextPath}/admin/newsletters">← Quay lại quản lý Newsletter</a> |
                <a href="${pageContext.request.contextPath}/admin/dashboard">← Quay lại Dashboard</a> |
                <a href="${pageContext.request.contextPath}/test-email">🧪 Trang test email</a>
            </div>
        </div>
    </div>
    
    <script>
        function toggleRecipients() {
            const sendToAll = document.getElementById('sendToAll');
            const customEmailsDiv = document.getElementById('customEmailsDiv');
            const selectedCount = document.getElementById('selectedCount');
            const sendToAllHidden = document.getElementById('sendToAllHidden');
            
            if (sendToAll.checked) {
                customEmailsDiv.style.display = 'none';
                selectedCount.textContent = '${activeSubscribers != null ? activeSubscribers : 0}';
                sendToAllHidden.value = '1';
            } else {
                customEmailsDiv.style.display = 'block';
                sendToAllHidden.value = '';
                updateCustomCount();
            }
        }
        
        function updateCustomCount() {
            const customEmails = document.getElementById('customEmails').value;
            const emails = customEmails.split('\\n').filter(email => email.trim() && email.includes('@'));
            document.getElementById('selectedCount').textContent = emails.length;
        }
        
        function updatePreview() {
            const subject = document.getElementById('subject').value;
            const content = document.getElementById('content').value;
            const previewContent = document.getElementById('previewContent');
            
            if (subject || content) {
                previewContent.innerHTML = `
                    <div style="border-bottom: 1px solid #ddd; padding-bottom: 10px; margin-bottom: 15px;">
                        <strong>Tiêu đề:</strong> ${subject || 'Chưa có tiêu đề'}
                    </div>
                    <div style="line-height: 1.6; white-space: pre-wrap;">
                        ${content || 'Chưa có nội dung'}
                    </div>
                `;
            } else {
                previewContent.innerHTML = 'Nhập nội dung để xem trước...';
            }
        }
        
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
            
            const confirmMessage = `Bạn có chắc chắn muốn gửi newsletter "${subject}" đến ${selectedCount} người nhận?\\n\\nHành động này không thể hoàn tác.`;
            
            if (confirm(confirmMessage)) {
                // Show loading
                const submitBtn = document.querySelector('button[type="submit"]');
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<span>⏳</span><span>Đang gửi...</span>';
                return true;
            }
            
            return false;
        }
        
        function sendTestEmail() {
            const subject = document.getElementById('subject').value;
            const content = document.getElementById('content').value;
            
            if (!subject || !content) {
                alert('Vui lòng nhập đầy đủ tiêu đề và nội dung');
                return;
            }
            
            const testEmail = prompt('Nhập email để nhận thử nghiệm:', 'test@example.com');
            if (!testEmail) return;
            
            // Send test email
            fetch('${pageContext.request.contextPath}/test-email', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `to=${encodeURIComponent(testEmail)}&subject=${encodeURIComponent(subject)}&content=${encodeURIComponent(content)}&emailType=newsletter`
            })
            .then(response => response.text())
            .then(data => {
                if (data.startsWith('SUCCESS:')) {
                    alert('Email thử nghiệm đã được gửi thành công đến ' + testEmail);
                } else {
                    alert('Lỗi: ' + data);
                }
            })
            .catch(error => {
                alert('Có lỗi xảy ra khi gửi email thử nghiệm');
            });
        }
        
        function clearForm() {
            if (confirm('Bạn có chắc chắn muốn xóa toàn bộ nội dung form?')) {
                document.getElementById('newsletterForm').reset();
                toggleRecipients();
                updatePreview();
            }
        }
        
        // Auto-update preview and count
        document.getElementById('subject').addEventListener('input', updatePreview);
        document.getElementById('content').addEventListener('input', updatePreview);
        document.getElementById('customEmails').addEventListener('input', updateCustomCount);
        
        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            toggleRecipients();
            updatePreview();
        });
    </script>
</body>
</html>