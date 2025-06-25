<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <!-- Header Section Begin -->
    <header class="header">
        <div class="header__top">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-7">
                        <div class="header__top__left">
                            <p>Free shipping, 30-day return or refund guarantee.</p>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-5">
                        <div class="header__top__right">
                            <div class="header__top__links">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.currentUser}">
                                        <a href="profile">My Account</a>
                                        <a href="logout">Logout</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="login">Sign in</a>
                                        <a href="register">Register</a>
                                    </c:otherwise>
                                </c:choose>
                                <a href="faqs">FAQs</a>
                            </div>
                            <div class="header__top__hover">
                                <span>Usd <i class="arrow_carrot-down"></i></span>
                                <ul>
                                    <li>USD</li>
                                    <li>EUR</li>
                                    <li>USD</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-3">
                    <div class="header__logo">
                        <a href="home"><img src="img/logo.png" alt=""></a>
                    </div>
                </div>

                <%-- Get current page name --%>
                <c:set var="currentPage" value="${pageContext.request.requestURI}" />
                <c:set var="pageName" value="${fn:substringAfter(currentPage, '/')}" />

                <div class="col-lg-6 col-md-6">
                    <nav class="header__menu mobile-menu">
                        <ul>
                            <%-- Home menu item --%>
                            <li class="${(fn:contains(pageName, 'home') || pageName == '' || pageName == '/') ? 'active' : ''}">
                                <a href="home">Home</a>
                            </li>

                            <%-- Shop menu item --%>
                            <li class="${fn:contains(pageName, 'shop') && !fn:contains(pageName, 'shopping-cart') && !fn:contains(pageName, 'shop-details') ? 'active' : ''}">
                                <a href="shop">Shop</a>
                            </li>

                            <%-- Pages menu item with dropdown --%>
                            <li class="${(fn:contains(pageName, 'about.jsp') ||
                                        fn:contains(pageName, 'shop-details.html') ||
                                        fn:contains(pageName, 'shopping-cart.html') ||
                                        fn:contains(pageName, 'checkout.jsp') ||
                                        fn:contains(pageName, 'blog-details.jsp')) ? 'active' : ''}">
                                <a href="#">Pages</a>
                                <ul class="dropdown">
                                    <li class="${fn:contains(pageName, 'about.jsp') ? 'active' : ''}">
                                        <a href="about.jsp">About Us</a>
                                    </li>
                                    <li class="${fn:contains(pageName, 'shop-details.html') ? 'active' : ''}">
                                        <a href="./shop-details.html">Shop Details</a>
                                    </li>
                                    <li class="${fn:contains(pageName, 'shopping-cart.html') ? 'active' : ''}">
                                        <a href="cart">Shopping Cart</a>
                                    </li>
                                    <li class="${fn:contains(pageName, 'checkout.jsp') ? 'active' : ''}">
                                        <a href="checkout.jsp">Check Out</a>
                                    </li>
                                    <li class="${fn:contains(pageName, 'blog-details.jsp') ? 'active' : ''}">
                                        <a href="blog-details.jsp">Blog Details</a>
                                    </li>
                                </ul>
                            </li>

                            <%-- Blog menu item --%>
                            <li class="${fn:contains(pageName, 'blog') && !fn:contains(pageName, 'blog-details') ? 'active' : ''}">
                                <a href="blog">Blog</a>
                            </li>

                            <%-- Contacts menu item --%>
                            <li class="${fn:contains(pageName, 'contact') ? 'active' : ''}">
                                <a href="contact">Contacts</a>
                            </li>
                        </ul>
                    </nav>
                </div>
                <div class="header__nav__option">
                    <a href="#" class="search-switch"><img src="img/icon/search.png" alt=""></a>
                    <a href="#"><img src="img/icon/heart.png" alt=""></a>
                    <a href="cart">
                        <img src="img/icon/cart.png" alt="">
                        <span>${not empty sessionScope.cart ? sessionScope.cart.size() : 0}</span>
                    </a>
                    <div class="price">$${not empty sessionScope.cart ? String.format("%.2f", Helper.total(sessionScope.cart)) : '0.00'}</div>
                </div>
            </div>
            <div class="canvas__open"><i class="fa fa-bars"></i></div>
        </div>
    </header>
    <!-- Header Section End -->