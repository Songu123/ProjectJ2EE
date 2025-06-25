
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Products - Fashion Shop Admin</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <!-- Favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/admin/img/favicon.ico" type="image/x-icon">

    <!-- Google Web Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Icon Font -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        :root {
            --primary: #4f46e5;
            --secondary: #64748b;
            --success: #10b981;
            --info: #0ea5e9;
            --warning: #f59e0b;
            --danger: #ef4444;
            --dark: #0f172a;
            --light: #f8fafc;
            --border: #e2e8f0;
            --bg-light: #f1f5f9;
            --card-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg-light);
            color: var(--dark);
            line-height: 1.5;
        }

        .wrapper {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 260px;
            background: linear-gradient(180deg, var(--primary) 0%, #4338ca 100%);
            color: white;
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            z-index: 1000;
            transition: all 0.3s;
        }

        .sidebar-header {
            padding: 25px 20px;
            display: flex;
            align-items: center;
        }

        .sidebar-header h3 {
            margin: 0;
            font-weight: 600;
            font-size: 1.25rem;
            color: white;
        }

        .sidebar-menu {
            padding: 10px 0;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 400;
            transition: all 0.3s;
            border-left: 3px solid transparent;
        }

        .sidebar-menu a i {
            margin-right: 12px;
            font-size: 1.1rem;
            width: 20px;
        }

        .sidebar-menu a.active,
        .sidebar-menu a:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
            border-left: 3px solid white;
        }

        .content {
            margin-left: 260px;
            width: calc(100% - 260px);
            padding: 25px;
            transition: all 0.3s;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: white;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            box-shadow: var(--card-shadow);
        }

        .top-bar h4 {
            margin: 0;
            font-weight: 600;
            color: var(--dark);
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .user-info img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }

        .card {
            background-color: white;
            border: none;
            border-radius: 10px;
            box-shadow: var(--card-shadow);
            margin-bottom: 25px;
            transition: all 0.2s;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            border-bottom: 1px solid var(--border);
        }

        .card-header h5 {
            margin: 0;
            font-weight: 600;
            font-size: 1.1rem;
        }

        .data-table {
            width: 100%;
            margin-bottom: 0;
            color: var(--dark);
        }

        .data-table th {
            padding: 15px 20px;
            border-bottom: 1px solid var(--border);
            font-weight: 600;
            color: var(--secondary);
            background-color: rgba(241, 245, 249, 0.5);
        }

        .data-table td {
            padding: 15px 20px;
            vertical-align: middle;
            border-bottom: 1px solid var(--border);
        }

        .data-table tr:last-child td {
            border-bottom: none;
        }

        .data-table tbody tr:hover {
            background-color: rgba(241, 245, 249, 0.5);
        }

        .product-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 6px;
        }

        .btn {
            font-weight: 500;
            padding: 0.45rem 1.2rem;
            border-radius: 6px;
            transition: all 0.2s;
        }

        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
        }

        .btn-primary:hover {
            background-color: #4338ca;
            border-color: #4338ca;
        }

        .btn-success {
            background-color: var(--success);
            border-color: var(--success);
        }

        .btn-success:hover {
            background-color: #059669;
            border-color: #059669;
        }

        .btn-danger {
            background-color: var(--danger);
            border-color: var(--danger);
        }

        .btn-danger:hover {
            background-color: #dc2626;
            border-color: #dc2626;
        }

        .btn-sm {
            padding: 0.25rem 0.75rem;
            font-size: 0.875rem;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .footer {
            background-color: white;
            padding: 15px 20px;
            border-radius: 10px;
            box-shadow: var(--card-shadow);
            text-align: center;
            color: var(--secondary);
            font-size: 0.875rem;
            margin-top: 20px;
        }

        .toggle-sidebar {
            display: none;
            background: none;
            border: none;
            color: var(--dark);
            font-size: 1.25rem;
            cursor: pointer;
        }

        @media (max-width: 991.98px) {
            .toggle-sidebar {
                display: block;
                margin-right: 15px;
            }

            .sidebar {
                margin-left: -260px;
            }

            .sidebar.active {
                margin-left: 0;
            }

            .content {
                margin-left: 0;
                width: 100%;
            }

            .content.pushed {
                margin-left: 260px;
                width: calc(100% - 260px);
            }
        }
    </style>
</head>

<body>
<div class="wrapper">
    <!-- Sidebar -->
    <nav class="sidebar">
        <div class="sidebar-header">
            <h3><i class="fas fa-shopping-bag me-2"></i> FashionShop</h3>
        </div>

        <div class="sidebar-menu">
            <a href="dashboard">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
            <a href="IndexOrderServlet">
                <i class="fas fa-shopping-cart"></i> Orders
            </a>
            <a href="ProductsServlet" class="active">
                <i class="fas fa-tshirt"></i> Products
            </a>
            <a href="CategoriesServlet">
                <i class="fas fa-list"></i> Categories
            </a>
            <a href="UsersServlet">
                <i class="fas fa-users"></i> Customers
            </a>
            <a href="SettingsServlet">
                <i class="fas fa-cog"></i> Settings
            </a>
            <a href="LogoutServlet">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </nav>

    <!-- Content -->
    <div class="content">
        <!-- Top Bar -->
        <div class="top-bar">
            <div class="d-flex align-items-center">
                <button class="toggle-sidebar me-3">
                    <i class="fas fa-bars"></i>
                </button>
                <h4>Products</h4>
            </div>
            <div class="user-info">
                <div class="d-none d-sm-block">
                    <span class="fw-medium">Admin</span>
                </div>
                <img src="https://ui-avatars.com/api/?name=Admin&background=4F46E5&color=fff" alt="Admin">
            </div>
        </div>

        <!-- Products Table -->
        <div class="card">
            <div class="card-header">
                <h5>Product Management</h5>
                <a href="AddProductServlet" class="btn btn-primary btn-sm">
                    <i class="fas fa-plus me-1"></i> Add New Product
                </a>
            </div>
            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Category</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="i" value="0"/>
                    <c:forEach items="${productList}" var="product">
                        <c:set var="i" value="${i+1}"/>
                        <tr>
                            <td>${i}</td>
                            <td>
                                <img src="${product.thumbnail}" class="product-image" alt="${product.name}"/>
                            </td>
                            <td>
                                <span class="fw-medium">${product.name}</span>
                            </td>
                            <td>
                                <span class="fw-medium">$<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${product.quantity > 10}">
                                        <span class="text-success fw-medium">${product.quantity}</span>
                                    </c:when>
                                    <c:when test="${product.quantity > 0}">
                                        <span class="text-warning fw-medium">${product.quantity}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-danger fw-medium">Out of stock</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${product.category.name}</td>
                            <td>
                                <div class="action-buttons">
                                    <a href="ViewProductServlet?productId=${product.id}" class="btn btn-info btn-sm">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <a href="EditProductServlet?productId=${product.id}" class="btn btn-warning btn-sm">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <form action="DeleteProductServlet" method="POST" style="display: inline-block;">
                                        <input type="hidden" name="productId" value="${product.id}"/>
                                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this product?')">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer">
            <p class="mb-0">© 2023 FashionShop Admin Panel. All rights reserved.</p>
        </div>
    </div>
</div>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    $(document).ready(function() {
        // Toggle sidebar
        $('.toggle-sidebar').on('click', function() {
            $('.sidebar').toggleClass('active');
            $('.content').toggleClass('pushed');
        });

        // Delete confirmation
        $('.delete-btn').on('click', function(e) {
            if (!confirm('Are you sure you want to delete this product?')) {
                e.preventDefault();
            }
        });
    });
</script>
</body>
</html>