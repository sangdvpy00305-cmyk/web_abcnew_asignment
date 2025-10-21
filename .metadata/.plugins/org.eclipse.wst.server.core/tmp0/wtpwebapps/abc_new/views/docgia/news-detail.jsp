<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .navbar-brand { font-weight: bold; color: #c41e3a !important; }
        .news-content { line-height: 1.8; }
        .news-meta { color: #666; font-size: 0.9rem; }
        .related-news .card { transition: transform 0.2s; }
        .related-news .card:hover { transform: translateY(-2px); }
        .breadcrumb-item a { text-decoration: none; }
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
                    <c:forEach var="category" items="${categories}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/category/${category.id}">
                                ${category.name}
                            </a>
                        </li>
                    </c:forEach>
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

    <!-- Main Content -->
    <div class="container mt-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
                </li>
                <li class="breadcrumb-item">
                    <a href="${pageContext.request.contextPath}/category/${news.categoryId}">${news.categoryName}</a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">Chi tiết tin tức</li>
            </ol>
        </nav>

        <div class="row">
            <!-- Main Article -->
            <div class="col-lg-8">
                <article class="card shadow-sm">
                    <div class="card-body">
                        <!-- Article Header -->
                        <div class="mb-4">
                            <h1 class="card-title h2 mb-3">${news.title}</h1>
                            
                            <div class="news-meta mb-3">
                                <span class="me-3">
                                    <i class="fas fa-user"></i> ${news.authorName}
                                </span>
                                <span class="me-3">
                                    <i class="fas fa-calendar"></i> 
                                    <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </span>
                                <span class="me-3">
                                    <i class="fas fa-eye"></i> ${news.viewCount} lượt xem
                                </span>
                                <span class="badge bg-danger">
                                    <i class="fas fa-tag"></i> ${news.categoryName}
                                </span>
                            </div>
                        </div>

                        <!-- Article Image -->
                        <c:if test="${not empty news.image}">
                            <div class="text-center mb-4">
                                <img src="${pageContext.request.contextPath}${news.image}" 
                                     alt="${news.title}" 
                                     class="img-fluid rounded shadow-sm"
                                     style="max-height: 400px;">
                            </div>
                        </c:if>

                        <!-- Article Content -->
                        <div class="news-content">
                            ${news.content}
                        </div>

                        <!-- Social Share -->
                        <div class="mt-4 pt-3 border-top">
                            <h6>Chia sẻ bài viết:</h6>
                            <div class="d-flex gap-2">
                                <a href="#" class="btn btn-outline-danger btn-sm">
                                    <i class="fab fa-facebook-f"></i> Facebook
                                </a>
                                <a href="#" class="btn btn-outline-info btn-sm">
                                    <i class="fab fa-twitter"></i> Twitter
                                </a>
                                <a href="#" class="btn btn-outline-success btn-sm">
                                    <i class="fab fa-whatsapp"></i> WhatsApp
                                </a>
                            </div>
                        </div>
                    </div>
                </article>
            </div>

            <!-- Sidebar -->
            <div class="col-lg-4">
                <!-- Related News -->
                <c:if test="${not empty relatedNews}">
                    <div class="card shadow-sm mb-4">
                        <div class="card-header bg-danger text-white">
                            <h5 class="mb-0">
                                <i class="fas fa-newspaper"></i> Tin tức cùng chuyên mục
                            </h5>
                        </div>
                        <div class="card-body p-0">
                            <c:forEach var="relatedItem" items="${relatedNews}">
                                <div class="border-bottom p-3">
                                    <div class="row g-2">
                                        <c:if test="${not empty relatedItem.image}">
                                            <div class="col-4">
                                                <img src="${pageContext.request.contextPath}${relatedItem.image}" 
                                                     alt="${relatedItem.title}"
                                                     class="img-fluid rounded"
                                                     style="height: 60px; object-fit: cover;">
                                            </div>
                                            <div class="col-8">
                                        </c:if>
                                        <c:if test="${empty relatedItem.image}">
                                            <div class="col-12">
                                        </c:if>
                                            <a href="${pageContext.request.contextPath}/news/${relatedItem.id}" 
                                               class="text-decoration-none">
                                                <h6 class="mb-1 text-dark">${relatedItem.title}</h6>
                                            </a>
                                            <small class="text-muted">
                                                <i class="fas fa-calendar"></i>
                                                <fmt:formatDate value="${relatedItem.postedDate}" pattern="dd/MM/yyyy"/>
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <!-- Newsletter Signup -->
                <div class="card shadow-sm">
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
    <footer class="bg-dark text-light mt-5 py-4">
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