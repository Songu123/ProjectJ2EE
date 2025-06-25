
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Register Account</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    .register-container {
      max-width: 500px;
      margin: 40px auto;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
    }
    .form-header {
      text-align: center;
      margin-bottom: 25px;
      color: #343a40;
    }
    .btn-register {
      width: 100%;
      padding: 10px;
      font-weight: 500;
    }
    .form-footer {
      text-align: center;
      margin-top: 20px;
    }
    .password-toggle {
      cursor: pointer;
      position: absolute;
      right: 10px;
      top: 10px;
    }
    .input-group {
      position: relative;
    }
  </style>
</head>
<body class="bg-light">

<div class="container">
  <div class="register-container bg-white">
    <div class="form-header">
      <h2 class="mb-3">Create an Account</h2>
      <p class="text-muted">Please fill in your information to register</p>
    </div>

    <form action="register" method="post">
      <div class="mb-3">
        <label for="fullname" class="form-label">Full Name</label>
        <input type="text" class="form-control" id="fullname" name="fullname" required>
      </div>

      <div class="mb-3">
        <label for="email" class="form-label">Email Address</label>
        <input type="email" class="form-control" id="email" name="email" required>
      </div>

      <div class="mb-3">
        <label for="pwd" class="form-label">Password</label>
        <div class="input-group">
          <input type="password" class="form-control" id="pwd" name="password" required>
          <span class="password-toggle" onclick="togglePassword()">
                        <i class="fas fa-eye" id="toggleIcon"></i>
                    </span>
        </div>
      </div>

      <div class="mb-3">
        <label for="confirmpwd" class="form-label">Confirm Password</label>
        <input type="password" class="form-control" id="confirmpwd" name="confirmpassword" required>
      </div>

      <div class="form-check mb-3">
        <input class="form-check-input" type="checkbox" id="terms" name="terms" required>
        <label class="form-check-label" for="terms">
          I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>
        </label>
      </div>

      <button type="submit" class="btn btn-primary btn-register">Create Account</button>

      <div class="form-footer">
        <p>Already have an account? <a href="login.jsp">Log In</a></p>
      </div>
    </form>
  </div>
</div>

<script>
  function togglePassword() {
    const passwordField = document.getElementById("pwd");
    const toggleIcon = document.getElementById("toggleIcon");

    if (passwordField.type === "password") {
      passwordField.type = "text";
      toggleIcon.classList.remove("fa-eye");
      toggleIcon.classList.add("fa-eye-slash");
    } else {
      passwordField.type = "password";
      toggleIcon.classList.remove("fa-eye-slash");
      toggleIcon.classList.add("fa-eye");
    }
  }
</script>

</body>
</html>
