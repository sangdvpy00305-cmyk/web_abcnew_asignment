<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!-- Navigation Component -->
<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
            <i class="fas fa-newspaper text-danger"></i> <fmt:message key="app.title" />
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link ${param.page == 'home' ? 'active' : ''}" href="${pageContext.request.contextPath}/home">
                        <i class="fas fa-home"></i> <fmt:message key="menu.home" />
                    </a>
                </li>
                <c:forEach var="category" items="${categories}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/category/${category.id}">
                            ${category.name}
                        </a>
                    </li>
                </c:forEach>
                <li class="nav-item">
                    <a class="nav-link ${param.page == 'about' ? 'active' : ''}" href="${pageContext.request.contextPath}/about">
                        <i class="fas fa-info-circle"></i> <fmt:message key="menu.about" />
                    </a>
                </li>
            </ul>

            <!-- Search Form -->
            <form class="d-flex me-3" action="${pageContext.request.contextPath}/search" method="get">
                <input class="form-control me-2" type="search" name="q"
                    placeholder="<fmt:message key="search.placeholder" />" required>
                <button class="btn btn-outline-danger" type="submit">
                    <i class="fas fa-search"></i>
                </button>
            </form>

            <ul class="navbar-nav">
                <!-- Language Switcher -->
                <%@ include file="language-switcher.jsp" %>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/login">
                        <i class="fas fa-sign-in-alt"></i> <fmt:message key="menu.login" />
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>