package com.son;

import com.son.data.dao.CategoryDao;
import com.son.data.dao.Database;
import com.son.data.dao.DatabaseDao;
import com.son.data.model.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class BaseServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {
        DatabaseDao.init(new Database());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CategoryDao categoryDao = DatabaseDao.getInstance().getCategoryDao();
        List<Category> categoryList = categoryDao.findAll();

        req.setAttribute("categoryList", categoryList);
    }
}
