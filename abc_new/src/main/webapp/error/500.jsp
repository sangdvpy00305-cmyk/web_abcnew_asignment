<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - Lỗi hệ thống - ABC News</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }
        
        .error-container {
            text-align: center;
            max-width: 600px;
            padding: 40px;
        }
        
        .error-code {
            font-size: 8rem;
            font-weight: bold;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .error-title {
            font-size: 2rem;
            margin-bottom: 15px;
        }
        
        .error-message {
            font-size: 1.2rem;
            margin-bottom: 30px;
            opacity: 0.9;
        }
        
        .back-btn {
            display: inline-block;
            padding: 15px 30px;
            background: rgba(255,255,255,0.2);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s;
            margin: 10px;
        }
        
        .back-btn:hover {
            background: rgba(255,255,255,0.3);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-code">500</div>
        <h1 class="error-title">Lỗi hệ thống</h1>
        <p class="error-message">
            Xin lỗi, đã xảy ra lỗi trong quá trình xử lý. Vui lòng thử lại sau hoặc liên hệ quản trị viên.
        </p>
        
        <a href="${pageContext.request.contextPath}/home" class="back-btn">
            🏠 Về trang chủ
        </a>
        
        <a href="javascript:history.back()" class="back-btn">
            ← Quay lại
        </a>
    </div>
</body>
</html>