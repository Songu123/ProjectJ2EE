<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
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
        <section id="prodetails" class="section-p1">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <div class="single-pro-img">
                            <img src="${product.thumbnail}" alt="" id="MainImg" width="100%">
                            <div class="small-img-group">
                                <div class="col-sm-3">
                                    <img src="assets/images/products/f1.jpg" alt="" class="small-img" width="100%">
                                </div>
                                <div class="col-sm-3">
                                    <img src="assets/images/products/f2.jpg" alt="" class="small-img" width="100%">
                                </div>
                                <div class="col-sm-3">
                                    <img src="assets/images/products/f3.jpg" alt="" class="small-img" width="100%">
                                </div>
                                <div class="col-sm-3">
                                    <img src="assets/images/products/f4.jpg" alt="" class="small-img" width="100%">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                         <form action="cart" method="post" class="single-pro-details">
                                <input type="hidden" name="action" value="create"/>
                                <input type="hidden" name="productId" value="${product.id}"/>
                                <input type="hidden" name="price" value="${product.price}"/>
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">T-Shirt</li>
                                    </ol>
                                </nav>
                                <h1>${product.name}</h1>
                                <p class="price">$${product.price}</p>
                                <div class="form-group">
                                    <label for="size" class="form-label">Select Size</label>
                                    <select name="size" id="size" class="form-control" required>
                                        <option value="" disabled selected>Select Size</option>
                                        <option value="S">S</option>
                                        <option value="M">M</option>
                                        <option value="L">L</option>
                                        <option value="XL">XL</option>
                                        <option value="XXL">XXL</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="quantity" class="form-label">Quantity</label>
                                    <input name="quantity" type="number" id="quantity" class="form-control" value="1" min="1" required>
                                </div>
                                <button type="submit" class="btn btn-primary">Add To Cart</button>
                                <h2>Product Details</h2>
                                <p>${product.description}</p>
                            </form>
                    </div>
                </div>
            </div>
        </section>

        <section id="product1" class="section-p1">
            <h2>New Arrivals</h2>
            <p>Summer Collection New Morden Design</p>
            <div class="prod-cont">
                <c:forEach items="${newsProductList}" var="product">
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

        <%@include file="./inc/footer.jsp"%>

    </body>

</html>
