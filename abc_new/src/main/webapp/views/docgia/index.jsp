<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>ABC News - Trang tin tức hàng đầu Việt Nam</title>
                <meta name="description"
                    content="ABC News - Trang tin tức hàng đầu Việt Nam. Cập nhật tin tức nhanh chóng, chính xác và đáng tin cậy 24/7.">
                <meta name="keywords"
                    content="tin tức, báo chí, ABC News, Việt Nam, thời sự, kinh tế, thể thao, giải trí">
                <meta name="author" content="ABC News">
                <link rel="alternate" type="application/rss+xml" title="ABC News RSS"
                    href="${pageContext.request.contextPath}/rss">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <link href="${pageContext.request.contextPath}/css/docgia.css" rel="stylesheet">
                <style>
                    .hero-section {
                        background: linear-gradient(135deg, #c41e3a, #a01729) !important;
                    }
                    .navbar-brand {
                        color: #c41e3a !important;
                    }
                    .text-danger {
                        color: #c41e3a !important;
                    }
                    .btn-outline-danger {
                        color: #c41e3a !important;
                        border-color: #c41e3a !important;
                    }
                    .btn-outline-danger:hover {
                        background-color: #c41e3a !important;
                        border-color: #c41e3a !important;
                    }
                    .bg-danger {
                        background-color: #c41e3a !important;
                    }
                    .btn-danger {
                        background-color: #c41e3a !important;
                        border-color: #c41e3a !important;
                    }
                    .btn-danger:hover {
                        background-color: #a01729 !important;
                        border-color: #a01729 !important;
                    }
                </style>
            </head>

            <body>
                <!-- Navigation -->
                <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
                    <div class="container">
                        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-newspaper text-danger"></i> ABC News
                        </a>

                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav me-auto">
                                <li class="nav-item">
                                    <a class="nav-link active" href="${pageContext.request.contextPath}/home">
                                        <i class="fas fa-home"></i> Trang chủ
                                    </a>
                                </li>
                                <c:forEach var="category" items="${categories}">
                                    <li class="nav-item">
                                        <a class="nav-link"
                                            href="${pageContext.request.contextPath}/category/${category.id}">
                                            ${category.name}
                                        </a>
                                    </li>
                                </c:forEach>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/about">
                                        <i class="fas fa-info-circle"></i> Giới thiệu
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
                                <h1 class="display-4 fw-bold mb-3">ABC News</h1>
                                <p class="lead mb-4">Tin tức nhanh chóng, chính xác và đáng tin cậy 24/7</p>
                                <div class="d-flex gap-3">
                                    <a href="#latest-news" class="btn btn-light btn-lg">
                                        <i class="fas fa-newspaper"></i> Tin mới nhất
                                    </a>
                                    <a href="#newsletter" class="btn btn-outline-light btn-lg">
                                        <i class="fas fa-envelope"></i> Đăng ký nhận tin
                                    </a>
                                </div>
                            </div>
                            <div class="col-lg-4 text-center">
                                <i class="fas fa-newspaper fa-5x opacity-75"></i>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Main Content -->
                <div class="container my-5">
                    <div class="row">
                        <!-- Main Content Area -->
                        <div class="col-lg-8">
                            <!-- Featured News -->
                            <c:if test="${not empty featuredNews}">
                                <section class="mb-5">
                                    <h2 class="section-title mb-4">
                                        <i class="fas fa-star text-warning"></i> Tin nổi bật
                                    </h2>
                                    <div class="row">
                                        <c:forEach var="featured" items="${featuredNews}" varStatus="status">
                                            <div class="col-md-${status.index == 0 ? '12' : '6'} mb-4">
                                                <div class="card news-card shadow-sm h-100">
                                                    <c:if test="${not empty featured.image}">
                                                        <img src="${pageContext.request.contextPath}${featured.image}"
                                                            class="card-img-top" alt="${featured.title}"
                                                            style="height: ${status.index == 0 ? '300px' : '200px'}; object-fit: cover;">
                                                    </c:if>
                                                    <div class="card-body">
                                                        <h${status.index==0 ? '3' : '5' } class="card-title">
                                                            <a href="${pageContext.request.contextPath}/news/${featured.id}"
                                                                class="text-decoration-none text-dark">
                                                                ${featured.title}
                                                            </a>
                                                        </h${status.index==0 ? '3' : '5' }>
                                                        <c:if test="${not empty featured.summary}">
                                                            <p class="card-text news-excerpt text-muted">
                                                                ${featured.summary}
                                                            </p>
                                                        </c:if>
                                                        <div class="d-flex justify-content-between align-items-center">
                                                            <small class="text-muted">
                                                                <i class="fas fa-user"></i> ${featured.authorName}
                                                            </small>
                                                            <small class="text-muted">
                                                                <i class="fas fa-eye"></i> ${featured.viewCount}
                                                            </small>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </section>
                            </c:if>

                            <!-- Latest News -->
                            <section id="latest-news" class="mb-5">
                                <h2 class="section-title mb-4">
                                    <i class="fas fa-clock text-danger"></i> Tin mới nhất
                                </h2>
                                <c:choose>
                                    <c:when test="${not empty latestNews}">
                                        <div class="row">
                                            <c:forEach var="latest" items="${latestNews}">
                                                <div class="col-md-6 mb-4">
                                                    <div class="card news-card shadow-sm h-100">
                                                        <c:if test="${not empty latest.image}">
                                                            <img src="${pageContext.request.contextPath}${latest.image}"
                                                                class="card-img-top" alt="${latest.title}"
                                                                style="height: 200px; object-fit: cover;">
                                                        </c:if>
                                                        <div class="card-body d-flex flex-column">
                                                            <h5 class="card-title">
                                                                <a href="${pageContext.request.contextPath}/news/${latest.id}"
                                                                    class="text-decoration-none text-dark">
                                                                    ${latest.title}
                                                                </a>
                                                            </h5>
                                                            <c:if test="${not empty latest.summary}">
                                                                <p
                                                                    class="card-text news-excerpt text-muted flex-grow-1">
                                                                    ${latest.summary}
                                                                </p>
                                                            </c:if>
                                                            <div class="mt-auto">
                                                                <div
                                                                    class="d-flex justify-content-between align-items-center">
                                                                    <small class="text-muted">
                                                                        <i class="fas fa-user"></i> ${latest.authorName}
                                                                    </small>
                                                                    <small class="text-muted">
                                                                        <i class="fas fa-eye"></i> ${latest.viewCount}
                                                                    </small>
                                                                </div>
                                                                <small class="text-muted">
                                                                    <i class="fas fa-calendar"></i>
                                                                    <fmt:formatDate value="${latest.postedDate}"
                                                                        pattern="dd/MM/yyyy HH:mm" />
                                                                </small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-5">
                                            <i class="fas fa-newspaper fa-3x text-muted mb-3"></i>
                                            <h4 class="text-muted">Chưa có tin tức mới</h4>
                                            <p class="text-muted">Hiện tại chưa có tin tức nào được đăng. Vui lòng quay
                                                lại sau!</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </section>
                        </div>

                        <!-- Sidebar -->
                        <div class="col-lg-4">
                            <!-- Hot News -->
                            <c:if test="${not empty hotNews}">
                                <div class="card shadow-sm mb-4">
                                    <div class="card-header bg-danger text-white">
                                        <h5 class="mb-0">
                                            <i class="fas fa-fire"></i> Tin hot nhất
                                        </h5>
                                    </div>
                                    <div class="card-body p-0">
                                        <c:forEach var="hot" items="${hotNews}">
                                            <div class="border-bottom p-3">
                                                <div class="row g-2">
                                                    <c:if test="${not empty hot.image}">
                                                        <div class="col-4">
                                                            <img src="${pageContext.request.contextPath}${hot.image}"
                                                                alt="${hot.title}" class="img-fluid rounded"
                                                                style="height: 60px; object-fit: cover;">
                                                        </div>
                                                        <div class="col-8">
                                                    </c:if>
                                                    <c:if test="${empty hot.image}">
                                                        <div class="col-12">
                                                    </c:if>
                                                    <a href="${pageContext.request.contextPath}/news/${hot.id}"
                                                        class="text-decoration-none">
                                                        <h6 class="mb-1 text-dark">${hot.title}</h6>
                                                    </a>
                                                    <small class="text-muted">
                                                        <i class="fas fa-eye"></i> ${hot.viewCount} lượt xem
                                                    </small>
                                                </div>
                                            </div>
                                    </div>
                                    </c:forEach>
                                </div>
                        </div>
                        </c:if>

                        <!-- Recent Viewed -->
                        <c:if test="${not empty recentViewedNews}">
                            <div class="card shadow-sm mb-4">
                                <div class="card-header bg-info text-white">
                                    <h5 class="mb-0">
                                        <i class="fas fa-history"></i> Đã xem gần đây
                                    </h5>
                                </div>
                                <div class="card-body p-0">
                                    <c:forEach var="recent" items="${recentViewedNews}">
                                        <div class="border-bottom p-3">
                                            <div class="row g-2">
                                                <c:if test="${not empty recent.image}">
                                                    <div class="col-4">
                                                        <img src="${pageContext.request.contextPath}${recent.image}"
                                                            alt="${recent.title}" class="img-fluid rounded"
                                                            style="height: 60px; object-fit: cover;">
                                                    </div>
                                                    <div class="col-8">
                                                </c:if>
                                                <c:if test="${empty recent.image}">
                                                    <div class="col-12">
                                                </c:if>
                                                <a href="${pageContext.request.contextPath}/news/${recent.id}"
                                                    class="text-decoration-none">
                                                    <h6 class="mb-1 text-dark">${recent.title}</h6>
                                                </a>
                                                <small class="text-muted">
                                                    <i class="fas fa-calendar"></i>
                                                    <fmt:formatDate value="${recent.postedDate}" pattern="dd/MM/yyyy" />
                                                </small>
                                            </div>
                                        </div>
                                </div>
                                </c:forEach>
                            </div>
                    </div>
                    </c:if>

                    <!-- Newsletter Signup -->
                    <div id="newsletter" class="card shadow-sm">
                        <div class="card-header bg-success text-white">
                            <h5 class="mb-0">
                                <i class="fas fa-envelope"></i> Đăng ký nhận tin
                            </h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text">Nhận tin tức mới nhất từ ABC News qua email.</p>
                            <form action="${pageContext.request.contextPath}/newsletter" method="post">
                                <div class="mb-3">
                                    <input type="email" class="form-control" name="email"
                                        placeholder="Nhập email của bạn" required>
                                </div>
                                <button type="submit" class="btn btn-success w-100">
                                    <i class="fas fa-paper-plane"></i> Đăng ký
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                </div>
                </div>

                <!-- Footer -->
                <footer class="bg-dark text-light py-4">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-6">
                                <h5><i class="fas fa-newspaper"></i> ABC News</h5>
                                <p>Trang tin tức hàng đầu Việt Nam</p>
                                <div class="mt-3">
                                    <a href="${pageContext.request.contextPath}/rss" class="text-light me-3">
                                        <i class="fas fa-rss"></i> RSS Feed
                                    </a>
                                    <a href="${pageContext.request.contextPath}/newsletter" class="text-light">
                                        <i class="fas fa-envelope"></i> Newsletter
                                    </a>
                                </div>
                            </div>
                            <div class="col-md-6 text-md-end">
                                <p>&copy; 2024 ABC News. All rights reserved.</p>
                                <div class="mt-2">
                                    <a href="#" class="text-light me-2"><i class="fab fa-facebook"></i></a>
                                    <a href="#" class="text-light me-2"><i class="fab fa-twitter"></i></a>
                                    <a href="#" class="text-light me-2"><i class="fab fa-youtube"></i></a>
                                    <a href="#" class="text-light"><i class="fab fa-instagram"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </footer>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>