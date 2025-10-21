# Tài liệu Yêu cầu - Website Tin tức ABC News

## Giới thiệu

Dự án xây dựng website tin tức ABC News là một hệ thống quản lý và hiển thị tin tức trực tuyến phục vụ 3 đối tượng người dùng chính: đọc giả, phóng viên và quản trị viên. Hệ thống được phát triển bằng Java Web với kiến trúc MVC, sử dụng JSP/Servlet và cơ sở dữ liệu SQL Server.

## Yêu cầu

### Yêu cầu 1: Giao diện và Chức năng cho Đọc giả

**User Story:** Là một đọc giả, tôi muốn có giao diện website tin tức hiện đại, thân thiện và dễ sử dụng như VnExpress.net, với khả năng tương tác và cá nhân hóa nội dung, để có trải nghiệm đọc tin tức tốt nhất.

#### Tiêu chí chấp nhận

1. KHI truy cập trang chủ THÌ hệ thống SẼ hiển thị header sticky với logo, menu mega dropdown, search box có autocomplete và dark/light mode toggle
2. KHI hiển thị tin nổi bật THÌ hệ thống SẼ có hero slider với ảnh full-width, overlay text, dots navigation và auto-play
3. KHI hiển thị danh sách tin THÌ hệ thống SẼ có card layout với ảnh, tiêu đề, excerpt, author avatar, publish time và social share buttons
4. KHI tìm kiếm THÌ hệ thống SẼ có instant search với dropdown suggestions, filter options và search history
5. KHI xem chi tiết tin THÌ hệ thống SẼ có reading progress bar, estimated reading time, font size adjuster và print/save options
6. KHI cuộn trang THÌ hệ thống SẼ có infinite scroll hoặc pagination, back-to-top button và related articles sidebar
7. KHI tương tác THÌ hệ thống SẼ có like/dislike buttons, comment system và social media sharing
8. KHI responsive THÌ giao diện SẼ có mobile-first design, swipe gestures, touch-friendly buttons và AMP support

### Yêu cầu 2: Giao diện và Chức năng cho Phóng viên

**User Story:** Là một phóng viên, tôi muốn có giao diện quản lý hiện đại và trực quan để quản lý các bài viết của mình một cách hiệu quả, với dashboard thống kê và editor WYSIWYG chuyên nghiệp.

#### Tiêu chí chấp nhận

1. KHI phóng viên đăng nhập với Role = 0 THÌ hệ thống SẼ chuyển đến dashboard phóng viên với sidebar menu và header có avatar + dropdown
2. KHI hiển thị dashboard THÌ hệ thống SẼ có các widget: tổng số bài viết, lượt xem, bài viết tuần này, và biểu đồ thống kê
3. KHI tạo/sửa tin THÌ hệ thống SẼ có editor WYSIWYG với toolbar: bold, italic, link, ảnh, video, table và preview
4. KHI quản lý bài viết THÌ hệ thống SẼ có bảng danh sách với filter, search, sort và pagination hiện đại
5. KHI upload ảnh THÌ hệ thống SẼ có drag & drop, preview thumbnail và progress bar
6. KHI lưu bài viết THÌ hệ thống SẼ có auto-save, validation form và thông báo toast
7. KHI xem thống kê THÌ hệ thống SẼ có biểu đồ lượt xem theo ngày/tuần/tháng với Chart.js
8. KHI responsive THÌ giao diện SẼ có sidebar collapse, table responsive và touch-friendly controls

### Yêu cầu 3: Giao diện và Chức năng cho Quản trị viên

**User Story:** Là một quản trị viên, tôi muốn có giao diện admin panel hiện đại với dashboard tổng quan và các module quản lý đầy đủ, để có thể giám sát và điều hành toàn bộ hệ thống một cách hiệu quả.

#### Tiêu chí chấp nhận

1. KHI quản trị viên đăng nhập với Role = 1 THÌ hệ thống SẼ hiển thị admin dashboard với sidebar menu, header breadcrumb và main content area
2. KHI hiển thị dashboard THÌ hệ thống SẼ có các card thống kê: tổng users, tổng bài viết, lượt xem hôm nay, newsletter subscribers với icon và màu sắc
3. KHI hiển thị biểu đồ THÌ hệ thống SẼ có chart lượt truy cập theo ngày, top bài viết xem nhiều và phân bố theo chuyên mục
4. KHI quản lý users THÌ hệ thống SẼ có DataTable với search, filter theo role, sort, export Excel và modal form thêm/sửa
5. KHI quản lý categories THÌ hệ thống SẼ có drag & drop để sắp xếp thứ tự, toggle active/inactive và bulk actions
6. KHI quản lý tin tức THÌ hệ thống SẼ có filter theo status (draft/published), author, category và date range picker
7. KHI quản lý newsletter THÌ hệ thống SẼ có bulk email sender, template editor và tracking statistics
8. KHI hiển thị sidebar THÌ hệ thống SẼ có menu collapse/expand, active state highlighting và user profile dropdown
9. KHI responsive THÌ giao diện SẼ có mobile-first design với hamburger menu và touch-optimized controls

