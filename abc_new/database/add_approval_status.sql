-- Thêm cột trạng thái duyệt bài vào bảng NEWS
USE abc_news;
GO

-- Thêm cột ApprovalStatus
-- 0 = Chờ duyệt (Draft/Pending)
-- 1 = Đã duyệt (Approved/Published) 
-- 2 = Từ chối (Rejected)
ALTER TABLE NEWS 
ADD ApprovalStatus INT DEFAULT 1;
GO

-- Cập nhật tất cả bài cũ thành đã duyệt
UPDATE NEWS SET ApprovalStatus = 1 WHERE ApprovalStatus IS NULL;
GO

-- Thêm cột ghi chú duyệt bài (tùy chọn)
ALTER TABLE NEWS 
ADD ApprovalNote NVARCHAR(500) NULL;
GO

-- Thêm cột thời gian duyệt
ALTER TABLE NEWS 
ADD ApprovedAt DATETIME NULL;
GO

-- Thêm cột người duyệt
ALTER TABLE NEWS 
ADD ApprovedBy VARCHAR(10) NULL;
GO

-- Thêm foreign key cho ApprovedBy
ALTER TABLE NEWS 
ADD CONSTRAINT FK_NEWS_ApprovedBy 
FOREIGN KEY (ApprovedBy) REFERENCES USERS(Id);
GO

PRINT 'Đã thêm các cột trạng thái duyệt bài thành công!';