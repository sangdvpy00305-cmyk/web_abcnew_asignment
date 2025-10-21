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
        .news-card { transition: transform 0.2s; }
        .news-card:hover { transform: translateY(-2px); }
        .news-excerpt { display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; }
        .breadcrumb-item a { text-decoration: none; }
        .search-highlight { background-color: yellow; font-weight: bold; }
        .search-form { background: linear-gradient(135deg, #c41e3a, #a01729) !important; }
        .btn-outline-danger { color: #c41e3a !important; border-color: #c41e3a !important; }
        .btn-outline-danger:hover { background-color: #c41e3a !important; border-color: #c41e3a !important; }
        .bg-danger { background-color: #c41e3a !important; }
        .btn-danger { background-color: #c41e3a !important; border-color: #c41e3a !important; }
        .btn-danger:hover { background-color: #a01729 !important; border-color: #a01729 !important; }
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
                    <c:forEach var="category" items="${categories}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/category/${category.id}">
                                ${category.name}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
                
                <!-- Search Form in Navbar -->
                <form class="d-flex me-3" action="${pageContext.request.contextPath}/search" method="get">
                    <input class="form-control me-2" type="search" name="q" 
                           placeholder="Tìm kiếm tin tức..." value="${searchKeyword}" required>
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

    <!-- Search Header -->
    <section class="search-form text-white py-4">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h1 class="h3 mb-2">
                        <i class="fas fa-search"></i> Kết quả tìm kiếm
                    </h1>
                    <p class="mb-0">
                        Tìm thấy <strong>${totalNews}</strong> kết quả cho từ khóa: 
                        <strong>"${searchKeyword}"</strong>
                    </p>
                </div>
                <div class="col-lg-4">
                    <!-- Advanced Search Form -->
                    <form action="${pageContext.request.contextPath}/search" method="get" class="mt-3 mt-lg-0">
                        <div class="input-group">
                            <input type="text" class="form-control" name="q" 
                                   placeholder="Tìm kiếm khác..." value="${searchKeyword}">
                            <button class="btn btn-light" type="submit">
                                <i class="fas fa-search"></i> Tìm
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container mt-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                    Tìm kiếm: ${searchKeyword}
                </li>
            </ol>
        </nav>

        <!-- Search Results -->
        <div class="row">
            <c:forEach var="newsItem" items="${searchResults}">
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
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <small class="text-muted">
                                        <i class="fas fa-user"></i> ${newsItem.authorName}
                                    </small>
                                    <small class="text-muted">
                                        <i class="fas fa-eye"></i> ${newsItem.viewCount}
                                    </small>
                                </div>
                                <div class="d-flex justify-content-between align-items-center">
                                    <small class="text-muted">
                                        <i class="fas fa-calendar"></i>
                                        <fmt:formatDate value="${newsItem.postedDate}" pattern="dd/MM/yyyy"/>
                                    </small>
                                    <span class="badge bg-danger">
                                        <i class="fas fa-tag"></i> ${newsItem.categoryName}
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- No Results Message -->
        <c:if test="${empty searchResults}">
            <div class="text-center py-5">
                <i class="fas fa-search fa-3x text-muted mb-3"></i>
                <h4 class="text-muted">Không tìm thấy kết quả nào</h4>
                <p class="text-muted">
                    Không có tin tức nào phù hợp với từ khóa "<strong>${searchKeyword}</strong>".
                </p>
                <div class="mt-4">
                    <h6>Gợi ý:</h6>
                    <ul class="list-unstyled text-muted">
                        <li>• Kiểm tra lại chính tả từ khóa</li>
                        <li>• Thử sử dụng từ khóa khác</li>
                        <li>• Sử dụng từ khóa ngắn gọn hơn</li>
                    </ul>
                </div>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-danger mt-3">
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
                            <a class="page-link" href="?q=${searchKeyword}&page=${currentPage - 1}">
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
                                    <a class="page-link" href="?q=${searchKeyword}&page=${pageNum}">${pageNum}</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    
                    <!-- Next Page -->
                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="?q=${searchKeyword}&page=${currentPage + 1}">
                                Sau <i class="fas fa-chevron-right"></i>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </c:if>

        <!-- Search Tips -->
        <c:if test="${not empty searchResults}">
            <div class="card mt-4 bg-light">
                <div class="card-body">
                    <h6 class="card-title">
                        <i class="fas fa-lightbulb text-warning"></i> Mẹo tìm kiếm
                    </h6>
                    <div class="row">
                        <div class="col-md-6">
                            <ul class="list-unstyled mb-0 small text-muted">
                                <li>• Sử dụng từ khóa cụ thể để có kết quả chính xác hơn</li>
                                <li>• Thử tìm kiếm với các từ đồng nghĩa</li>
                            </ul>
                        </div>
                        <div class="col-md-6">
                            <ul class="list-unstyled mb-0 small text-muted">
                                <li>• Tìm kiếm theo tên tác giả hoặc chuyên mục</li>
                                <li>• Sử dụng dấu ngoặc kép cho cụm từ chính xác</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
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