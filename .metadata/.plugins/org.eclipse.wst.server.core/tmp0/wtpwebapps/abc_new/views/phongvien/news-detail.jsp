<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết tin tức - ABC News Reporter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h4><i class="fas fa-newspaper"></i> Chi tiết tin tức</h4>
                        <div>
                            <a href="${pageContext.request.contextPath}/reporter/news/edit/${news.id}" class="btn btn-warning btn-sm">
                                <i class="fas fa-edit"></i> Sửa
                            </a>
                            <a href="${pageContext.request.contextPath}/reporter/news" class="btn btn-secondary btn-sm">
                                <i class="fas fa-arrow-left"></i> Quay lại
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <h2>${news.title}</h2>
                        
                        <div class="mb-3">
                            <small class="text-muted">
                                <i class="fas fa-user"></i> ${news.authorName} | 
                                <i class="fas fa-calendar"></i> <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy HH:mm" /> |
                                <i class="fas fa-eye"></i> ${news.viewCount} lượt xem |
                                <i class="fas fa-folder"></i> ${news.categoryName}
                            </small>
                        </div>
                        
                        <div class="mb-3">
                            <c:choose>
                                <c:when test="${news.home == 1}">
                                    <span class="badge bg-success">Đã xuất bản</span>
                                </c:when>
                                <c:when test="${news.home == 0}">
                                    <span class="badge bg-warning">Chờ duyệt</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">Bản nháp</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <c:if test="${not empty news.image}">
                            <div class="mb-3">
                                <img src="${pageContext.request.contextPath}${news.image}" alt="${news.title}" class="img-fluid rounded">
                            </div>
                        </c:if>
                        
                        <div class="content">
                            ${news.content}
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h5><i class="fas fa-info-circle"></i> Thông tin</h5>
                    </div>
                    <div class="card-body">
                        <p><strong>ID:</strong> ${news.id}</p>
                        <p><strong>Tác giả:</strong> ${news.authorName}</p>
                        <p><strong>Danh mục:</strong> ${news.categoryName}</p>
                        <p><strong>Ngày đăng:</strong> <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy HH:mm" /></p>
                        <p><strong>Lượt xem:</strong> ${news.viewCount}</p>
                        <p><strong>Trạng thái:</strong> 
                            <c:choose>
                                <c:when test="${news.home == 1}">
                                    <span class="text-success">Đã xuất bản</span>
                                </c:when>
                                <c:when test="${news.home == 0}">
                                    <span class="text-warning">Chờ duyệt</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-secondary">Bản nháp</span>
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>