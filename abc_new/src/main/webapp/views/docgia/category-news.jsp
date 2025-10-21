<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                    .navbar-brand {
                        font-weight: bold;
                        color: #c41e3a !important;
                    }

                    .news-card {
                        transition: transform 0.2s;
                    }

                    .news-card:hover {
                        transform: translateY(-2px);
                    }

                    .news-excerpt {
                        display: -webkit-box;
                        -webkit-line-clamp: 3;
                        -webkit-box-orient: vertical;
                        overflow: hidden;
                    }

                    .breadcrumb-item a {
                        text-decoration: none;
                    }
                </style>
            </head>

            <body>
                <!-- Navigation -->
                <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
                    <div class="container">
                        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-newspaper"></i> ABC News
                        </a>

                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav me-auto">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/home">
                                        <i class="fas fa-home"></i> Trang chủ
                                    </a>
                                </li>
                                <c:forEach var="cat" items="${categories}">
                                    <li class="nav-item">
                                        <a class="nav-link ${cat.id == category.id ? 'active' : ''}"
                                            href="${pageContext.request.contextPath}/category/${cat.id}">
                                            ${cat.name}
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

                            <ul class="navbar-nav"></ul>
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
                            <li class="breadcrumb-item active" aria-current="page">${category.name}</li>
                        </ol>
                    </nav>

                    <!-- Page Header -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h1 class="h2 mb-1">${category.name}</h1>
                                    <p class="text-muted mb-0">
                                        <i class="fas fa-newspaper"></i> ${totalNews} bài viết
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- News List -->
                    <div class="row">
                        <c:forEach var="newsItem" items="${categoryNews}">
                            <div class="col-md-6 col-lg-4 mb-4">
                                <div class="card h-100 news-card shadow-sm">
                                    <c:if test="${not empty newsItem.image}">
                                        <img src="${pageContext.request.contextPath}${newsItem.image}"
                                            class="card-img-top" alt="${newsItem.title}"
                                            style="height: 200px; object-fit: cover;">
                                    </c:if>

                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title">
                                            <a href="${pageContext.request.contextPath}/news/${newsItem.id}"
                                                class="text-decoration-none text-dark">
                                                ${newsItem.title}
                                            </a>
                                        </h5>

                                        <c:if test="${not empty newsItem.content}">
                                            <p class="card-text news-excerpt text-muted">
                                                ${newsItem.content}
                                            </p>
                                        </c:if>

                                        <div class="mt-auto">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <small class="text-muted">
                                                    <i class="fas fa-user"></i> ${newsItem.authorName}
                                                </small>
                                                <small class="text-muted">
                                                    <i class="fas fa-eye"></i> ${newsItem.viewCount}
                                                </small>
                                            </div>
                                            <small class="text-muted">
                                                <i class="fas fa-calendar"></i>
                                                <fmt:formatDate value="${newsItem.postedDate}"
                                                    pattern="dd/MM/yyyy HH:mm" />
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- No News Message -->
                    <c:if test="${empty categoryNews}">
                        <div class="text-center py-5">
                            <i class="fas fa-newspaper fa-3x text-muted mb-3"></i>
                            <h4 class="text-muted">Chưa có tin tức nào trong chuyên mục này</h4>
                            <p class="text-muted">Vui lòng quay lại sau hoặc xem các chuyên mục khác.</p>
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-danger">
                                <i class="fas fa-home"></i> Về trang chủ
                            </a>
                        </div>
                    </c:if>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <nav aria-label="Page navigation" class="mt-4">
                            <ul class="pagination justify-content-center">
                                <!-- Previous Page -->
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage - 1}">
                                            <i class="fas fa-chevron-left"></i> Trước
                                        </a>
                                    </li>
                                </c:if>

                                <!-- Page Numbers -->
                                <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                    <c:choose>
                                        <c:when test="${pageNum == currentPage}">
                                            <li class="page-item active">
                                                <span class="page-link">${pageNum}</span>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${pageNum}">${pageNum}</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>

                                <!-- Next Page -->
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage + 1}">
                                            Sau <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </c:if>
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