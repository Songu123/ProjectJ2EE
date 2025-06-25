package com.son;

import com.son.data.Impl.UserImpl;
import com.son.data.dao.UserDAO;
import com.son.data.model.User;
import com.son.utils.EmailUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.UUID;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends BaseServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("forgot-password.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");

//        Kiểm tra email có tồn tại hay không
        User user = userDAO.find(email);
        if (user == null) {
            req.setAttribute("error", "Email không tồn tại trong hệ thống.");
            req.getRequestDispatcher("forgot-password.jsp").forward(req, resp);
            return;
        }

//        Tạo token và lưu vào cơ sở dữ liệu
        String token = UUID.randomUUID().toString();
        user.setResetToken(token);
        user.setResetTokenExpire(LocalDateTime.now().plusMinutes(30));
        userDAO.update(user);
        System.out.println("Đã cập nhật token cho người dùng: " + user);

        String resetLink = "http://localhost:8080/ProjectJ2EE/reset-password?token=" + token;
        EmailUtils.send(email, "Yêu cầu đặt lại mật khẩu",
                "Bạn đã yêu cầu đặt lại mật khẩu. Vui lòng nhấp vào liên kết sau để đặt lại mật khẩu của bạn: " + resetLink);

        req.setAttribute("message", "Một email đã được gửi đến " + email + " với hướng dẫn đặt lại mật khẩu.");
        req.getRequestDispatcher("forgot-password.jsp").forward(req, resp);
    }
}
