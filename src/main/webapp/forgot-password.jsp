<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu - E-Commerce</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts + Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            min-height: 100vh;
            background: #f4f6f8;
            font-family: 'Montserrat', sans-serif;
        }
        .forgot-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .forgot-card {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 6px 24px 0 rgba(120,120,120,0.11), 0 1.5px 8px 0 rgba(180,180,180,0.08);
            padding: 42px 34px 32px 34px;
            max-width: 460px;
            width: 100%;
        }
        .forgot-logo {
            text-align: center;
            font-size: 2.2rem;
            color: #4b5e6b;
            margin-bottom: 10px;
            font-weight: 700;
            letter-spacing: 2px;
        }
        .forgot-logo i {
            font-size: 2.1rem;
            color: #7a8ca5;
            vertical-align: middle;
        }
        .forgot-title {
            text-align: center;
            font-size: 1.22rem;
            color: #495057;
            font-weight: 600;
            margin-bottom: 12px;
        }
        .forgot-subtitle {
            text-align: center;
            font-size: 0.95rem;
            color: #6c757d;
            margin-bottom: 28px;
        }
        /* Enhanced input styling */
        .custom-input-group {
            position: relative;
            margin-bottom: 20px;
        }
        .custom-input-group .form-control {
            border-radius: 14px;
            border: 1.5px solid #e0e3ea;
            box-shadow: 0 2px 10px 0 rgba(76, 94, 108, 0.04);
            padding-left: 46px;
            font-size: 1.08rem;
            height: 50px;
            background: #f7f9fa;
            transition: border 0.18s, box-shadow 0.18s;
        }
        .custom-input-group .form-control:focus {
            border-color: #7a8ca5;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(122,140,165,0.13);
        }
        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #a2b0c3;
            font-size: 1.18rem;
            pointer-events: none;
        }
        .btn-forgot {
            background: #7a8ca5;
            color: #fff;
            font-weight: 600;
            border-radius: 12px;
            height: 50px;
            font-size: 1.06rem;
            box-shadow: 0 2px 10px 0 rgba(78,92,108,0.09);
            transition: all 0.2s ease;
        }
        .btn-forgot:hover {
            background: #4b5e6b;
            transform: translateY(-1px);
            box-shadow: 0 4px 14px 0 rgba(78,92,108,0.15);
        }
        .back-link {
            color: #7a8ca5;
            text-decoration: none;
            font-weight: 600;
            display: block;
            text-align: center;
            margin-top: 15px;
            transition: color 0.15s;
        }
        .back-link:hover {
            color: #4b5e6b;
        }
        @media (max-width: 576px) {
            .forgot-card {
                padding: 30px 20px;
                margin: 0 15px;
            }
        }
    </style>
</head>
<body>
<div class="forgot-wrapper">
    <div class="forgot-card">
        <div class="forgot-logo mb-3">
            <i class="fa-solid fa-bag-shopping"></i> SHOP
        </div>
        <div class="forgot-title">
            Quên mật khẩu?
        </div>
        <div class="forgot-subtitle">
            Nhập email đã đăng ký để nhận hướng dẫn khôi phục mật khẩu
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success mb-4">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger mb-4">${error}</div>
        </c:if>

        <form action="forgot-password" method="post">
            <div class="custom-input-group">
                <input type="email" class="form-control" name="email"
                       placeholder="Địa chỉ email" required autofocus>
                <span class="input-icon"><i class="fa-regular fa-envelope"></i></span>
            </div>

            <button type="submit" class="btn btn-forgot w-100">Gửi email xác nhận</button>

            <a href="login" class="back-link">
                <i class="fa-solid fa-arrow-left me-1"></i> Quay lại đăng nhập
            </a>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>