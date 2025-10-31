<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!-- Language Switcher Component -->
<li class="nav-item dropdown">
    <a class="nav-link dropdown-toggle" href="#" id="languageDropdown" role="button" data-bs-toggle="dropdown">
        <i class="fas fa-globe"></i> <fmt:message key="menu.language" />
    </a>
    <ul class="dropdown-menu">
        <li><a class="dropdown-item ${sessionScope.lang == 'vi' || sessionScope.lang == null ? 'active' : ''}" href="?lang=vi">🇻🇳 Tiếng Việt</a></li>
        <li><a class="dropdown-item ${sessionScope.lang == 'en' ? 'active' : ''}" href="?lang=en">🇺🇸 English</a></li>
        <li><a class="dropdown-item ${sessionScope.lang == 'zh' ? 'active' : ''}" href="?lang=zh">🇨🇳 中文</a></li>
    </ul>
</li>