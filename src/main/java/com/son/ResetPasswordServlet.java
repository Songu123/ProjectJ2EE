package com.son;

import com.son.data.Impl.UserImpl;
import com.son.data.dao.UserDAO;
import com.son.data.model.User;
import com.son.utils.PasswordUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends BaseServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token");
        User user = userDAO.findByResetToken(token);
        System.out.println(user);

//        Kiểm tra token có hợp lệ hay không
        if (user == null || user.getResetTokenExpire() == null || user.getResetTokenExpire().isBefore(java.time.LocalDateTime.now())) {
            req.setAttribute("error", "Token không hợp lệ hoặc đã hết hạn.");
            System.out.println("Token không); hợp lệ hoặc đã hết hạn.");
            req.getRequestDispatcher("reset-password.jsp").forward(req, resp);
            return;
        }

        req.setAttribute("token", token);
        req.getRequestDispatcher("reset-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token");
        String newPassword = req.getParameter("password");
        System.out.println("newPassword: " + newPassword);
        User user = userDAO.findByResetToken(token);

//        Kiểm tra token có hợp lệ hay không
        if (user == null || user.getResetTokenExpire() == null || user.getResetTokenExpire().isBefore(java.time.LocalDateTime.now())) {
            req.setAttribute("error", "Token không hợp lệ hoặc đã hết hạn.");
            req.getRequestDispatcher("reset-password.jsp").forward(req, resp);
            return;
        }

        user.setPassword(PasswordUtils.hashPassword(newPassword));
        user.setResetToken(null);
        user.setResetTokenExpire(null);
        userDAO.update(user);

        req.setAttribute("message", "Mật khẩu đã được đặt lại thành công.");
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }
}
