<%--
    Document   : header
    Created on : Aug 12, 2024, 3:59:06 PM
    Author     : Welcome
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header id="header">
    <a href="index.html"><img src="assets/images/logo.png" class="logo" alt=""></a>
    <ul id="navbar">
        <li><a class="active" href="index.html">Home</a></li>
        <li>
            <a href="shop">Shop</a>
            <ul class="sub-menu">
                <c:forEach items="${categoryList}" var="category">
                    <li class="menu-item">
                        <a href="CategoryServlet?categoryId=${category.id}">${category.name}</a>
                    </li>
                </c:forEach>
        </li>
    </ul>
</li>
<li><a href="blog">Blog</a></li>
<li><a href="about">About</a></li>
<li><a href="contact">Contact</a></li>
<li><a href="cart"><i class="fa-solid fa-bag-shopping"></i></a></li>
<li>
    <c:if test="${sessionScope.currentUser == null}">
        <a href="login">Login</a>
    </c:if>

    <c:if test="${sessionScope.currentUser != null}">
        <a href="logout">Logout</a>
    </c:if>
</li>
</ul>
</header>