package com.son;

import com.son.data.Impl.UserImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class ListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        UserImpl userDAO = new UserImpl();
//        req.setAttribute("ListUser", userDAO.getAll());

        req.getRequestDispatcher("list.jsp").forward(req, resp);


    }
}
