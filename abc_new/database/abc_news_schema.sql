-- Tạo database ABC News
CREATE DATABASE abc_news;
USE abc_news;
GO

-- Bảng người dùng
CREATE TABLE USERS (
    Id VARCHAR(10) PRIMARY KEY,
    Password VARCHAR(50) NOT NULL,
    Fullname NVARCHAR(40) NOT NULL,
    Birthday DATE,
    Gender BIT NULL,
    Mobile VARCHAR(10),
    Email VARCHAR(30),
    Role BIT NULL -- TRUE 1 = quản trị, FALSE 0 = phóng viên
);
GO

-- Bảng loại tin
CREATE TABLE CATEGORIES (
    Id VARCHAR(10) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL
);
GO

-- Bảng tin tức
CREATE TABLE NEWS (
    Id VARCHAR(30) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Content NVARCHAR(MAX) NOT NULL,
    Image VARCHAR(50),
    PostedDate DATE,
    Author VARCHAR(10),
    ViewCount INT DEFAULT 0,
    CategoryId VARCHAR(10),
    Home BIT DEFAULT 0, -- FALSE → 0
    FOREIGN KEY (Author) REFERENCES USERS(Id),
    FOREIGN KEY (CategoryId) REFERENCES CATEGORIES(Id)
);
GO

-- Bảng đăng ký nhận tin
CREATE TABLE NEWSLETTERS (
    Email VARCHAR(30) PRIMARY KEY,
    Enabled BIT DEFAULT 1 -- TRUE → 1
);
GO

-- Thêm dữ liệu mẫu
INSERT INTO USERS VALUES 
('admin', '123456', N'Quản trị viên', '1990-01-01', 1, '0123456789', 'admin@abcnews.com', 1),
('reporter1', '123456', N'Phóng viên A', '1995-05-15', 0, '0987654321', 'reporter1@abcnews.com', 0),
('pv001', '123456', N'Phóng viên Nguyễn Văn A', '1992-03-15', 1, '0901234567', 'pv001@abcnews.com', 0),
('pv002', '123456', N'Phóng viên Trần Thị B', '1994-07-20', 0, '0912345678', 'pv002@abcnews.com', 0);

-- Tạo bảng NEWSLETTERS
CREATE TABLE NEWSLETTERS (
    Id NVARCHAR(50) PRIMARY KEY,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    SubscribedAt DATETIME DEFAULT GETDATE(),
    LastSentAt DATETIME NULL,
    IsActive BIT DEFAULT 1,
    Enabled BIT DEFAULT 1 -- Alias for IsActive for backward compatibility
);
GO

INSERT INTO CATEGORIES VALUES 
('CAT001', N'Thời sự'),
('CAT002', N'Thể thao'),
('CAT003', N'Giải trí'),
('CAT004', N'Công nghệ'),
('CAT005', N'Kinh tế');

-- Thêm dữ liệu tin tức mẫu
INSERT INTO NEWS (Id, Title, Content, Summary, Image, PostedDate, Author, ViewCount, CategoryId, Home) VALUES 
('NEWS001', N'Việt Nam đạt nhiều thành tựu trong phát triển kinh tế 2024', 
 N'Trong năm 2024, Việt Nam đã đạt được nhiều thành tựu quan trọng trong lĩnh vực kinh tế. GDP tăng trưởng ổn định, thu hút đầu tư nước ngoài tăng mạnh, xuất khẩu đạt kết quả tích cực. Các chuyên gia đánh giá cao những nỗ lực của Chính phủ trong việc cải thiện môi trường đầu tư và thúc đẩy phát triển kinh tế bền vững.', 
 N'Việt Nam đạt nhiều thành tựu kinh tế trong năm 2024', '/uploads/news/sample-news.jpg', '2024-10-19', 'pv001', 150, 'CAT005', 1),

('NEWS002', N'Đội tuyển bóng đá Việt Nam chuẩn bị cho vòng loại World Cup', 
 N'Đội tuyển bóng đá quốc gia Việt Nam đang tích cực chuẩn bị cho các trận đấu quan trọng trong vòng loại World Cup 2026. HLV trưởng đã công bố danh sách 25 cầu thủ được triệu tập, trong đó có nhiều gương mặt trẻ triển vọng. Người hâm mộ đang rất kỳ vọng vào thành tích của đội tuyển trong những trận đấu sắp tới.', 
 N'Đội tuyển Việt Nam chuẩn bị World Cup 2026', '/uploads/news/sample-news.jpg', '2024-10-18', 'pv002', 200, 'CAT002', 1),

('NEWS003', N'Công nghệ AI được ứng dụng rộng rãi trong giáo dục Việt Nam', 
 N'Trí tuệ nhân tạo (AI) đang được ứng dụng ngày càng rộng rãi trong lĩnh vực giáo dục tại Việt Nam. Nhiều trường học đã triển khai các giải pháp AI để hỗ trợ việc dạy và học, từ việc cá nhân hóa chương trình học đến việc đánh giá năng lực học sinh. Đây được coi là bước tiến quan trọng trong việc hiện đại hóa nền giáo dục.', 
 'news003.jpg', '2024-10-17', 'pv001', 120, 'CAT004', 0),

('NEWS004', N'Festival âm nhạc quốc tế sẽ được tổ chức tại Hà Nội', 
 N'Festival âm nhạc quốc tế lớn nhất trong năm sẽ được tổ chức tại Hà Nội vào cuối tháng 11. Sự kiện này sẽ quy tụ nhiều nghệ sĩ nổi tiếng trong và ngoài nước, hứa hẹn mang đến những màn trình diễn đặc sắc cho khán giả. Đây là cơ hội tuyệt vời để quảng bá văn hóa âm nhạc Việt Nam ra thế giới.', 
 'news004.jpg', '2024-10-16', 'pv002', 80, 'CAT003', 1),

('NEWS005', N'Chính phủ ban hành chính sách mới hỗ trợ doanh nghiệp nhỏ', 
 N'Chính phủ vừa ban hành gói chính sách mới nhằm hỗ trợ các doanh nghiệp nhỏ và vừa vượt qua khó khăn. Gói hỗ trợ bao gồm các ưu đãi về thuế, tín dụng và thủ tục hành chính. Đây được đánh giá là động thái tích cực giúp thúc đẩy phát triển kinh tế và tạo việc làm cho người lao động.', 
 'news005.jpg', '2024-10-15', 'admin', 95, 'CAT001', 0);

-- Thêm dữ liệu tin tức mẫu
INSERT INTO NEWS (Id, Title, Content, Image, PostedDate, Author, ViewCount, CategoryId, Home) VALUES 
('NEWS001', N'Việt Nam đạt nhiều 

-- Thêm dữ liệu mẫu cho NEWSLETTERS
INSERT INTO NEWSLETTERS (Id, Email, SubscribedAt, IsActive, Enabled) VALUES 
('NL001', 'user1@example.com', GETDATE(), 1, 1),
('NL002', 'user2@example.com', GETDATE(), 1, 1),
('NL003', 'user3@example.com', GETDATE(), 0, 0);
GO