package com.son;

import com.son.data.Impl.UserImpl;
import com.son.data.dao.UserDAO;
import com.son.data.model.User;
import com.son.utils.PasswordUtils;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Objects;

public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check if user is already logged in
        HttpSession session = req.getSession();
        if (session.getAttribute("currentUser") != null) { // Sửa lại cho đồng nhất
            resp.sendRedirect("home");
        } else {
            req.getRequestDispatcher("login.jsp").include(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        // Không in thông tin nhạy cảm ra console
         System.out.println(email);
         System.out.println(password);

        // Input validation
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Email và mật khẩu không được để trống");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }

        try {
            // Get the user object from the database
            User user = userDAO.find(email);

            System.out.println("User found: " + user); // Debugging line, can be removed later
            if (user != null) {
                // Check password
                boolean check = PasswordUtils.checkPassword(password, user.getPassword());
                System.out.println("Password check result: " + check); // Debugging line, can be removed later
                if (!check) {
                    req.setAttribute("errorMessage", "Email hoặc mật khẩu không đúng");
                    req.getRequestDispatcher("login.jsp").forward(req, resp);
                    return;
                }

                // Log successful authentication
                getServletContext().log("Login successful for user: " + user.getEmail());

                HttpSession session = req.getSession(true); // Create new session if none exists
                session.setAttribute("currentUser", user);

                // Redirect based on user role
                if (Objects.equals(user.getRole(), "admin")) {
                    resp.sendRedirect("dashboard");
                } else {
                    resp.sendRedirect("home");
                }
            } else {
                // Log failed authentication
                getServletContext().log("Login failed for email: " + email);
                req.setAttribute("errorMessage", "Email hoặc mật khẩu không đúng");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            // Log the exception
            getServletContext().log("Error during login process", e);

            req.setAttribute("errorMessage", "Lỗi hệ thống, vui lòng thử lại sau");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}