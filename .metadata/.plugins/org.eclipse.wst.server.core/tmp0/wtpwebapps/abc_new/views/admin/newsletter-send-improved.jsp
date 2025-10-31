<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gửi Newsletter - ABC News Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .preview-section {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 0.375rem;
            padding: 1rem;
            margin-top: 1rem;
        }
        .email-preview {
            max-height: 400px;
            overflow-y: auto;
            border: 1px solid #ddd;
            padding: 15px;
            background: white;
            border-radius: 5px;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-danger">
        <div class="container-fluid">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="fas fa-newspaper"></i> ABC NEWS ADMIN
            </a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">
                    <i class="fas fa-user"></i> ${sessionScope.fullname}
                </span>
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-3 col-lg-2 d-md-block bg-white sidebar collapse">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-tachometer-alt"></i> Tổng quan
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                                <i class="fas fa-users"></i> Quản lý người dùng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">
                                <i class="fas fa-folder"></i> Quản lý danh mục
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/news">
                                <i class="fas fa-newspaper"></i> Quản lý tin tức
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/newsletters">
                                <i class="fas fa-envelope"></i> Quản lý Newsletter
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/newsletters/send">
                                <i class="fas fa-paper-plane"></i> Gửi Newsletter
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">
                        <i class="fas fa-paper-plane text-success"></i> Gửi Newsletter
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/newsletters" class="btn btn-outline-secondary">
                            <i class="fas fa-list"></i> Danh sách Subscribers
                        </a>
                    </div>
                </div>

                <!-- Thông báo -->
                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Thống kê nhanh -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="card bg-success text-white">
                            <div class="card-body">
                                <h5><i class="fas fa-users"></i> Subscribers hoạt động: ${activeSubscribers}</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card bg-info text-white">
                            <div class="card-body">
                                <h5><i class="fas fa-envelope"></i> Tổng subscribers: ${totalSubscribers}</h5>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- Form gửi email -->
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <i class="fas fa-edit"></i> Soạn Newsletter
                                </h5>
                            </div>
                            <div class="card-body">
                                <form method="post" id="newsletterForm">
                                    <!-- Tiêu đề -->
                                    <div class="mb-3">
                                        <label for="subject" class="form-label">
                                            <i class="fas fa-heading"></i> Tiêu đề email <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" class="form-control" id="subject" name="subject" 
                                               placeholder="Nhập tiêu đề email..." required>
                                    </div>

                                    <!-- Nội dung -->
                                    <div class="mb-3">
                                        <label for="content" class="form-label">
                                            <i class="fas fa-align-left"></i> Nội dung email <span class="text-danger">*</span>
                                        </label>
                                        <textarea class="form-control" id="content" name="content" rows="8" 
                                                  placeholder="Nhập nội dung email..." required></textarea>
                                        <div class="form-text">
                                            <i class="fas fa-info-circle"></i> Hỗ trợ xuống dòng và định dạng cơ bản
                                        </div>
                                    </div>

                                    <!-- Tùy chọn người nhận -->
                                    <div class="mb-3">
                                        <label class="form-label">
                                            <i class="fas fa-users"></i> Người nhận
                                        </label>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="sendToAll" id="sendToAll" value="1" checked>
                                            <label class="form-check-label" for="sendToAll">
                                                <i class="fas fa-broadcast-tower"></i> Gửi đến tất cả subscribers hoạt động (${activeSubscribers} người)
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="sendToAll" id="sendToCustom" value="0">
                                            <label class="form-check-label" for="sendToCustom">
                                                <i class="fas fa-list"></i> Gửi đến danh sách email tùy chỉnh
                                            </label>
                                        </div>
                                    </div>

                                    <!-- Danh sách email tùy chỉnh -->
                                    <div class="mb-3" id="customEmailsDiv" style="display: none;">
                                        <label for="customEmails" class="form-label">
                                            <i class="fas fa-envelope-open-text"></i> Danh sách email (mỗi email một dòng)
                                        </label>
                                        <textarea class="form-control" id="customEmails" name="customEmails" rows="5" 
                                                  placeholder="user1@example.com&#10;user2@example.com&#10;user3@example.com"></textarea>
                                    </div>

                                    <!-- Nút gửi -->
                                    <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-success btn-lg" id="sendBtn">
                                            <i class="fas fa-paper-plane"></i> Gửi Newsletter
                                        </button>
                                        <button type="button" class="btn btn-outline-secondary" onclick="previewEmail()">
                                            <i class="fas fa-eye"></i> Xem trước
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Preview -->
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <i class="fas fa-eye"></i> Xem trước Email
                                </h5>
                            </div>
                            <div class="card-body">
                                <div id="emailPreview" class="email-preview">
                                    <div class="text-muted text-center py-4">
                                        <i class="fas fa-envelope fa-3x mb-3"></i>
                                        <p>Nhập tiêu đề và nội dung để xem trước email</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Template mẫu -->
                        <div class="card mt-3">
                            <div class="card-header">
                                <h6 class="mb-0">
                                    <i class="fas fa-magic"></i> Template mẫu
                                </h6>
                            </div>
                            <div class="card-body">
                                <button type="button" class="btn btn-outline-primary btn-sm w-100 mb-2" onclick="useTemplate('welcome')">
                                    <i class="fas fa-hand-wave"></i> Chào mừng
                                </button>
                                <button type="button" class="btn btn-outline-info btn-sm w-100 mb-2" onclick="useTemplate('news')">
                                    <i class="fas fa-newspaper"></i> Tin tức mới
                                </button>
                                <button type="button" class="btn btn-outline-warning btn-sm w-100" onclick="useTemplate('event')">
                                    <i class="fas fa-calendar"></i> Sự kiện
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle custom emails
        document.querySelectorAll('input[name="sendToAll"]').forEach(radio => {
            radio.addEventListener('change', function() {
                const customDiv = document.getElementById('customEmailsDiv');
                if (this.value === '0') {
                    customDiv.style.display = 'block';
                } else {
                    customDiv.style.display = 'none';
                }
            });
        });

        // Preview email
        function previewEmail() {
            const subject = document.getElementById('subject').value;
            const content = document.getElementById('content').value;
            const preview = document.getElementById('emailPreview');
            
            if (!subject && !content) {
                preview.innerHTML = `
                    <div class="text-muted text-center py-4">
                        <i class="fas fa-envelope fa-3x mb-3"></i>
                        <p>Nhập tiêu đề và nội dung để xem trước email</p>
                    </div>
                `;
                return;
            }
            
            preview.innerHTML = `
                <div style="font-family: Arial, sans-serif; line-height: 1.6;">
                    <div style="background: #28a745; color: white; padding: 15px; text-align: center; border-radius: 5px 5px 0 0;">
                        <h3 style="margin: 0;"><i class="fas fa-newspaper"></i> ABC News Newsletter</h3>
                    </div>
                    <div style="padding: 20px; border: 1px solid #ddd; border-top: none;">
                        <h4 style="color: #333; margin-bottom: 15px;">${subject || 'Tiêu đề email'}</h4>
                        <div style="color: #555; line-height: 1.8;">
                            ${(content || 'Nội dung email sẽ hiển thị ở đây...').replace(/\n/g, '<br>')}
                        </div>
                    </div>
                    <div style="background: #f8f9fa; padding: 10px; text-align: center; font-size: 12px; color: #666; border: 1px solid #ddd; border-top: none; border-radius: 0 0 5px 5px;">
                        © 2024 ABC News. <a href="#" style="color: #28a745;">Hủy đăng ký</a>
                    </div>
                </div>
            `;
        }

        // Auto preview on input
        document.getElementById('subject').addEventListener('input', previewEmail);
        document.getElementById('content').addEventListener('input', previewEmail);

        // Use template
        function useTemplate(type) {
            const subjectField = document.getElementById('subject');
            const contentField = document.getElementById('content');
            
            switch(type) {
                case 'welcome':
                    subjectField.value = '🎉 Chào mừng bạn đến với ABC News!';
                    contentField.value = `Xin chào!\n\nCảm ơn bạn đã đăng ký nhận tin tức từ ABC News. Chúng tôi rất vui mừng có bạn trong cộng đồng độc giả của mình.\n\nBạn sẽ nhận được những tin tức mới nhất, chính xác và kịp thời từ chúng tôi.\n\nTrân trọng,\nĐội ngũ ABC News`;
                    break;
                case 'news':
                    subjectField.value = '📰 Tin tức nổi bật tuần này từ ABC News';
                    contentField.value = `Tin tức nổi bật tuần này:\n\n• [Tiêu đề tin 1]\n• [Tiêu đề tin 2]\n• [Tiêu đề tin 3]\n\nTruy cập website để đọc chi tiết: ${window.location.origin}/abc-new/home\n\nCảm ơn bạn đã theo dõi ABC News!`;
                    break;
                case 'event':
                    subjectField.value = '📅 Sự kiện đặc biệt từ ABC News';
                    contentField.value = `Thông báo sự kiện:\n\n[Tên sự kiện]\nThời gian: [Ngày giờ]\nĐịa điểm: [Địa chỉ]\n\nChúng tôi rất mong được gặp bạn tại sự kiện này!\n\nĐăng ký tham gia: [Link đăng ký]`;
                    break;
            }
            previewEmail();
        }

        // Form submission
        document.getElementById('newsletterForm').addEventListener('submit', function(e) {
            const sendBtn = document.getElementById('sendBtn');
            const originalText = sendBtn.innerHTML;
            
            sendBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang gửi...';
            sendBtn.disabled = true;
            
            // Re-enable after form submission
            setTimeout(() => {
                sendBtn.innerHTML = originalText;
                sendBtn.disabled = false;
            }, 3000);
        });
    </script>
</body>
</html>