### Yêu cầu 4: Giao diện và Layout theo mô hình VnExpress.net

**User Story:** Là một đọc giả, tôi muốn có giao diện website tin tức hiện đại giống VnExpress.net với layout chuyên nghiệp và trải nghiệm người dùng tối ưu, để có thể dễ dàng tiếp cận thông tin một cách nhanh chóng và tiện lợi.

#### Tiêu chí chấp nhận

1. KHI truy cập trang chủ THÌ hệ thống SẼ hiển thị header cố định với logo ABC News bên trái, menu ngang các chuyên mục chính, ô tìm kiếm và nút đăng nhập bên phải
2. KHI hiển thị trang chủ THÌ hệ thống SẼ có layout 3 cột: tin nổi bật chính ở giữa (60%), sidebar tin phụ bên phải (25%), và menu chuyên mục dọc bên trái (15%)
3. KHI hiển thị tin nổi bật THÌ hệ thống SẼ có ảnh lớn (400x250px), tiêu đề lớn, tóm tắt và thời gian đăng, với hiệu ứng hover
4. KHI hiển thị danh sách tin THÌ hệ thống SẼ có ảnh thumbnail (150x100px), tiêu đề, tóm tắt 2-3 dòng, thời gian và số lượt xem
5. KHI hiển thị menu chuyên mục THÌ hệ thống SẼ có các mục: Thời sự, Thế giới, Kinh doanh, Giải trí, Thể thao, Pháp luật, Giáo dục, Sức khỏe, Đời sống, Du lịch, Khoa học, Số hóa, Xe, Ý kiến
6. KHI hiển thị sidebar THÌ hệ thống SẼ có: tin xem nhiều nhất (top 10), tin mới nhất, form đăng ký newsletter, và khu vực quảng cáo
7. KHI hiển thị trang chi tiết tin THÌ hệ thống SẼ có breadcrumb, tiêu đề lớn, thông tin tác giả/thời gian/lượt xem, nội dung với ảnh minh họa, và sidebar tin liên quan
8. KHI hiển thị footer THÌ hệ thống SẼ có thông tin liên hệ, bản quyền, các liên kết mạng xã hội và sitemap
9. KHI responsive mobile THÌ hệ thống SẼ có menu hamburger, layout 1 cột, ảnh thu nhỏ, và navigation touch-friendly
10. KHI tải trang THÌ hệ thống SẼ có loading animation và lazy loading cho ảnh để tối ưu tốc độ

### Yêu cầu 5: Xử lý dữ liệu và bảo mật

**User Story:** Là người phát triển, tôi muốn hệ thống xử lý dữ liệu an toàn và hiệu quả, để đảm bảo tính toàn vẹn dữ liệu.

#### Tiêu chí chấp nhận

1. KHI người dùng gửi form THÌ hệ thống SẼ xử lý qua phương thức GET hoặc POST tương ứng
2. KHI người dùng đăng nhập THÌ hệ thống SẼ tạo session để lưu trạng thái đăng nhập
3. KHI xử lý dữ liệu THÌ hệ thống SẼ sử dụng BeanUtil để quản lý dữ liệu
4. KHI kết nối database THÌ hệ thống SẼ sử dụng JDBC để tương tác với SQL Server
5. KHI có lỗi xảy ra THÌ hệ thống SẼ hiển thị thông báo lỗi phù hợp cho người dùng

### Yêu cầu 6: Tính năng Email và Thống kê

**User Story:** Là quản trị viên, tôi muốn hệ thống tự động gửi email và theo dõi thống kê, để nâng cao hiệu quả vận hành.

#### Tiêu chí chấp nhận

1. KHI có tin mới được đăng THÌ hệ thống SẼ gửi email thông báo đến danh sách newsletter
2. KHI đọc giả xem tin THÌ hệ thống SẼ tăng ViewCount của tin đó lên 1
3. KHI hiển thị tin THÌ hệ thống SẼ hiển thị số lượt xem
4. KHI gửi email THÌ hệ thống SẼ sử dụng thông tin cấu hình email từ ứng dụng
5. NẾU email trong newsletter có Enabled = 0 THÌ hệ thống SẼ KHÔNG gửi email đến địa chỉ đó

### Yêu cầu 7: Kiến trúc MVC và Công nghệ

**User Story:** Là nhà phát triển, tôi muốn hệ thống được xây dựng theo mô hình MVC với JSP, JSTL và Servlets, để đảm bảo code có cấu trúc rõ ràng và dễ bảo trì.

