<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Đăng nhập - ABC News</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico">
            <style>
                .login-wrapper {
                    min-height: 100vh;
                    background: linear-gradient(135deg, #c41e3a 0%, #a01729 100%);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 20px;
                }

                .login-container {
                    background: white;
                    border-radius: 15px;
                    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                    overflow: hidden;
                    width: 100%;
                    max-width: 900px;
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    min-height: 600px;
                }

                .login-left {
                    background: linear-gradient(135deg, #c41e3a, #a01729);
                    color: white;
                    padding: 60px 40px;
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                    text-align: center;
                }

                .login-right {
                    padding: 60px 40px;
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                }

                .login-logo {
                    font-size: 3rem;
                    font-weight: bold;
                    margin-bottom: 20px;
                    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
                }

                .login-tagline {
                    font-size: 1.2rem;
                    opacity: 0.9;
                    margin-bottom: 30px;
                    line-height: 1.6;
                }

                .login-features {
                    list-style: none;
                    text-align: left;
                }

                .login-features li {
                    margin-bottom: 15px;
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    font-size: 1rem;
                }

                .login-form h2 {
                    color: #c41e3a;
                    margin-bottom: 30px;
                    font-size: 2rem;
                    text-align: center;
                }

                .role-tabs {
                    display: flex;
                    margin-bottom: 30px;
                    background: #f8f9fa;
                    border-radius: 8px;
                    padding: 4px;
                }

                .role-tab {
                    flex: 1;
                    padding: 12px 20px;
                    text-align: center;
                    border-radius: 6px;
                    cursor: pointer;
                    transition: all 0.3s;
                    font-weight: 500;
                    color: #666;
                }

                .role-tab.active {
                    background: #c41e3a;
                    color: white;
                    box-shadow: 0 2px 8px rgba(196, 30, 58, 0.3);
                }

                .form-group {
                    margin-bottom: 25px;
                }

                .form-group label {
                    display: block;
                    margin-bottom: 8px;
                    font-weight: 500;
                    color: #333;
                }

                .form-group input {
                    width: 100%;
                    padding: 15px 20px;
                    border: 2px solid #e0e0e0;
                    border-radius: 8px;
                    font-size: 16px;
                    transition: border-color 0.3s;
                }

                .form-group input:focus {
                    outline: none;
                    border-color: #c41e3a;
                    box-shadow: 0 0 0 3px rgba(196, 30, 58, 0.1);
                }

                .login-btn {
                    width: 100%;
                    padding: 15px;
                    background: linear-gradient(135deg, #c41e3a, #a01729);
                    color: white;
                    border: none;
                    border-radius: 8px;
                    font-size: 16px;
                    font-weight: bold;
                    cursor: pointer;
                    transition: transform 0.3s;
                    margin-bottom: 20px;
                }

                .login-btn:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(196, 30, 58, 0.3);
                }

                .error-message {
                    background: #f8d7da;
                    color: #721c24;
                    padding: 12px;
                    border-radius: 6px;
                    margin-bottom: 20px;
                    border: 1px solid #f5c6cb;
                }

                .demo-accounts {
                    background: #f8f9fa;
                    padding: 20px;
                    border-radius: 8px;
                    margin-top: 20px;
                    font-size: 14px;
                }

                .demo-accounts h4 {
                    color: #c41e3a;
                    margin-bottom: 15px;
                }

                .demo-account {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    padding: 8px 0;
                    border-bottom: 1px solid #e0e0e0;
                }

                .demo-account:last-child {
                    border-bottom: none;
                }

                .demo-btn {
                    background: #28a745;
                    color: white;
                    border: none;
                    padding: 5px 12px;
                    border-radius: 4px;
                    font-size: 12px;
                    cursor: pointer;
                }

                .back-home {
                    text-align: center;
                    margin-top: 30px;
                }

                .back-home a {
                    color: #c41e3a;
                    text-decoration: none;
                    font-weight: 500;
                }

                @media (max-width: 768px) {
                    .login-container {
                        grid-template-columns: 1fr;
                        max-width: 400px;
                    }

                    .login-left {
                        padding: 40px 30px;
                    }

                    .login-right {
                        padding: 40px 30px;
                    }

                    .login-logo {
                        font-size: 2.5rem;
                    }
                }
            </style>
        </head>

        <body>
            <div class="login-wrapper">
                <div class="login-container">
                    <!-- Left Side - Branding -->
                    <div class="login-left">
                        <div class="login-logo">ABC NEWS</div>
                        <div class="login-tagline">
                            Hệ thống quản lý tin tức hàng đầu Việt Nam
                        </div>

                        <ul class="login-features">
                            <li>
                                <span>✅</span>
                                <span>Quản lý tin tức chuyên nghiệp</span>
                            </li>
                            <li>
                                <span>✅</span>
                                <span>Giao diện thân thiện, dễ sử dụng</span>
                            </li>
                            <li>
                                <span>✅</span>
                                <span>Bảo mật thông tin tuyệt đối</span>
                            </li>
                            <li>
                                <span>✅</span>
                                <span>Hỗ trợ đa nền tảng</span>
                            </li>
                            <li>
                                <span>✅</span>
                                <span>Cập nhật realtime 24/7</span>
                            </li>
                        </ul>
                    </div>

                    <!-- Right Side - Login Form -->
                    <div class="login-right">
                        <form class="login-form" action="${pageContext.request.contextPath}/login" method="post">
                            <h2>🔐 Đăng nhập</h2>

                            <!-- Error Message -->
                            <c:if test="${not empty error}">
                                <div
                                    style="background: #f8d7da; color: #721c24; padding: 12px; border-radius: 6px; margin-bottom: 20px; border: 1px solid #f5c6cb;">
                                    <strong>❌ Lỗi:</strong> ${error}
                                </div>
                            </c:if>

                            <!-- Success Message -->
                            <c:if test="${not empty success}">
                                <div
                                    style="background: #d4edda; color: #155724; padding: 12px; border-radius: 6px; margin-bottom: 20px; border: 1px solid #c3e6cb;">
                                    <strong>✅ Thành công:</strong> ${success}
                                </div>
                            </c:if>

                            <!-- Display error message if exists -->
                            <c:if test="${not empty error}">
                                <div class="error-message">
                                    ${error}
                                </div>
                            </c:if>

                            <div class="form-group">
                                <label for="username">👤 Tên đăng nhập:</label>
                                <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập"
                                    value="${not empty rememberedUsername ? rememberedUsername : username}" required>
                            </div>

                            <div class="form-group">
                                <label for="password">🔒 Mật khẩu:</label>
                                <input type="password" id="password" name="password" placeholder="Nhập mật khẩu"
                                    value="${not empty rememberedPassword ? rememberedPassword : ''}" required>
                            </div>

                            <div
                                style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 25px;">
                                <label style="display: flex; align-items: center; gap: 8px; font-size: 14px;">
                                    <input type="checkbox" name="rememberMe" value="1" style="width: auto;" ${rememberMe
                                        ? 'checked' : '' }>
                                    <span>🍪 Ghi nhớ đăng nhập (7 ngày)</span>
                                </label>
                            </div>

                            <button type="submit" class="login-btn">
                                🚀 Đăng nhập ngay
                            </button>
                        </form>

                        <!-- Demo Accounts -->
                        <div class="demo-accounts">
                            <h4>🎯 Tài khoản demo để test:</h4>

                            <div class="demo-account">
                                <div>
                                    <strong>Admin:</strong> admin / 123456
                                </div>
                                <button type="button" class="demo-btn" onclick="fillDemo('admin', '123456')">
                                    Dùng thử
                                </button>
                            </div>

                            <div class="demo-account">
                                <div>
                                    <strong>Phóng viên:</strong> pv001 / 123456
                                </div>
                                <button type="button" class="demo-btn" onclick="fillDemo('pv001', '123456')">
                                    Dùng thử
                                </button>
                            </div>

                            <div class="demo-account">
                                <div>
                                    <strong>Phóng viên:</strong> pv002 / 123456
                                </div>
                                <button type="button" class="demo-btn" onclick="fillDemo('pv002', '123456')">
                                    Dùng thử
                                </button>
                            </div>
                        </div>
                    <div class="back-home">
                            <a href="${pageContext.request.contextPath}/home">← Quay về trang chủ ABC
                                News</a>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                // Fill demo account
                function fillDemo(username, password) {
                    document.getElementById('username').value = username;
                    document.getElementById('password').value = password;
                }

                // Focus first input
                document.addEventListener('DOMContentLoaded', function () {
                    document.getElementById('username').focus();
                });
            </script>
        </body>

        </html>