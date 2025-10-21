# Tài liệu Thiết kế - Website Tin tức ABC News

## Tổng quan

Website ABC News được thiết kế theo kiến trúc MVC với giao diện hiện đại như VnExpress.net, hỗ trợ 3 loại người dùng: đọc giả, phóng viên và quản trị viên. Hệ thống sử dụng Java Web (JSP/Servlet), SQL Server và các công nghệ frontend hiện đại.

## Kiến trúc Hệ thống

### Kiến trúc Tổng thể
```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Presentation  │    │    Business     │    │      Data       │
│     Layer       │    │     Layer       │    │     Layer       │
├─────────────────┤    ├─────────────────┤    ├─────────────────┤
│ • JSP Views     │◄──►│ • Servlets      │◄──►│ • SQL Server    │
│ • CSS/JS        │    │ • JavaBeans     │    │ • JDBC          │
│ • JSTL Tags     │    │ • Business Logic│    │ • Connection    │
│ • Bootstrap     │    │ • Validation    │    │   Pool          │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### Cấu trúc Thư mục
```
abc_new/
├── src/main/
│   ├── java/com/abcnews/
│   │   ├── controller/          # Servlets
│   │   ├── model/              # JavaBeans
│   │   ├── dao/                # Data Access Objects
│   │   ├── service/            # Business Logic
│   │   └── util/               # Utilities
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── web.xml
│       │   └── lib/
│       ├── assets/
│       │   ├── css/
│       │   ├── js/
│       │   └── images/
│       ├── views/
│       │   ├── docgia/         # Reader views
│       │   ├── phongvien/      # Reporter views
│       │   └── admin/          # Admin views
│       └── login.jsp
```

## Thành phần và Giao diện

### 1. Giao diện Đọc giả (Public)

#### Layout Chính
- **Header**: Logo + Menu mega dropdown + Search + Dark/Light toggle
- **Hero Section**: Slider tin nổi bật với overlay text
- **Content Grid**: Card layout 3 cột responsive
- **Sidebar**: Newsletter signup + Tin xem nhiều + Quảng cáo
- **Footer**: Links + Social media + Copyright

#### Các trang chính
- `home.jsp`: Trang chủ với hero slider và grid tin tức
- `news-detail.jsp`: Chi tiết tin với reading progress bar
- `category-news.jsp`: Danh sách tin theo chuyên mục
- `search-results.jsp`: Kết quả tìm kiếm với highlight

### 2. Giao diện Phóng viên (Reporter Dashboard)

#### Layout Dashboard
- **Sidebar**: Menu collapse với icon + text
- **Header**: Breadcrumb + User dropdown + Notifications
- **Main Content**: Widgets + Tables + Forms

#### Các trang chính
- `dashboard.jsp`: Thống kê với Chart.js
- `my-news.jsp`: DataTable quản lý bài viết
- `news-form.jsp`: WYSIWYG editor với drag & drop

### 3. Giao diện Quản trị viên (Admin Panel)

#### Layout Admin
- **Sidebar**: Menu tree với active states
- **Header**: Breadcrumb + Quick actions + Profile
- **Dashboard**: Cards thống kê + Charts + Recent activities

#### Các trang chính
- `dashboard.jsp`: Overview với widgets và biểu đồ
- `users-management.jsp`: CRUD users với DataTable
- `news-management.jsp`: Quản lý tất cả tin tức
- `categories-management.jsp`: Drag & drop categories

### 4. Trang Đăng nhập

#### Thiết kế
- **Background**: Gradient với animation
- **Form**: Floating labels + Icon prefix + Validation
- **Features**: Social login + Remember me + 2FA
- **Responsive**: Mobile-optimized với touch support

## Mô hình Dữ liệu

### Cơ sở dữ liệu SQL Server

#### Bảng USERS
```sql
CREATE TABLE USERS (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) UNIQUE NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    Fullname NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Role INT NOT NULL, -- 0: Phóng viên, 1: Admin
    Avatar NVARCHAR(255),
    CreatedDate DATETIME DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1
);
```

#### Bảng CATEGORIES
```sql
CREATE TABLE CATEGORIES (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Slug NVARCHAR(100) UNIQUE NOT NULL,
    Description NVARCHAR(500),
    SortOrder INT DEFAULT 0,
    IsActive BIT DEFAULT 1
);
```

#### Bảng NEWS
```sql
CREATE TABLE NEWS (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(255) NOT NULL,
    Slug NVARCHAR(255) UNIQUE NOT NULL,
    Summary NVARCHAR(500),
    Content NTEXT NOT NULL,
    Image NVARCHAR(255),
    CategoryId INT FOREIGN KEY REFERENCES CATEGORIES(Id),
    Author INT FOREIGN KEY REFERENCES USERS(Id),
    ViewCount INT DEFAULT 0,
    Home BIT DEFAULT 0, -- Tin nổi bật
    PostedDate DATETIME DEFAULT GETDATE(),
    IsPublished BIT DEFAULT 1
);
```

#### Bảng NEWSLETTERS
```sql
CREATE TABLE NEWSLETTERS (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    SubscribedDate DATETIME DEFAULT GETDATE(),
    Enabled BIT DEFAULT 1
);
```

### JavaBeans Models

#### User.java
```java
public class User {
    private int id;
    private String username;
    private String password;
    private String fullname;
    private String email;
    private int role;
    private String avatar;
    private Date createdDate;
    private boolean isActive;
    