#### Tiêu chí chấp nhận

1. KHI xây dựng ứng dụng THÌ hệ thống SẼ tuân theo mô hình MVC với Model (JavaBean), View (JSP), Controller (Servlet)
2. KHI tạo giao diện THÌ hệ thống SẼ sử dụng JSP để tạo các trang động với khả năng nhúng Java code
3. KHI hiển thị dữ liệu THÌ hệ thống SẼ sử dụng JSTL (core, fmt, functions) để giảm thiểu scriptlet Java trong JSP
4. KHI xử lý request THÌ hệ thống SẼ sử dụng Servlet để điều hướng và xử lý logic nghiệp vụ
5. KHI xử lý form THÌ hệ thống SẼ hỗ trợ cả phương thức GET và POST
6. KHI quản lý dữ liệu THÌ hệ thống SẼ sử dụng BeanUtil để binding dữ liệu từ request vào JavaBean
7. KHI triển khai THÌ hệ thống SẼ được đóng gói thành file WAR và deploy trên Tomcat server

### Yêu cầu 8: Tính năng nâng cao theo VnExpress.net

**User Story:** Là người dùng, tôi muốn có các tính năng hiện đại như VnExpress.net bao gồm tương tác, chia sẻ và cá nhân hóa nội dung, để có trải nghiệm đọc tin tức phong phú và hấp dẫn.

#### Tiêu chí chấp nhận

1. KHI đọc tin THÌ hệ thống SẼ có nút chia sẻ lên Facebook, Twitter, Zalo và copy link
2. KHI hiển thị tin THÌ hệ thống SẼ có chức năng in bài viết và lưu bookmark
3. KHI cuộn trang THÌ hệ thống SẼ có nút "Lên đầu trang" và thanh tiến trình đọc
4. KHI xem tin THÌ hệ thống SẼ gợi ý "Tin liên quan" dựa trên cùng chuyên mục
5. KHI tìm kiếm THÌ hệ thống SẼ có gợi ý từ khóa và lọc theo thời gian, chuyên mục
6. KHI hiển thị ảnh THÌ hệ thống SẼ có chức năng phóng to ảnh (lightbox) và slideshow
7. KHI load trang THÌ hệ thống SẼ có breadcrumb navigation và sitemap XML
8. KHI truy cập mobile THÌ hệ thống SẼ có swipe gesture cho slideshow và pull-to-refresh

### Yêu cầu 9: Giao diện Đăng nhập và Xác thực

**User Story:** Là người dùng, tôi muốn có trang đăng nhập hiện đại, bảo mật và thân thiện với người dùng, với các tùy chọn đăng nhập linh hoạt và giao diện đẹp mắt.

#### Tiêu chí chấp nhận

1. KHI truy cập trang đăng nhập THÌ hệ thống SẼ hiển thị form đăng nhập với background gradient, logo ABC News và animation loading
2. KHI hiển thị form THÌ hệ thống SẼ có input fields với floating labels, icon prefix, validation real-time và password strength indicator
3. KHI đăng nhập THÌ hệ thống SẼ có checkbox "Remember me", forgot password link và social login options (Facebook, Google)
4. KHI validation THÌ hệ thống SẼ hiển thị error messages inline, success notifications và loading spinner
5. KHI đăng nhập thành công THÌ hệ thống SẼ redirect theo role: admin → admin dashboard, phóng viên → reporter dashboard, đọc giả → homepage
6. KHI responsive THÌ trang đăng nhập SẼ có mobile-optimized layout với touch-friendly inputs và keyboard navigation
7. KHI bảo mật THÌ hệ thống SẼ có CAPTCHA sau 3 lần thất bại, session timeout và 2FA option
8. KHI hiển thị THÌ trang SẼ có dark/light theme toggle và accessibility features (screen reader support)

### Yêu cầu 10: SEO và Performance

**User Story:** Là quản trị viên, tôi muốn website được tối ưu SEO và hiệu suất như VnExpress.net, để tăng lượng truy cập và cải thiện trải nghiệm người dùng.

#### Tiêu chí chấp nhận

1. KHI tạo URL THÌ hệ thống SẼ tạo URL thân thiện SEO dạng /chuyen-muc/tieu-de-bai-viet-id.html
2. KHI hiển thị trang THÌ hệ thống SẼ có meta title, description và keywords phù hợp
3. KHI load ảnh THÌ hệ thống SẼ có alt text và lazy loading để tối ưu tốc độ
4. KHI tạo sitemap THÌ hệ thống SẼ tự động cập nhật sitemap.xml khi có tin mới
5. KHI nén tài nguyên THÌ hệ thống SẼ minify CSS/JS và nén ảnh để giảm thời gian tải
6. KHI cache THÌ hệ thống SẼ cache trang tĩnh và sử dụng CDN cho tài nguyên tĩnh