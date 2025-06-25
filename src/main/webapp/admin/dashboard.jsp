
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Admin Dashboard - Fashion Shop</title>
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

        .stats-card {
            display: flex;
            align-items: center;
            padding: 20px;
        }

        .stats-icon {
            width: 56px;
            height: 56px;
            background-color: rgba(79, 70, 229, 0.1);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            font-size: 1.5rem;
            margin-right: 20px;
            flex-shrink: 0;
        }

        .stats-icon.revenue {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--success);
        }

        .stats-icon.completed {
            background-color: rgba(14, 165, 233, 0.1);
            color: var(--info);
        }

        .stats-icon.pending {
            background-color: rgba(245, 158, 11, 0.1);
            color: var(--warning);
        }

        .stats-details h5 {
            font-size: 0.875rem;
            color: var(--secondary);
            margin-bottom: 5px;
        }

        .stats-details h3 {
            font-size: 1.5rem;
            font-weight: 600;
            margin: 0;
            color: var(--dark);
        }

        .chart-container {
            padding: 20px;
        }

        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .chart-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--dark);
            margin: 0;
        }

        .chart-link {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.875rem;
        }

        .table-responsive {
            margin: 0;
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

        .status-badge {
            padding: 5px 10px;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 500;
            text-transform: uppercase;
        }

        .status-badge.pending {
            background-color: rgba(245, 158, 11, 0.1);
            color: var(--warning);
        }

        .status-badge.processing {
            background-color: rgba(14, 165, 233, 0.1);
            color: var(--info);
        }

        .status-badge.completed {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--success);
        }

        .status-badge.canceled {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--danger);
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 32px;
            height: 32px;
            border-radius: 6px;
            color: white;
            margin-right: 5px;
            transition: all 0.2s;
        }

        .action-btn.view {
            background-color: var(--primary);
        }

        .action-btn.edit {
            background-color: var(--warning);
        }

        .card-footer {
            padding: 15px 20px;
            border-top: 1px solid var(--border);
            text-align: center;
        }

        .view-all {
            color: var(--primary);
            font-weight: 500;
            text-decoration: none;
        }

        .progress-bar {
            height: 8px;
            border-radius: 4px;
        }

        .toggle-sidebar {
            display: none;
            background: none;
            border: none;
            color: var(--dark);
            font-size: 1.25rem;
            cursor: pointer;
        }

        .footer {
            background-color: white;
            padding: 15px 20px;
            border-radius: 10px;
            box-shadow: var(--card-shadow);
            text-align: center;
            color: var(--secondary);
            font-size: 0.875rem;
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
            <a href="dashboard" class="active">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
            <a href="IndexOrderServlet">
                <i class="fas fa-shopping-cart"></i> Orders
            </a>
            <a href="ProductsServlet">
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
                <h4>Dashboard</h4>
            </div>
            <div class="user-info">
                <div class="d-none d-sm-block">
                    <span class="fw-medium">Admin</span>
                </div>
                <img src="https://ui-avatars.com/api/?name=Admin&background=4F46E5&color=fff" alt="Admin">
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="row g-4">
            <div class="col-md-6 col-xl-3">
                <div class="card">
                    <div class="stats-card">
                        <div class="stats-icon">
                            <i class="fas fa-shopping-bag"></i>
                        </div>
                        <div class="stats-details">
                            <h5>Today's Orders</h5>
                            <h3>${numberOrderToday}</h3>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-xl-3">
                <div class="card">
                    <div class="stats-card">
                        <div class="stats-icon revenue">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <div class="stats-details">
                            <h5>Total Revenue</h5>
                            <h3>$${totalRevenue}</h3>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-xl-3">
                <div class="card">
                    <div class="stats-card">
                        <div class="stats-icon completed">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="stats-details">
                            <h5>Completed Orders</h5>
                            <h3>${numberOrderFinished}</h3>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-xl-3">
                <div class="card">
                    <div class="stats-card">
                        <div class="stats-icon pending">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="stats-details">
                            <h5>Pending Orders</h5>
                            <h3>${numberOrderPending}</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts -->
        <div class="row g-4 mt-2">
            <div class="col-lg-8">
                <div class="card h-100">
                    <div class="chart-container">
                        <div class="chart-header">
                            <h5 class="chart-title">Sales Overview</h5>
                            <a href="SalesReportServlet" class="chart-link">View Report</a>
                        </div>
                        <div style="height: 300px;">
                            <canvas id="weekly-sales"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="card h-100">
                    <div class="chart-container">
                        <div class="chart-header">
                            <h5 class="chart-title">Sales Distribution</h5>
                            <a href="ProductsServlet" class="chart-link">View All</a>
                        </div>
                        <div class="d-flex justify-content-center" style="height: 300px;">
                            <canvas id="sales-distribution"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Orders -->
        <div class="card mt-4">
            <div class="chart-header p-4">
                <h5 class="chart-title">Recent Orders</h5>
                <a href="IndexOrderServlet" class="chart-link">View All Orders</a>
            </div>
            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Date</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${orderList}" var="order" varStatus="loop">
                        <c:if test="${loop.index < 5}">
                            <tr>
                                <td>
                                    <span class="fw-medium">${order.code}</span>
                                </td>
                                <td>${order.firstName} ${order.lastName}</td>
                                <td><fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy" /></td>
                                <td>$<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.status eq 'PENDING'}">
                                            <span class="status-badge pending">Pending</span>
                                        </c:when>
                                        <c:when test="${order.status eq 'PROCESSING'}">
                                            <span class="status-badge processing">Processing</span>
                                        </c:when>
                                        <c:when test="${order.status eq 'COMPLETED'}">
                                            <span class="status-badge completed">Completed</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge canceled">Canceled</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="OrderDetailServlet?orderId=${order.id}" class="action-btn view">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <a href="EditOrderServlet?orderId=${order.id}" class="action-btn edit">
                                        <i class="fas fa-pencil-alt"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="card-footer">
                <a href="IndexOrderServlet" class="view-all">View All Orders <i class="fas fa-arrow-right ms-1"></i></a>
            </div>
        </div>

        <!-- Two Columns -->
        <div class="row g-4 mt-2">
            <!-- Top Products -->
            <div class="col-lg-6">
                <div class="card h-100">
                    <div class="chart-header p-4">
                        <h5 class="chart-title">Top Products</h5>
                        <a href="ProductsServlet" class="chart-link">View All</a>
                    </div>
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                            <tr>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Sold</th>
                                <th>Status</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${topProducts}" var="product" varStatus="loop">
                                <c:if test="${loop.index < 5}">
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div style="width:40px;height:40px;background-color:#f1f5f9;border-radius:6px;display:flex;align-items:center;justify-content:center;margin-right:10px;">
                                                    <i class="fas fa-tshirt text-primary"></i>
                                                </div>
                                                <span class="fw-medium">${product.name}</span>
                                            </div>
                                        </td>
                                        <td>$${product.price}</td>
                                        <td>${product.soldCount}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${product.quantity > 10}">
                                                    <span class="status-badge completed">In Stock</span>
                                                </c:when>
                                                <c:when test="${product.quantity > 0}">
                                                    <span class="status-badge pending">Low Stock</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge canceled">Out of Stock</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Recent Customers -->
            <div class="col-lg-6">
                <div class="card h-100">
                    <div class="chart-header p-4">
                        <h5 class="chart-title">Recent Customers</h5>
                        <a href="UsersServlet" class="chart-link">View All</a>
                    </div>
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                            <tr>
                                <th>Customer</th>
                                <th>Email</th>
                                <th>Orders</th>
                                <th>Spent</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${recentUsers}" var="user" varStatus="loop">
                                <c:if test="${loop.index < 5}">
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="https://ui-avatars.com/api/?name=${user.firstName}+${user.lastName}&background=4F46E5&color=fff"
                                                     alt="${user.firstName}" style="width:32px;height:32px;border-radius:50%;margin-right:10px;">
                                                <span class="fw-medium">${user.firstName} ${user.lastName}</span>
                                            </div>
                                        </td>
                                        <td>${user.email}</td>
                                        <td>${user.orderCount}</td>
                                        <td>$${user.totalSpent}</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer mt-4">
            <p class="mb-0">© 2023 FashionShop Admin Panel. All rights reserved.</p>
        </div>
    </div>
