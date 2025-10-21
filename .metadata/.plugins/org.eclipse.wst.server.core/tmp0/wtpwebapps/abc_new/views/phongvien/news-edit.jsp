<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa tin tức - ABC News Reporter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h4><i class="fas fa-edit"></i> Sửa tin tức</h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>
                        
                        <form action="${pageContext.request.contextPath}/reporter/news/edit/${news.id}" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label for="title" class="form-label">Tiêu đề *</label>
                                <input type="text" class="form-control" id="title" name="title" value="${news.title}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="summary" class="form-label">Tóm tắt</label>
                                <textarea class="form-control" id="summary" name="summary" rows="3">${news.summary}</textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label for="content" class="form-label">Nội dung *</label>
                                <textarea class="form-control" id="content" name="content" rows="10" required>${news.content}</textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label for="categoryId" class="form-label">Danh mục *</label>
                                <select class="form-select" id="categoryId" name="categoryId" required>
                                    <option value="">Chọn danh mục</option>
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.id}" ${news.categoryId == category.id ? 'selected' : ''}>
                                            ${category.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="imageFile" class="form-label">Hình ảnh</label>
                                <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*" onchange="previewImage(this)">
                                <c:if test="${not empty news.image}">
                                    <div class="mt-2">
                                        <img src="${pageContext.request.contextPath}${news.image}" alt="Current image" class="img-thumbnail" style="max-width: 200px;">
                                        <p class="text-muted">Ảnh hiện tại</p>
                                    </div>
                                </c:if>
                                <img id="imagePreview" class="img-thumbnail mt-2" style="max-width: 200px; display: none;" alt="Preview">
                            </div>
                            
                            <div class="mb-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="requestPublish" name="requestPublish" value="1">
                                    <label class="form-check-label" for="requestPublish">
                                        Gửi duyệt ngay
                                    </label>
                                </div>
                            </div>
                            
                            <div class="d-flex gap-2">
                                <button type="submit" name="action" value="draft" class="btn btn-secondary">
                                    <i class="fas fa-save"></i> Lưu bản nháp
                                </button>
                                <button type="submit" name="action" value="submit" class="btn btn-primary">
                                    <i class="fas fa-paper-plane"></i> Cập nhật & Gửi duyệt
                                </button>
                                <a href="${pageContext.request.contextPath}/reporter/news" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left"></i> Quay lại
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function previewImage(input) {
            const preview = document.getElementById('imagePreview');
            
            if (input.files && input.files[0]) {
                const file = input.files[0];
                
                // Validate file type
                if (!file.type.startsWith('image/')) {
                    alert('Vui lòng chọn file ảnh (JPG, PNG, GIF)!');
                    input.value = '';
                    return;
                }
                
                // Validate file size (5MB)
                if (file.size > 5 * 1024 * 1024) {
                    alert('File quá lớn! Kích thước tối đa cho phép là 5MB.');
                    input.value = '';
                    return;
                }
                
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                };
                reader.readAsDataURL(file);
            } else {
                preview.style.display = 'none';
            }
        }
    </script>
</body>
</html>