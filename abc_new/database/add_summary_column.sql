-- Thêm cột Summary vào bảng NEWS
USE abc_news;
GO

ALTER TABLE NEWS ADD Summary NVARCHAR(500);
GO

-- Cập nhật dữ liệu có sẵn với summary mặc định
UPDATE NEWS SET Summary = LEFT(Content, 200) + '...' WHERE Summary IS NULL;
GO