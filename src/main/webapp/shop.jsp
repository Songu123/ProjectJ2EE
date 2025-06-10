<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cara</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
              integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="assets/css/style.css">
    </head>

    <body>

        <%@include file="./inc/header.jsp"%>

        <section id="page-header">
            <h2>#stayhome</h2>
            <p>Save more with coupons & up to 70% off!</p>
            <div class="wrap-form">
                <div class="search-form">
                    <form action="search" class="w-full" method="get">
                        <div class="from-control flex items-center relative w-full">
                            <svg xmlns="http://www.w3.org/2000/svg" class="icon-search" fill="none" viewBox="0 0 24 24"
                                 stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                  d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                            </svg>
                            <input name="keyword" placeholder="Search ..." type="text"
                                   class="search-input w-full bg-white border-[1px] rounded-[30px] h-[40px] border-[#b3b3b3] pl-[40px]">
                        </div>
                    </form>
                </div>
            </div>
        </section>

        <section id="product1" class="section-p1">
            <div class="prod-cont">
                <c:forEach items="${productList}" var="product">
                    <div class="prod">
                        <img src="${product.thumbnail}" alt="">
                        <div class="des">
                            <span>adidas</span>
                            <h5>${product.name}</h5>
                            <div class="star">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </div>
                            <h4>$${product.price}</h4>
                        </div>
                        <a href="product?productId=${product.id}"><i class="fa-solid fa-cart-shopping cart"></i></a>
                    </div>
                </c:forEach>
            </div>
        </section>

        <section id="pagination" class="section-p1">
            <c:forEach var="i" begin="1" end="${numberPage + 1}">
                <a <c:if test="${i == page}">class="active"</c:if>  href="shop?page=${i}">${i}</a>
            </c:forEach>
            <a href="#"><i class="fa-solid fa-arrow-right"></i></a>
        </section>

        <%@include file="./inc/footer.jsp"%>

    </body>

</html>