    // Constructors, getters, setters
}
```

#### News.java
```java
public class News {
    private int id;
    private String title;
    private String slug;
    private String summary;
    private String content;
    private String image;
    private int categoryId;
    private int author;
    private int viewCount;
    private boolean home;
    private Date postedDate;
    private boolean isPublished;
    
    // Constructors, getters, setters
}
```

## Xử lý Lỗi

### Chiến lược Xử lý Lỗi
1. **Validation**: Client-side với JavaScript + Server-side với Java
2. **Error Pages**: Custom 404, 500 error pages
3. **Logging**: Log4j để ghi lại lỗi hệ thống
4. **User Feedback**: Toast notifications cho success/error messages

### Error Handling Flow
```
User Input → Client Validation → Server Validation → Business Logic → Database
     ↓              ↓                    ↓                ↓            ↓
Error Display ← Error Response ← Exception Handling ← Service Layer ← DAO Layer
```

## Chiến lược Testing

### Unit Testing
- **JUnit**: Test các method trong Service và DAO layers
- **Mockito**: Mock database connections và external services
- **Coverage**: Minimum 80% code coverage

### Integration Testing
- **Servlet Testing**: Test các controller endpoints
- **Database Testing**: Test CRUD operations với test database
- **UI Testing**: Selenium cho automated browser testing

### Performance Testing
- **Load Testing**: JMeter cho test tải
- **Database Performance**: Query optimization và indexing
- **Frontend Performance**: Lighthouse audit cho web vitals

## Công nghệ và Framework

### Backend
- **Java 21**: Core language
- **Jakarta Servlet 6.0**: Web framework
- **JSP 3.1 + JSTL 3.0**: View layer
- **SQL Server**: Database
- **JDBC**: Database connectivity
- **Jakarta Mail**: Email functionality

### Frontend
- **Bootstrap 5**: CSS framework
- **jQuery 3.7**: JavaScript library
- **Chart.js**: Data visualization
- **Font Awesome**: Icons
- **TinyMCE**: WYSIWYG editor
- **DataTables**: Advanced table features

### Build Tools
- **Maven**: Dependency management và build
- **Tomcat 10**: Application server
- **Git**: Version control

## Bảo mật

### Authentication & Authorization
- **Session Management**: HttpSession cho user state
- **Password Hashing**: BCrypt cho mã hóa password
- **Role-based Access**: Filter để kiểm tra quyền truy cập
- **CSRF Protection**: Token validation cho forms

### Data Security
- **SQL Injection Prevention**: PreparedStatement
- **XSS Protection**: Input sanitization và output encoding
- **File Upload Security**: File type validation và virus scanning
- **HTTPS**: SSL/TLS encryption cho production

## Deployment và Monitoring

### Deployment Strategy
- **Environment**: Development → Staging → Production
- **Database Migration**: SQL scripts cho schema changes
- **Configuration**: Properties files cho different environments
- **Backup**: Automated database backup schedule

### Monitoring
- **Application Logs**: Log4j với different log levels
- **Performance Monitoring**: JVM metrics và database performance
- **Error Tracking**: Centralized error logging và alerting
- **User Analytics**: Google Analytics integration