</div>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>

<script>
    $(document).ready(function() {
        // Toggle sidebar
        $('.toggle-sidebar').on('click', function() {
            $('.sidebar').toggleClass('active');
            $('.content').toggleClass('pushed');
        });

        // Weekly sales chart
        const salesCtx = document.getElementById('weekly-sales').getContext('2d');
        new Chart(salesCtx, {
            type: 'line',
            data: {
                labels: ${dateList != null ? dateList : "['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']"},
                datasets: [{
                    label: 'Orders',
                    data: ${orderByDateList != null ? orderByDateList : "[5, 12, 8, 15, 10, 20, 18]"},
                    borderColor: '#4f46e5',
                    backgroundColor: 'rgba(79, 70, 229, 0.1)',
                    tension: 0.4,
                    fill: true,
                    pointBackgroundColor: 'white',
                    pointBorderColor: '#4f46e5',
                    pointBorderWidth: 2,
                    pointRadius: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    x: {
                        grid: {
                            display: false
                        }
                    },
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        },
                        ticks: {
                            precision: 0
                        }
                    }
                }
            }
        });

        // Sales distribution chart
        const distributionCtx = document.getElementById('sales-distribution').getContext('2d');
        new Chart(distributionCtx, {
            type: 'doughnut',
            data: {
                labels: ['Clothing', 'Accessories', 'Footwear', 'Others'],
                datasets: [{
                    data: [45, 25, 20, 10],
                    backgroundColor: ['#4f46e5', '#10b981', '#0ea5e9', '#f59e0b'],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '70%',
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            boxWidth: 12,
                            padding: 15
                        }
                    }
                }
            }
        });
    });
</script>
</body>
</html>
