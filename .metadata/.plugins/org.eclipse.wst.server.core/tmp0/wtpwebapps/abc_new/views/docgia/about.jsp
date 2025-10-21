<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Về chúng tôi - ABC News</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .navbar-brand { font-weight: bold; color: #c41e3a !important; }
        .hero-section { background: linear-gradient(135deg, #c41e3a, #a01729) !important; }
        .feature-icon { font-size: 3rem; color: #c41e3a !important; }
        .team-card { transition: transform 0.2s; }
        .team-card:hover { transform: translateY(-5px); }
        .btn-outline-danger { color: #c41e3a !important; border-color: #c41e3a !important; }
        .btn-outline-danger:hover { background-color: #c41e3a !important; border-color: #c41e3a !important; }
        .bg-danger { background-color: #c41e3a !important; }
        .text-danger { color: #c41e3a !important; }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <i class="fas fa-newspaper"></i> ABC News
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home"></i> Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/about">
                            <i class="fas fa-info-circle"></i> Về chúng tôi
                        </a>
                    </li>
                </ul>
                
                <!-- Search Form -->
                <form class="d-flex me-3" action="${pageContext.request.contextPath}/search" method="get">
                    <input class="form-control me-2" type="search" name="q" 
                           placeholder="Tìm kiếm tin tức..." required>
                    <button class="btn btn-outline-danger" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
                
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/login">
                            <i class="fas fa-sign-in-alt"></i> Đăng nhập
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section text-white py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h1 class="display-4 fw-bold mb-3">Về ABC News</h1>
                    <p class="lead mb-4">Chúng tôi cam kết mang đến những tin tức chính xác, kịp thời và đáng tin cậy cho độc giả Việt Nam</p>
                </div>
                <div class="col-lg-4 text-center">
                    <i class="fas fa-users fa-5x opacity-75"></i>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container my-5">
        <!-- Mission Section -->
        <section class="mb-5">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h2 class="mb-4">Sứ mệnh của chúng tôi</h2>
                    <p class="lead text-muted">
                        ABC News được thành lập với sứ mệnh cung cấp thông tin chính xác, khách quan và kịp thời 
                        cho cộng đồng. Chúng tôi tin rằng thông tin chất lượng là nền tảng của một xã hội dân chủ 
                        và phát triển.
                    </p>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section class="mb-5">
            <h2 class="text-center mb-5">Tại sao chọn ABC News?</h2>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="text-center">
                        <i class="fas fa-clock feature-icon mb-3"></i>
                        <h4>Cập nhật 24/7</h4>
                        <p class="text-muted">
                            Tin tức được cập nhật liên tục 24 giờ một ngày, 7 ngày một tuần 
                            để bạn không bỏ lỡ thông tin quan trọng nào.
                        </p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="text-center">
                        <i class="fas fa-shield-alt feature-icon mb-3"></i>
                        <h4>Thông tin đáng tin cậy</h4>
                        <p class="text-muted">
                            Mọi tin tức đều được kiểm chứng kỹ lưỡng bởi đội ngũ biên tập viên 
                            giàu kinh nghiệm trước khi đăng tải.
                        </p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="text-center">
                        <i class="fas fa-globe feature-icon mb-3"></i>
                        <h4>Đa dạng chủ đề</h4>
                        <p class="text-muted">
                            Từ thời sự, kinh tế, thể thao đến giải trí, chúng tôi cung cấp 
                            thông tin đa dạng phục vụ mọi sở thích của độc giả.
                        </p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Team Section -->
        <section class="mb-5">
            <h2 class="text-center mb-5">Đội ngũ của chúng tôi</h2>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card team-card shadow-sm h-100">
                        <div class="card-body text-center">
                            <div class="mb-3">
                                <i class="fas fa-user-circle fa-4x text-danger"></i>
                            </div>
                            <h5 class="card-title">Nguyễn Văn A</h5>
                            <p class="text-muted">Tổng Biên tập</p>
                            <p class="card-text">
                                Với hơn 15 năm kinh nghiệm trong ngành báo chí, 
                                anh A đã dẫn dắt ABC News trở thành một trong những 
                                trang tin tức uy tín nhất.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card team-card shadow-sm h-100">
                        <div class="card-body text-center">
                            <div class="mb-3">
                                <i class="fas fa-user-circle fa-4x text-success"></i>
                            </div>
                            <h5 class="card-title">Trần Thị B</h5>
                            <p class="text-muted">Phó Tổng Biên tập</p>
                            <p class="card-text">
                                Chuyên gia về tin tức kinh tế và chính trị, 
                                chị B có khả năng phân tích sâu sắc và 
                                trình bày thông tin một cách dễ hiểu.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card team-card shadow-sm h-100">
                        <div class="card-body text-center">
                            <div class="mb-3">
                                <i class="fas fa-user-circle fa-4x text-warning"></i>
                            </div>
                            <h5 class="card-title">Lê Văn C</h5>
                            <p class="text-muted">Trưởng phòng Kỹ thuật</p>
                            <p class="card-text">
                                Đảm bảo website hoạt động ổn định và 
                                liên tục cải tiến trải nghiệm người dùng 
                                với những công nghệ mới nhất.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Contact Section -->
        <section class="mb-5">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <div class="card shadow-sm">
                        <div class="card-header bg-danger text-white">
                            <h3 class="mb-0">
                                <i class="fas fa-envelope"></i> Liên hệ với chúng tôi
                            </h3>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <h5><i class="fas fa-map-marker-alt text-danger"></i> Địa chỉ</h5>
                                    <p class="text-muted">
                                        123 Đường ABC, Quận 1<br>
                                        TP. Hồ Chí Minh, Việt Nam
                                    </p>
                                    
                                    <h5><i class="fas fa-phone text-success"></i> Điện thoại</h5>
                                    <p class="text-muted">
                                        Tổng đài: (028) 1234 5678<br>
                                        Hotline: 0901 234 567
                                    </p>
                                </div>
                                <div class="col-md-6">
                                    <h5><i class="fas fa-envelope text-primary"></i> Email</h5>
                                    <p class="text-muted">
                                        Biên tập: editor@abcnews.com<br>
                                        Quảng cáo: ads@abcnews.com<br>
                                        Hỗ trợ: support@abcnews.com
                                    </p>
                                    
                                    <h5><i class="fas fa-share-alt text-info"></i> Mạng xã hội</h5>
                                    <div class="d-flex gap-3">
                                        <a href="#" class="text-primary"><i class="fab fa-facebook fa-2x"></i></a>
                                        <a href="#" class="text-info"><i class="fab fa-twitter fa-2x"></i></a>
                                        <a href="#" class="text-danger"><i class="fab fa-youtube fa-2x"></i></a>
                                        <a href="#" class="text-warning"><i class="fab fa-instagram fa-2x"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-light py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="fas fa-newspaper"></i> ABC News</h5>
                    <p>Trang tin tức hàng đầu Việt Nam</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p>&copy; 2024 ABC News. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>