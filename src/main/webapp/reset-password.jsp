<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password - Fashion Shop</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">

    <style>
        .reset-password-section {
            padding: 80px 0;
            background-color: #f3f2ee;
        }
        .reset-password-form {
            max-width: 500px;
            margin: 0 auto;
            padding: 40px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 0 20px rgba(0,0,0,0.08);
        }
        .reset-password-title {
            text-align: center;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 25px;
        }
        .site-btn {
            width: 100%;
        }
        .login-link {
            margin-top: 20px;
            text-align: center;
        }
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        .success-message {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .password-requirements {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
        .password-strength {
            height: 5px;
            margin-top: 5px;
            border-radius: 2px;
        }
    </style>
</head>
<body>
<!-- Page Preloder -->
<div id="preloder">
    <div class="loader"></div>
</div>

<!-- Header Section Begin -->
<%@include file="./inc/header.jsp" %>
<!-- Header Section End -->

<!-- Reset Password Section Begin -->
<section class="reset-password-section">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="reset-password-form">
                    <div class="reset-password-title">
                        <h4>Reset Your Password</h4>
                        <p>Please enter your new password below</p>
                    </div>

                    <c:if test="${not empty message}">
                        <div class="message ${messageType == 'success' ? 'success-message' : 'error-message'}">
                                ${message}
                        </div>
                    </c:if>

                    <c:if test="${empty tokenValid || tokenValid == true}">
                        <form action="reset-password" method="post" id="passwordResetForm">
                            <input type="hidden" name="token" value="${param.token}">
                            <div class="form-group">
                                <label for="password">New Password</label>
                                <input type="password" class="form-control" id="password" name="password"
                                       placeholder="Enter new password" required>
                                <div class="password-strength" id="passwordStrength"></div>
                                <div class="password-requirements">
                                    Password must be at least 8 characters and include uppercase, lowercase, numbers, and special characters.
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="confirmPassword">Confirm Password</label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                                       placeholder="Confirm your new password" required>
                            </div>
                            <button type="submit" class="site-btn" id="resetBtn">Reset Password</button>
                        </form>
                    </c:if>

                    <c:if test="${tokenValid == false}">
                        <div class="error-message">
                            This password reset link is invalid or has expired. Please request a new one.
                        </div>
                        <div class="text-center mt-4">
                            <a href="forgot-password" class="site-btn">Request New Reset Link</a>
                        </div>
                    </c:if>

                    <div class="login-link">
                        <p>Remember your password? <a href="login">Sign In</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Reset Password Section End -->

<!-- Footer Section Begin -->
<%@include file="./inc/footer.jsp" %>
<!-- Footer Section End -->

<!-- Js Plugins -->
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.nice-select.min.js"></script>
<script src="js/jquery.nicescroll.min.js"></script>
<script src="js/jquery.magnific-popup.min.js"></script>
<script src="js/jquery.countdown.min.js"></script>
<script src="js/jquery.slicknav.js"></script>
<script src="js/mixitup.min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/main.js"></script>

<script>
    $(document).ready(function() {
        // Password strength indicator
        $('#password').on('input', function() {
            const password = $(this).val();
            const strength = checkPasswordStrength(password);

            let color = '';
            if (strength === 0) color = '#dc3545'; // Weak (red)
            else if (strength === 1) color = '#ffc107'; // Medium (yellow)
            else color = '#28a745'; // Strong (green)

            $('#passwordStrength').css({
                'width': ((strength + 1) * 33.33) + '%',
                'background-color': color
            });
        });

        // Confirm password check
        $('#passwordResetForm').on('submit', function(e) {
            const password = $('#password').val();
            const confirmPassword = $('#confirmPassword').val();

            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match. Please try again.');
                return false;
            }

            if (checkPasswordStrength(password) === 0) {
                e.preventDefault();
                alert('Password is too weak. Please use a stronger password.');
                return false;
            }
        });

        function checkPasswordStrength(password) {
            if (!password) return 0;

            let strength = 0;
            // Has uppercase
            if (/[A-Z]/.test(password)) strength++;
            // Has lowercase, numbers and special chars
            if (/[a-z]/.test(password) && /[0-9]/.test(password) &&
                /[^A-Za-z0-9]/.test(password)) strength++;
            // Length at least 8
            if (password.length >= 8) strength++;

            return Math.min(2, strength);
        }
    });
</script>
</body>
</html>