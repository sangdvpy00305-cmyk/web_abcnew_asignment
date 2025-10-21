# Package Docgia - ABC News

## Cập nhật Jakarta 6 và CSS riêng

### Thay đổi chính:

#### 1. Jakarta Tags (thay vì JSTL cũ)
- **Trước**: `<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>`
- **Sau**: `<%@ taglib prefix="c" uri="jakarta.tags.core" %>`
- **Trước**: `<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>`
- **Sau**: `<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>`

#### 2. CSS riêng cho package docgia
- **File CSS mới**: `/assets/css/docgia.css`
- **Áp dụng cho**: Tất cả JSP trong `/views/docgia/`
- **Tính năng**: 
  - Responsive design
  - Modern UI/UX
  - Tối ưu cho đọc tin tức
  - Animation và hover effects

#### 3. Cấu trúc thư mục được tổ chức lại:
```
abc_new/
├── src/main/webapp/
│   ├── assets/
│   │   └── css/
│   │       └── docgia.css (CSS riêng cho docgia)
│   ├── css/
│   │   └── style.css (CSS chung, import docgia.css)
│   ├── views/
│   │   └── docgia/
│   │       ├── index.jsp (Trang chủ)
│   │       ├── category.jsp (Danh mục)
│   │       ├── detail.jsp (Chi tiết bài viết)
│   │       └── newsletter.jsp (Đăng ký newsletter)
│   └── login.jsp
```

#### 4. Liên kết được sửa đổi:
- **Login → Docgia**: `${pageContext.request.contextPath}/views/docgia/index.jsp`
- **Docgia → Login**: `${pageContext.request.contextPath}/login.jsp`
- **CSS paths**: Sử dụng `${pageContext.request.contextPath}/assets/css/docgia.css`

#### 5. Tính năng CSS mới:
- **Header**: Gradient background, responsive search
- **Navigation**: Hover effects, active states
- **Articles**: Card layout, hover animations
- **Sidebar**: Modern widgets, statistics
- **Footer**: Grid layout, social links
- **Mobile**: Fully responsive design

### Kiểm tra hoạt động:

1. **Jakarta 6**: Đã cập nhật trong pom.xml
2. **JSTL Tags**: Đã chuyển sang Jakarta tags
3. **CSS**: Tách riêng và tối ưu cho docgia
4. **Links**: Đã sửa tất cả đường dẫn tương đối

### Lưu ý:
- File `css/style.css` vẫn tồn tại để tương thích ngược
- Các package khác (admin, phongvien) có thể tạo CSS riêng tương tự
- Jakarta 6 đã được cấu hình sẵn trong pom.xml

### Các lỗi đã sửa:

#### 1. Liên kết giữa login và docgia:
- ✅ **Login → Docgia**: `${pageContext.request.contextPath}/views/docgia/index.jsp`
- ✅ **Docgia → Login**: `${pageContext.request.contextPath}/login.jsp`

#### 2. Đường dẫn CSS và favicon:
- ✅ **CSS**: `${pageContext.request.contextPath}/assets/css/docgia.css`
- ✅ **Favicon**: `${pageContext.request.contextPath}/images/favicon.ico`

#### 3. Navigation links:
- ✅ **Trang chủ**: `${pageContext.request.contextPath}/views/docgia/index.jsp`
- ✅ **Category**: `${pageContext.request.contextPath}/views/docgia/category.jsp?id=X`
- ✅ **Newsletter**: `${pageContext.request.contextPath}/views/docgia/newsletter.jsp`

#### 4. Jakarta Tags:
- ✅ **Core**: `jakarta.tags.core`
- ✅ **Fmt**: `jakarta.tags.fmt`

### Test:
1. Truy cập `/login.jsp` → Click "Quay về trang chủ ABC News"
2. Truy cập `/views/docgia/index.jsp` → Click "Đăng nhập"
3. Test navigation: Trang chủ, Category, Newsletter
4. Kiểm tra responsive trên mobile
5. Kiểm tra các animation và hover effects

### Lưu ý quan trọng:
- Tất cả đường dẫn đã sử dụng `${pageContext.request.contextPath}` để đảm bảo hoạt động đúng
- CSS riêng cho docgia đã được tách ra hoàn toàn
- Jakarta 6 tags đã được cập nhật đầy đủ