<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng nhập - E-Commerce</title>
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
    .login-wrapper {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .login-card {
      background: #fff;
      border-radius: 18px;
      box-shadow: 0 6px 24px 0 rgba(120,120,120,0.11), 0 1.5px 8px 0 rgba(180,180,180,0.08);
      padding: 42px 34px 32px 34px;
      max-width: 410px;
      width: 100%;
    }
    .login-logo {
      text-align: center;
      font-size: 2.2rem;
      color: #4b5e6b;
      margin-bottom: 10px;
      font-weight: 700;
      letter-spacing: 2px;
    }
    .login-logo i {
      font-size: 2.1rem;
      color: #7a8ca5;
      vertical-align: middle;
    }
    .login-title {
      text-align: center;
      font-size: 1.22rem;
      color: #495057;
      font-weight: 600;
      margin-bottom: 28px;
    }
    .form-label {
      font-weight: 500;
    }

    /* --- Input đẹp hơn --- */
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
      height: 48px;
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
      transition: color 0.18s;
    }
    .custom-input-group .form-control:focus + .input-icon {
      color: #7a8ca5;
    }
    ::placeholder {
      color: #b6bfc9 !important;
      opacity: 1;
      font-size: 1.03rem;
    }
    .btn-login {
      background: #7a8ca5;
      color: #fff;
      font-weight: 700;
      border-radius: 11px;
      font-size: 1.06rem;
      box-shadow: 0 2px 10px 0 rgba(78,92,108,0.09);
      letter-spacing: 1px;
      transition: 0.17s;
    }
    .btn-login:hover, .btn-login:focus {
      background: #4b5e6b;
      color: #fff;
      box-shadow: 0 2px 18px 0 rgba(78,92,108,0.13);
    }
    .alert {
      border-radius: 8px;
    }
    .nav-link {
      color: #7a8ca5;
      text-decoration: underline;
      font-weight: 600;
      transition: color 0.15s;
    }
    .nav-link:hover {
      color: #4b5e6b;
    }
    @media (max-width: 600px) {
      .login-card { padding: 24px 5vw 18px 5vw;}
    }
  </style>
</head>
<body>
<div class="login-wrapper">
  <div class="login-card shadow-sm">
    <div class="login-logo mb-1">
      <i class="fa-solid fa-bag-shopping"></i> SHOP
    </div>
    <div class="login-title mb-4">
      Đăng nhập vào tài khoản của bạn
    </div>
    <form action="login" method="post">
      <div class="custom-input-group">
        <input type="text"
               class="form-control"
               name="email"
               placeholder="Tên đăng nhập"
               value="${param.username}"
               required autofocus>
        <span class="input-icon"><i class="fa fa-user"></i></span>
      </div>
      <div class="custom-input-group">
        <input type="password"
               class="form-control"
               name="password"
               placeholder="Mật khẩu"
               required>
        <span class="input-icon"><i class="fa fa-lock"></i></span>
      </div>
      <c:if test="${not empty error}">
        <div class="alert alert-danger py-2 mb-3">${error}</div>
      </c:if>
      <c:if test="${not empty message}">
        <div class="alert alert-success py-2 mb-3">${message}</div>
      </c:if>
        <a href="forgot-password" methods="get">Bạn quên mật khầu?</a>
      <button type="submit" class="btn btn-login w-100 mb-2">Đăng nhập</button>
      <div class="text-center mt-2">
        <a href="register" class="nav-link">Bạn chưa có tài khoản? Đăng ký</a>
      </div>
    </form>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>