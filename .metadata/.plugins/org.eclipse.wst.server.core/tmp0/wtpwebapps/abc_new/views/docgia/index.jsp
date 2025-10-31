<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'vi'}" scope="request" />
            <fmt:setBundle basename="global" scope="request" />
            <!DOCTYPE html>
            <html lang="${sessionScope.lang != null ? sessionScope.lang : 'vi'}">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>
                    <fmt:message key="app.title" /> -
                    <fmt:message key="app.slogan" />
                </title>
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
                <link href="${pageContext.request.contextPath}/static/css/dark-mode.css" rel="stylesheet">
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
                                        <i class="fas fa-home"></i>
                                        <fmt:message key="menu.home" />
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
                                        <i class="fas fa-info-circle"></i>
                                        <fmt:message key="menu.about" />
                                    </a>
                                </li>
                            </ul>

                            <!-- Search Form -->
                            <form class="d-flex me-3" action="${pageContext.request.contextPath}/search" method="get">
                                <input class="form-control me-2" type="search" name="q" placeholder="<fmt:message key="
                                    search.placeholder" />" required>
                                <button class="btn btn-outline-danger" type="submit">
                                    <i class="fas fa-search"></i>
                                </button>
                            </form>

                            <ul class="navbar-nav">
                                <!-- Theme Toggle Button -->
                                <li class="nav-item">
                                    <button id="theme-toggle" class="theme-toggle" title="Chuyển sang chế độ tối" aria-label="Chuyển sang chế độ tối">
                                        🌙
                                    </button>
                                </li>
                                
                                <!-- Language Switcher -->
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="languageDropdown" role="button"
                                        data-bs-toggle="dropdown">
                                        <i class="fas fa-globe"></i>
                                        <fmt:message key="menu.language" />
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="?lang=vi">🇻🇳 Tiếng Việt</a></li>
                                        <li><a class="dropdown-item" href="?lang=en">🇺🇸 English</a></li>
                                        <li><a class="dropdown-item" href="?lang=zh">🇨🇳 中文</a></li>
                                    </ul>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                        <i class="fas fa-sign-in-alt"></i>
                                        <fmt:message key="menu.login" />
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
                                <h1 class="display-4 fw-bold mb-3">
                                    <fmt:message key="app.title" />
                                </h1>
                                <p class="lead mb-4">
                                    <fmt:message key="app.slogan" />
                                </p>
                                <div class="d-flex gap-3">
                                    <a href="#latest-news" class="btn btn-light btn-lg">
                                        <i class="fas fa-newspaper"></i>
                                        <fmt:message key="news.latest" />
                                    </a>
                                    <a href="#newsletter" class="btn btn-outline-light btn-lg">
                                        <i class="fas fa-envelope"></i>
                                        <fmt:message key="action.subscribe" />
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
                            <!-- Tin nổi bật -->
                            <c:if test="${not empty featuredNews}">
                                <section class="mb-5">
                                    <h2 class="section-title mb-4">
                                        <i class="fas fa-star text-warning"></i>
                                        <fmt:message key="news.featured" />
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
                                    <i class="fas fa-clock text-danger"></i>
                                    <fmt:message key="news.latest" />
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
                                            <h4 class="text-muted">
                                                <fmt:message key="news.no.news" />
                                            </h4>
                                            <p class="text-muted">
                                                <fmt:message key="news.no.news.description" />
                                            </p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </section>

                            <!-- Tất cả tin tức -->
                            <section class="mb-5">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h2 class="section-title mb-0">
                                        <i class="fas fa-list text-primary"></i>
                                        <fmt:message key="menu.all.news" />
                                    </h2>
                                    <a href="${pageContext.request.contextPath}/all-news"
                                        class="btn btn-outline-danger btn-sm">
                                        <i class="fas fa-arrow-right"></i>
                                        <fmt:message key="action.view.all" />
                                    </a>
                                </div>

                                <c:choose>
                                    <c:when test="${not empty allNews}">
                                        <div class="row">
                                            <c:forEach var="news" items="${allNews}" varStatus="status">
                                                <c:if test="${status.index < 6}">
                                                    <div class="col-md-6 col-lg-4 mb-4">
                                                        <div class="card news-card shadow-sm h-100">
                                                            <c:if test="${not empty news.image}">
                                                                <img src="${pageContext.request.contextPath}${news.image}"
                                                                    class="card-img-top" alt="${news.title}"
                                                                    style="height: 180px; object-fit: cover;">
                                                            </c:if>
                                                            <div class="card-body d-flex flex-column">
                                                                <h6 class="card-title">
                                                                    <a href="${pageContext.request.contextPath}/news/${news.id}"
                                                                        class="text-decoration-none text-dark">
                                                                        ${news.title}
                                                                    </a>
                                                                </h6>
                                                                <c:if test="${not empty news.summary}">
                                                                    <p
                                                                        class="card-text news-excerpt text-muted flex-grow-1 small">
                                                                        ${news.summary}
                                                                    </p>
                                                                </c:if>
                                                                <div class="mt-auto">
                                                                    <div
                                                                        class="d-flex justify-content-between align-items-center">
                                                                        <small class="text-muted">
                                                                            <i class="fas fa-user"></i>
                                                                            ${news.authorName}
                                                                        </small>
                                                                        <small class="text-muted">
                                                                            <i class="fas fa-eye"></i> ${news.viewCount}
                                                                        </small>
                                                                    </div>
                                                                    <div
                                                                        class="d-flex justify-content-between align-items-center mt-1">
                                                                        <small class="text-muted">
                                                                            <i class="fas fa-calendar"></i>
                                                                            <fmt:formatDate value="${news.postedDate}"
                                                                                pattern="dd/MM/yyyy" />
                                                                        </small>
                                                                        <span class="badge bg-danger small">
                                                                            ${news.categoryName}
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-4">
                                            <i class="fas fa-newspaper fa-2x text-muted mb-3"></i>
                                            <h5 class="text-muted">Chưa có tin tức nào</h5>
                                            <p class="text-muted">Hiện tại chưa có tin tức nào được đăng.</p>
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
                                            <i class="fas fa-fire"></i>
                                            <fmt:message key="news.popular" />
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
                                        <i class="fas fa-history"></i>
                                        <fmt:message key="news.recent.viewed" />
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
                                <i class="fas fa-envelope"></i>
                                <fmt:message key="newsletter.title" />
                            </h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text">
                                <fmt:message key="newsletter.description" />
                            </p>
                            <form action="${pageContext.request.contextPath}/simple-newsletter" method="post"
                                id="newsletterForm">
                                <div class="mb-3">
                                    <input type="email" class="form-control" name="email"
                                        placeholder="<fmt:message key=" newsletter.email.placeholder" />" required>
                                    <input type="hidden" name="action" value="subscribe">
                                </div>
                                <button type="submit" class="btn btn-success w-100"
                                    onclick="handleNewsletterSubmit(event)">
                                    <i class="fas fa-paper-plane"></i>
                                    <fmt:message key="action.subscribe" />
                                </button>
                            </form>
                            <div id="newsletterMessage" class="mt-2" style="display: none;"></div>
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
                <script src="${pageContext.request.contextPath}/assets/js/theme-toggle.js"></script>

                <script>
                    // Fallback theme toggle if main script fails
                    document.addEventListener('DOMContentLoaded', function() {
                        const toggleBtn = document.getElementById('theme-toggle');
                        if (toggleBtn && !window.themeManager) {
                            console.log('Using fallback theme toggle');
                            
                            // Simple theme toggle
                            toggleBtn.addEventListener('click', function() {
                                const html = document.documentElement;
                                const isDark = html.hasAttribute('data-theme');
                                
                                if (isDark) {
                                    html.removeAttribute('data-theme');
                                    toggleBtn.innerHTML = '🌙';
                                    toggleBtn.title = 'Chuyển sang chế độ tối';
                                    localStorage.setItem('abc-news-theme', 'light');
                                } else {
                                    html.setAttribute('data-theme', 'dark');
                                    toggleBtn.innerHTML = '☀️';
                                    toggleBtn.title = 'Chuyển sang chế độ sáng';
                                    localStorage.setItem('abc-news-theme', 'dark');
                                }
                            });
                            
                            // Load saved theme
                            const savedTheme = localStorage.getItem('abc-news-theme');
                            if (savedTheme === 'dark') {
                                document.documentElement.setAttribute('data-theme', 'dark');
                                toggleBtn.innerHTML = '☀️';
                                toggleBtn.title = 'Chuyển sang chế độ sáng';
                            }
                        }
                    });
                </script>


                <script>
                    // Function xử lý submit trực tiếp
                    function handleNewsletterSubmit(event) {
                        console.log('Button clicked directly');
                        event.preventDefault();

                        const form = document.getElementById('newsletterForm');
                        const email = form.querySelector('input[name="email"]').value;

                        if (!email || email.trim() === '') {
                            alert('Vui lòng nhập email');
                            return;
                        }

                        // Gửi request đơn giản
                        const formData = new FormData(form);

                        fetch(form.action, {
                            method: 'POST',
                            body: formData
                        })
                            .then(response => response.text())
                            .then(result => {
                                console.log('Response:', result);
                                if (result === 'success') {
                                    alert('Đăng ký thành công!');
                                    form.reset();
                                } else if (result === 'error_already_subscribed') {
                                    alert('Email này đã được đăng ký trước đó.');
                                } else {
                                    alert('Có lỗi xảy ra: ' + result);
                                }
                            })
                            .catch(error => {
                                console.error('Error:', error);
                                alert('Lỗi kết nối: ' + error.message);
                            });
                    }

                    // Xử lý form đăng ký newsletter
                    document.addEventListener('DOMContentLoaded', function () {
                        const form = document.getElementById('newsletterForm');
                        console.log('Newsletter form found:', form);

                        if (!form) {
                            console.error('Newsletter form not found!');
                            return;
                        }

                        form.addEventListener('submit', function (e) {
                            console.log('Form submit event triggered');
                            e.preventDefault();

                            const form = this;
                            const messageDiv = document.getElementById('newsletterMessage');
                            const submitBtn = form.querySelector('button[type="submit"]');
                            const originalBtnText = submitBtn.innerHTML;

                            // Hiển thị loading
                            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
                            submitBtn.disabled = true;

                            // Gửi request
                            fetch(form.action, {
                                method: 'POST',
                                body: new FormData(form)
                            })
                                .then(response => {
                                    console.log('Response status:', response.status);
                                    console.log('Response headers:', response.headers);
                                    return response.text();
                                })
                                .then(result => {
                                    console.log('Server response:', result);
                                    messageDiv.style.display = 'block';

                                    if (result === 'success') {
                                        messageDiv.className = 'alert alert-success mt-2';
                                        messageDiv.innerHTML = '<i class="fas fa-check-circle"></i> Đăng ký thành công! Cảm ơn bạn đã đăng ký nhận tin.';
                                        form.reset();
                                    } else if (result === 'error_already_subscribed') {
                                        messageDiv.className = 'alert alert-warning mt-2';
                                        messageDiv.innerHTML = '<i class="fas fa-exclamation-triangle"></i> Email này đã được đăng ký trước đó.';
                                    } else if (result === 'error_invalid_email') {
                                        messageDiv.className = 'alert alert-danger mt-2';
                                        messageDiv.innerHTML = '<i class="fas fa-times-circle"></i> Email không hợp lệ. Vui lòng kiểm tra lại.';
                                    } else if (result === 'error_empty_email') {
                                        messageDiv.className = 'alert alert-danger mt-2';
                                        messageDiv.innerHTML = '<i class="fas fa-times-circle"></i> Vui lòng nhập email.';
                                    } else {
                                        messageDiv.className = 'alert alert-danger mt-2';
                                        messageDiv.innerHTML = '<i class="fas fa-times-circle"></i> Có lỗi xảy ra. Server trả về: "' + result + '"';
                                    }

                                    // Ẩn thông báo sau 5 giây
                                    setTimeout(() => {
                                        messageDiv.style.display = 'none';
                                    }, 5000);
                                })
                                .catch(error => {
                                    messageDiv.style.display = 'block';
                                    messageDiv.className = 'alert alert-danger mt-2';
                                    messageDiv.innerHTML = '<i class="fas fa-times-circle"></i> Lỗi kết nối. Vui lòng thử lại sau.';
                                    console.error('Error:', error);
                                })
                                .finally(() => {
                                    // Khôi phục nút submit
                                    submitBtn.innerHTML = originalBtnText;
                                    submitBtn.disabled = false;
                                });
                        });
                    });
                </script>
            </body>

            </html>