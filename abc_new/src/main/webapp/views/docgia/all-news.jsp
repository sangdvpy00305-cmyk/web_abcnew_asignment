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
                <title><fmt:message key="menu.all.news" /> - <fmt:message key="app.title" /></title>
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
                <%@ include file="components/navigation.jsp" %>

                <!-- Header Section -->
                <section class="hero-section text-white py-4">
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="col-lg-8">
                                <h1 class="h2 fw-bold mb-2">Tất cả tin tức</h1>
                                <p class="mb-0">Tổng hợp ${totalNews} tin tức mới nhất từ ABC News</p>
                            </div>
                            <div class="col-lg-4 text-center">
                                <i class="fas fa-list fa-3x opacity-75"></i>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Main Content -->
                <div class="container my-5">
                    <!-- Breadcrumb -->
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                Tất cả tin tức
                            </li>
                        </ol>
                    </nav>

                    <!-- News Grid -->
                    <c:choose>
                        <c:when test="${not empty allNews}">
                            <div class="row">
                                <c:forEach var="news" items="${allNews}">
                                    <div class="col-md-6 col-lg-4 mb-4">
                                        <div class="card news-card shadow-sm h-100">
                                            <c:if test="${not empty news.image}">
                                                <img src="${pageContext.request.contextPath}${news.image}"
                                                    class="card-img-top" alt="${news.title}"
                                                    style="height: 200px; object-fit: cover;">
                                            </c:if>

                                            <div class="card-body d-flex flex-column">
                                                <h5 class="card-title">
                                                    <a href="${pageContext.request.contextPath}/news/${news.id}"
                                                        class="text-decoration-none text-dark">
                                                        ${news.title}
                                                    </a>
                                                </h5>

                                                <c:if test="${not empty news.summary}">
                                                    <p class="card-text news-excerpt text-muted flex-grow-1">
                                                        ${news.summary}
                                                    </p>
                                                </c:if>

                                                <div class="mt-auto">
                                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                                        <small class="text-muted">
                                                            <i class="fas fa-user"></i> ${news.authorName}
                                                        </small>
                                                        <small class="text-muted">
                                                            <i class="fas fa-eye"></i> ${news.viewCount}
                                                        </small>
                                                    </div>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <small class="text-muted">
                                                            <i class="fas fa-calendar"></i>
                                                            <fmt:formatDate value="${news.postedDate}"
                                                                pattern="dd/MM/yyyy" />
                                                        </small>
                                                        <span class="badge bg-danger">
                                                            <i class="fas fa-tag"></i> ${news.categoryName}
                                                        </span>
                                                    </div>
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
                                <h4 class="text-muted">Chưa có tin tức nào</h4>
                                <p class="text-muted">Hiện tại chưa có tin tức nào được đăng tải.</p>
                                <a href="${pageContext.request.contextPath}/home" class="btn btn-danger mt-3">
                                    <i class="fas fa-home"></i> Về trang chủ
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <nav aria-label="Page navigation" class="mt-5">
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

                    <!-- Statistics -->
                    <c:if test="${not empty allNews}">
                        <div class="card mt-4 bg-light">
                            <div class="card-body text-center">
                                <div class="row">
                                    <div class="col-md-4">
                                        <h5 class="text-danger">${totalNews}</h5>
                                        <small class="text-muted">Tổng số tin tức</small>
                                    </div>
                                    <div class="col-md-4">
                                        <h5 class="text-danger">${currentPage}</h5>
                                        <small class="text-muted">Trang hiện tại</small>
                                    </div>
                                    <div class="col-md-4">
                                        <h5 class="text-danger">${totalPages}</h5>
                                        <small class="text-muted">Tổng số trang</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
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